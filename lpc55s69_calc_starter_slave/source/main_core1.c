/*
 * 2023 (C) E. Boucharé
 */

#include "pin_mux.h"
#include "board.h"

#include "fsl_gpio.h"
#include "fsl_common.h"
#include "fsl_power.h"

#include "lcd.h"

/*******************************************************************************
 * Definitions
 ******************************************************************************/
//#define FOR_TEST

#ifdef FOR_TEST
#define LED_INIT()                   \
    gpio_pin_config_t led_config = { \
        kGPIO_DigitalOutput,         \
        0,                           \
    };                               \
    GPIO_PinInit(GPIO, BOARD_LED_RED_GPIO_PORT, BOARD_LED_RED_GPIO_PIN, &led_config);
#define LED_TOGGLE() GPIO_PortToggle(GPIO, BOARD_LED_RED_GPIO_PORT, 1u << BOARD_LED_RED_GPIO_PIN);

#else

typedef enum {
	L_SOLID, L_DOTTED, L_DASHED, L_COMB, L_ARROW, L_BAR, L_FBAR,
	L_STEP, L_FSTEP, L_NONE
} line_t;

typedef enum {
	M_CROSS, M_PLUS, M_DOT, M_STAR, M_CIRCLE, M_FCIRCLE,
	M_SQUARE, M_FSQUARE, M_DIAMOND, M_FDIAMOND, M_ARROW,
	M_TRIANGLE, M_FTRIANGLE, M_NONE
} marker_t;

line_t		ltype=L_SOLID;
marker_t	mtype=M_NONE;
int			msize=6;

#endif
/*******************************************************************************
 * Mailbox and events
 ******************************************************************************/
#define EVT_MASK						(0xFF<<24)

#define EVT_NONE						0
#define EVT_CORE_UP						(1U<<24)
#define EVT_RETVAL						(2U<<24)
#define EVT DRAWPOINT					(3U<<24)
#define EVT_DRAWLINE					(4U<<24)
#define EVT_DRAWRECT					(5U<<24)
#define EVT_DRAWRNDRECT					(6U<<24)
#define EVT_DRAWCIRCLE					(7U<<24)
#define EVT_DRAWELLISPSE				(8U<<24)
#define EVT_DRAWLINES					(9U<<24)
#define EVT_DRAWSEGMENTS				(10U<<24)
#define EVT_FILLRECT					(11U<<24)
#define EVT_CLIP						(12U<<24)
#define EVT_UNCLIP						(13U<<24)
#define EVT_DRAWPATH					(14U<<24)

#define EVT_FORECOLOR					(15U<<24)
#define EVT_BACKCOLOR					(16U<<24)
#define EVT_SETFONT						(17U<<24)
#define EVT_SETALIGNMENT				(18U<<24)
#define EVT_SETDIRECTION				(19U<<24)
#define EVT_DRAWSTRING					(20U<<24)

#define EVT_GETBUFFER					(30U<<24)

/* mailbox communication between cores */
void mb_init(void)
{
//  Init already done by core0
	MAILBOX->MBOXIRQ[0].IRQCLR=0xFFFFFFFF;
    NVIC_SetPriority(MAILBOX_IRQn, 2);
    NVIC_EnableIRQ(MAILBOX_IRQn);
}

/* pop event from CPU0 */
uint32_t mb_pop_evt(void)
{
	uint32_t evt=MAILBOX->MBOXIRQ[0].IRQ;
	MAILBOX->MBOXIRQ[0].IRQCLR=evt;
	return evt;
}

/* send event to CPU0, wait if there is already a pending event, unless force is set */
bool mb_push_evt(uint32_t evt, bool force)
{
	if (MAILBOX->MBOXIRQ[1].IRQ && !force) {
		return false;
	}
	MAILBOX->MBOXIRQ[1].IRQSET=evt;
	return true;
}

/* event queue */
#define MAX_EVT_DATA				5
typedef struct _Event {
	uint32_t	event;
	uint32_t	data[MAX_EVT_DATA];
} Event;

/* event queue handling */
#define MAX_EVTS					20

volatile Event evq[MAX_EVTS];
volatile int evq_rd=0, evq_wr=0;

bool next_event(Event *evt)
{
	if (evq_rd==evq_wr) return false;

	*evt=evq[evq_rd];
	evq_rd=(evq_rd+1) % MAX_EVTS;
	return true;
}

void MAILBOX_IRQHandler(void)
{
	if (((evq_wr+1)%MAX_EVTS)!=evq_rd) {
		evq[evq_wr].event = mb_pop_evt();
		evq_wr=(evq_wr+1) % MAX_EVTS;
	}
}

/*******************************************************************************
 * shared buffer
 ******************************************************************************/
extern SPoint __start_noinit_shmem[];
SPoint *shdata=__start_noinit_shmem;

/*******************************************************************************
 * main
 ******************************************************************************/
