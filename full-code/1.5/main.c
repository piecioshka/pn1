// sdcc -c main.c
// sdcc --model-small --code-loc 0x4000 --xram-loc 0 main.rel
// packihx main.ihx > main.hex
//  - COPY content of main.hex into clipboard.
//  - PUT char "q" into Tera Term
//  - PASTE onto Tera Term (alt+v)

// Deklaracje zmiennych zwi¹zanych ze sprzêtem
// powinny byc globalne!

// Deklaracja zmiennej powizanej z klawiatura
xdata at 0x8000 unsigned char U12;

// Deklaracja zmiennej powi¹zanej ze sprzêtem
//  - "sbit": 1-bitowa zmienna
//  - "at 0xB4": lokalizacja miejsca w pamiêci
sbit at 0xB4 T1;

void main(void) {
    // 8-bitowa bez znaku
    unsigned char i = 0;

    T1 = 1;

    // Specyficzne dla programowania niskopoziomowego.
    for (;;) {
    	// Wlaczenie
    	if ((U12 & 0x000E) == 0) {
            T1 = 0;
        }
        
        // Wylaczenie
        if ((U12 & 0x0007) == 0) {
            T1 = 1;
        }

        for (i = 0; i < 70; i++);
    }
}
