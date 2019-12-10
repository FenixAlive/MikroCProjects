#line 1 "D:/cursoPic/quinto/mikroClaboratorios/seguidor4/seguidor4.c"
void ADC_Init();
void iniciar_seguidor();
void cambiar_velocidad();
void leer_sensores();
void controlador();
void actuadores();
int i=0, j=0;
int sensoresPrin[] = {0,0,0,0,0,0,0,0};

unsigned char pwm_motores[] = {0, 0};

unsigned char direccion_motores[] = {0, 0};
unsigned char ultima_vuelta = 0;

unsigned char velocidad = 70;

float velVuelta = 70;

float Kp = 0.7;
float Kd = 0.021;
float Ki = 0;
float derivAnt = 0;
float integral = 0;

void main() {
 ANSEL = 0xFF;
 ANSELH = 0x00;
 C1ON_bit = 0;
 C2ON_bit = 0;

 TRISA = 0xFF;

 OPTION_REG &= 0x7F;


 TRISB = 0x7F;
 PORTB = 0x7F;
 TRISC = 0x00;
 PORTC = 0x00;

 TRISD = 0x00;
 PORTD = 0x00;

 iniciar_seguidor();
 cambiar_velocidad();
 while(1){
 leer_sensores();
 controlador();
 actuadores();
 }
}

void iniciar_seguidor(){
 if(!(PORTB & 0x01)){

 PORTC.RC3 = 1;
 }

 PORTC.RC0 = 1;
 PORTD.RD0 = direccion_motores[0];
 PORTD.RD1 = !direccion_motores[0];
 PORTD.RD2 = direccion_motores[1];
 PORTD.RD3 = !direccion_motores[1];
 PWM1_Init(5000);
 PWM2_Init(5000);
 PWM1_Start();
 PWM2_Start();
}

void cambiar_velocidad(){
 if(!(PORTB & 0x02)){
 velocidad = 100;
 Kd=0.024;
 Kp=0.79;
 }
}

void leer_sensores(){
 char cuantosSam = 7;

 for(i=0;i<8;i++){
 sensoresPrin[i] = 0;
 }

 for(i=0;i<cuantosSam;i++){
 for(j=0;j<8;j++){
 sensoresPrin[j] += ADC_Read(j) / cuantosSam;
 }
 }
}

void controlador(){
 float suma = 0;
 float pwm1 = 0;
 float pwm2 = 0;
 float deriv = 0;
 for(i=0;i<4;i++){
 suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
 }
 deriv = Kd * (suma - derivAnt)/0.01;
 derivAnt= suma;
 if(deriv > 5000){
 deriv = 5000;
 }else if(deriv < -5000){
 deriv = -5000;
 }
 integral += Ki*suma;
 if(integral > 1500){
 integral = 1500;
 }else if(integral < -1500){
 integral = -1500;
 }
 suma = (Kp * suma + deriv + integral )*255 / 10000;
 if( suma > velocidad){
 direccion_motores[0] = 0;
 direccion_motores[1] = 1;
 pwm1 = suma+velocidad > 255 ? 255 : suma + velocidad;
 pwm2 = suma-velocidad > 255 ? 255 : suma - velocidad;
 }else if (suma < -velocidad){
 direccion_motores[0] = 1;
 direccion_motores[1] = 0;
 pwm1 = -suma-velocidad > 255 ? 255 : -suma-velocidad;
 pwm2 = -suma+velocidad > 255 ? 255 : -suma+velocidad;
 }else{
 direccion_motores[0] = 0;
 direccion_motores[1] = 0;
 pwm1 = velocidad+suma > 255 ? 255 : velocidad+suma;
 pwm2 = velocidad-suma > 255 ? 255 : velocidad-suma;
 }
 if(sensoresPrin[7] > 700 && sensoresPrin[0] < 500){
 ultima_vuelta = 0;
 }else if(sensoresPrin[0] > 700 && sensoresPrin[7] < 500){
 ultima_vuelta = 1;
 }
 if( derivAnt < 2000 && derivAnt > -2000 &&((sensoresPrin[3] + 300 > sensoresPrin[0]) && (sensoresPrin[3] - 300 < sensoresPrin[0])) && ( (sensoresPrin[4] + 300 > sensoresPrin[7]) && (sensoresPrin[4] - 300 < sensoresPrin[7]))){
 pwm1 = velVuelta;
 pwm2 = velVuelta;
 direccion_motores[0] = ultima_vuelta;
 direccion_motores[1] = !ultima_vuelta;
 }
 pwm_motores[0] = (char) pwm1;
 pwm_motores[1] = (char) pwm2;
}

void actuadores(){

 PORTD.RD0 = direccion_motores[0];
 PORTD.RD1 = !direccion_motores[0];
 PORTD.RD2 = direccion_motores[1];
 PORTD.RD3 = !direccion_motores[1];

 PWM1_Set_Duty(pwm_motores[0]);
 PWM2_Set_Duty(pwm_motores[1]);
}