int main(void)
{
    /* Init board hardware.*/
#ifndef FOR_TEST
	lcd_init();
	lcd_switch_to(LCD_DPY);
#endif
    /* Initialize mailbox, send EVT_CORE_UP to notify core 0 that core 1 is up
     * and ready to work.
     */
	mb_init();
    mb_push_evt(EVT_CORE_UP,true);

#ifndef FOR_TEST
	Event ev;
 	short x0, x1, y0, y1, x, y, w, h;
 	uint16_t alignment;
 	uint16_t direction;
 	Font* font;
 	int n;
   	DC dc;

   	lcd_get_default_DC(&dc);
    for (;;) {
    	while (!next_event(&ev)) {}
    	switch (ev.event & EVT_MASK) {
    	case EVT_FORECOLOR:
    		dc.fcolor=(Color)(ev.event & 0x0000FFFF);
    		break;
    	case EVT_DRAWLINES:
    		n=ev.event&0x7FF;
    		x0=shdata[0].x; y0=shdata[0].y;
    		for (int i=1;i<n;i++) {
    			x1=shdata[i].x; y1=shdata[i].y;
    			lcd_line(x0,y0,x1,y1,dc.fcolor);
    			x0=x1; y0=y1;
    		}
    		mb_push_evt(EVT_RETVAL,true);
    		break;
    	case EVT_DRAWSEGMENTS:
    		n=ev.event&0xFFF;
    		for (int i=1;i<n;i++) {
    			x0=shdata[2*i].x;
    			y0=shdata[2*i].y;
    			x1=shdata[2*i+1].x;
    			y1=shdata[2*i+1].y;
    			lcd_line(x0, y0,x1,y1, dc.fcolor);
    	    }
    		mb_push_evt(EVT_RETVAL, true); // Push an event to indicate the drawing operation is complete
    		break;
    	case EVT_DRAWRECT:

    	    x=shdata[0].x;
    		y=shdata[0].y;
    		w=shdata[1].x;
    		h=shdata[1].y;
    		lcd_draw_rect(x, y, w, h,dc.fcolor);
    		mb_push_evt(EVT_RETVAL,true);
    		break;
    	case EVT_CLIP:
    	    x0=shdata[0].x;
    	    y0=shdata[0].y;
    	    x1=shdata[1].x;
    	    y1=shdata[1].y;
    	    lcd_clip(x0,y0,x1, y1);
    	    mb_push_evt(EVT_RETVAL,true);
    	    break;
    	case EVT_UNCLIP:
    	    lcd_unclip();
    	    break;
    	case EVT_SETFONT:
    	    font=(Font * )(ev.event&0xFFFFFFFF);
    	    lcd_set_font(&dc,font);
    	    break;
    	case EVT_SETALIGNMENT:
    	    alignment=ev.event&0x00000FFF;
    	    lcd_set_alignment(&dc,alignment);
    	    break;
    	case EVT_SETDIRECTION:
    	    direction=ev.event&0x000000FF;
    	    lcd_set_direction(&dc,direction);
    		break;
    	case EVT_DRAWSTRING:
    	    x0=shdata[0].x; y0=shdata[0].y;
    	    n = ev.event&0x0000FFFF;
    	    int dataIndex = 1;
    	    char *my_str = NULL;
    	    my_str = (char *)malloc((n) * sizeof (char));
    	    if (my_str != NULL) {
    	    	for (int i=0; i<n; i+=2){
    	    		my_str[i] = (char) (shdata [dataIndex].x);
    	    		my_str[i+1] = (char) (shdata [dataIndex].y);
    	    		dataIndex++;
    	    	}
    	    }
    	    lcd_draw_string(&dc, x0, y0, my_str);
    	    mb_push_evt (EVT_RETVAL, true);
    	    free (my_str);
    	    break;
    	case EVT_FILLRECT:
    	    x = shdata[0].x;
    	    y = shdata[0].y;
    	    w = shdata[1].x;
    	    h = shdata[1].y;
    	    Color fill_color = (Color)(ev.event & 0xFFFF);

    	    lcd_fill_rect(x, y, w, h, fill_color);
    	    mb_push_evt(EVT_RETVAL, true);

    	    break;
    	default:
    		break;
    	}
    }
#else
    /* enable clock for GPIO */
    CLOCK_EnableClock(kCLOCK_Gpio0);
    CLOCK_EnableClock(kCLOCK_Gpio1);
    BOARD_InitBootPins();
   /* Make a noticable delay after the reset */
    /* Use startup parameter from the master core... */
    for (int i = 0; i < 2; i++)
    {
        SDK_DelayAtLeastUs(1000000U, 150000000L);
    }

    /* Configure LED */
    LED_INIT();

    for (;;)
    {
        SDK_DelayAtLeastUs(500000U, 150000000L);
        LED_TOGGLE();
    }
#endif
}
