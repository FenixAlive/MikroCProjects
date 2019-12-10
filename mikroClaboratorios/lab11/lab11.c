unsigned char duty = 0;
void main() {
 // puerto C como salidas
  TRISC = 0;
  PORTC = 0;
  // inicio pwm1 puerto C pin 2
  PWM1_Init(1000);
  PWM1_Start();
  //ciclo infinito va aumentando cada 10ms la variable duty al ser
  // tipo char al llegar a 255 automaticamente hace overflow y vuelve a 0
  //el valor de duty se pone en el pwm correspondiente
  while (1) {  
    PWM1_Set_Duty(duty++);
    Delay_ms(10);
  }
}