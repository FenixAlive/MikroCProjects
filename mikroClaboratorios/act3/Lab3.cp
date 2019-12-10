#line 1 "D:/cursoPic/quinto/mikroClaboratorios/act3/Lab3.c"
void main() {

 TRISC.RC0 = 0;

 while(1){






 PORTC.RC0 ^= 1;

 delay_ms(250);
 }
}
