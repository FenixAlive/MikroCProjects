#line 1 "D:/cursoPic/quinto/mikroClaboratorios/seguuidor1/seguidor1.c"
#line 23 "D:/cursoPic/quinto/mikroClaboratorios/seguuidor1/seguidor1.c"
void ADC_Init();
void iniciar_seguidor();
void velocidades();
void calibrar_sensor();
void buzzer();
void leer_sensores();
void controlador();
void actuadores();

unsigned int sensoresPrin[] = {0,0,0,0,0,0,0,0};

unsigned char pwm_motores[] = {0, 0};

unsigned char direccion_motores[] = {1, 1};
unsigned char velocidad = 220;
unsigned char valOk = 70;
char i = 0, j = 0;


float Kp = 3;
float Kd = 0.04;
int N = 30000;
float Ki = 0.15;
float errorAnt = 0;
int acumInt = 0;

void main() {
 ANSEL = 0xFF;
 ANSELH = 0x00;
 C1ON_bit = 0;
 C2ON_bit = 0;

 TRISA = 0xFF;

 OPTION_REG &= 0x7F;


 TRISB = 0x7F;
 PORTB = 0x7F;
 TRISC = 0;
 PORTC = 0;


 if(!(PORTB & 0x02)){
 PWM1_Init(5000);
 PWM2_Init(5000);

 TRISD = 0x00;
 PORTD = 0x00;

 iniciar_seguidor();
 buzzer();
 Delay_ms(300);
 buzzer();
 Delay_ms(300);
 buzzer();
 Delay_ms(300);
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

 for(i=0;i<8;i++){
 sensoresPrin[i] = 0;
 }

 for(i=0;i<cuantosSam;i++){
 for(j=0;j<8;j++){
 sensoresPrin[j] += ADC_Read(j);
 }
 }

 for(i=0;i<8;i++){
 sensoresPrin[i] /= cuantosSam;
 }
}
#line 169 "D:/cursoPic/quinto/mikroClaboratorios/seguuidor1/seguidor1.c"
void controlador(){
 int suma = 0;
 int dd = 0;
 int deriv = 0;
 for(i=0;i<4;i++){
 suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
 }
 dd = suma;
 acumInt += suma;

 suma = (Kp*suma+ Kd*(suma-errorAnt)/10 + Ki*acumInt)*255/10000;

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

 pwm_motores[0] = suma;
 pwm_motores[1] = suma;
}


void actuadores(){


 PORTD.RD0 = direccion_motores[0];
 PORTD.RD1 = !direccion_motores[0];
 PORTD.RD2 = direccion_motores[1];
 PORTD.RD3 = !direccion_motores[1];

 PWM1_Set_Duty(pwm_motores[0]);
 PWM2_Set_Duty(pwm_motores[1]);
}

void iniciar_seguidor(){

 PORTC.RC3 = 1;

 PORTC.RC0 = 1;

 PORTD.RD0 = direccion_motores[0];
 PORTD.RD1 = !direccion_motores[0];
 PORTD.RD2 = direccion_motores[1];
 PORTD.RD3 = !direccion_motores[1];
 PWM1_Start();
 PWM2_Start();
 PWM1_Set_Duty(pwm_motores[0]);
 PWM2_Set_Duty(pwm_motores[1]);
}

void calibrar_sensor(){buzzer();}
#line 267 "D:/cursoPic/quinto/mikroClaboratorios/seguuidor1/seguidor1.c"
void velocidades(){}

void buzzer(){
 PORTB.RB7 = 1;
 Delay_ms(300);
 PORTB.RB7 = 0;
}
