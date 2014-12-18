                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.3 Sat Dec 13 15:15:31 2014
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module main
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _wysw
                             12 	.globl _znak
                             13 	.globl _main
                             14 	.globl _pause
                             15 	.globl _Init
                             16 	.globl _LED
                             17 	.globl _U10
                             18 	.globl _U15
                             19 	.globl _buffer
                             20 	.globl _r
                             21 ;--------------------------------------------------------
                             22 ; special function registers
                             23 ;--------------------------------------------------------
                    0088     24 _TCON	=	0x0088
                    0089     25 _TMOD	=	0x0089
                    008D     26 _TH1	=	0x008d
                    008B     27 _TL1	=	0x008b
                    00A8     28 _IE	=	0x00a8
                             29 ;--------------------------------------------------------
                             30 ; special function bits 
                             31 ;--------------------------------------------------------
                             32 ;--------------------------------------------------------
                             33 ; overlayable register banks 
                             34 ;--------------------------------------------------------
                             35 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                      36 	.ds 8
                             37 ;--------------------------------------------------------
                             38 ; internal ram data
                             39 ;--------------------------------------------------------
                             40 	.area DSEG    (DATA)
   0008                      41 _r::
   0008                      42 	.ds 1
   0009                      43 _buffer::
   0009                      44 	.ds 4
                             45 ;--------------------------------------------------------
                             46 ; overlayable items in internal ram 
                             47 ;--------------------------------------------------------
                             48 	.area	OSEG    (OVR,DATA)
                             49 ;--------------------------------------------------------
                             50 ; Stack segment in internal ram 
                             51 ;--------------------------------------------------------
                             52 	.area	SSEG	(DATA)
   000D                      53 __start__stack:
   000D                      54 	.ds	1
                             55 
                             56 ;--------------------------------------------------------
                             57 ; indirectly addressable internal ram data
                             58 ;--------------------------------------------------------
                             59 	.area ISEG    (DATA)
                             60 ;--------------------------------------------------------
                             61 ; bit data
                             62 ;--------------------------------------------------------
                             63 	.area BSEG    (BIT)
                             64 ;--------------------------------------------------------
                             65 ; external ram data
                             66 ;--------------------------------------------------------
                             67 	.area XSEG    (XDATA)
                    8000     68 _U15	=	0x8000
                    FFFF     69 _U10	=	0xffff
                             70 ;--------------------------------------------------------
                             71 ; external initialized ram data
                             72 ;--------------------------------------------------------
                             73 	.area XISEG   (XDATA)
                             74 ;--------------------------------------------------------
                             75 ; interrupt vector 
                             76 ;--------------------------------------------------------
                             77 	.area CSEG    (CODE)
   4000                      78 __interrupt_vect:
   4000 02 40 E2             79 	ljmp	__sdcc_gsinit_startup
   4003 32                   80 	reti
   4004                      81 	.ds	7
   400B 02 40 38             82 	ljmp	_LED
   400E                      83 	.ds	5
   4013 32                   84 	reti
   4014                      85 	.ds	7
   401B 32                   86 	reti
   401C                      87 	.ds	7
   4023 32                   88 	reti
   4024                      89 	.ds	7
   402B 32                   90 	reti
   402C                      91 	.ds	7
                             92 ;--------------------------------------------------------
                             93 ; global & static initialisations
                             94 ;--------------------------------------------------------
                             95 	.area GSINIT  (CODE)
                             96 	.area GSFINAL (CODE)
                             97 	.area GSINIT  (CODE)
   40E2                      98 __sdcc_gsinit_startup:
   40E2 75 81 0C             99 	mov	sp,#__start__stack - 1
   40E5 12 40 DE            100 	lcall	__sdcc_external_startup
   40E8 E5 82               101 	mov	a,dpl
   40EA 60 03               102 	jz	__sdcc_init_data
   40EC 02 40 33            103 	ljmp	__sdcc_program_startup
   40EF                     104 __sdcc_init_data:
                            105 ;	_mcs51_genXINIT() start
   40EF 74 00               106 	mov	a,#l_XINIT
   40F1 44 00               107 	orl	a,#l_XINIT>>8
   40F3 60 29               108 	jz	00003$
   40F5 74 30               109 	mov	a,#s_XINIT
   40F7 24 00               110 	add	a,#l_XINIT
   40F9 F9                  111 	mov	r1,a
   40FA 74 41               112 	mov	a,#s_XINIT>>8
   40FC 34 00               113 	addc	a,#l_XINIT>>8
   40FE FA                  114 	mov	r2,a
   40FF 90 41 30            115 	mov	dptr,#s_XINIT
   4102 78 00               116 	mov	r0,#s_XISEG
   4104 75 A0 00            117 	mov	p2,#(s_XISEG >> 8)
   4107 E4                  118 00001$:	clr	a
   4108 93                  119 	movc	a,@a+dptr
   4109 F2                  120 	movx	@r0,a
   410A A3                  121 	inc	dptr
   410B 08                  122 	inc	r0
   410C B8 00 02            123 	cjne	r0,#0,00002$
   410F 05 A0               124 	inc	p2
   4111 E5 82               125 00002$:	mov	a,dpl
   4113 B5 01 F1            126 	cjne	a,ar1,00001$
   4116 E5 83               127 	mov	a,dph
   4118 B5 02 EC            128 	cjne	a,ar2,00001$
   411B 75 A0 FF            129 	mov	p2,#0xFF
   411E                     130 00003$:
                            131 ;	_mcs51_genXINIT() end
                            132 ;N:\projects\pn1\FDLMZB~0\3\main.c:66: unsigned char r = 0;
                            133 ;     genAssign
   411E 75 08 00            134 	mov	_r,#0x00
                            135 ;N:\projects\pn1\FDLMZB~0\3\main.c:69: unsigned char buffer[4] = {0, 0, 0, 0};
                            136 ;     genPointerSet
                            137 ;     genNearPointerSet
                            138 ;     genDataPointerSet
   4121 75 09 00            139 	mov	_buffer,#0x00
                            140 ;     genPointerSet
                            141 ;     genNearPointerSet
                            142 ;     genDataPointerSet
   4124 75 0A 00            143 	mov	(_buffer + 0x0001),#0x00
                            144 ;     genPointerSet
                            145 ;     genNearPointerSet
                            146 ;     genDataPointerSet
   4127 75 0B 00            147 	mov	(_buffer + 0x0002),#0x00
                            148 ;     genPointerSet
                            149 ;     genNearPointerSet
                            150 ;     genDataPointerSet
   412A 75 0C 00            151 	mov	(_buffer + 0x0003),#0x00
                            152 	.area GSFINAL (CODE)
   412D 02 40 33            153 	ljmp	__sdcc_program_startup
                            154 ;--------------------------------------------------------
                            155 ; Home
                            156 ;--------------------------------------------------------
                            157 	.area HOME    (CODE)
                            158 	.area CSEG    (CODE)
                            159 ;--------------------------------------------------------
                            160 ; code
                            161 ;--------------------------------------------------------
                            162 	.area CSEG    (CODE)
   4033                     163 __sdcc_program_startup:
   4033 12 40 A1            164 	lcall	_main
                            165 ;	return from main will lock up
   4036 80 FE               166 	sjmp .
                            167 ;------------------------------------------------------------
                            168 ;Allocation info for local variables in function 'LED'
                            169 ;------------------------------------------------------------
                            170 ;------------------------------------------------------------
                            171 ;N:\projects\pn1\FDLMZB~0\3\main.c:71: void LED(void) interrupt 1 {
                            172 ;	-----------------------------------------
                            173 ;	 function LED
                            174 ;	-----------------------------------------
   4038                     175 _LED:
                    0002    176 	ar2 = 0x02
                    0003    177 	ar3 = 0x03
                    0004    178 	ar4 = 0x04
                    0005    179 	ar5 = 0x05
                    0006    180 	ar6 = 0x06
                    0007    181 	ar7 = 0x07
                    0000    182 	ar0 = 0x00
                    0001    183 	ar1 = 0x01
   4038 C0 E0               184 	push	acc
   403A C0 F0               185 	push	b
   403C C0 82               186 	push	dpl
   403E C0 83               187 	push	dph
   4040 C0 02               188 	push	ar2
   4042 C0 00               189 	push	ar0
   4044 C0 D0               190 	push	psw
   4046 75 D0 00            191 	mov	psw,#0x00
                            192 ;N:\projects\pn1\FDLMZB~0\3\main.c:73: U10 = cyfra_n;
                            193 ;     genAssign
   4049 90 FF FF            194 	mov	dptr,#_U10
                            195 ;       Peephole 180   changed mov to clr
   404C E4                  196 	clr  a
   404D F0                  197 	movx	@dptr,a
                            198 ;N:\projects\pn1\FDLMZB~0\3\main.c:76: U15 = wysw[r];
                            199 ;     genPlus
   404E E5 08               200 	mov	a,_r
                            201 ;       Peephole 180   changed mov to clr
                            202 ;     genPointerGet
                            203 ;     genCodePointerGet
                            204 ;       Peephole 186   optimized movc sequence
   4050 90 40 DA            205 	mov  dptr,#_wysw
   4053 93                  206 	movc a,@a+dptr
                            207 ;     genAssign
                            208 ;       Peephole 100   removed redundant mov
   4054 FA                  209 	mov  r2,a
   4055 90 80 00            210 	mov  dptr,#_U15
   4058 F0                  211 	movx @dptr,a
                            212 ;N:\projects\pn1\FDLMZB~0\3\main.c:79: U10 = znak[buffer[r]]; 
                            213 ;     genPlus
   4059 E5 08               214 	mov	a,_r
   405B 24 09               215 	add	a,#_buffer
   405D F8                  216 	mov	r0,a
                            217 ;     genPointerGet
                            218 ;     genNearPointerGet
   405E 86 02               219 	mov	ar2,@r0
                            220 ;     genPlus
                            221 ;       Peephole 236g
   4060 EA                  222 	mov  a,r2
                            223 ;       Peephole 180   changed mov to clr
                            224 ;     genPointerGet
                            225 ;     genCodePointerGet
                            226 ;       Peephole 186   optimized movc sequence
   4061 90 40 CA            227 	mov  dptr,#_znak
   4064 93                  228 	movc a,@a+dptr
                            229 ;     genAssign
                            230 ;       Peephole 100   removed redundant mov
   4065 FA                  231 	mov  r2,a
   4066 90 FF FF            232 	mov  dptr,#_U10
   4069 F0                  233 	movx @dptr,a
                            234 ;N:\projects\pn1\FDLMZB~0\3\main.c:82: r++;
                            235 ;     genPlus
                            236 ;     genPlusIncr
   406A 05 08               237 	inc	_r
                            238 ;N:\projects\pn1\FDLMZB~0\3\main.c:85: r &= 0x03;
                            239 ;     genAnd
   406C 53 08 03            240 	anl	_r,#0x03
   406F                     241 00101$:
   406F D0 D0               242 	pop	psw
   4071 D0 00               243 	pop	ar0
   4073 D0 02               244 	pop	ar2
   4075 D0 83               245 	pop	dph
   4077 D0 82               246 	pop	dpl
   4079 D0 F0               247 	pop	b
   407B D0 E0               248 	pop	acc
   407D 32                  249 	reti
                            250 ;------------------------------------------------------------
                            251 ;Allocation info for local variables in function 'Init'
                            252 ;------------------------------------------------------------
                            253 ;------------------------------------------------------------
                            254 ;N:\projects\pn1\FDLMZB~0\3\main.c:90: void Init(void) {
                            255 ;	-----------------------------------------
                            256 ;	 function Init
                            257 ;	-----------------------------------------
   407E                     258 _Init:
                            259 ;N:\projects\pn1\FDLMZB~0\3\main.c:91: TMOD = (TMOD & 0xf0) | 0x02;
                            260 ;     genAnd
   407E 74 F0               261 	mov	a,#0xF0
   4080 55 89               262 	anl	a,_TMOD
                            263 ;     genOr
   4082 44 02               264 	orl	a,#0x02
   4084 F5 89               265 	mov	_TMOD,a
                            266 ;N:\projects\pn1\FDLMZB~0\3\main.c:94: TCON = 0x10;
                            267 ;     genAssign
   4086 75 88 10            268 	mov	_TCON,#0x10
                            269 ;N:\projects\pn1\FDLMZB~0\3\main.c:98: TL1 = TH1 = 0x06;
                            270 ;     genAssign
   4089 75 8D 06            271 	mov	_TH1,#0x06
                            272 ;     genAssign
   408C 75 8B 06            273 	mov	_TL1,#0x06
                            274 ;N:\projects\pn1\FDLMZB~0\3\main.c:101: IE = 0x82;
                            275 ;     genAssign
   408F 75 A8 82            276 	mov	_IE,#0x82
   4092                     277 00101$:
   4092 22                  278 	ret
                            279 ;------------------------------------------------------------
                            280 ;Allocation info for local variables in function 'pause'
                            281 ;------------------------------------------------------------
                            282 ;------------------------------------------------------------
                            283 ;N:\projects\pn1\FDLMZB~0\3\main.c:106: void pause() {
                            284 ;	-----------------------------------------
                            285 ;	 function pause
                            286 ;	-----------------------------------------
   4093                     287 _pause:
                            288 ;N:\projects\pn1\FDLMZB~0\3\main.c:108: for (i = 0; i < 255; i++);
                            289 ;     genAssign
   4093 7A FF               290 	mov	r2,#0xFF
   4095 7B 00               291 	mov	r3,#0x00
   4097                     292 00103$:
                            293 ;     genDjnz
                            294 ;     genMinus
                            295 ;     genMinusDec
   4097 1A                  296 	dec	r2
   4098 BA FF 01            297 	cjne	r2,#0xff,00108$
   409B 1B                  298 	dec	r3
   409C                     299 00108$:
                            300 ;     genIfx
   409C EA                  301 	mov	a,r2
   409D 4B                  302 	orl	a,r3
                            303 ;     genIfxJump
                            304 ;       Peephole 109   removed ljmp by inverse jump logic
   409E 70 F7               305 	jnz  00103$
   40A0                     306 00109$:
   40A0                     307 00104$:
   40A0 22                  308 	ret
                            309 ;------------------------------------------------------------
                            310 ;Allocation info for local variables in function 'main'
                            311 ;------------------------------------------------------------
                            312 ;r                         Allocated to registers r2 
                            313 ;------------------------------------------------------------
                            314 ;N:\projects\pn1\FDLMZB~0\3\main.c:113: void main(void) {
                            315 ;	-----------------------------------------
                            316 ;	 function main
                            317 ;	-----------------------------------------
   40A1                     318 _main:
                            319 ;N:\projects\pn1\FDLMZB~0\3\main.c:115: unsigned char r = 0;
                            320 ;     genAssign
   40A1 7A 00               321 	mov	r2,#0x00
                            322 ;N:\projects\pn1\FDLMZB~0\3\main.c:118: Init();
                            323 ;     genCall
   40A3 C0 02               324 	push	ar2
   40A5 12 40 7E            325 	lcall	_Init
   40A8 D0 02               326 	pop	ar2
   40AA                     327 00104$:
                            328 ;N:\projects\pn1\FDLMZB~0\3\main.c:122: pause();
                            329 ;     genCall
   40AA C0 02               330 	push	ar2
   40AC 12 40 93            331 	lcall	_pause
   40AF D0 02               332 	pop	ar2
                            333 ;N:\projects\pn1\FDLMZB~0\3\main.c:125: if (r == 255) {
                            334 ;     genCmpEq
                            335 ;       Peephole 132   changed ljmp to sjmp
                            336 ;       Peephole 199   optimized misc jump sequence
   40B1 BA FF 12            337 	cjne r2,#0xFF,00102$
                            338 ;00110$:
                            339 ;       Peephole 200   removed redundant sjmp
   40B4                     340 00111$:
                            341 ;N:\projects\pn1\FDLMZB~0\3\main.c:127: buffer[1]++;
                            342 ;     genPointerGet
                            343 ;     genNearPointerGet
                            344 ;     genDataPointerGet
   40B4 AB 0A               345 	mov	r3,(_buffer + 0x0001)
                            346 ;     genPlus
                            347 ;     genPlusIncr
   40B6 0B                  348 	inc	r3
                            349 ;     genPointerSet
                            350 ;     genNearPointerSet
                            351 ;     genDataPointerSet
   40B7 8B 0A               352 	mov	(_buffer + 0x0001),r3
                            353 ;N:\projects\pn1\FDLMZB~0\3\main.c:129: buffer[1] = buffer[1] & 0x0f;
                            354 ;     genAnd
   40B9 53 03 0F            355 	anl	ar3,#0x0F
                            356 ;     genPointerSet
                            357 ;     genNearPointerSet
                            358 ;     genDataPointerSet
   40BC 8B 0A               359 	mov	(_buffer + 0x0001),r3
                            360 ;N:\projects\pn1\FDLMZB~0\3\main.c:132: buffer[0] = 0x0f - buffer[1];
                            361 ;     genMinus
   40BE 74 0F               362 	mov	a,#0x0F
   40C0 C3                  363 	clr	c
                            364 ;       Peephole 236l
   40C1 9B                  365 	subb  a,r3
                            366 ;     genPointerSet
                            367 ;     genNearPointerSet
                            368 ;     genDataPointerSet
   40C2 F5 09               369 	mov	_buffer,a
                            370 ;N:\projects\pn1\FDLMZB~0\3\main.c:135: r = 0;
                            371 ;     genAssign
   40C4 7A 00               372 	mov	r2,#0x00
   40C6                     373 00102$:
                            374 ;N:\projects\pn1\FDLMZB~0\3\main.c:139: r++; 
                            375 ;     genPlus
                            376 ;     genPlusIncr
   40C6 0A                  377 	inc	r2
                            378 ;       Peephole 132   changed ljmp to sjmp
   40C7 80 E1               379 	sjmp 00104$
   40C9                     380 00106$:
   40C9 22                  381 	ret
                            382 	.area CSEG    (CODE)
   40CA                     383 _znak:
   40CA 5F                  384 	.db #0x5F
   40CB 44                  385 	.db #0x44
   40CC 3E                  386 	.db #0x3E
   40CD 76                  387 	.db #0x76
   40CE 65                  388 	.db #0x65
   40CF 73                  389 	.db #0x73
   40D0 7B                  390 	.db #0x7B
   40D1 46                  391 	.db #0x46
   40D2 7F                  392 	.db #0x7F
   40D3 77                  393 	.db #0x77
   40D4 6F                  394 	.db #0x6F
   40D5 79                  395 	.db #0x79
   40D6 1B                  396 	.db #0x1B
   40D7 7C                  397 	.db #0x7C
   40D8 3B                  398 	.db #0x3B
   40D9 2B                  399 	.db #0x2B
   40DA                     400 _wysw:
   40DA D0                  401 	.db #0xD0
   40DB E0                  402 	.db #0xE0
   40DC 70                  403 	.db #0x70
   40DD B0                  404 	.db #0xB0
                            405 	.area XINIT   (CODE)
