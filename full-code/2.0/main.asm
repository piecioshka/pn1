;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.3 Sat Nov 15 15:04:29 2014

;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _fn_putchar
	.globl _fn_getchar
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_SBUF	=	0x0099
_SCON	=	0x0098
_TMOD	=	0x0089
_TCON	=	0x0088
_PCON	=	0x0087
_TH1	=	0x008d
_TL1	=	0x008b
;--------------------------------------------------------
; special function bits 
;--------------------------------------------------------
_TI	=	0x0099
_RI	=	0x0098
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
;Allocation info for local variables in function 'fn_getchar'
;------------------------------------------------------------
;------------------------------------------------------------
;main.c:21: char fn_getchar() {
;	-----------------------------------------
;	 function fn_getchar
;	-----------------------------------------
_fn_getchar:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;main.c:25: while (RI == 0);
00101$:
;     genNot
	mov	c,_RI
	cpl	c
	clr	a
	rlc	a
;     genIfx
;       Peephole 105   removed redundant mov
	mov  r2,a
;     genIfxJump
;       Peephole 109   removed ljmp by inverse jump logic
	jnz  00101$
00108$:
;main.c:26: RI = 0;
;     genAssign
	clr	_RI
;main.c:28: znak = SBUF; 
;     genAssign
	mov	dpl,_SBUF
;main.c:29: return znak;
;     genRet
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'fn_putchar'
;------------------------------------------------------------
;------------------------------------------------------------
;main.c:32: fn_putchar(char znak) {
;	-----------------------------------------
;	 function fn_putchar
;	-----------------------------------------
_fn_putchar:
;     genReceive
	mov	_SBUF,dpl
;main.c:35: while (TI == 0);
00101$:
;     genNot
	mov	c,_TI
	cpl	c
	clr	a
	rlc	a
;     genIfx
;       Peephole 105   removed redundant mov
	mov  r2,a
;     genIfxJump
;       Peephole 109   removed ljmp by inverse jump logic
	jnz  00101$
00108$:
;main.c:36: TI = 0;
;     genAssign
	clr	_TI
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;c                         Allocated to registers 
;------------------------------------------------------------
;main.c:39: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;main.c:42: SCON = 0x50;
;     genAssign
	mov	_SCON,#0x50
;main.c:45: TMOD &= 0x0f;
;     genAnd
	anl	_TMOD,#0x0F
;main.c:46: TMOD |= 0x20;
;     genOr
	orl	_TMOD,#0x20
;main.c:49: TCON = 0x40;
;     genAssign
	mov	_TCON,#0x40
;main.c:50: PCON = 0x80;
;     genAssign
	mov	_PCON,#0x80
;main.c:53: TH1 = TL1 = 253;
;     genAssign
	mov	_TL1,#0xFD
;     genAssign
	mov	_TH1,#0xFD
00102$:
;main.c:57: c = fn_getchar();
;     genCall
	lcall	_fn_getchar
	mov	a,dpl
;     genAssign
	mov	dpl,a
;main.c:59: fn_putchar(c);
;     genCall
	lcall	_fn_putchar
;       Peephole 132   changed ljmp to sjmp
	sjmp 00102$
00104$:
	ret
	.area CSEG    (CODE)
	.area XINIT   (CODE)
