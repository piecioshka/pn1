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

#define wysw_1 0xD0
#define wysw_2 0xE0
#define wysw_3 0x70
#define wysw_4 0xB0

//------------------------------------------------------------------------------

xdata at 0x8000 unsigned char U15;
xdata at 0xFFFF unsigned char U10;

sfr at 0x88 TCON;
sfr at 0x89 TMOD;
sfr at 0x8C TH0;
sfr at 0x8A TL0;
// Rejestr wewnętrzny procesora zw. z bitem EA
sfr at 0xA8 IE;

//------------------------------------------------------------------------------

code char znak[16] = {cyfra_0, cyfra_1, cyfra_2, cyfra_3, cyfra_4, cyfra_5, cyfra_6, cyfra_7, cyfra_8, cyfra_9, cyfra_a, cyfra_b, cyfra_c, cyfra_d, cyfra_e, cyfra_f};

code char wysw[4] = {wysw_1, wysw_2, wysw_3, wysw_4};

//------------------------------------------------------------------------------

// Licznik
unsigned char r = 0;
unsigned char buffer[4] = {0, 0, 0, 0};

void LED(void) interrupt 1 {
    // Wyłączenie poprzedniego wyświetlacza.
    U10 = cyfra_n;

    // Wybranie wyświetlacza.
    U15 = wysw[r];

    // Wstawienie wartości
    U10 = znak[buffer[r]];

    r++;
    r &= 0x03;
}

//------------------------------------------------------------------------------

#define _CONST 0x06

void Init(void) {
    TMOD = (TMOD & 0xf0) | 0x02;
    TCON = 0x10;
    TL0 = TH0 = _CONST;
    IE = 0x82; // 10000010;
}

//------------------------------------------------------------------------------

void pause() {
   int i = 0;
   for (i = 0; i < 255; i++);
}

//------------------------------------------------------------------------------

void main(void) {
   unsigned char r = 0;

   Init();

   for (;;) {
      pause();

      if (r == 255) {
           buffer[1]++;
           buffer[1] = buffer[1] & 0x0f;
           buffer[0] = 0x0f - buffer[1];
           r = 0;
      }

      r++; 
   }
}
