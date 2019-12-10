unsigned char totprom = 5;
unsigned char contprom = 0;
unsigned int valsum = 0;
void main() {

TRISC = 0x00;
PORTC = 0x00;
TRISD = 0x00;
PORTD = 0x00;
//proy 9
// ADCS1, ADCS0, CHS3 2 1 0 GO/DONE ADON
TRISA.RA0 = 1;
ANSEL.RA0 = 1;

ADCON0.ADCS1 = 1;
ADCON0.ADCS0 = 1;
ADCON1.ADFM = 1;
ADCON0.ADON = 1;
while(1){

Delay_ms(5);

ADCON0.GO_DONE=1;
while(ADCON0.GO_DONE){

}
if(++contprom > totprom){
  valsum /= totprom+1;
  PORTC = valsum % 256;
  PORTD = valsum / 256;
  valsum = 0;
  contprom = 0;
}
valsum += ADRESL+ADRESH*256;
}
}