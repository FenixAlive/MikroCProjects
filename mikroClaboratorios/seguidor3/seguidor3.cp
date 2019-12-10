#line 1 "D:/cursoPic/quinto/mikroClaboratorios/seguidor3/seguidor3.c"
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
unsigned char velocidad = 0;
float Kp = 1;
float Kd = 2;
float Ki = 0.03;
float derivAnt = 0;
float integral = 0;
float sumaAnt = 0;

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
 if(!(PORTB & 0x02)){

 PORTC.RC3 = 1;
 }

 PORTC.RC0 = 1;
 PORTD.RD0 = direccion_motores[0];
 PORTD.RD1 = !direccion_motores[0];
 PORTD.RD2 = direccion_motores[1];
 PORTD.RD3 = !direccion_motores[1];
 PWM1_Init(10000);
 PWM2_Init(10000);
 PWM1_Start();
 PWM2_Start();
}

void cambiar_velocidad(){
 if(!(PORTB & 0x04)){
 velocidad = 210;
 }
}

void leer_sensores(){
 char cuantosSam = 9;

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
 float deriv = 0;
 for(i=0;i<4;i++){
 suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
 }
 deriv = Kd * (suma - derivAnt);
 derivAnt = suma;
 if(deriv > 7000){
 deriv = 7000;
 }else if(deriv < -7000){
 deriv = -7000;
 }
 integral += Ki*suma;
 if(integral > 3000){
 integral = 3000;
 }else if(integral < -3000){
 integral = -3000;
 }
 suma = (Kp * suma + deriv + integral )*255 / 10000;

 if( suma > 30){
 direccion_motores[0] = 0;
 direccion_motores[1] = 1;
 ultima_vuelta = 0;
 }else if (suma < -30){
 direccion_motores[0] = 1;
 direccion_motores[1] = 0;
 ultima_vuelta = 1;
 suma = -suma;
 }else{
 if(sensoresPrin[7] < 700 && sensoresPrin[0] < 700 && sensoresPrin[3] > 600 && sensoresPrin[4] > 600){
 direccion_motores[0] = 0;
 direccion_motores[1] = 0;
 suma = velocidad;
 }else{
 suma = 80;
 direccion_motores[0] = ultima_vuelta;
 direccion_motores[1] = !ultima_vuelta;
 }
 }
 suma = suma > 255 ? 255 : suma;
 pwm_motores[0] = (char) suma;
 pwm_motores[1] = (char) suma;
 sumaAnt = suma;
}

void actuadores(){

 PORTD.RD0 = direccion_motores[0];
 PORTD.RD1 = !direccion_motores[0];
 PORTD.RD2 = direccion_motores[1];
 PORTD.RD3 = !direccion_motores[1];

 PWM1_Set_Duty(pwm_motores[0]);
 PWM2_Set_Duty(pwm_motores[1]);
}
