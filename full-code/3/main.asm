;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.3 Sat Dec 13 15:15:31 2014

;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wysw
	.globl _znak
	.globl _main
	.globl _pause
	.globl _Init
	.globl _LED
	.globl _U10
	.globl _U15
	.globl _buffer
	.globl _r
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_TCON	=	0x0088
_TMOD	=	0x0089
_TH1	=	0x008d
_TL1	=	0x008b
_IE	=	0x00a8
;--------------------------------------------------------
; special function bits 
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable register banks 
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_r::
	.ds 1
_buffer::
	.ds 4
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
_U15	=	0x8000
_U10	=	0xffff
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
	ljmp	_LED
	.ds	5
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
;N:\projects\pn1\FDLMZB~0\3\main.c:66: unsigned char r = 0;
;     genAssign
	mov	_r,#0x00
;N:\projects\pn1\FDLMZB~0\3\main.c:69: unsigned char buffer[4] = {0, 0, 0, 0};
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	_buffer,#0x00
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	(_buffer + 0x0001),#0x00
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	(_buffer + 0x0002),#0x00
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	(_buffer + 0x0003),#0x00
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
;Allocation info for local variables in function 'LED'
;------------------------------------------------------------
;------------------------------------------------------------
;N:\projects\pn1\FDLMZB~0\3\main.c:71: void LED(void) interrupt 1 {
;	-----------------------------------------
;	 function LED
;	-----------------------------------------
_LED:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	push	acc
	push	b
	push	dpl
	push	dph
	push	ar2
	push	ar0
	push	psw
	mov	psw,#0x00
;N:\projects\pn1\FDLMZB~0\3\main.c:73: U10 = cyfra_n;
;     genAssign
	mov	dptr,#_U10
;       Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;N:\projects\pn1\FDLMZB~0\3\main.c:76: U15 = wysw[r];
;     genPlus
	mov	a,_r
;       Peephole 180   changed mov to clr
;     genPointerGet
;     genCodePointerGet
;       Peephole 186   optimized movc sequence
	mov  dptr,#_wysw
	movc a,@a+dptr
;     genAssign
;       Peephole 100   removed redundant mov
	mov  r2,a
	mov  dptr,#_U15
	movx @dptr,a
;N:\projects\pn1\FDLMZB~0\3\main.c:79: U10 = znak[buffer[r]]; 
;     genPlus
	mov	a,_r
	add	a,#_buffer
	mov	r0,a
;     genPointerGet
;     genNearPointerGet
	mov	ar2,@r0
;     genPlus
;       Peephole 236g
	mov  a,r2
;       Peephole 180   changed mov to clr
;     genPointerGet
;     genCodePointerGet
;       Peephole 186   optimized movc sequence
	mov  dptr,#_znak
	movc a,@a+dptr
;     genAssign
;       Peephole 100   removed redundant mov
	mov  r2,a
	mov  dptr,#_U10
	movx @dptr,a
;N:\projects\pn1\FDLMZB~0\3\main.c:82: r++;
;     genPlus
;     genPlusIncr
	inc	_r
;N:\projects\pn1\FDLMZB~0\3\main.c:85: r &= 0x03;
;     genAnd
	anl	_r,#0x03
00101$:
	pop	psw
	pop	ar0
	pop	ar2
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'Init'
;------------------------------------------------------------
;------------------------------------------------------------
;N:\projects\pn1\FDLMZB~0\3\main.c:90: void Init(void) {
;	-----------------------------------------
;	 function Init
;	-----------------------------------------
_Init:
;N:\projects\pn1\FDLMZB~0\3\main.c:91: TMOD = (TMOD & 0xf0) | 0x02;
;     genAnd
	mov	a,#0xF0
	anl	a,_TMOD
;     genOr
	orl	a,#0x02
	mov	_TMOD,a
;N:\projects\pn1\FDLMZB~0\3\main.c:94: TCON = 0x10;
;     genAssign
	mov	_TCON,#0x10
;N:\projects\pn1\FDLMZB~0\3\main.c:98: TL1 = TH1 = 0x06;
;     genAssign
	mov	_TH1,#0x06
;     genAssign
	mov	_TL1,#0x06
;N:\projects\pn1\FDLMZB~0\3\main.c:101: IE = 0x82;
;     genAssign
	mov	_IE,#0x82
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'pause'
;------------------------------------------------------------
;------------------------------------------------------------
;N:\projects\pn1\FDLMZB~0\3\main.c:106: void pause() {
;	-----------------------------------------
;	 function pause
;	-----------------------------------------
_pause:
;N:\projects\pn1\FDLMZB~0\3\main.c:108: for (i = 0; i < 255; i++);
;     genAssign
	mov	r2,#0xFF
	mov	r3,#0x00
00103$:
;     genDjnz
;     genMinus
;     genMinusDec
	dec	r2
	cjne	r2,#0xff,00108$
	dec	r3
00108$:
;     genIfx
	mov	a,r2
	orl	a,r3
;     genIfxJump
;       Peephole 109   removed ljmp by inverse jump logic
	jnz  00103$
00109$:
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;r                         Allocated to registers r2 
;------------------------------------------------------------
;N:\projects\pn1\FDLMZB~0\3\main.c:113: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;N:\projects\pn1\FDLMZB~0\3\main.c:115: unsigned char r = 0;
;     genAssign
	mov	r2,#0x00
;N:\projects\pn1\FDLMZB~0\3\main.c:118: Init();
;     genCall
	push	ar2
	lcall	_Init
	pop	ar2
00104$:
;N:\projects\pn1\FDLMZB~0\3\main.c:122: pause();
;     genCall
	push	ar2
	lcall	_pause
	pop	ar2
;N:\projects\pn1\FDLMZB~0\3\main.c:125: if (r == 255) {
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r2,#0xFF,00102$
;00110$:
;       Peephole 200   removed redundant sjmp
00111$:
;N:\projects\pn1\FDLMZB~0\3\main.c:127: buffer[1]++;
;     genPointerGet
;     genNearPointerGet
;     genDataPointerGet
	mov	r3,(_buffer + 0x0001)
;     genPlus
;     genPlusIncr
	inc	r3
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	(_buffer + 0x0001),r3
;N:\projects\pn1\FDLMZB~0\3\main.c:129: buffer[1] = buffer[1] & 0x0f;
;     genAnd
	anl	ar3,#0x0F
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	(_buffer + 0x0001),r3
;N:\projects\pn1\FDLMZB~0\3\main.c:132: buffer[0] = 0x0f - buffer[1];
;     genMinus
	mov	a,#0x0F
	clr	c
;       Peephole 236l
	subb  a,r3
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	_buffer,a
;N:\projects\pn1\FDLMZB~0\3\main.c:135: r = 0;
;     genAssign
	mov	r2,#0x00
00102$:
;N:\projects\pn1\FDLMZB~0\3\main.c:139: r++; 
;     genPlus
;     genPlusIncr
	inc	r2
;       Peephole 132   changed ljmp to sjmp
	sjmp 00104$
00106$:
	ret
	.area CSEG    (CODE)
_znak:
	.db #0x5F
	.db #0x44
	.db #0x3E
	.db #0x76
	.db #0x65
	.db #0x73
	.db #0x7B
	.db #0x46
	.db #0x7F
	.db #0x77
	.db #0x6F
	.db #0x79
	.db #0x1B
	.db #0x7C
	.db #0x3B
	.db #0x2B
_wysw:
	.db #0xD0
	.db #0xE0
	.db #0x70
	.db #0xB0
	.area XINIT   (CODE)
