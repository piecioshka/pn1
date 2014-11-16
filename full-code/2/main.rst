                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.3 Sat Nov 15 15:04:29 2014
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
   4000 02 40 7A             71 	ljmp	__sdcc_gsinit_startup
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
   407A                      90 __sdcc_gsinit_startup:
   407A 75 81 07             91 	mov	sp,#__start__stack - 1
   407D 12 40 76             92 	lcall	__sdcc_external_startup
   4080 E5 82                93 	mov	a,dpl
   4082 60 03                94 	jz	__sdcc_init_data
   4084 02 40 33             95 	ljmp	__sdcc_program_startup
   4087                      96 __sdcc_init_data:
                             97 ;	_mcs51_genXINIT() start
   4087 74 00                98 	mov	a,#l_XINIT
   4089 44 00                99 	orl	a,#l_XINIT>>8
   408B 60 29               100 	jz	00003$
   408D 74 B9               101 	mov	a,#s_XINIT
   408F 24 00               102 	add	a,#l_XINIT
   4091 F9                  103 	mov	r1,a
   4092 74 40               104 	mov	a,#s_XINIT>>8
   4094 34 00               105 	addc	a,#l_XINIT>>8
   4096 FA                  106 	mov	r2,a
   4097 90 40 B9            107 	mov	dptr,#s_XINIT
   409A 78 00               108 	mov	r0,#s_XISEG
   409C 75 A0 00            109 	mov	p2,#(s_XISEG >> 8)
   409F E4                  110 00001$:	clr	a
   40A0 93                  111 	movc	a,@a+dptr
   40A1 F2                  112 	movx	@r0,a
   40A2 A3                  113 	inc	dptr
   40A3 08                  114 	inc	r0
   40A4 B8 00 02            115 	cjne	r0,#0,00002$
   40A7 05 A0               116 	inc	p2
   40A9 E5 82               117 00002$:	mov	a,dpl
   40AB B5 01 F1            118 	cjne	a,ar1,00001$
   40AE E5 83               119 	mov	a,dph
   40B0 B5 02 EC            120 	cjne	a,ar2,00001$
   40B3 75 A0 FF            121 	mov	p2,#0xFF
   40B6                     122 00003$:
                            123 ;	_mcs51_genXINIT() end
                            124 	.area GSFINAL (CODE)
   40B6 02 40 33            125 	ljmp	__sdcc_program_startup
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
                            213 ;c                         Allocated to registers 
                            214 ;------------------------------------------------------------
                            215 ;main.c:39: void main(void) {
                            216 ;	-----------------------------------------
                            217 ;	 function main
                            218 ;	-----------------------------------------
   4054                     219 _main:
                            220 ;main.c:42: SCON = 0x50;
                            221 ;     genAssign
   4054 75 98 50            222 	mov	_SCON,#0x50
                            223 ;main.c:45: TMOD &= 0x0f;
                            224 ;     genAnd
   4057 53 89 0F            225 	anl	_TMOD,#0x0F
                            226 ;main.c:46: TMOD |= 0x20;
                            227 ;     genOr
   405A 43 89 20            228 	orl	_TMOD,#0x20
                            229 ;main.c:49: TCON = 0x40;
                            230 ;     genAssign
   405D 75 88 40            231 	mov	_TCON,#0x40
                            232 ;main.c:50: PCON = 0x80;
                            233 ;     genAssign
   4060 75 87 80            234 	mov	_PCON,#0x80
                            235 ;main.c:53: TH1 = TL1 = 253;
                            236 ;     genAssign
   4063 75 8B FD            237 	mov	_TL1,#0xFD
                            238 ;     genAssign
   4066 75 8D FD            239 	mov	_TH1,#0xFD
   4069                     240 00102$:
                            241 ;main.c:57: c = fn_getchar();
                            242 ;     genCall
   4069 12 40 38            243 	lcall	_fn_getchar
   406C E5 82               244 	mov	a,dpl
                            245 ;     genAssign
   406E F5 82               246 	mov	dpl,a
                            247 ;main.c:59: fn_putchar(c);
                            248 ;     genCall
   4070 12 40 46            249 	lcall	_fn_putchar
                            250 ;       Peephole 132   changed ljmp to sjmp
   4073 80 F4               251 	sjmp 00102$
   4075                     252 00104$:
   4075 22                  253 	ret
                            254 	.area CSEG    (CODE)
                            255 	.area XINIT   (CODE)
