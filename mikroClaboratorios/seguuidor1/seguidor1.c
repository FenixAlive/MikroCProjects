/*
  sin linea
  300 300 300 300 300 300 300 300
  con linea centrada
  300 300 300 900 900 300 300 300
  linea chueca
  300 300 700 1000 700 300 300 300
*/

/*botones
  //todo el tiempo estan en 5v, al dejar pasar la tierra consideramos que se activan
  //Solo el modo calibración se puede cambiar una vez iniciado el while del programa, los demas
  //botones solo los reconoce al iniciar el programa, resetear al cambiar el estado, esto para
  //hacer mas rapido la lectura del while sin tantos if
  0x02- Enciende sensores y motores
  0x04 y 0x08- 3 modos de velocidad con estos dos botones en binario 0x08 es el menos significativo 0x04 el msb
  0x10- Enciende modo calibracion (aqui se encienden automaticamente los sensores y se apagan los motores)
        En modo calibración el bit 08 apagado calibra blanco, encendido calibra negro

*/

//si hay linea el sensor vale 1000 aprox, si no hay linea vale entre 300 a 500
void ADC_Init();
void iniciar_seguidor();
void velocidades();
void calibrar_sensor();
void buzzer();
void leer_sensores();
void controlador();
void actuadores();

unsigned int sensoresPrin[] = {0,0,0,0,0,0,0,0};
//entre 0 minimo a 255 maximo
unsigned char pwm_motores[] = {0, 0};
//0 reversa, 1 adelante
unsigned char direccion_motores[] = {0, 0};
unsigned char velocidad = 220;
unsigned char valOk = 70;
char i = 0, j = 0;

//constantes actuador
float Kp = 3;
float Kd = 0.04;
int N = 30000;  //filtro derivativo
float Ki = 0.15;
float errorAnt = 0; //derivada
int acumInt = 0; //integral acumulada

void main() {
     ANSEL = 0xFF;
     ANSELH = 0x00; //por ahora solo los 8 sensores como analogos
     C1ON_bit = 0;               // apago comparadores
     C2ON_bit = 0;
     // PORTA entrada
     TRISA  = 0xFF;
     //Activo PULL-UPS Puerto B
     OPTION_REG &= 0x7F;
     //pin 7 B salida buzzer
     //pin 0 a 6 entrada  digital
     TRISB = 0x7F;
     PORTB = 0x7F;
     TRISC = 0;                          // salidas puerto C
     PORTC = 0;                          // poner PORTC en 0
     
     //si esta encendido el boton B 0x02 comienza el robot a funcionar normal
     if(!(PORTB & 0x02)){
       // poner puerto D como salidas
       TRISD = 0x00;
       PORTD = 0x00;
       iniciar_seguidor();
       while(1){
         leer_sensores();
         controlador();
         actuadores();
       }
     }else{
       buzzer();
       Delay_ms(200);
       while(1){
         if(!(PORTB & 0x08)){
           calibrar_sensor();
         }
       }
     }
}

void leer_sensores(){
  char cuantosSam = 9;
  //inicio en 0 los sensores
  for(i=0;i<8;i++){
    sensoresPrin[i] = 0;
  }
  //guardo la suma de 7 valores analogos en los 8 sensores
  for(i=0;i<cuantosSam;i++){
    for(j=0;j<8;j++){
      sensoresPrin[j] += ADC_Read(j);
    }
  }
  // saco promedio
  for(i=0;i<8;i++){
    sensoresPrin[i] /= cuantosSam;
  }
}

