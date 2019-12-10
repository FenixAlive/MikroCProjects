#line 1 "D:/cursoPic/quinto/mikroClaboratorios/lab10/lab10.c"

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


char uart_rd;
char text1[17];
char text2[17];
char i = 0;
char k = 1;
void limpiar_texto(char texto[]);
void escribir_letra();

void main() {
 ANSEL = 0;
 ANSELH = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Laboratorio 10");
 Lcd_Out(2,1,"  Luis Munoz");

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Laboratorio 10");
 UART1_Write(10);
 UART1_Write(13);
 UART1_Write_Text("Luis Munoz");
 UART1_Write(10);
 UART1_Write(13);
 while (1) {
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 escribir_letra();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,text1);
 Lcd_Out(2,1,text2);
 UART1_Write(uart_rd);
 }

 }
}

void limpiar_texto(char texto[]){
 char j = 0;
 for(j=0;j<17;j++){
 texto[j] = '\0';
 }
}

void escribir_letra(){
 if(!i && k == 1){
 limpiar_texto(text1);
 limpiar_texto(text2);
 text1[i] = '_';
 }
 if(uart_rd == '°'){
 limpiar_texto(text1);
 limpiar_texto(text2);
 i = 0;
 k = 1;
 text1[i] = '_';
 }else if(uart_rd == '¬'){
 if(k == 2){
 if(i == 0){
 text2[i] = '\0';
 k = 1;
 i = 15;
 text1[i] = '_';
 }else{
 text2[i] = '\0';
 text2[--i] = '_';
 }
 }else{
 if(i){
 text1[i] = '\0';
 text1[--i] = '_';
 }
 }
 }else{
 if(k == 1){
 text1[i] = uart_rd;
 text1[i+1] = '_';
 }else{
 text2[i] = uart_rd;
 text2[i+1] = '_';
 }
 if(++i > 15){
 i = 0;
 if(k > 1){
 k = 1;
 text2[16] = '\0';
 }else{
 k = 2;
 text2[i] = '_';
 text1[16] = '\0';
 }
 }
 }

}
