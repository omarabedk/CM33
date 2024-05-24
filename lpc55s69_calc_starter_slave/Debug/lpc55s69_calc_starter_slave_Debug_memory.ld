/*
 * GENERATED FILE - DO NOT EDIT
 * Copyright 2008-2013 Code Red Technologies Ltd,
 * Copyright 2013-2024 NXP
 * Generated linker script file for LPC55S69
 * Created from memory.ldt by FMCreateLinkMemory
 * Using Freemarker v2.3.30
 * MCUXpresso IDE v11.9.0 [Build 2144] [2024-01-05] on Apr 15, 2024, 11:16:05 AM
 */

MEMORY
{
  /* Define each memory region */
  SRAM (rwx) : ORIGIN = 0x20030000, LENGTH = 0xc000 /* 48K bytes (alias RAM) */  
  shmem (rwx) : ORIGIN = 0x2003c000, LENGTH = 0x4000 /* 16K bytes (alias RAM2) */  
  SRAMX (rwx) : ORIGIN = 0x4000000, LENGTH = 0x8000 /* 32K bytes (alias RAM3) */  
  USB_RAM (rwx) : ORIGIN = 0x40100000, LENGTH = 0x4000 /* 16K bytes (alias RAM4) */  
  SRAM4 (rwx) : ORIGIN = 0x20040000, LENGTH = 0x4000 /* 16K bytes (alias RAM5) */  
}

  /* Define a symbol for the top of each memory region */
  __base_SRAM = 0x20030000  ; /* SRAM */  
  __base_RAM = 0x20030000 ; /* RAM */  
  __top_SRAM = 0x20030000 + 0xc000 ; /* 48K bytes */  
  __top_RAM = 0x20030000 + 0xc000 ; /* 48K bytes */  
  __base_shmem = 0x2003c000  ; /* shmem */  
  __base_RAM2 = 0x2003c000 ; /* RAM2 */  
  __top_shmem = 0x2003c000 + 0x4000 ; /* 16K bytes */  
  __top_RAM2 = 0x2003c000 + 0x4000 ; /* 16K bytes */  
  __base_SRAMX = 0x4000000  ; /* SRAMX */  
  __base_RAM3 = 0x4000000 ; /* RAM3 */  
  __top_SRAMX = 0x4000000 + 0x8000 ; /* 32K bytes */  
  __top_RAM3 = 0x4000000 + 0x8000 ; /* 32K bytes */  
  __base_USB_RAM = 0x40100000  ; /* USB_RAM */  
  __base_RAM4 = 0x40100000 ; /* RAM4 */  
  __top_USB_RAM = 0x40100000 + 0x4000 ; /* 16K bytes */  
  __top_RAM4 = 0x40100000 + 0x4000 ; /* 16K bytes */  
  __base_SRAM4 = 0x20040000  ; /* SRAM4 */  
  __base_RAM5 = 0x20040000 ; /* RAM5 */  
  __top_SRAM4 = 0x20040000 + 0x4000 ; /* 16K bytes */  
  __top_RAM5 = 0x20040000 + 0x4000 ; /* 16K bytes */  
