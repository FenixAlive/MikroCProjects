#line 1 "D:/cursoPic/quinto/mikroClaboratorios/lab7/lab7.c"

void main() {



 OPTION_REG = 0b10111000;

 TRISC = 0x00;
 PORTC = 0x00;
 TMR0 = 0x00;

 while(1){
 PORTC = TMR0;
 }

}
