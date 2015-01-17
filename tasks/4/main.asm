;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.3.3 Sat Jan 17 14:35:18 2015

;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wk_
	.globl _znak
	.globl _main
	.globl _InitLED
	.globl _LED
	.globl _U10
	.globl _U12
	.globl _U15
	.globl _key
	.globl _t
	.globl _buffer
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
_buffer::
	.ds 4
_t::
	.ds 1
_key::
	.ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
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
_U12	=	0x8000
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
;N:\projects\pn1-labs\tasks\4\main.c:58: unsigned char buffer[4] = {0, 0, 0, 0};
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
;N:\projects\pn1-labs\tasks\4\main.c:59: unsigned char t = 0;
;     genAssign
	mov	_t,#0x00
;N:\projects\pn1-labs\tasks\4\main.c:60: unsigned char key = 0;
;     genAssign
	mov	_key,#0x00
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
;zz                        Allocated to registers r2 
;------------------------------------------------------------
;N:\projects\pn1-labs\tasks\4\main.c:62: void LED(void) interrupt 1
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
;N:\projects\pn1-labs\tasks\4\main.c:66: U10 = cyfra_n;
;     genAssign
	mov	dptr,#_U10
;       Peephole 180   changed mov to clr
	clr  a
	movx	@dptr,a
;N:\projects\pn1-labs\tasks\4\main.c:67: U15 = wk_[t];
;     genPlus
	mov	a,_t
;       Peephole 180   changed mov to clr
;     genPointerGet
;     genCodePointerGet
;       Peephole 186   optimized movc sequence
	mov  dptr,#_wk_
	movc a,@a+dptr
;     genAssign
;       Peephole 100   removed redundant mov
	mov  r2,a
	mov  dptr,#_U15
	movx @dptr,a
;N:\projects\pn1-labs\tasks\4\main.c:70: zz = (U12 & 0xf0) >> 4;
;     genAssign
	mov	dptr,#_U12
	movx	a,@dptr
;     genAnd
;     genRightShift
;     genRightShiftLiteral
;     genrshOne
;       Peephole 139   removed redundant mov
	anl  a,#0xF0
	mov  r2,a
	swap	a
	anl	a,#0x0f
	mov	r2,a
