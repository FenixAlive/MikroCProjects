void main() {
//para guardar el tiempo en centisegundos
long tiempo = 0;
//para guardar valores temporales al ajustar la hora
long temp = 0;
//para ver si estoy en set y que estoy ajustando
int set = 0;
//para los for
int i = 0;
//Pines analogos apagados
ANSEL = 0x00;
ANSELH = 0x00;

//configuración de pines utilizados como salida
TRISA &= 0xC0;
TRISC &= 0xC0;
TRISD &= 0xE0;
//Pin 7 del puerto B como entrada para set de reloj
TRISB.RB7 = 1;
//Pin 6 del puerto B salida led indicador de set reloj
TRISB.RB6 = 0;
//puertos de salidas led
//segundos
PORTA = 0x00;
//Minutos
PORTC = 0x00;
//horas
PORTD = 0x00;
PORTB.RB6 = 0;

while(1) {
  //Checar boton
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
        //ajustar horas
        PORTA = 0x00;
        temp = PORTD & 0b00011111;
      }else if(set == 2){
        //ajustar minutos
        PORTD = temp & 0b00011111;
        temp = PORTC & 0b00111111;
      }else if(set == 3){
        //volver a reloj
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
      //
      PORTA = (tiempo/10) % 60;
      PORTC = (tiempo/(600)) % 60;
      PORTD = (tiempo/(36000)) % 24;
      break;
    case 1:
      if(temp > 23){
        temp = 0;
      }
      //ajustar horas
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
      //ajustar minutos
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