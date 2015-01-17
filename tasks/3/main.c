// sdcc -c main.c
// sdcc --model-small --code-loc 0x4000 --xram-loc 0 main.rel
// packihx main.ihx > main.hex
//  - COPY content of main.hex into clipboard.
//  - PUT char "q" into Tera Term
//  - PASTE onto Tera Term (alt+v)

#define SEG_A 0x02
#define SEG_B 0x04
#define SEG_C 0x40
#define SEG_D 0x10
#define SEG_E 0x08
#define SEG_F 0x01
#define SEG_G 0x20
#define SEG_H 0x80

#define cyfra_n 0
#define cyfra_0 SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F
#define cyfra_1 SEG_B | SEG_C
#define cyfra_2 SEG_A | SEG_B | SEG_D | SEG_E | SEG_G
#define cyfra_3 SEG_A | SEG_B | SEG_C | SEG_D | SEG_G
#define cyfra_4 SEG_B | SEG_C | SEG_F | SEG_G
#define cyfra_5 SEG_A | SEG_C | SEG_D | SEG_F | SEG_G
#define cyfra_6 SEG_A | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G
#define cyfra_7 SEG_A | SEG_B | SEG_C
#define cyfra_8 SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G
#define cyfra_9 SEG_A | SEG_B | SEG_C | SEG_D | SEG_F | SEG_G
#define cyfra_a SEG_A | SEG_B | SEG_C | SEG_E | SEG_F | SEG_G
#define cyfra_b SEG_C | SEG_D | SEG_E | SEG_F | SEG_G
#define cyfra_c SEG_A | SEG_D | SEG_E | SEG_F
#define cyfra_d SEG_B | SEG_C | SEG_D | SEG_E | SEG_G
#define cyfra_e SEG_A | SEG_D | SEG_E | SEG_F | SEG_G
#define cyfra_f SEG_A | SEG_E | SEG_F | SEG_G

#define wysw_1 0xD0 // 1101 0000
#define wysw_2 0xE0 // 1110 0000
#define wysw_3 0x70 // 0111 0000
#define wysw_4 0xB0 // 1011 0000

//------------------------------------------------------------------------------

// Rejestr dla wyswietlacza
xdata at 0x8000 unsigned char U15;
// Rejestr segmentow
xdata at 0xFFFF unsigned char U10;

sfr at 0x88 TCON;
// Ustawienie trybu pracy licznika
sfr at 0x89 TMOD;
// Ustawienie predkosci transmisji
sfr at 0x8D TH1;

sfr at 0x8B TL1;
// Rejestr wewnetrzny procesora zw. z bitem EA
sfr at 0xA8 IE;

//------------------------------------------------------------------------------

// Lista znaków które zostana wyswietlone
code char znak[16] = {cyfra_0, cyfra_1, cyfra_2, cyfra_3, cyfra_4, cyfra_5, cyfra_6, cyfra_7, cyfra_8, cyfra_9, cyfra_a, cyfra_b, cyfra_c, cyfra_d, cyfra_e, cyfra_f};

// Lista wyœwietlaczy (4 na plytce).
code char wysw[4] = {wysw_1, wysw_2, wysw_3, wysw_4};

//------------------------------------------------------------------------------

// Zmienna globaln - indeks wyswietlacza
unsigned char r = 0;

// Cyfry do wyswietlenia.
unsigned char buffer[4] = {0, 0, 0, 0};

void LED(void) interrupt 1 {
	// Wylaczenie poprzedniego wyswietlacza.
	U10 = cyfra_n;

	// Wybranie wyswietlacza.
	U15 = wysw[r];

	// Wstawienie wartosci
	U10 = znak[buffer[r]]; 

	// Aktualizujemy indeks o 1
	r++;
	
	// Reset indeksu
	r &= 0x03;
}

//------------------------------------------------------------------------------

void Init(void) {
    // Ustawienie trybu pracy licznika
    TMOD = (TMOD & 0xf0) | 0x02;

    // Uruchamiamy przerwania licznik
    TCON = 0x10;

    // Ustawienie predkosci transmisji
    TL1 = TH1 = 0x06;

    // Zezwolenie na przyjmowanie przerwan
    IE = 0x82;
}

//------------------------------------------------------------------------------

void pause() {
   int i = 0;
   for (i = 0; i < 255; i++);
}

//------------------------------------------------------------------------------

void main(void) {
   // Zerujemy licznik.
   unsigned char r = 0;
  
   // Inicjalizujemy rejestry.
   Init();
   
   for (;;) {
      // Opozniamy petle
      pause();
      
      // Jesli jestesma na koncu taktu licznika, to aktualizujemy wartosci w buforze.
      if (r == 255) {
           // Rosnaca wartosc na 2 pozycji.
           buffer[1]++;
           // ... mnozymy przez 0015, aby nie wyszlo po za zakres 15 (F).
           buffer[1] = buffer[1] & 0x0f;

           // Malejacy wartosc z 1 pozycji, Odejmujemy od 15 wybrana wartosc w poprzedniej linijce.
           buffer[0] = 0x0f - buffer[1];
           
           // Resetujemy licznik.
           r = 0;
      }     
      
      // Aktualizujemy licznik (zwiekszajac go o 1 - najwolniejsze skoki w liczniku).
      r++; 
   }
}
