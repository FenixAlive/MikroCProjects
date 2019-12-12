void ADC_Init();
float luz;
int i = 0;
void main() {
  char cuentaMax = 60;
  char cuenta = cuentaMax;
  ANSEL  = 0x01;
  ANSELH = 0x00;
  C1ON_bit = 0;               // Disable comparators
  C2ON_bit = 0;
  TRISA  = 0xFF;
  OPTION_REG = OPTION_REG & 0x7F;
  PORTB = 0xFF;
  //puerto C como salida
  TRISC = 0x01;
  PORTC = 0x00;
  if(!PORTB.RB1){      //apaga todo
    while(1){
      if(!(PORTB.RB2)){  //funciona luz y movimiento o siempre prendido
        luz = 0;
        for(i=0;i<5;i++){
          luz += ADC_Read(0);
        }
        luz = luz / 5;
        if(luz < 500){
          if(PORTC && 0x01){
            Delay_ms(200);
            if(PORTC && 0x01){
              cuenta = cuentaMax;
            }
          }
        }
        if(cuenta > 0){
          PORTC.RC1 = 1;
          cuenta--;
        }else{
          PORTC.RC1 = 0;
        }
      }else{
        PORTC.RC1 = 1;
      }
      Delay_ms(1000);
    }
  }
}