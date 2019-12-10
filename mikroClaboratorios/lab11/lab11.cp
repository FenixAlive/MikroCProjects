#line 1 "D:/cursoPic/quinto/mikroClaboratorios/lab11/lab11.c"
unsigned char duty = 0;
void main() {

 TRISC = 0;
 PORTC = 0;

 PWM1_Init(1000);
 PWM1_Start();



 while (1) {
 PWM1_Set_Duty(duty++);
 Delay_ms(10);
 }
}
