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
	char c;

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
		c = fn_getchar();
		// c = c + 1; 
		fn_putchar(c);
	}	
}
