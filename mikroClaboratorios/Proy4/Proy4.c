// conexiones LCD
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

unsigned long cuenta = 0;
char palabra[11] = "0";
unsigned long numfrec = 0;

char i = 0;
//convierte numero a string
void num2str();

void main(){
  //Option reg RBPU, INTEDG, T0CS, T0SE, PSA, PS2, PS1, PS2
//SE ESTAN MODIFICANDO EN ESTE REGISTRO DEL PIN 0 AL 5, 6 Y 7 SE DEJAN IGUAL
// psa 0:2 0x00
  OPTION_REG.T0CS = 1;
  OPTION_REG.T0SE = 1;
  OPTION_REG.PSA = 1;
  OPTION_REG.PS2 = 0;
  OPTION_REG.PS1 = 0;
  OPTION_REG.PS0 = 0;

//INTCON  GIE, PEIE, T0IE, INTE, RBIE, T0IF, INTF, RBIF
INTCON |= 0b10100000; //interrupcion local

  ANSEL  = 0;                        // apago analogos
  ANSELH = 0;
  C1ON_bit = 0;                      // apago comparadores
  C2ON_bit = 0;
  Lcd_Init();                       // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,1,"Frecunciometro");
  while(1) {
    cuenta = 0;
    TMR0 = 0x00;
    Delay_ms(1000);
    numfrec = cuenta*256+TMR0;          // calculo frecuencia
    Lcd_Cmd(_LCD_CLEAR);               // limpio lcd
    Lcd_Cmd(_LCD_CURSOR_OFF);          // quito cursor
    Lcd_Out(1,1,"Frec:");                 // escribo texto en 1,1 del led
    num2str();
    Lcd_Out(1,7, palabra);

  }
}

void num2str(){
  i = 10;
  if(numfrec){
    while(numfrec && i > -1){
      palabra[--i] = 48 + (numfrec % 10);
      numfrec /= 10;
    }
    while(i > 0){
      palabra[--i] = 32;
    }
    palabra[10] = '\0';
  }else{
    palabra[--i] = '0';
    while(i > 0){
      palabra[--i] = 32;
    }
    palabra[10] = '\0';

  }
}

void interrupt(){
  if(INTCON & 0b00000100){
    cuenta++;
    INTCON &= 0b11111011; //limpiar bandera de interrupcion
  }
}