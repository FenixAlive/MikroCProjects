#line 1 "D:/cursoPic/quinto/mikroClaboratorios/act4/Lab3y4.c"
void revisaBoton(int* presionar) {

 if(!PORTD.RC7){
 delay_ms(130);
 if(!PORTD.RC7){

 (*presionar) ^= 1;

 PORTC = 0;
 }
 }
}

void main() {


 int presionar = 0;

 TRISC = 0x00;

 PORTC = 0;



 OPTION_REG = OPTION_REG & 0x7F;

 ANSELH = 0x00;

 PORTB = 0xFF;

 TRISD.RC7 = 1;

 while(1) {

 revisaBoton(&presionar);

 if(presionar){

 if(PORTB.RB0) {


 PORTC=PORTB & 0x77;

 delay_ms(250);

 PORTC = 0x01;

 delay_ms(250);
 }else {

 PORTC = 0;
 }
 } else {







 PORTC.RC0 ^= 1;

 delay_ms(250);
 }
 }
}
