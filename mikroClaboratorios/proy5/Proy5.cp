#line 1 "D:/cursoPic/quinto/mikroClaboratorios/proy5/Proy5.c"

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

void ADC_Init();


const char tamStr = 5;
const char tMues = 50;
unsigned long temp = 0;
float temper = 0.0;
unsigned int analogos[4] = {0,0,0,0};
char palabra[tamStr+1] = "0";

char i = 0;

void num2str(unsigned int *val);
void float2str(float *val);
void analog_Read(int chan);

void main(){


 INTCON |= 0b10000000;

 ANSEL = 0x0F;
 ANSELH = 0x00;
 TRISA = 0x0F;
 C1ON_bit = 0;
 C2ON_bit = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Proyecto 6");
 Lcd_Out(2,1,"Luis Munoz");




 Delay_ms(1000);
 while(1) {
 analog_Read(0);
 analog_Read(1);
 analog_Read(2);
 analog_Read(3);


 Delay_us(tMues);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,"R:");
 num2str(&analogos[0]);
 Lcd_Out(1,3, palabra);

 Lcd_Out(1,9,"I:");
 num2str(&analogos[1]);
 Lcd_Out(1,12, palabra);

 Lcd_Out(2,1,"L:");
 num2str(&analogos[2]);
 Lcd_Out(2,3, palabra);

 Lcd_Out(2,9,"T:");
 temper = (float) (analogos[3] * 520) / 1023;
 float2str(&temper);
 Lcd_Out(2,12, palabra);

 Delay_ms(1000);
 }
}

void num2str(unsigned int *val){
 i = tamStr;
 if(*val){
 while(*val && i > -1){
 palabra[--i] = 48 + (*val % 10);
 *val /= 10;
 }
 while(i > 0){
 palabra[--i] = 32;
 }
 }else{
 palabra[--i] = '0';
 while(i > 0){
 palabra[--i] = 32;
 }
 }
 palabra[5] = '\0';
}

void float2str(float *val){
 int temp = (int) ((*val) * 100);
 if(temp >= 10000){
 temp = 9999;
 }
 i = tamStr;
 if(temp){
 while(temp && i > -1){
 if(i == tamStr-2){
 palabra[--i] = '.';
 }else{
 palabra[--i] = 48 + (temp % 10);
 temp /= 10;
 }
 }
 while(i > 0){
 palabra[--i] = 32;
 }
 }else{
 palabra[--i] = '0';
 while(i > 0){
 palabra[--i] = 32;
 }
 }
 palabra[5] = '\0';
}

void analog_Read(int chan){
 temp = 0;
 for(i=0;i<tMues;i++){
 temp += ADC_Read(chan);
 }
 analogos[chan] = temp/tMues;

}