//mejorada
/*
void controlador(){
  int suma = 0;
  int deriv = 0;
  for(i=0;i<4;i++){
    suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
  }
  //integral
  acumInt += suma;
  //filtro integral
  if(acumInt > 50000){
    acumInt = 50000;
  }else if(acumInt < -50000){
    acumInt = -50000;
  }
  
  //derivativo
  deriv = suma-(errorAnt);
  //errorAnt[2]=errorAnt[1];
  //errorAnt[1]=errorAnt[0];
  errorAnt = suma;
  //filtro derivativo
  if(deriv > N){
   deriv = N;
  }else if(deriv < -N){
   deriv = -N;
  }
  //error maximo 4000+3000+2000+1000 = 10000 = 255
  suma = (Kp*suma+ Kd*(deriv)/0.01 + Ki*acumInt)*255/10000;
  //suma = Kp*suma;//+ Kd*(suma-errorAnt)/100;
  if( suma > valOk){
    direccion_motores[0] = 0;
    direccion_motores[1] = 1;
  }else if (suma < -valOk){
    direccion_motores[0] = 1;
    direccion_motores[1] = 0;
    suma = -suma;
  }else{
    direccion_motores[0] = 0;
    direccion_motores[1] = 0;
    suma = velocidad;
  }
  suma = suma > 255 ? 255 : suma;
  if(suma < 120){
    PORTC.RC3 = 0;
  }else{
    PORTC.RC3 = 1;
  }
  pwm_motores[0] =  (int) suma;
  pwm_motores[1] =  (int) suma;
}
*/

//funciona bien basico
void controlador(){
  int suma = 0;
  int dd = 0;
  int deriv = 0;
  for(i=0;i<4;i++){
    suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
  }
  dd = suma;
  acumInt += suma;
  //error maximo 4000+3000+2000+1000 = 10000 = 255
  suma = (Kp*suma+ Kd*(suma-errorAnt)/10 + Ki*acumInt)*255/10000;
  //suma = Kp*suma;//+ Kd*(suma-errorAnt)/100;
  errorAnt = dd;

  suma = suma > 255 ? 255 : suma;
  suma += velocidad;
  if( suma > 0){
    direccion_motores[0] = 0;
    direccion_motores[1] = 1;
  }else if (suma < 0){
    direccion_motores[0] = 1;
    direccion_motores[1] = 0;
    suma = -suma;
  }else{
    direccion_motores[0] = 1;
    direccion_motores[1] = 1;
  }

  pwm_motores[0] =  suma;
  pwm_motores[1] =  suma;
}


void actuadores(){
  //ver como activar freno
  //direccion de motores
  PORTD.RD0 = direccion_motores[0];
  PORTD.RD1 = !direccion_motores[0];
  PORTD.RD2 = direccion_motores[1];
  PORTD.RD3 = !direccion_motores[1];
  //potencia
  PWM1_Set_Duty(pwm_motores[0]);
  PWM2_Set_Duty(pwm_motores[1]);
}
void iniciar_seguidor(){
  // pin 3 = prender tb6612 motores
  PORTC.RC3 = 1;
  //pin 0 = prender IR leds sensores
  PORTC.RC0 = 1;
  PORTD.RD0 = direccion_motores[0];
  PORTD.RD1 = !direccion_motores[0];
  PORTD.RD2 = direccion_motores[1];
  PORTD.RD3 = !direccion_motores[1];
  PWM1_Init(10000);                    // Initializar PWM1
  PWM2_Init(10000);                    // Initializar PWM2
  PWM1_Start();                       // start PWM1
  PWM2_Start();                       // start PWM2
}
void calibrar_sensor(){buzzer();}
/*
void calibrar_sensor(){
  //valores de sensores menor y mayor
//cuando funcione calibracion cambiar a 10000
int menor_cal = 300;
//cuando funcione calibracion cambiar a 0
int mayor_cal = 1000;
  int suma = 0;
  menor = 10000;
  mayor = 0;
  //pin 0 = prender IR leds sensores
  PORTC.RC0 = 1;
  buzzer();
  leer_sensores();
  for(j = 0; j<100; j++){
    suma = 0;
    for(i=0;i<8;i++){
      suma += sensoresPrin[i];
    }
    if(PORTB & 0x08){
      if(suma < menor){
        menor = suma;
      }
    }else{
      if(suma > mayor){
        mayor = suma;
      }
    }
  }
  if(PORTB & 0x08){
    menor = menor / 8;
  }else{
    mayor = mayor / 8;
  }
}
*/
void velocidades(){}