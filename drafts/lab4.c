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

// wyświetlacz
//#define wysw_1 0xD0
//#define wysw_2 0xE0
//#define wysw_3 0x70
//#define wysw_4 0xB0

// wyświetlacz i klawiatura
#define wk_1 0xDE // 1101 1110
#define wk_2 0xED // 1110 1101
#define wk_3 0x7B // 0111 1011
#define wk_4 0xB7 // 1011 0111

xdata at 0x8000 unsigned char U15;
xdata at 0x8000 unsigned char U12;
xdata at 0xFFFF unsigned char U10;

sfr at 0x88 TCON;
sfr at 0x89 TMOD;
sfr at 0x8C TH0;
sfr at 0x8A TL0;
sfr at 0xA8 IE;

code char znak[16] = {cyfra_0, cyfra_1, cyfra_2, cyfra_3, cyfra_4, cyfra_5, cyfra_6, cyfra_7, cyfra_8, cyfra_9, cyfra_a, cyfra_b, cyfra_c, cyfra_d, cyfra_e, cyfra_f};

//code char wysw[4] = {wysw_1, wysw_2, wysw_3, wysw_4};
code char wk_[4] = {wk_1, wk_2, wk_3, wk_4};

unsigned char buffer[4] = {0, 0, 0, 0};
unsigned char t = 0;
unsigned char key = 0;

void LED(void) interrupt 1 {
    unsigned char zz;

    // Wpisanie 0 na wyświetlacz.
    U10 = cyfra_n;

    // Wybranie 2 pole wyświetlacza i pierwszego rzędu klawiatury.
    U15 = wk_[t];

    zz = (U12 & 0xf0) >> 4; // w zz zapisane sa 0000 i pierwsze 4 bity z U12

    // Jakiś guzik jest wciśnięty.
    if (zz != 0x0f) {
        // Sprawdza czy wciśnięty jest 4 guzik.
        if (zz == 0x07) {
            key = 0x00 | t;

        // Sprawdza 3 guzik.
        } else if (zz == 0x0b) {
            key = 0x04 | t;

        // Sprawdza 2 guzik.
        } else if (zz == 0x0d) {
            key = 0x08 | t;

        // Sprawdza 1 guzik.
        } else if (zz == 0x0e) {
            key = 0x0c | t;
        }
    }

    U10 = buffer[t];

    t++;
    t &= 0x03;
}

//-------------------------------------------------------------------

void InitLED(void) {
    TMOD = (TMOD & 0xf0) | 0x02;
    TCON = 0x10;
    TL0 = TH0 = 0x06;
    IE = 0x82;
}

//-------------------------------------------------------------------

void main(void) {

    InitLED();

    for (;;) {
        // Wpisanie do buffer[0] wartości z dolnej klawiatury.
        buffer[0] = znak[~U12 & 0x0f];
        buffer[1] = znak[key];
    }
}
