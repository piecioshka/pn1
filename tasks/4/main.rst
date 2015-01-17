                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.3 Sat Jan 17 14:35:18 2015
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module main
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _wk_
                             12 	.globl _znak
                             13 	.globl _main
                             14 	.globl _InitLED
                             15 	.globl _LED
                             16 	.globl _U10
                             17 	.globl _U12
                             18 	.globl _U15
                             19 	.globl _key
                             20 	.globl _t
                             21 	.globl _buffer
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                    0088     25 _TCON	=	0x0088
                    0089     26 _TMOD	=	0x0089
                    008D     27 _TH1	=	0x008d
                    008B     28 _TL1	=	0x008b
                    00A8     29 _IE	=	0x00a8
                             30 ;--------------------------------------------------------
                             31 ; special function bits 
                             32 ;--------------------------------------------------------
                             33 ;--------------------------------------------------------
                             34 ; overlayable register banks 
                             35 ;--------------------------------------------------------
                             36 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                      37 	.ds 8
                             38 ;--------------------------------------------------------
                             39 ; internal ram data
                             40 ;--------------------------------------------------------
                             41 	.area DSEG    (DATA)
   0008                      42 _buffer::
   0008                      43 	.ds 4
   000C                      44 _t::
   000C                      45 	.ds 1
   000D                      46 _key::
   000D                      47 	.ds 1
                             48 ;--------------------------------------------------------
                             49 ; overlayable items in internal ram 
                             50 ;--------------------------------------------------------
                             51 	.area OSEG    (OVR,DATA)
                             52 ;--------------------------------------------------------
                             53 ; Stack segment in internal ram 
                             54 ;--------------------------------------------------------
                             55 	.area	SSEG	(DATA)
   000E                      56 __start__stack:
   000E                      57 	.ds	1
                             58 
                             59 ;--------------------------------------------------------
                             60 ; indirectly addressable internal ram data
                             61 ;--------------------------------------------------------
                             62 	.area ISEG    (DATA)
                             63 ;--------------------------------------------------------
                             64 ; bit data
                             65 ;--------------------------------------------------------
                             66 	.area BSEG    (BIT)
                             67 ;--------------------------------------------------------
                             68 ; external ram data
                             69 ;--------------------------------------------------------
                             70 	.area XSEG    (XDATA)
                    8000     71 _U15	=	0x8000
                    8000     72 _U12	=	0x8000
                    FFFF     73 _U10	=	0xffff
                             74 ;--------------------------------------------------------
                             75 ; external initialized ram data
                             76 ;--------------------------------------------------------
                             77 	.area XISEG   (XDATA)
                             78 ;--------------------------------------------------------
                             79 ; interrupt vector 
                             80 ;--------------------------------------------------------
                             81 	.area CSEG    (CODE)
   4000                      82 __interrupt_vect:
   4000 02 41 02             83 	ljmp	__sdcc_gsinit_startup
   4003 32                   84 	reti
   4004                      85 	.ds	7
   400B 02 40 38             86 	ljmp	_LED
   400E                      87 	.ds	5
   4013 32                   88 	reti
   4014                      89 	.ds	7
   401B 32                   90 	reti
   401C                      91 	.ds	7
   4023 32                   92 	reti
   4024                      93 	.ds	7
   402B 32                   94 	reti
   402C                      95 	.ds	7
                             96 ;--------------------------------------------------------
                             97 ; global & static initialisations
                             98 ;--------------------------------------------------------
                             99 	.area GSINIT  (CODE)
                            100 	.area GSFINAL (CODE)
                            101 	.area GSINIT  (CODE)
   4102                     102 __sdcc_gsinit_startup:
   4102 75 81 0D            103 	mov	sp,#__start__stack - 1
   4105 12 40 FE            104 	lcall	__sdcc_external_startup
   4108 E5 82               105 	mov	a,dpl
   410A 60 03               106 	jz	__sdcc_init_data
   410C 02 40 33            107 	ljmp	__sdcc_program_startup
   410F                     108 __sdcc_init_data:
                            109 ;	_mcs51_genXINIT() start
   410F 74 00               110 	mov	a,#l_XINIT
   4111 44 00               111 	orl	a,#l_XINIT>>8
   4113 60 29               112 	jz	00003$
   4115 74 53               113 	mov	a,#s_XINIT
   4117 24 00               114 	add	a,#l_XINIT
   4119 F9                  115 	mov	r1,a
   411A 74 41               116 	mov	a,#s_XINIT>>8
   411C 34 00               117 	addc	a,#l_XINIT>>8
   411E FA                  118 	mov	r2,a
   411F 90 41 53            119 	mov	dptr,#s_XINIT
   4122 78 00               120 	mov	r0,#s_XISEG
   4124 75 A0 00            121 	mov	p2,#(s_XISEG >> 8)
   4127 E4                  122 00001$:	clr	a
   4128 93                  123 	movc	a,@a+dptr
   4129 F2                  124 	movx	@r0,a
   412A A3                  125 	inc	dptr
   412B 08                  126 	inc	r0
   412C B8 00 02            127 	cjne	r0,#0,00002$
   412F 05 A0               128 	inc	p2
   4131 E5 82               129 00002$:	mov	a,dpl
   4133 B5 01 F1            130 	cjne	a,ar1,00001$
   4136 E5 83               131 	mov	a,dph
   4138 B5 02 EC            132 	cjne	a,ar2,00001$
   413B 75 A0 FF            133 	mov	p2,#0xFF
   413E                     134 00003$:
                            135 ;	_mcs51_genXINIT() end
                            136 ;N:\projects\pn1-labs\tasks\4\main.c:58: unsigned char buffer[4] = {0, 0, 0, 0};
                            137 ;     genPointerSet
                            138 ;     genNearPointerSet
                            139 ;     genDataPointerSet
   413E 75 08 00            140 	mov	_buffer,#0x00
                            141 ;     genPointerSet
                            142 ;     genNearPointerSet
                            143 ;     genDataPointerSet
   4141 75 09 00            144 	mov	(_buffer + 0x0001),#0x00
                            145 ;     genPointerSet
                            146 ;     genNearPointerSet
                            147 ;     genDataPointerSet
   4144 75 0A 00            148 	mov	(_buffer + 0x0002),#0x00
                            149 ;     genPointerSet
                            150 ;     genNearPointerSet
                            151 ;     genDataPointerSet
   4147 75 0B 00            152 	mov	(_buffer + 0x0003),#0x00
                            153 ;N:\projects\pn1-labs\tasks\4\main.c:59: unsigned char t = 0;
                            154 ;     genAssign
   414A 75 0C 00            155 	mov	_t,#0x00
                            156 ;N:\projects\pn1-labs\tasks\4\main.c:60: unsigned char key = 0;
                            157 ;     genAssign
   414D 75 0D 00            158 	mov	_key,#0x00
                            159 	.area GSFINAL (CODE)
   4150 02 40 33            160 	ljmp	__sdcc_program_startup
                            161 ;--------------------------------------------------------
                            162 ; Home
                            163 ;--------------------------------------------------------
                            164 	.area HOME    (CODE)
                            165 	.area CSEG    (CODE)
                            166 ;--------------------------------------------------------
                            167 ; code
                            168 ;--------------------------------------------------------
                            169 	.area CSEG    (CODE)
   4033                     170 __sdcc_program_startup:
   4033 12 40 C3            171 	lcall	_main
                            172 ;	return from main will lock up
   4036 80 FE               173 	sjmp .
                            174 ;------------------------------------------------------------
                            175 ;Allocation info for local variables in function 'LED'
                            176 ;------------------------------------------------------------
                            177 ;zz                        Allocated to registers r2 
                            178 ;------------------------------------------------------------
                            179 ;N:\projects\pn1-labs\tasks\4\main.c:62: void LED(void) interrupt 1
                            180 ;	-----------------------------------------
                            181 ;	 function LED
                            182 ;	-----------------------------------------
   4038                     183 _LED:
                    0002    184 	ar2 = 0x02
                    0003    185 	ar3 = 0x03
                    0004    186 	ar4 = 0x04
                    0005    187 	ar5 = 0x05
                    0006    188 	ar6 = 0x06
                    0007    189 	ar7 = 0x07
                    0000    190 	ar0 = 0x00
                    0001    191 	ar1 = 0x01
   4038 C0 E0               192 	push	acc
   403A C0 F0               193 	push	b
   403C C0 82               194 	push	dpl
   403E C0 83               195 	push	dph
   4040 C0 02               196 	push	ar2
   4042 C0 00               197 	push	ar0
   4044 C0 D0               198 	push	psw
   4046 75 D0 00            199 	mov	psw,#0x00
                            200 ;N:\projects\pn1-labs\tasks\4\main.c:66: U10 = cyfra_n;
                            201 ;     genAssign
   4049 90 FF FF            202 	mov	dptr,#_U10
                            203 ;       Peephole 180   changed mov to clr
   404C E4                  204 	clr  a
   404D F0                  205 	movx	@dptr,a
                            206 ;N:\projects\pn1-labs\tasks\4\main.c:67: U15 = wk_[t];
                            207 ;     genPlus
   404E E5 0C               208 	mov	a,_t
                            209 ;       Peephole 180   changed mov to clr
                            210 ;     genPointerGet
                            211 ;     genCodePointerGet
                            212 ;       Peephole 186   optimized movc sequence
   4050 90 40 FA            213 	mov  dptr,#_wk_
   4053 93                  214 	movc a,@a+dptr
                            215 ;     genAssign
                            216 ;       Peephole 100   removed redundant mov
   4054 FA                  217 	mov  r2,a
   4055 90 80 00            218 	mov  dptr,#_U15
   4058 F0                  219 	movx @dptr,a
                            220 ;N:\projects\pn1-labs\tasks\4\main.c:70: zz = (U12 & 0xf0) >> 4;
                            221 ;     genAssign
   4059 90 80 00            222 	mov	dptr,#_U12
   405C E0                  223 	movx	a,@dptr
                            224 ;     genAnd
                            225 ;     genRightShift
                            226 ;     genRightShiftLiteral
                            227 ;     genrshOne
                            228 ;       Peephole 139   removed redundant mov
   405D 54 F0               229 	anl  a,#0xF0
   405F FA                  230 	mov  r2,a
   4060 C4                  231 	swap	a
   4061 54 0F               232 	anl	a,#0x0f
   4063 FA                  233 	mov	r2,a
                            234 ;N:\projects\pn1-labs\tasks\4\main.c:72: if(zz != 0x0f){
                            235 ;     genCmpEq
   4064 BA 0F 02            236 	cjne	r2,#0x0F,00121$
                            237 ;       Peephole 132   changed ljmp to sjmp
   4067 80 27               238 	sjmp 00113$
   4069                     239 00121$:
                            240 ;N:\projects\pn1-labs\tasks\4\main.c:74: if(zz == 0x07)    // 0111
                            241 ;     genCmpEq
                            242 ;       Peephole 132   changed ljmp to sjmp
                            243 ;       Peephole 199   optimized misc jump sequence
   4069 BA 07 05            244 	cjne r2,#0x07,00110$
                            245 ;00122$:
                            246 ;       Peephole 200   removed redundant sjmp
   406C                     247 00123$:
                            248 ;N:\projects\pn1-labs\tasks\4\main.c:75: key = 0x00 | t; // 0000
                            249 ;     genOr
   406C 85 0C 0D            250 	mov	_key,_t
                            251 ;       Peephole 132   changed ljmp to sjmp
   406F 80 1F               252 	sjmp 00113$
   4071                     253 00110$:
                            254 ;N:\projects\pn1-labs\tasks\4\main.c:77: if(zz == 0x0b)    // 1011
                            255 ;     genCmpEq
                            256 ;       Peephole 132   changed ljmp to sjmp
                            257 ;       Peephole 199   optimized misc jump sequence
   4071 BA 0B 08            258 	cjne r2,#0x0B,00107$
                            259 ;00124$:
                            260 ;       Peephole 200   removed redundant sjmp
   4074                     261 00125$:
                            262 ;N:\projects\pn1-labs\tasks\4\main.c:78: key = 0x04 | t; // ... (0100)
                            263 ;     genOr
   4074 74 04               264 	mov	a,#0x04
   4076 45 0C               265 	orl	a,_t
   4078 F5 0D               266 	mov	_key,a
                            267 ;       Peephole 132   changed ljmp to sjmp
   407A 80 14               268 	sjmp 00113$
   407C                     269 00107$:
                            270 ;N:\projects\pn1-labs\tasks\4\main.c:80: if(zz == 0x0d)    // ... (1101)
                            271 ;     genCmpEq
                            272 ;       Peephole 132   changed ljmp to sjmp
                            273 ;       Peephole 199   optimized misc jump sequence
   407C BA 0D 08            274 	cjne r2,#0x0D,00104$
                            275 ;00126$:
                            276 ;       Peephole 200   removed redundant sjmp
   407F                     277 00127$:
                            278 ;N:\projects\pn1-labs\tasks\4\main.c:81: key = 0x08 | t; // ... (1000)
                            279 ;     genOr
   407F 74 08               280 	mov	a,#0x08
   4081 45 0C               281 	orl	a,_t
   4083 F5 0D               282 	mov	_key,a
                            283 ;       Peephole 132   changed ljmp to sjmp
   4085 80 09               284 	sjmp 00113$
   4087                     285 00104$:
                            286 ;N:\projects\pn1-labs\tasks\4\main.c:83: if(zz == 0x0e)    // 1110
                            287 ;     genCmpEq
                            288 ;       Peephole 132   changed ljmp to sjmp
                            289 ;       Peephole 199   optimized misc jump sequence
   4087 BA 0E 06            290 	cjne r2,#0x0E,00113$
                            291 ;00128$:
                            292 ;       Peephole 200   removed redundant sjmp
   408A                     293 00129$:
                            294 ;N:\projects\pn1-labs\tasks\4\main.c:84: key = 0x0c | t; // 1100
                            295 ;     genOr
   408A 74 0C               296 	mov	a,#0x0C
   408C 45 0C               297 	orl	a,_t
   408E F5 0D               298 	mov	_key,a
   4090                     299 00113$:
                            300 ;N:\projects\pn1-labs\tasks\4\main.c:87: U10 = buffer[t];
                            301 ;     genPlus
   4090 E5 0C               302 	mov	a,_t
   4092 24 08               303 	add	a,#_buffer
   4094 F8                  304 	mov	r0,a
                            305 ;     genPointerGet
                            306 ;     genNearPointerGet
   4095 90 FF FF            307 	mov	dptr,#_U10
   4098 E6                  308 	mov	a,@r0
   4099 F0                  309 	movx	@dptr,a
                            310 ;N:\projects\pn1-labs\tasks\4\main.c:89: t++;
                            311 ;     genPlus
                            312 ;     genPlusIncr
   409A 05 0C               313 	inc	_t
                            314 ;N:\projects\pn1-labs\tasks\4\main.c:90: t &= 0x03; // ... (Dzialamy tylko na 4 wyswietlaczach)
                            315 ;     genAnd
   409C 53 0C 03            316 	anl	_t,#0x03
   409F                     317 00114$:
   409F D0 D0               318 	pop	psw
   40A1 D0 00               319 	pop	ar0
   40A3 D0 02               320 	pop	ar2
   40A5 D0 83               321 	pop	dph
   40A7 D0 82               322 	pop	dpl
   40A9 D0 F0               323 	pop	b
   40AB D0 E0               324 	pop	acc
   40AD 32                  325 	reti
                            326 ;------------------------------------------------------------
                            327 ;Allocation info for local variables in function 'InitLED'
                            328 ;------------------------------------------------------------
                            329 ;------------------------------------------------------------
                            330 ;N:\projects\pn1-labs\tasks\4\main.c:94: void InitLED(void)
                            331 ;	-----------------------------------------
                            332 ;	 function InitLED
                            333 ;	-----------------------------------------
   40AE                     334 _InitLED:
                            335 ;N:\projects\pn1-labs\tasks\4\main.c:96: TMOD = (TMOD & 0xf0) | 0x02; // ... (Ustawienie trybu pracy licznika)
                            336 ;     genAnd
   40AE 74 F0               337 	mov	a,#0xF0
   40B0 55 89               338 	anl	a,_TMOD
                            339 ;     genOr
   40B2 44 02               340 	orl	a,#0x02
   40B4 F5 89               341 	mov	_TMOD,a
                            342 ;N:\projects\pn1-labs\tasks\4\main.c:97: TCON = 0x10; // ... (Uruchamiamy przerwania licznik)
                            343 ;     genAssign
   40B6 75 88 10            344 	mov	_TCON,#0x10
                            345 ;N:\projects\pn1-labs\tasks\4\main.c:98: TL1 = TH1 = 0x06; // ..., ..., ... (Ustawienie predkosci transmisji)
                            346 ;     genAssign
   40B9 75 8D 06            347 	mov	_TH1,#0x06
                            348 ;     genAssign
   40BC 75 8B 06            349 	mov	_TL1,#0x06
                            350 ;N:\projects\pn1-labs\tasks\4\main.c:99: IE = 0x82; // ... (Zezwolenie na przyjmowanie przerwan)
                            351 ;     genAssign
   40BF 75 A8 82            352 	mov	_IE,#0x82
   40C2                     353 00101$:
   40C2 22                  354 	ret
                            355 ;------------------------------------------------------------
                            356 ;Allocation info for local variables in function 'main'
                            357 ;------------------------------------------------------------
                            358 ;------------------------------------------------------------
                            359 ;N:\projects\pn1-labs\tasks\4\main.c:103: void main(void){
                            360 ;	-----------------------------------------
                            361 ;	 function main
                            362 ;	-----------------------------------------
   40C3                     363 _main:
                            364 ;N:\projects\pn1-labs\tasks\4\main.c:105: InitLED();
                            365 ;     genCall
   40C3 12 40 AE            366 	lcall	_InitLED
   40C6                     367 00102$:
                            368 ;N:\projects\pn1-labs\tasks\4\main.c:109: buffer[0] = znak[~U12 & 0x0f];
                            369 ;     genAssign
   40C6 90 80 00            370 	mov	dptr,#_U12
   40C9 E0                  371 	movx	a,@dptr
                            372 ;     genCpl
                            373 ;       Peephole 105   removed redundant mov
                            374 ;       Peephole 184   removed redundant mov
   40CA F4                  375 	cpl  a
   40CB FA                  376 	mov  r2,a
                            377 ;     genAnd
   40CC 74 0F               378 	mov	a,#0x0F
   40CE 5A                  379 	anl	a,r2
                            380 ;     genPlus
   40CF 24 EA               381 	add	a,#_znak
   40D1 F5 82               382 	mov	dpl,a
   40D3 74 40               383 	mov	a,#(_znak >> 8)
   40D5 34 00               384 	addc	a,#0x00
   40D7 F5 83               385 	mov	dph,a
                            386 ;     genPointerGet
                            387 ;     genCodePointerGet
   40D9 E4                  388 	clr	a
   40DA 93                  389 	movc	a,@a+dptr
   40DB FA                  390 	mov	r2,a
                            391 ;     genPointerSet
                            392 ;     genNearPointerSet
                            393 ;     genDataPointerSet
   40DC 8A 08               394 	mov	_buffer,r2
                            395 ;N:\projects\pn1-labs\tasks\4\main.c:110: buffer[1] = znak[key];
                            396 ;     genPlus
   40DE E5 0D               397 	mov	a,_key
                            398 ;       Peephole 180   changed mov to clr
                            399 ;     genPointerGet
                            400 ;     genCodePointerGet
                            401 ;       Peephole 186   optimized movc sequence
   40E0 90 40 EA            402 	mov  dptr,#_znak
   40E3 93                  403 	movc a,@a+dptr
   40E4 FA                  404 	mov	r2,a
                            405 ;     genPointerSet
                            406 ;     genNearPointerSet
                            407 ;     genDataPointerSet
   40E5 8A 09               408 	mov	(_buffer + 0x0001),r2
                            409 ;       Peephole 132   changed ljmp to sjmp
   40E7 80 DD               410 	sjmp 00102$
   40E9                     411 00104$:
   40E9 22                  412 	ret
                            413 	.area CSEG    (CODE)
   40EA                     414 _znak:
   40EA 5F                  415 	.db #0x5F
   40EB 44                  416 	.db #0x44
   40EC 3E                  417 	.db #0x3E
   40ED 76                  418 	.db #0x76
   40EE 65                  419 	.db #0x65
   40EF 73                  420 	.db #0x73
   40F0 7B                  421 	.db #0x7B
   40F1 46                  422 	.db #0x46
   40F2 7F                  423 	.db #0x7F
   40F3 77                  424 	.db #0x77
   40F4 6F                  425 	.db #0x6F
   40F5 79                  426 	.db #0x79
   40F6 1B                  427 	.db #0x1B
   40F7 7C                  428 	.db #0x7C
   40F8 3B                  429 	.db #0x3B
   40F9 2B                  430 	.db #0x2B
   40FA                     431 _wk_:
   40FA DE                  432 	.db #0xDE
   40FB ED                  433 	.db #0xED
   40FC 7B                  434 	.db #0x7B
   40FD B7                  435 	.db #0xB7
                            436 	.area XINIT   (CODE)
