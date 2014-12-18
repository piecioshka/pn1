                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.3 Sat Oct 11 15:48:04 2014
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module main
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _U12
                             13 ;--------------------------------------------------------
                             14 ; special function registers
                             15 ;--------------------------------------------------------
                             16 ;--------------------------------------------------------
                             17 ; special function bits 
                             18 ;--------------------------------------------------------
                    00B4     19 _T1	=	0x00b4
                             20 ;--------------------------------------------------------
                             21 ; overlayable register banks 
                             22 ;--------------------------------------------------------
                             23 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                      24 	.ds 8
                             25 ;--------------------------------------------------------
                             26 ; internal ram data
                             27 ;--------------------------------------------------------
                             28 	.area DSEG    (DATA)
                             29 ;--------------------------------------------------------
                             30 ; overlayable items in internal ram 
                             31 ;--------------------------------------------------------
                             32 	.area	OSEG    (OVR,DATA)
                             33 ;--------------------------------------------------------
                             34 ; Stack segment in internal ram 
                             35 ;--------------------------------------------------------
                             36 	.area	SSEG	(DATA)
   0008                      37 __start__stack:
   0008                      38 	.ds	1
                             39 
                             40 ;--------------------------------------------------------
                             41 ; indirectly addressable internal ram data
                             42 ;--------------------------------------------------------
                             43 	.area ISEG    (DATA)
                             44 ;--------------------------------------------------------
                             45 ; bit data
                             46 ;--------------------------------------------------------
                             47 	.area BSEG    (BIT)
                             48 ;--------------------------------------------------------
                             49 ; external ram data
                             50 ;--------------------------------------------------------
                             51 	.area XSEG    (XDATA)
                    8000     52 _U12	=	0x8000
                             53 ;--------------------------------------------------------
                             54 ; external initialized ram data
                             55 ;--------------------------------------------------------
                             56 	.area XISEG   (XDATA)
                             57 ;--------------------------------------------------------
                             58 ; interrupt vector 
                             59 ;--------------------------------------------------------
                             60 	.area CSEG    (CODE)
   4000                      61 __interrupt_vect:
   4000 02 40 5F             62 	ljmp	__sdcc_gsinit_startup
   4003 32                   63 	reti
   4004                      64 	.ds	7
   400B 32                   65 	reti
   400C                      66 	.ds	7
   4013 32                   67 	reti
   4014                      68 	.ds	7
   401B 32                   69 	reti
   401C                      70 	.ds	7
   4023 32                   71 	reti
   4024                      72 	.ds	7
   402B 32                   73 	reti
   402C                      74 	.ds	7
                             75 ;--------------------------------------------------------
                             76 ; global & static initialisations
                             77 ;--------------------------------------------------------
                             78 	.area GSINIT  (CODE)
                             79 	.area GSFINAL (CODE)
                             80 	.area GSINIT  (CODE)
   405F                      81 __sdcc_gsinit_startup:
   405F 75 81 07             82 	mov	sp,#__start__stack - 1
   4062 12 40 5B             83 	lcall	__sdcc_external_startup
   4065 E5 82                84 	mov	a,dpl
   4067 60 03                85 	jz	__sdcc_init_data
   4069 02 40 33             86 	ljmp	__sdcc_program_startup
   406C                      87 __sdcc_init_data:
                             88 ;	_mcs51_genXINIT() start
   406C 74 00                89 	mov	a,#l_XINIT
   406E 44 00                90 	orl	a,#l_XINIT>>8
   4070 60 29                91 	jz	00003$
   4072 74 9E                92 	mov	a,#s_XINIT
   4074 24 00                93 	add	a,#l_XINIT
   4076 F9                   94 	mov	r1,a
   4077 74 40                95 	mov	a,#s_XINIT>>8
   4079 34 00                96 	addc	a,#l_XINIT>>8
   407B FA                   97 	mov	r2,a
   407C 90 40 9E             98 	mov	dptr,#s_XINIT
   407F 78 00                99 	mov	r0,#s_XISEG
   4081 75 A0 00            100 	mov	p2,#(s_XISEG >> 8)
   4084 E4                  101 00001$:	clr	a
   4085 93                  102 	movc	a,@a+dptr
   4086 F2                  103 	movx	@r0,a
   4087 A3                  104 	inc	dptr
   4088 08                  105 	inc	r0
   4089 B8 00 02            106 	cjne	r0,#0,00002$
   408C 05 A0               107 	inc	p2
   408E E5 82               108 00002$:	mov	a,dpl
   4090 B5 01 F1            109 	cjne	a,ar1,00001$
   4093 E5 83               110 	mov	a,dph
   4095 B5 02 EC            111 	cjne	a,ar2,00001$
   4098 75 A0 FF            112 	mov	p2,#0xFF
   409B                     113 00003$:
                            114 ;	_mcs51_genXINIT() end
                            115 	.area GSFINAL (CODE)
   409B 02 40 33            116 	ljmp	__sdcc_program_startup
                            117 ;--------------------------------------------------------
                            118 ; Home
                            119 ;--------------------------------------------------------
                            120 	.area HOME    (CODE)
                            121 	.area CSEG    (CODE)
                            122 ;--------------------------------------------------------
                            123 ; code
                            124 ;--------------------------------------------------------
                            125 	.area CSEG    (CODE)
   4033                     126 __sdcc_program_startup:
   4033 12 40 38            127 	lcall	_main
                            128 ;	return from main will lock up
   4036 80 FE               129 	sjmp .
                            130 ;------------------------------------------------------------
                            131 ;Allocation info for local variables in function 'main'
                            132 ;------------------------------------------------------------
                            133 ;------------------------------------------------------------
                            134 ;Z:\projects\pn1-labs\1.5\main.c:19: void main(void) {
                            135 ;	-----------------------------------------
                            136 ;	 function main
                            137 ;	-----------------------------------------
   4038                     138 _main:
                    0002    139 	ar2 = 0x02
                    0003    140 	ar3 = 0x03
                    0004    141 	ar4 = 0x04
                    0005    142 	ar5 = 0x05
                    0006    143 	ar6 = 0x06
                    0007    144 	ar7 = 0x07
                    0000    145 	ar0 = 0x00
                    0001    146 	ar1 = 0x01
                            147 ;Z:\projects\pn1-labs\1.5\main.c:23: T1 = 1;
                            148 ;     genAssign
   4038 D2 B4               149 	setb	_T1
   403A                     150 00109$:
                            151 ;Z:\projects\pn1-labs\1.5\main.c:28: if ((U12 & 0x000E) == 0) {
                            152 ;     genAssign
   403A 90 80 00            153 	mov	dptr,#_U12
   403D E0                  154 	movx	a,@dptr
   403E FA                  155 	mov	r2,a
                            156 ;     genAnd
   403F 53 02 0E            157 	anl	ar2,#0x0E
                            158 ;     genCmpEq
                            159 ;       Peephole 132   changed ljmp to sjmp
                            160 ;       Peephole 199   optimized misc jump sequence
   4042 BA 00 02            161 	cjne r2,#0x00,00102$
                            162 ;00118$:
                            163 ;       Peephole 200   removed redundant sjmp
   4045                     164 00119$:
                            165 ;Z:\projects\pn1-labs\1.5\main.c:29: T1 = 0;
                            166 ;     genAssign
   4045 C2 B4               167 	clr	_T1
   4047                     168 00102$:
                            169 ;Z:\projects\pn1-labs\1.5\main.c:33: if ((U12 & 0x0007) == 0) {
                            170 ;     genAssign
   4047 90 80 00            171 	mov	dptr,#_U12
   404A E0                  172 	movx	a,@dptr
   404B FA                  173 	mov	r2,a
                            174 ;     genAnd
   404C 53 02 07            175 	anl	ar2,#0x07
                            176 ;     genCmpEq
                            177 ;       Peephole 132   changed ljmp to sjmp
                            178 ;       Peephole 199   optimized misc jump sequence
   404F BA 00 02            179 	cjne r2,#0x00,00115$
                            180 ;00120$:
                            181 ;       Peephole 200   removed redundant sjmp
   4052                     182 00121$:
                            183 ;Z:\projects\pn1-labs\1.5\main.c:34: T1 = 1;
                            184 ;     genAssign
   4052 D2 B4               185 	setb	_T1
                            186 ;Z:\projects\pn1-labs\1.5\main.c:37: for (i = 0; i < 70; i++);
   4054                     187 00115$:
                            188 ;     genAssign
   4054 7A 46               189 	mov	r2,#0x46
   4056                     190 00107$:
                            191 ;     genDjnz
                            192 ;       Peephole 132   changed ljmp to sjmp
                            193 ;       Peephole 205   optimized misc jump sequence
   4056 DA FE               194 	djnz r2,00107$
   4058                     195 00122$:
   4058                     196 00123$:
                            197 ;       Peephole 132   changed ljmp to sjmp
   4058 80 E0               198 	sjmp 00109$
   405A                     199 00111$:
   405A 22                  200 	ret
                            201 	.area CSEG    (CODE)
                            202 	.area XINIT   (CODE)
