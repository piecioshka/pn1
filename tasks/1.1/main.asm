;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.3 Sat Oct 11 15:48:04 2014

;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _U12
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; special function bits 
;--------------------------------------------------------
_T1	=	0x00b4
;--------------------------------------------------------
; overlayable register banks 
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG	(DATA)
__start__stack:
	.ds	1

;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_U12	=	0x8000
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area CSEG    (CODE)
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
__sdcc_gsinit_startup:
	mov	sp,#__start__stack - 1
	lcall	__sdcc_external_startup
	mov	a,dpl
	jz	__sdcc_init_data
	ljmp	__sdcc_program_startup
__sdcc_init_data:
;	_mcs51_genXINIT() start
	mov	a,#l_XINIT
	orl	a,#l_XINIT>>8
	jz	00003$
	mov	a,#s_XINIT
	add	a,#l_XINIT
	mov	r1,a
	mov	a,#s_XINIT>>8
	addc	a,#l_XINIT>>8
	mov	r2,a
	mov	dptr,#s_XINIT
	mov	r0,#s_XISEG
	mov	p2,#(s_XISEG >> 8)
00001$:	clr	a
	movc	a,@a+dptr
	movx	@r0,a
	inc	dptr
	inc	r0
	cjne	r0,#0,00002$
	inc	p2
00002$:	mov	a,dpl
	cjne	a,ar1,00001$
	mov	a,dph
	cjne	a,ar2,00001$
	mov	p2,#0xFF
00003$:
;	_mcs51_genXINIT() end
	.area GSFINAL (CODE)
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
__sdcc_program_startup:
	lcall	_main
;	return from main will lock up
	sjmp .
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;Z:\projects\pn1-labs\1.5\main.c:19: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;Z:\projects\pn1-labs\1.5\main.c:23: T1 = 1;
;     genAssign
	setb	_T1
00109$:
;Z:\projects\pn1-labs\1.5\main.c:28: if ((U12 & 0x000E) == 0) {
;     genAssign
	mov	dptr,#_U12
	movx	a,@dptr
	mov	r2,a
;     genAnd
	anl	ar2,#0x0E
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r2,#0x00,00102$
;00118$:
;       Peephole 200   removed redundant sjmp
00119$:
;Z:\projects\pn1-labs\1.5\main.c:29: T1 = 0;
;     genAssign
	clr	_T1
00102$:
;Z:\projects\pn1-labs\1.5\main.c:33: if ((U12 & 0x0007) == 0) {
;     genAssign
	mov	dptr,#_U12
	movx	a,@dptr
	mov	r2,a
;     genAnd
	anl	ar2,#0x07
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r2,#0x00,00115$
;00120$:
;       Peephole 200   removed redundant sjmp
00121$:
;Z:\projects\pn1-labs\1.5\main.c:34: T1 = 1;
;     genAssign
	setb	_T1
;Z:\projects\pn1-labs\1.5\main.c:37: for (i = 0; i < 70; i++);
00115$:
;     genAssign
	mov	r2,#0x46
00107$:
;     genDjnz
;       Peephole 132   changed ljmp to sjmp
;       Peephole 205   optimized misc jump sequence
	djnz r2,00107$
00122$:
00123$:
;       Peephole 132   changed ljmp to sjmp
	sjmp 00109$
00111$:
	ret
	.area CSEG    (CODE)
	.area XINIT   (CODE)
