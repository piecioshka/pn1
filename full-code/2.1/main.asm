;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.3 Sat Nov 15 15:48:39 2014

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
;a                         Allocated to registers r2 
;b                         Allocated to registers r4 
;a1                        Allocated to registers r2 
;a2                        Allocated to registers r3 
;b1                        Allocated to registers r4 
;b2                        Allocated to registers r5 
;c                         Allocated to registers r5 
;o                         Allocated to registers r3 
;r                         Allocated to registers r5 
;------------------------------------------------------------
;main.c:39: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;main.c:47: SCON = 0x50;
;     genAssign
	mov	_SCON,#0x50
;main.c:50: TMOD &= 0x0f;
;     genAnd
	anl	_TMOD,#0x0F
;main.c:51: TMOD |= 0x20;
;     genOr
	orl	_TMOD,#0x20
;main.c:54: TCON = 0x40;
;     genAssign
	mov	_TCON,#0x40
;main.c:55: PCON = 0x80;
;     genAssign
	mov	_PCON,#0x80
;main.c:58: TH1 = TL1 = 253;
;     genAssign
	mov	_TL1,#0xFD
;     genAssign
	mov	_TH1,#0xFD
00110$:
;main.c:62: a1 = fn_getchar();		
;     genCall
	lcall	_fn_getchar
	mov	a,dpl
;     genAssign
	mov	r2,a
;main.c:63: fn_putchar(a1);
;     genCall
	mov	dpl,r2
	push	ar2
	lcall	_fn_putchar
	pop	ar2
;main.c:64: a2 = fn_getchar();
;     genCall
	push	ar2
	lcall	_fn_getchar
	mov	a,dpl
	pop	ar2
;     genAssign
	mov	r3,a
;main.c:65: fn_putchar(a2);
;     genCall
	mov	dpl,r3
	push	ar2
	push	ar3
	lcall	_fn_putchar
	pop	ar3
	pop	ar2
;main.c:67: a = (a1 -'0') * 10 + (a2 - '0');
;     genMinus
	mov	a,r2
	add	a,#0xd0
;     genMult
;     genMultOneByte
	clr	F0
	jnb	acc.7,00118$
	setb	F0
	cpl	a
	inc	a
00118$:
	mov	b,#0x0a
	mul	ab
	jnb	F0,00119$
	cpl	a
	add	a,#1
	xch	a,b
	cpl	a
	addc	a,#0
	xch	a,b
00119$:
	mov	r2,a
	mov	r4,b
;     genMinus
	mov	a,r3
	add	a,#0xd0
;     genCast
;       Peephole 105   removed redundant mov
	mov  r3,a
	rlc	a
	subb	a,acc
	mov	r5,a
;     genPlus
;       Peephole 236g
	mov  a,r3
;       Peephole 236a
	add  a,r2
	mov	r2,a
;       Peephole 236g
	mov  a,r5
;       Peephole 236b
	addc  a,r4
	mov	r4,a
;     genCast
;main.c:69: o = fn_getchar();
;     genCall
	push	ar2
	lcall	_fn_getchar
	mov	a,dpl
	pop	ar2
;     genAssign
	mov	r3,a
;main.c:70: fn_putchar(o);
;     genCall
	mov	dpl,r3
	push	ar2
	push	ar3
	lcall	_fn_putchar
	pop	ar3
	pop	ar2
;main.c:72: b1 = fn_getchar();		
;     genCall
	push	ar2
	push	ar3
	lcall	_fn_getchar
	mov	a,dpl
	pop	ar3
	pop	ar2
;     genAssign
	mov	r4,a
;main.c:73: fn_putchar(b1);
;     genCall
	mov	dpl,r4
	push	ar2
	push	ar3
	push	ar4
	lcall	_fn_putchar
	pop	ar4
	pop	ar3
	pop	ar2
;main.c:74: b2 = fn_getchar();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_fn_getchar
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;     genAssign
	mov	r5,a
;main.c:75: fn_putchar(b2);
;     genCall
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_fn_putchar
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;main.c:77: b = (b1 - '0') * 10 + (b2 - '0');
;     genMinus
	mov	a,r4
	add	a,#0xd0
