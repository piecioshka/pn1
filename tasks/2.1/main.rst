                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.3 Sat Nov 15 15:48:39 2014
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module main
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _fn_putchar
                             13 	.globl _fn_getchar
                             14 ;--------------------------------------------------------
                             15 ; special function registers
                             16 ;--------------------------------------------------------
                    0099     17 _SBUF	=	0x0099
                    0098     18 _SCON	=	0x0098
                    0089     19 _TMOD	=	0x0089
                    0088     20 _TCON	=	0x0088
                    0087     21 _PCON	=	0x0087
                    008D     22 _TH1	=	0x008d
                    008B     23 _TL1	=	0x008b
                             24 ;--------------------------------------------------------
                             25 ; special function bits 
                             26 ;--------------------------------------------------------
                    0099     27 _TI	=	0x0099
                    0098     28 _RI	=	0x0098
                             29 ;--------------------------------------------------------
                             30 ; overlayable register banks 
                             31 ;--------------------------------------------------------
                             32 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                      33 	.ds 8
                             34 ;--------------------------------------------------------
                             35 ; internal ram data
                             36 ;--------------------------------------------------------
                             37 	.area DSEG    (DATA)
                             38 ;--------------------------------------------------------
                             39 ; overlayable items in internal ram 
                             40 ;--------------------------------------------------------
                             41 	.area	OSEG    (OVR,DATA)
                             42 	.area	OSEG    (OVR,DATA)
                             43 ;--------------------------------------------------------
                             44 ; Stack segment in internal ram 
                             45 ;--------------------------------------------------------
                             46 	.area	SSEG	(DATA)
   0008                      47 __start__stack:
   0008                      48 	.ds	1
                             49 
                             50 ;--------------------------------------------------------
                             51 ; indirectly addressable internal ram data
                             52 ;--------------------------------------------------------
                             53 	.area ISEG    (DATA)
                             54 ;--------------------------------------------------------
                             55 ; bit data
                             56 ;--------------------------------------------------------
                             57 	.area BSEG    (BIT)
                             58 ;--------------------------------------------------------
                             59 ; external ram data
                             60 ;--------------------------------------------------------
                             61 	.area XSEG    (XDATA)
                             62 ;--------------------------------------------------------
                             63 ; external initialized ram data
                             64 ;--------------------------------------------------------
                             65 	.area XISEG   (XDATA)
                             66 ;--------------------------------------------------------
                             67 ; interrupt vector 
                             68 ;--------------------------------------------------------
                             69 	.area CSEG    (CODE)
   4000                      70 __interrupt_vect:
   4000 02 42 18             71 	ljmp	__sdcc_gsinit_startup
   4003 32                   72 	reti
   4004                      73 	.ds	7
   400B 32                   74 	reti
   400C                      75 	.ds	7
   4013 32                   76 	reti
   4014                      77 	.ds	7
   401B 32                   78 	reti
   401C                      79 	.ds	7
   4023 32                   80 	reti
   4024                      81 	.ds	7
   402B 32                   82 	reti
   402C                      83 	.ds	7
                             84 ;--------------------------------------------------------
                             85 ; global & static initialisations
                             86 ;--------------------------------------------------------
                             87 	.area GSINIT  (CODE)
                             88 	.area GSFINAL (CODE)
                             89 	.area GSINIT  (CODE)
   4218                      90 __sdcc_gsinit_startup:
   4218 75 81 07             91 	mov	sp,#__start__stack - 1
   421B 12 42 14             92 	lcall	__sdcc_external_startup
   421E E5 82                93 	mov	a,dpl
   4220 60 03                94 	jz	__sdcc_init_data
   4222 02 40 33             95 	ljmp	__sdcc_program_startup
   4225                      96 __sdcc_init_data:
                             97 ;	_mcs51_genXINIT() start
   4225 74 00                98 	mov	a,#l_XINIT
   4227 44 00                99 	orl	a,#l_XINIT>>8
   4229 60 29               100 	jz	00003$
   422B 74 57               101 	mov	a,#s_XINIT
   422D 24 00               102 	add	a,#l_XINIT
   422F F9                  103 	mov	r1,a
   4230 74 42               104 	mov	a,#s_XINIT>>8
   4232 34 00               105 	addc	a,#l_XINIT>>8
   4234 FA                  106 	mov	r2,a
   4235 90 42 57            107 	mov	dptr,#s_XINIT
   4238 78 00               108 	mov	r0,#s_XISEG
   423A 75 A0 00            109 	mov	p2,#(s_XISEG >> 8)
   423D E4                  110 00001$:	clr	a
   423E 93                  111 	movc	a,@a+dptr
   423F F2                  112 	movx	@r0,a
   4240 A3                  113 	inc	dptr
   4241 08                  114 	inc	r0
   4242 B8 00 02            115 	cjne	r0,#0,00002$
   4245 05 A0               116 	inc	p2
   4247 E5 82               117 00002$:	mov	a,dpl
   4249 B5 01 F1            118 	cjne	a,ar1,00001$
   424C E5 83               119 	mov	a,dph
   424E B5 02 EC            120 	cjne	a,ar2,00001$
   4251 75 A0 FF            121 	mov	p2,#0xFF
   4254                     122 00003$:
                            123 ;	_mcs51_genXINIT() end
                            124 	.area GSFINAL (CODE)
   4254 02 40 33            125 	ljmp	__sdcc_program_startup
                            126 ;--------------------------------------------------------
                            127 ; Home
                            128 ;--------------------------------------------------------
                            129 	.area HOME    (CODE)
                            130 	.area CSEG    (CODE)
                            131 ;--------------------------------------------------------
                            132 ; code
                            133 ;--------------------------------------------------------
                            134 	.area CSEG    (CODE)
   4033                     135 __sdcc_program_startup:
   4033 12 40 54            136 	lcall	_main
                            137 ;	return from main will lock up
   4036 80 FE               138 	sjmp .
                            139 ;------------------------------------------------------------
                            140 ;Allocation info for local variables in function 'fn_getchar'
                            141 ;------------------------------------------------------------
                            142 ;------------------------------------------------------------
                            143 ;main.c:21: char fn_getchar() {
                            144 ;	-----------------------------------------
                            145 ;	 function fn_getchar
                            146 ;	-----------------------------------------
   4038                     147 _fn_getchar:
                    0002    148 	ar2 = 0x02
                    0003    149 	ar3 = 0x03
                    0004    150 	ar4 = 0x04
                    0005    151 	ar5 = 0x05
                    0006    152 	ar6 = 0x06
                    0007    153 	ar7 = 0x07
                    0000    154 	ar0 = 0x00
                    0001    155 	ar1 = 0x01
                            156 ;main.c:25: while (RI == 0);
   4038                     157 00101$:
                            158 ;     genNot
   4038 A2 98               159 	mov	c,_RI
   403A B3                  160 	cpl	c
   403B E4                  161 	clr	a
   403C 33                  162 	rlc	a
                            163 ;     genIfx
                            164 ;       Peephole 105   removed redundant mov
   403D FA                  165 	mov  r2,a
                            166 ;     genIfxJump
                            167 ;       Peephole 109   removed ljmp by inverse jump logic
   403E 70 F8               168 	jnz  00101$
   4040                     169 00108$:
                            170 ;main.c:26: RI = 0;
                            171 ;     genAssign
   4040 C2 98               172 	clr	_RI
                            173 ;main.c:28: znak = SBUF; 
                            174 ;     genAssign
   4042 85 99 82            175 	mov	dpl,_SBUF
                            176 ;main.c:29: return znak;
                            177 ;     genRet
   4045                     178 00104$:
   4045 22                  179 	ret
                            180 ;------------------------------------------------------------
                            181 ;Allocation info for local variables in function 'fn_putchar'
                            182 ;------------------------------------------------------------
                            183 ;------------------------------------------------------------
                            184 ;main.c:32: fn_putchar(char znak) {
                            185 ;	-----------------------------------------
                            186 ;	 function fn_putchar
                            187 ;	-----------------------------------------
   4046                     188 _fn_putchar:
                            189 ;     genReceive
   4046 85 82 99            190 	mov	_SBUF,dpl
                            191 ;main.c:35: while (TI == 0);
   4049                     192 00101$:
                            193 ;     genNot
   4049 A2 99               194 	mov	c,_TI
   404B B3                  195 	cpl	c
   404C E4                  196 	clr	a
   404D 33                  197 	rlc	a
                            198 ;     genIfx
                            199 ;       Peephole 105   removed redundant mov
   404E FA                  200 	mov  r2,a
                            201 ;     genIfxJump
                            202 ;       Peephole 109   removed ljmp by inverse jump logic
   404F 70 F8               203 	jnz  00101$
   4051                     204 00108$:
                            205 ;main.c:36: TI = 0;
                            206 ;     genAssign
   4051 C2 99               207 	clr	_TI
   4053                     208 00104$:
   4053 22                  209 	ret
                            210 ;------------------------------------------------------------
                            211 ;Allocation info for local variables in function 'main'
                            212 ;------------------------------------------------------------
                            213 ;a                         Allocated to registers r2 
                            214 ;b                         Allocated to registers r4 
                            215 ;a1                        Allocated to registers r2 
                            216 ;a2                        Allocated to registers r3 
                            217 ;b1                        Allocated to registers r4 
                            218 ;b2                        Allocated to registers r5 
                            219 ;c                         Allocated to registers r5 
                            220 ;o                         Allocated to registers r3 
                            221 ;r                         Allocated to registers r5 
                            222 ;------------------------------------------------------------
                            223 ;main.c:39: void main(void) {
                            224 ;	-----------------------------------------
                            225 ;	 function main
                            226 ;	-----------------------------------------
   4054                     227 _main:
                            228 ;main.c:47: SCON = 0x50;
                            229 ;     genAssign
   4054 75 98 50            230 	mov	_SCON,#0x50
                            231 ;main.c:50: TMOD &= 0x0f;
                            232 ;     genAnd
   4057 53 89 0F            233 	anl	_TMOD,#0x0F
                            234 ;main.c:51: TMOD |= 0x20;
                            235 ;     genOr
   405A 43 89 20            236 	orl	_TMOD,#0x20
                            237 ;main.c:54: TCON = 0x40;
                            238 ;     genAssign
   405D 75 88 40            239 	mov	_TCON,#0x40
                            240 ;main.c:55: PCON = 0x80;
                            241 ;     genAssign
   4060 75 87 80            242 	mov	_PCON,#0x80
                            243 ;main.c:58: TH1 = TL1 = 253;
                            244 ;     genAssign
   4063 75 8B FD            245 	mov	_TL1,#0xFD
                            246 ;     genAssign
   4066 75 8D FD            247 	mov	_TH1,#0xFD
   4069                     248 00110$:
                            249 ;main.c:62: a1 = fn_getchar();		
                            250 ;     genCall
   4069 12 40 38            251 	lcall	_fn_getchar
   406C E5 82               252 	mov	a,dpl
                            253 ;     genAssign
   406E FA                  254 	mov	r2,a
                            255 ;main.c:63: fn_putchar(a1);
                            256 ;     genCall
   406F 8A 82               257 	mov	dpl,r2
   4071 C0 02               258 	push	ar2
   4073 12 40 46            259 	lcall	_fn_putchar
   4076 D0 02               260 	pop	ar2
                            261 ;main.c:64: a2 = fn_getchar();
                            262 ;     genCall
   4078 C0 02               263 	push	ar2
   407A 12 40 38            264 	lcall	_fn_getchar
   407D E5 82               265 	mov	a,dpl
   407F D0 02               266 	pop	ar2
                            267 ;     genAssign
   4081 FB                  268 	mov	r3,a
                            269 ;main.c:65: fn_putchar(a2);
                            270 ;     genCall
   4082 8B 82               271 	mov	dpl,r3
   4084 C0 02               272 	push	ar2
   4086 C0 03               273 	push	ar3
   4088 12 40 46            274 	lcall	_fn_putchar
   408B D0 03               275 	pop	ar3
   408D D0 02               276 	pop	ar2
                            277 ;main.c:67: a = (a1 -'0') * 10 + (a2 - '0');
                            278 ;     genMinus
   408F EA                  279 	mov	a,r2
   4090 24 D0               280 	add	a,#0xd0
                            281 ;     genMult
                            282 ;     genMultOneByte
   4092 C2 D5               283 	clr	F0
   4094 30 E7 04            284 	jnb	acc.7,00118$
   4097 D2 D5               285 	setb	F0
   4099 F4                  286 	cpl	a
   409A 04                  287 	inc	a
   409B                     288 00118$:
   409B 75 F0 0A            289 	mov	b,#0x0a
   409E A4                  290 	mul	ab
   409F 30 D5 0A            291 	jnb	F0,00119$
   40A2 F4                  292 	cpl	a
   40A3 24 01               293 	add	a,#1
   40A5 C5 F0               294 	xch	a,b
   40A7 F4                  295 	cpl	a
   40A8 34 00               296 	addc	a,#0
   40AA C5 F0               297 	xch	a,b
   40AC                     298 00119$:
   40AC FA                  299 	mov	r2,a
   40AD AC F0               300 	mov	r4,b
                            301 ;     genMinus
   40AF EB                  302 	mov	a,r3
   40B0 24 D0               303 	add	a,#0xd0
                            304 ;     genCast
                            305 ;       Peephole 105   removed redundant mov
   40B2 FB                  306 	mov  r3,a
   40B3 33                  307 	rlc	a
   40B4 95 E0               308 	subb	a,acc
   40B6 FD                  309 	mov	r5,a
                            310 ;     genPlus
                            311 ;       Peephole 236g
   40B7 EB                  312 	mov  a,r3
                            313 ;       Peephole 236a
   40B8 2A                  314 	add  a,r2
   40B9 FA                  315 	mov	r2,a
                            316 ;       Peephole 236g
   40BA ED                  317 	mov  a,r5
                            318 ;       Peephole 236b
   40BB 3C                  319 	addc  a,r4
   40BC FC                  320 	mov	r4,a
                            321 ;     genCast
                            322 ;main.c:69: o = fn_getchar();
                            323 ;     genCall
   40BD C0 02               324 	push	ar2
   40BF 12 40 38            325 	lcall	_fn_getchar
   40C2 E5 82               326 	mov	a,dpl
   40C4 D0 02               327 	pop	ar2
                            328 ;     genAssign
   40C6 FB                  329 	mov	r3,a
                            330 ;main.c:70: fn_putchar(o);
                            331 ;     genCall
   40C7 8B 82               332 	mov	dpl,r3
   40C9 C0 02               333 	push	ar2
   40CB C0 03               334 	push	ar3
   40CD 12 40 46            335 	lcall	_fn_putchar
   40D0 D0 03               336 	pop	ar3
   40D2 D0 02               337 	pop	ar2
                            338 ;main.c:72: b1 = fn_getchar();		
                            339 ;     genCall
   40D4 C0 02               340 	push	ar2
   40D6 C0 03               341 	push	ar3
   40D8 12 40 38            342 	lcall	_fn_getchar
   40DB E5 82               343 	mov	a,dpl
   40DD D0 03               344 	pop	ar3
   40DF D0 02               345 	pop	ar2
                            346 ;     genAssign
   40E1 FC                  347 	mov	r4,a
                            348 ;main.c:73: fn_putchar(b1);
                            349 ;     genCall
   40E2 8C 82               350 	mov	dpl,r4
   40E4 C0 02               351 	push	ar2
   40E6 C0 03               352 	push	ar3
   40E8 C0 04               353 	push	ar4
   40EA 12 40 46            354 	lcall	_fn_putchar
   40ED D0 04               355 	pop	ar4
   40EF D0 03               356 	pop	ar3
   40F1 D0 02               357 	pop	ar2
                            358 ;main.c:74: b2 = fn_getchar();
                            359 ;     genCall
   40F3 C0 02               360 	push	ar2
   40F5 C0 03               361 	push	ar3
   40F7 C0 04               362 	push	ar4
   40F9 12 40 38            363 	lcall	_fn_getchar
   40FC E5 82               364 	mov	a,dpl
   40FE D0 04               365 	pop	ar4
   4100 D0 03               366 	pop	ar3
   4102 D0 02               367 	pop	ar2
                            368 ;     genAssign
   4104 FD                  369 	mov	r5,a
                            370 ;main.c:75: fn_putchar(b2);
                            371 ;     genCall
   4105 8D 82               372 	mov	dpl,r5
   4107 C0 02               373 	push	ar2
   4109 C0 03               374 	push	ar3
   410B C0 04               375 	push	ar4
   410D C0 05               376 	push	ar5
   410F 12 40 46            377 	lcall	_fn_putchar
   4112 D0 05               378 	pop	ar5
   4114 D0 04               379 	pop	ar4
   4116 D0 03               380 	pop	ar3
   4118 D0 02               381 	pop	ar2
                            382 ;main.c:77: b = (b1 - '0') * 10 + (b2 - '0');
                            383 ;     genMinus
   411A EC                  384 	mov	a,r4
   411B 24 D0               385 	add	a,#0xd0
                            386 ;     genMult
                            387 ;     genMultOneByte
   411D C2 D5               388 	clr	F0
   411F 30 E7 04            389 	jnb	acc.7,00120$
   4122 D2 D5               390 	setb	F0
   4124 F4                  391 	cpl	a
   4125 04                  392 	inc	a
   4126                     393 00120$:
   4126 75 F0 0A            394 	mov	b,#0x0a
   4129 A4                  395 	mul	ab
   412A 30 D5 0A            396 	jnb	F0,00121$
   412D F4                  397 	cpl	a
   412E 24 01               398 	add	a,#1
   4130 C5 F0               399 	xch	a,b
   4132 F4                  400 	cpl	a
   4133 34 00               401 	addc	a,#0
   4135 C5 F0               402 	xch	a,b
   4137                     403 00121$:
   4137 FC                  404 	mov	r4,a
   4138 AE F0               405 	mov	r6,b
                            406 ;     genMinus
   413A ED                  407 	mov	a,r5
   413B 24 D0               408 	add	a,#0xd0
                            409 ;     genCast
                            410 ;       Peephole 105   removed redundant mov
   413D FD                  411 	mov  r5,a
   413E 33                  412 	rlc	a
   413F 95 E0               413 	subb	a,acc
   4141 FF                  414 	mov	r7,a
                            415 ;     genPlus
                            416 ;       Peephole 236g
   4142 ED                  417 	mov  a,r5
                            418 ;       Peephole 236a
   4143 2C                  419 	add  a,r4
   4144 FC                  420 	mov	r4,a
                            421 ;       Peephole 236g
   4145 EF                  422 	mov  a,r7
                            423 ;       Peephole 236b
   4146 3E                  424 	addc  a,r6
   4147 FE                  425 	mov	r6,a
                            426 ;     genCast
                            427 ;main.c:79: c = fn_getchar();
                            428 ;     genCall
   4148 C0 02               429 	push	ar2
   414A C0 03               430 	push	ar3
   414C C0 04               431 	push	ar4
   414E 12 40 38            432 	lcall	_fn_getchar
   4151 E5 82               433 	mov	a,dpl
   4153 D0 04               434 	pop	ar4
   4155 D0 03               435 	pop	ar3
   4157 D0 02               436 	pop	ar2
                            437 ;     genAssign
   4159 FD                  438 	mov	r5,a
                            439 ;main.c:80: fn_putchar(c);
                            440 ;     genCall
   415A 8D 82               441 	mov	dpl,r5
   415C C0 02               442 	push	ar2
   415E C0 03               443 	push	ar3
   4160 C0 04               444 	push	ar4
   4162 C0 05               445 	push	ar5
   4164 12 40 46            446 	lcall	_fn_putchar
   4167 D0 05               447 	pop	ar5
   4169 D0 04               448 	pop	ar4
   416B D0 03               449 	pop	ar3
   416D D0 02               450 	pop	ar2
                            451 ;main.c:82: if (c == ' ' || c == '=') {
                            452 ;     genCmpEq
   416F BD 20 02            453 	cjne	r5,#0x20,00122$
                            454 ;       Peephole 132   changed ljmp to sjmp
   4172 80 08               455 	sjmp 00106$
   4174                     456 00122$:
                            457 ;     genCmpEq
   4174 BD 3D 02            458 	cjne	r5,#0x3D,00123$
   4177 80 03               459 	sjmp	00124$
   4179                     460 00123$:
   4179 02 40 69            461 	ljmp	00110$
   417C                     462 00124$:
   417C                     463 00106$:
                            464 ;main.c:83: fn_putchar('=');
                            465 ;     genCall
   417C 75 82 3D            466 	mov	dpl,#0x3D
   417F C0 02               467 	push	ar2
   4181 C0 03               468 	push	ar3
   4183 C0 04               469 	push	ar4
   4185 12 40 46            470 	lcall	_fn_putchar
   4188 D0 04               471 	pop	ar4
   418A D0 03               472 	pop	ar3
   418C D0 02               473 	pop	ar2
                            474 ;main.c:85: if (o == '+') {
                            475 ;     genCmpEq
                            476 ;       Peephole 132   changed ljmp to sjmp
                            477 ;       Peephole 199   optimized misc jump sequence
   418E BB 2B 05            478 	cjne r3,#0x2B,00104$
                            479 ;00125$:
                            480 ;       Peephole 200   removed redundant sjmp
   4191                     481 00126$:
                            482 ;main.c:86: r = a + b;
                            483 ;     genPlus
                            484 ;       Peephole 236g
   4191 EC                  485 	mov  a,r4
                            486 ;       Peephole 236a
   4192 2A                  487 	add  a,r2
   4193 FD                  488 	mov	r5,a
                            489 ;       Peephole 132   changed ljmp to sjmp
   4194 80 07               490 	sjmp 00105$
   4196                     491 00104$:
                            492 ;main.c:87: } else if (o == '-') {
                            493 ;     genCmpEq
                            494 ;       Peephole 132   changed ljmp to sjmp
                            495 ;       Peephole 199   optimized misc jump sequence
   4196 BB 2D 04            496 	cjne r3,#0x2D,00105$
                            497 ;00127$:
                            498 ;       Peephole 200   removed redundant sjmp
   4199                     499 00128$:
                            500 ;main.c:88: r = a - b;
                            501 ;     genMinus
   4199 EA                  502 	mov	a,r2
   419A C3                  503 	clr	c
                            504 ;       Peephole 236l
   419B 9C                  505 	subb  a,r4
   419C FD                  506 	mov	r5,a
   419D                     507 00105$:
                            508 ;main.c:91: fn_putchar((r % 100) + '0');
                            509 ;     genMod
                            510 ;     genModOneByte
   419D ED                  511 	mov	a,r5
   419E 64 64               512 	xrl	a,#0x64
   41A0 C0 E0               513 	push	acc
   41A2 74 64               514 	mov	a,#0x64
   41A4 30 E7 02            515 	jnb	acc.7,00129$
   41A7 F4                  516 	cpl	a
   41A8 04                  517 	inc	a
   41A9                     518 00129$:
   41A9 F5 F0               519 	mov	b,a
   41AB ED                  520 	mov	a,r5
   41AC 30 E7 02            521 	jnb	acc.7,00130$
   41AF F4                  522 	cpl	a
   41B0 04                  523 	inc	a
   41B1                     524 00130$:
   41B1 84                  525 	div	ab
   41B2 D0 E0               526 	pop	acc
   41B4 20 D2 09            527 	jb	ov,00131$
   41B7 30 E7 06            528 	jnb	acc.7,00131$
   41BA C3                  529 	clr	c
   41BB E4                  530 	clr	a
   41BC 95 F0               531 	subb	a,b
   41BE F5 F0               532 	mov	b,a
   41C0                     533 00131$:
   41C0 E5 F0               534 	mov	a,b
                            535 ;     genPlus
   41C2 24 30               536 	add	a,#0x30
   41C4 F5 82               537 	mov	dpl,a
                            538 ;     genCall
   41C6 C0 05               539 	push	ar5
   41C8 12 40 46            540 	lcall	_fn_putchar
   41CB D0 05               541 	pop	ar5
                            542 ;main.c:92: fn_putchar((r % 10) + '0');
                            543 ;     genMod
                            544 ;     genModOneByte
   41CD ED                  545 	mov	a,r5
   41CE 64 0A               546 	xrl	a,#0x0A
   41D0 C0 E0               547 	push	acc
   41D2 74 0A               548 	mov	a,#0x0A
   41D4 30 E7 02            549 	jnb	acc.7,00132$
   41D7 F4                  550 	cpl	a
   41D8 04                  551 	inc	a
   41D9                     552 00132$:
   41D9 F5 F0               553 	mov	b,a
   41DB ED                  554 	mov	a,r5
   41DC 30 E7 02            555 	jnb	acc.7,00133$
   41DF F4                  556 	cpl	a
   41E0 04                  557 	inc	a
   41E1                     558 00133$:
   41E1 84                  559 	div	ab
   41E2 D0 E0               560 	pop	acc
   41E4 20 D2 09            561 	jb	ov,00134$
   41E7 30 E7 06            562 	jnb	acc.7,00134$
   41EA C3                  563 	clr	c
   41EB E4                  564 	clr	a
   41EC 95 F0               565 	subb	a,b
   41EE F5 F0               566 	mov	b,a
   41F0                     567 00134$:
   41F0 E5 F0               568 	mov	a,b
                            569 ;     genPlus
   41F2 24 30               570 	add	a,#0x30
   41F4 F5 82               571 	mov	dpl,a
                            572 ;     genCall
   41F6 C0 05               573 	push	ar5
   41F8 12 40 46            574 	lcall	_fn_putchar
   41FB D0 05               575 	pop	ar5
                            576 ;main.c:93: fn_putchar('\0');
                            577 ;     genCall
   41FD 75 82 00            578 	mov	dpl,#0x00
   4200 C0 05               579 	push	ar5
   4202 12 40 46            580 	lcall	_fn_putchar
   4205 D0 05               581 	pop	ar5
                            582 ;main.c:94: fn_putchar(r);
                            583 ;     genCall
   4207 8D 82               584 	mov	dpl,r5
   4209 C0 05               585 	push	ar5
   420B 12 40 46            586 	lcall	_fn_putchar
   420E D0 05               587 	pop	ar5
   4210 02 40 69            588 	ljmp	00110$
   4213                     589 00112$:
   4213 22                  590 	ret
                            591 	.area CSEG    (CODE)
                            592 	.area XINIT   (CODE)
