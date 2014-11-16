// sdcc -c main.c
// sdcc --model-small --code-loc 0x4000 --xram-loc 0 main.rel
// packihx main.ihx > main.hex
//  - COPY content of main.hex into clipboard.
//  - PUT char "q" into Tera Term
//  - PASTE onto Tera Term (alt+v)

sfr at 0x99 SBUF;

sfr at 0x98 SCON;
sfr at 0x89 TMOD;
sfr at 0x88 TCON;
sfr at 0x87 PCON;

sfr at 0x8D TH1;
sfr at 0x8B TL1;

sbit at 0x99 TI;
sbit at 0x98 RI;

char fn_getchar() {
	char znak;

	// petla-az-znak-gotowy;
	while (RI == 0);
	RI = 0;

	znak = SBUF; 
	return znak;
}

fn_putchar(char znak) {
	SBUF = znak;
	// czekaj-az-znak-zostanie-wys³any; 
	while (TI == 0);
	TI = 0;
}

void main(void) {
	char a, b;
	char a1, a2;
	char b1, b2;
	char c;
	char o;
	char r;

	SCON = 0x50;

	// licznik - tryb 8-bitowy
	TMOD &= 0x0f;
	TMOD |= 0x20;

	// uruchamianie
	TCON = 0x40;
	PCON = 0x80;

	// wartoœæ
	TH1 = TL1 = 253;
	// TI = ? // linijka czysto informacyjna

	for (;;) {
		a1 = fn_getchar();		
		fn_putchar(a1);
		a2 = fn_getchar();
		fn_putchar(a2);
		
		a = (a1 -'0') * 10 + (a2 - '0');
		
		o = fn_getchar();
		fn_putchar(o);
		
		b1 = fn_getchar();		
		fn_putchar(b1);
		b2 = fn_getchar();
		fn_putchar(b2);
		
		b = (b1 - '0') * 10 + (b2 - '0');

		c = fn_getchar();
		fn_putchar(c);

		if (c == ' ' || c == '=') {
			fn_putchar('=');

			if (o == '+') {
				r = a + b;
			} else if (o == '-') {
				r = a - b;
			}

			fn_putchar((r % 100) + '0');
			fn_putchar((r % 10) + '0');
			fn_putchar('\0');
			fn_putchar(r);
		}
	}	
}
