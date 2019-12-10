#line 1 "D:/cursoPic/quinto/mikroClaboratorios/lab8/Lab8.c"
unsigned long cuenta = 0;

void main() {



OPTION_REG &= 0b00010111;
OPTION_REG |= 0b00010111;


INTCON |= 0b10100000;
TMR0 = 0x00;
TRISD &= 0x01;
PORTD &= 0x01;
}

void interrupt(){
 if(INTCON & 0b00000100){

 ++cuenta = cuenta > 15 ? 0 : cuenta;
 PORTD ^= !cuenta ? 0x01 : 0x00;
 INTCON &= 0b11111011;
 }
}
