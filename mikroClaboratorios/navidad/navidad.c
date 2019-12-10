void ADC_Init();
float luz;
int i = 0;
void main() {
  ANSEL  = 0x01;
  C1ON_bit = 0;               // Disable comparators
  C2ON_bit = 0;
  TRISA  = 0xFF;
  OPTION_REG = OPTION_REG & 0x7F;
  ANSELH = 0x00;
  PORTB = 0xFF;
  //puerto C como salida
  TRISC = 0x01;
  PORTC = 0x00;
  if(!PORTB.RB2){
    while(1){
      if(!(PORTB.RB1)){
        luz = 0;
        for(i=0;i<5;i++){
          luz += ADC_Read(0);
        }
        luz = luz / 5;
        if(luz < 600){
          if(PORTC && 0x01){
            Delay_ms(200);
            if(PORTC && 0x01){
              PORTC.RC1 = 1;
              Delay_ms(30000);
            }
          }
        }
        PORTC.RC1 = 0;
      }else{
        PORTC.RC1 = 1;
      }
    }
  }
}