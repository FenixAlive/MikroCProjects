#line 1 "D:/cursoPic/quinto/mikroClaboratorios/relojBinario/RelojBinario.c"
void main() {

long tiempo = 0;

long temp = 0;

int set = 0;

int i = 0;

ANSEL = 0x00;
ANSELH = 0x00;


TRISA &= 0xC0;
TRISC &= 0xC0;
TRISD &= 0xE0;

TRISB.RB7 = 1;

TRISB.RB6 = 0;


PORTA = 0x00;

PORTC = 0x00;

PORTD = 0x00;
PORTB.RB6 = 0;

while(1) {

 if(!PORTB.RB7) {
 delay_ms(50);
 if(!PORTB.RB7) {
 for(i = 0; i<13;i++){
 delay_ms(70);
 if(PORTB.RB7){
 temp++;
 break;
 }
 }
 }
 if(!PORTB.RB7) {
 PORTB.RB6 = 0;
 for(i=0;i<3;i++){
 PORTB.RB6 ^= 1;
 delay_ms(100);
 }
 set ++;
 if(set == 1){

 PORTA = 0x00;
 temp = PORTD & 0b00011111;
 }else if(set == 2){

 PORTD = temp & 0b00011111;
 temp = PORTC & 0b00111111;
 }else if(set == 3){

 set = 0;
 PORTB.RB6 = 0;
 PORTC = temp & 0b00111111;
 tiempo = (((long) PORTD)*60 + ((long) temp))*60*10;
 temp = 0;
 }else{
 PORTB.RB6 = 0;
 set = 0;
 temp = 0;
 }
 delay_ms(300);
 }
 }
 switch (set) {
 case 0:

 PORTA = (tiempo/10) % 60;
 PORTC = (tiempo/(600)) % 60;
 PORTD = (tiempo/(36000)) % 24;
 break;
 case 1:
 if(temp > 23){
 temp = 0;
 }

 if(tiempo % 8){
 PORTD = temp;
 }else{
 PORTD = 0xFF;
 }
 break;
 case 2:
 if(temp > 59){
 temp = 0;
 }

 if(tiempo % 8){
 PORTC = temp & 0b00111111;
 }else{
 PORTC = 0xFF;
 }
 break;
 default:
 break;

 }
 delay_us(98500);
 tiempo ++;
}
}
