void main() {
  ANSEL = 0x00;
  TRISA = 0x00;
  TRISC = 0x00;
  PORTC = 0x00;
  TRISD = 0x00;
  PORTD = 0x00;
  while(1){
    Delay_us(1000*2);
    PORTA.RA0 = 0;
    PORTA.RA0 = 1;
  }
}