;N:\projects\pn1-labs\tasks\4\main.c:72: if(zz != 0x0f){
;     genCmpEq
	cjne	r2,#0x0F,00121$
;       Peephole 132   changed ljmp to sjmp
	sjmp 00113$
00121$:
;N:\projects\pn1-labs\tasks\4\main.c:74: if(zz == 0x07)    // 0111
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r2,#0x07,00110$
;00122$:
;       Peephole 200   removed redundant sjmp
00123$:
;N:\projects\pn1-labs\tasks\4\main.c:75: key = 0x00 | t; // 0000
;     genOr
	mov	_key,_t
;       Peephole 132   changed ljmp to sjmp
	sjmp 00113$
00110$:
;N:\projects\pn1-labs\tasks\4\main.c:77: if(zz == 0x0b)    // 1011
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r2,#0x0B,00107$
;00124$:
;       Peephole 200   removed redundant sjmp
00125$:
;N:\projects\pn1-labs\tasks\4\main.c:78: key = 0x04 | t; // ... (0100)
;     genOr
	mov	a,#0x04
	orl	a,_t
	mov	_key,a
;       Peephole 132   changed ljmp to sjmp
	sjmp 00113$
00107$:
;N:\projects\pn1-labs\tasks\4\main.c:80: if(zz == 0x0d)    // ... (1101)
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r2,#0x0D,00104$
;00126$:
;       Peephole 200   removed redundant sjmp
00127$:
;N:\projects\pn1-labs\tasks\4\main.c:81: key = 0x08 | t; // ... (1000)
;     genOr
	mov	a,#0x08
	orl	a,_t
	mov	_key,a
;       Peephole 132   changed ljmp to sjmp
	sjmp 00113$
00104$:
;N:\projects\pn1-labs\tasks\4\main.c:83: if(zz == 0x0e)    // 1110
;     genCmpEq
;       Peephole 132   changed ljmp to sjmp
;       Peephole 199   optimized misc jump sequence
	cjne r2,#0x0E,00113$
;00128$:
;       Peephole 200   removed redundant sjmp
00129$:
;N:\projects\pn1-labs\tasks\4\main.c:84: key = 0x0c | t; // 1100
;     genOr
	mov	a,#0x0C
	orl	a,_t
	mov	_key,a
00113$:
;N:\projects\pn1-labs\tasks\4\main.c:87: U10 = buffer[t];
;     genPlus
	mov	a,_t
	add	a,#_buffer
	mov	r0,a
;     genPointerGet
;     genNearPointerGet
	mov	dptr,#_U10
	mov	a,@r0
	movx	@dptr,a
;N:\projects\pn1-labs\tasks\4\main.c:89: t++;
;     genPlus
;     genPlusIncr
	inc	_t
;N:\projects\pn1-labs\tasks\4\main.c:90: t &= 0x03; // ... (Dzialamy tylko na 4 wyswietlaczach)
;     genAnd
	anl	_t,#0x03
00114$:
	pop	psw
	pop	ar0
	pop	ar2
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'InitLED'
;------------------------------------------------------------
;------------------------------------------------------------
;N:\projects\pn1-labs\tasks\4\main.c:94: void InitLED(void)
;	-----------------------------------------
;	 function InitLED
;	-----------------------------------------
_InitLED:
;N:\projects\pn1-labs\tasks\4\main.c:96: TMOD = (TMOD & 0xf0) | 0x02; // ... (Ustawienie trybu pracy licznika)
;     genAnd
	mov	a,#0xF0
	anl	a,_TMOD
;     genOr
	orl	a,#0x02
	mov	_TMOD,a
;N:\projects\pn1-labs\tasks\4\main.c:97: TCON = 0x10; // ... (Uruchamiamy przerwania licznik)
;     genAssign
	mov	_TCON,#0x10
;N:\projects\pn1-labs\tasks\4\main.c:98: TL1 = TH1 = 0x06; // ..., ..., ... (Ustawienie predkosci transmisji)
;     genAssign
	mov	_TH1,#0x06
;     genAssign
	mov	_TL1,#0x06
;N:\projects\pn1-labs\tasks\4\main.c:99: IE = 0x82; // ... (Zezwolenie na przyjmowanie przerwan)
;     genAssign
	mov	_IE,#0x82
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;N:\projects\pn1-labs\tasks\4\main.c:103: void main(void){
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;N:\projects\pn1-labs\tasks\4\main.c:105: InitLED();
;     genCall
	lcall	_InitLED
00102$:
;N:\projects\pn1-labs\tasks\4\main.c:109: buffer[0] = znak[~U12 & 0x0f];
;     genAssign
	mov	dptr,#_U12
	movx	a,@dptr
;     genCpl
;       Peephole 105   removed redundant mov
;       Peephole 184   removed redundant mov
	cpl  a
	mov  r2,a
;     genAnd
	mov	a,#0x0F
	anl	a,r2
;     genPlus
	add	a,#_znak
	mov	dpl,a
	mov	a,#(_znak >> 8)
	addc	a,#0x00
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
	clr	a
	movc	a,@a+dptr
	mov	r2,a
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	_buffer,r2
;N:\projects\pn1-labs\tasks\4\main.c:110: buffer[1] = znak[key];
;     genPlus
	mov	a,_key
;       Peephole 180   changed mov to clr
;     genPointerGet
;     genCodePointerGet
;       Peephole 186   optimized movc sequence
	mov  dptr,#_znak
	movc a,@a+dptr
	mov	r2,a
;     genPointerSet
;     genNearPointerSet
;     genDataPointerSet
	mov	(_buffer + 0x0001),r2
;       Peephole 132   changed ljmp to sjmp
	sjmp 00102$
00104$:
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
_wk_:
	.db #0xDE
	.db #0xED
	.db #0x7B
	.db #0xB7
	.area XINIT   (CODE)
