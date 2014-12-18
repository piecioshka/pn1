                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.3.3 Sat Nov 15 14:09:41 2014
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module main
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 ;--------------------------------------------------------
                             13 ; special function registers
                             14 ;--------------------------------------------------------
                             15 ;--------------------------------------------------------
                             16 ; special function bits 
                             17 ;--------------------------------------------------------
                    00B4     18 _T1	=	0x00b4
                             19 ;--------------------------------------------------------
                             20 ; overlayable register banks 
                             21 ;--------------------------------------------------------
                             22 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                      23 	.ds 8
                             24 ;--------------------------------------------------------
                             25 ; internal ram data
                             26 ;--------------------------------------------------------
                             27 	.area DSEG    (DATA)
                             28 ;--------------------------------------------------------
                             29 ; overlayable items in internal ram 
                             30 ;--------------------------------------------------------
                             31 	.area OSEG    (OVR,DATA)
                             32 ;--------------------------------------------------------
                             33 ; Stack segment in internal ram 
                             34 ;--------------------------------------------------------
                             35 	.area	SSEG	(DATA)
   0009                      36 __start__stack:
   0009                      37 	.ds	1
                             38 
                             39 ;--------------------------------------------------------
                             40 ; indirectly addressable internal ram data
                             41 ;--------------------------------------------------------
                             42 	.area ISEG    (DATA)
                             43 ;--------------------------------------------------------
                             44 ; bit data
                             45 ;--------------------------------------------------------
                             46 	.area BSEG    (BIT)
                             47 ;--------------------------------------------------------
                             48 ; external ram data
                             49 ;--------------------------------------------------------
                             50 	.area XSEG    (XDATA)
                             51 ;--------------------------------------------------------
                             52 ; external initialized ram data
                             53 ;--------------------------------------------------------
                             54 	.area XISEG   (XDATA)
                             55 ;--------------------------------------------------------
                             56 ; interrupt vector 
                             57 ;--------------------------------------------------------
                             58 	.area CSEG    (CODE)
   0000                      59 __interrupt_vect:
   0000 02 00 5D             60 	ljmp	__sdcc_gsinit_startup
   0003 32                   61 	reti
   0004                      62 	.ds	7
   000B 32                   63 	reti
   000C                      64 	.ds	7
   0013 32                   65 	reti
   0014                      66 	.ds	7
   001B 32                   67 	reti
   001C                      68 	.ds	7
   0023 32                   69 	reti
   0024                      70 	.ds	7
   002B 32                   71 	reti
   002C                      72 	.ds	7
                             73 ;--------------------------------------------------------
                             74 ; global & static initialisations
                             75 ;--------------------------------------------------------
                             76 	.area GSINIT  (CODE)
                             77 	.area GSFINAL (CODE)
                             78 	.area GSINIT  (CODE)
   005D                      79 __sdcc_gsinit_startup:
   005D 75 81 08             80 	mov	sp,#__start__stack - 1
   0060 12 00 59             81 	lcall	__sdcc_external_startup
   0063 E5 82                82 	mov	a,dpl
   0065 60 03                83 	jz	__sdcc_init_data
   0067 02 00 33             84 	ljmp	__sdcc_program_startup
   006A                      85 __sdcc_init_data:
                             86 ;	_mcs51_genXINIT() start
   006A 74 00                87 	mov	a,#l_XINIT
   006C 44 00                88 	orl	a,#l_XINIT>>8
   006E 60 29                89 	jz	00003$
   0070 74 9C                90 	mov	a,#s_XINIT
   0072 24 00                91 	add	a,#l_XINIT
   0074 F9                   92 	mov	r1,a
   0075 74 00                93 	mov	a,#s_XINIT>>8
   0077 34 00                94 	addc	a,#l_XINIT>>8
   0079 FA                   95 	mov	r2,a
   007A 90 00 9C             96 	mov	dptr,#s_XINIT
   007D 78 00                97 	mov	r0,#s_XISEG
   007F 75 A0 00             98 	mov	p2,#(s_XISEG >> 8)
   0082 E4                   99 00001$:	clr	a
   0083 93                  100 	movc	a,@a+dptr
   0084 F2                  101 	movx	@r0,a
   0085 A3                  102 	inc	dptr
   0086 08                  103 	inc	r0
   0087 B8 00 02            104 	cjne	r0,#0,00002$
   008A 05 A0               105 	inc	p2
   008C E5 82               106 00002$:	mov	a,dpl
   008E B5 01 F1            107 	cjne	a,ar1,00001$
   0091 E5 83               108 	mov	a,dph
   0093 B5 02 EC            109 	cjne	a,ar2,00001$
   0096 75 A0 FF            110 	mov	p2,#0xFF
   0099                     111 00003$:
                            112 ;	_mcs51_genXINIT() end
                            113 	.area GSFINAL (CODE)
   0099 02 00 33            114 	ljmp	__sdcc_program_startup
                            115 ;--------------------------------------------------------
                            116 ; Home
                            117 ;--------------------------------------------------------
                            118 	.area HOME    (CODE)
                            119 	.area CSEG    (CODE)
                            120 ;--------------------------------------------------------
                            121 ; code
                            122 ;--------------------------------------------------------
                            123 	.area CSEG    (CODE)
   0033                     124 __sdcc_program_startup:
   0033 12 00 38            125 	lcall	_main
                            126 ;	return from main will lock up
   0036 80 FE               127 	sjmp .
                            128 ;------------------------------------------------------------
                            129 ;Allocation info for local variables in function 'main'
                            130 ;------------------------------------------------------------
                            131 ;i                         Allocated to registers 
                            132 ;r                         Allocated to registers 
                            133 ;------------------------------------------------------------
                            134 ;Z:\projects\pn1\FDLMZB~0\1\main.c:16: void main(void) {
                            135 ;	-----------------------------------------
                            136 ;	 function main
                            137 ;	-----------------------------------------
   0038                     138 _main:
                    0002    139 	ar2 = 0x02
                    0003    140 	ar3 = 0x03
                    0004    141 	ar4 = 0x04
                    0005    142 	ar5 = 0x05
                    0006    143 	ar6 = 0x06
                    0007    144 	ar7 = 0x07
                    0000    145 	ar0 = 0x00
                    0001    146 	ar1 = 0x01
   0038 C0 08               147 	push	_bp
   003A 85 81 08            148 	mov	_bp,sp
                            149 ;Z:\projects\pn1\FDLMZB~0\1\main.c:18: unsigned char i, r = 0;
                            150 ;     genAssign
   003D 7A 00               151 	mov	r2,#0x00
   003F                     152 00108$:
                            153 ;Z:\projects\pn1\FDLMZB~0\1\main.c:22: if ((r & 0x01) == 0) {
                            154 ;     genAnd
   003F 74 01               155 	mov	a,#0x01
   0041 5A                  156 	anl	a,r2
   0042 FB                  157 	mov	r3,a
                            158 ;     genCmpEq
                            159 ;       Peephole 132   changed ljmp to sjmp
                            160 ;       Peephole 199   optimized misc jump sequence
   0043 BB 00 04            161 	cjne r3,#0x00,00102$
                            162 ;00116$:
                            163 ;       Peephole 200   removed redundant sjmp
   0046                     164 00117$:
                            165 ;Z:\projects\pn1\FDLMZB~0\1\main.c:23: T1 = 0;
                            166 ;     genAssign
   0046 C2 B4               167 	clr	_T1
                            168 ;       Peephole 132   changed ljmp to sjmp
   0048 80 02               169 	sjmp 00103$
   004A                     170 00102$:
                            171 ;Z:\projects\pn1\FDLMZB~0\1\main.c:25: T1 = 1;
                            172 ;     genAssign
   004A D2 B4               173 	setb	_T1
   004C                     174 00103$:
                            175 ;Z:\projects\pn1\FDLMZB~0\1\main.c:27: r++;
                            176 ;     genPlus
                            177 ;     genPlusIncr
   004C 0A                  178 	inc	r2
                            179 ;Z:\projects\pn1\FDLMZB~0\1\main.c:28: for (i = 0; i < 70; i++);
                            180 ;     genAssign
   004D 7B 46               181 	mov	r3,#0x46
   004F                     182 00106$:
                            183 ;     genDjnz
                            184 ;       Peephole 132   changed ljmp to sjmp
                            185 ;       Peephole 205   optimized misc jump sequence
   004F DB FE               186 	djnz r3,00106$
   0051                     187 00118$:
   0051                     188 00119$:
                            189 ;       Peephole 132   changed ljmp to sjmp
   0051 80 EC               190 	sjmp 00108$
   0053                     191 00110$:
   0053 85 08 81            192 	mov	sp,_bp
   0056 D0 08               193 	pop	_bp
   0058 22                  194 	ret
                            195 	.area CSEG    (CODE)
                            196 	.area XINIT   (CODE)
