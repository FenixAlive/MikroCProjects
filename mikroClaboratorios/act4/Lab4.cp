#line 1 "D:/cursoPic/quinto/mikroClaboratorios/act4/Lab4.c"
void main() {

 TRISC = 0x00;



 OPTION_REG = OPTION_REG & 0x7F;

 ANSELH = 0x00;

 PORTB = 0xFF;

 while(1) {

 if(PORTB.RB0) {


 PORTC=PORTB & 0x77;

 delay_ms(250);

 PORTC = 0x01;

 delay_ms(250);
 }else {

 PORTC = 0;
 }
 }


}