;     genMult
;     genMultOneByte
	clr	F0
	jnb	acc.7,00120$
	setb	F0
	cpl	a
	inc	a
00120$:
	mov	b,#0x0a
	mul	ab
	jnb	F0,00121$
	cpl	a
	add	a,#1
	xch	a,b
	cpl	a
	addc	a,#0
	xch	a,b
00121$:
	mov	r4,a
	mov	r6,b
;     genMinus
	mov	a,r5
	add	a,#0xd0
;     genCast
;       Peephole 105   removed redundant mov
	mov  r5,a
	rlc	a
	subb	a,acc
	mov	r7,a
;     genPlus
;       Peephole 236g
	mov  a,r5
;       Peephole 236a
	add  a,r4
	mov	r4,a
;       Peephole 236g
	mov  a,r7
;       Peephole 236b
	addc  a,r6
	mov	r6,a
;     genCast
;main.c:79: c = fn_getchar();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_fn_getchar
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;     genAssign
	mov	r5,a
;main.c:80: fn_putchar(c);
;     genCall
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_fn_putchar
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;main.c:82: if (c == ' ' || c == '=') {
;     genCmpEq
	cjne	r5,#0x20,00122$
;       Peephole 132   changed ljmp to sjmp
	sjmp 00106$
00122$:
;     genCmpEq
	cjne	r5,#0x3D,00123$
	sjmp	00124$
00123$:
	ljmp	00110$
00124$:
00106$:
;main.c:83: fn_putchar('=');
;     genCall
	mov	dpl,#0x3D
	push	ar2
	push	ar3
	push	ar4
	lcall	_fn_putchar
	pop	ar4
	pop	ar3
	pop	ar2
;main.c:85: if (o == '+') {
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r3,#0x2B,00104$
;00125$:
;       Peephole 200   removed redundant sjmp
00126$:
;main.c:86: r = a + b;
;     genPlus
;       Peephole 236g
	mov  a,r4
;       Peephole 236a
	add  a,r2
	mov	r5,a
;       Peephole 132   changed ljmp to sjmp
	sjmp 00105$
00104$:
;main.c:87: } else if (o == '-') {
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r3,#0x2D,00105$
;00127$:
;       Peephole 200   removed redundant sjmp
00128$:
;main.c:88: r = a - b;
;     genMinus
	mov	a,r2
	clr	c
;       Peephole 236l
	subb  a,r4
	mov	r5,a
00105$:
;main.c:91: fn_putchar((r % 100) + '0');
;     genMod
;     genModOneByte
	mov	a,r5
	xrl	a,#0x64
	push	acc
	mov	a,#0x64
	jnb	acc.7,00129$
	cpl	a
	inc	a
00129$:
	mov	b,a
	mov	a,r5
	jnb	acc.7,00130$
	cpl	a
	inc	a
00130$:
	div	ab
	pop	acc
	jb	ov,00131$
	jnb	acc.7,00131$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00131$:
	mov	a,b
;     genPlus
	add	a,#0x30
	mov	dpl,a
;     genCall
	push	ar5
	lcall	_fn_putchar
	pop	ar5
;main.c:92: fn_putchar((r % 10) + '0');
;     genMod
;     genModOneByte
	mov	a,r5
	xrl	a,#0x0A
	push	acc
	mov	a,#0x0A
	jnb	acc.7,00132$
	cpl	a
	inc	a
00132$:
	mov	b,a
	mov	a,r5
	jnb	acc.7,00133$
	cpl	a
	inc	a
00133$:
	div	ab
	pop	acc
	jb	ov,00134$
	jnb	acc.7,00134$
	clr	c
	clr	a
	subb	a,b
	mov	b,a
00134$:
	mov	a,b
;     genPlus
	add	a,#0x30
	mov	dpl,a
;     genCall
	push	ar5
	lcall	_fn_putchar
	pop	ar5
;main.c:93: fn_putchar('\0');
;     genCall
	mov	dpl,#0x00
	push	ar5
	lcall	_fn_putchar
	pop	ar5
;main.c:94: fn_putchar(r);
;     genCall
	mov	dpl,r5
	push	ar5
	lcall	_fn_putchar
	pop	ar5
	ljmp	00110$
00112$:
	ret
	.area CSEG    (CODE)
	.area XINIT   (CODE)
