#line 1 "D:/cursoPic/quinto/act2/Act1y2.c"
void main() {

 int presionar = 0;

 TRISC=0x00;


 TRISD |= 0x20;

 OPTION_REG = OPTION_REG & 0x7F;

 ANSEL = 0x00;
 ANSELH = 0x00;


 PORTB = 0xFF;

 while(1){

 if(!PORTD.RC7){
 delay_ms(130);
 if(!PORTD.RC7){

 presionar = !presionar;
 }
 }
 if(presionar){
 PORTC=PORTB;
 }else{
 PORTC=0x055;
 }

 }
}
