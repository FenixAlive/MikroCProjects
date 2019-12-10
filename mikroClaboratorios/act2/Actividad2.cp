#line 1 "D:/cursoPic/quinto/act2/Actividad2.c"
void main() {
 TRISC=0x00;

 OPTION_REG = OPTION_REG & 0x7F;
 ANSELH = 0x00;
 PORTB = 0xFF;
 while(1){
 PORTC=PORTB;
 }
}
