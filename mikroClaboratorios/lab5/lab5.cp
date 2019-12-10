#line 1 "D:/cursoPic/quinto/mikroClaboratorios/lab5/lab5.c"

const float notas[] = {220.0, 246.94, 261.6, 293.67, 329.63, 349.23, 392.0, 440.0, 493.88, 523.25, 587.33};

void musica(unsigned char *idx, unsigned char *cual, const int tiempo){
 switch (*cual){
 case 0:
 if(*idx < 8){
 if( *idx % 2 ){
 Sound_Play(notas[0], tiempo);
 }else{
 Sound_Play(notas[(*idx+1)/2], tiempo);
 }
 }else{
 if( *idx % 2 ){
 Sound_Play(notas[4], tiempo);
 }else{
 Sound_Play(notas[(15-*idx)/2], tiempo);
 }
 }
 break;
 case 1:
 if(*idx % 2){
 Sound_Play(notas[4], tiempo);
 }else{
 if(*idx<8){
 Sound_Play(notas[4-((*idx+1)/2)], tiempo);
 }else{
 Sound_Play(notas[8-((*idx+1)/2)], tiempo);
 }
 }
 break;
 case 2:
 if(*idx % 2){
 if(*idx<8){
 Sound_Play(notas[4], tiempo);
 }else if (*idx == 14) {
 Sound_Play(notas[8], tiempo);
 }else{
 Sound_Play(notas[9], tiempo);
 }
 }else{
 if(*idx<8){
 Sound_Play(notas[0], tiempo);
 }else{
 Sound_Play(notas[(*idx+1)/2], tiempo);
 }
 }
 break;
 }

}


void apagaDisplay(){
 PORTC = 0x00;
 delay_ms(50);
}

void presentacion(){
 const char pres[] = {0x7C, 0x40, 0x58, 0x00, 0x6F, 0x5F, 0x6B, 0x3E};
 unsigned char k = 1;
 unsigned char i = 0;
 for(;i<8;i++){
 PORTC = pres[i];
 musica(&i,&k,230);
 }
 apagaDisplay();
}

void actividad0f(unsigned char tabla[]){
 unsigned char i, j=1, k=0;
 const int tempo = 230;

 while(1){
 for(i=0; i<16; i++){
 PORTC = tabla[i];
 if((j==20)){
 k=2;
 if(i==15){
 j=0;
 }
 }else if((j==10)){
 k=2;
 }else if(!(j%5)){
 k=1;
 }else{
 k=0;
 }
 musica(&i,&k,tempo);
 }
 j++;
 }
}

void adivinaBin(unsigned char tabla[], unsigned char *val){

 *val = rand() % 15 + 1;
 PORTC = tabla[*val];
}

void juegoBinario(unsigned char tabla[]){

 unsigned char i, j=0, k = 0, l = 0;
 unsigned char val;
 srand(PORTA);
 adivinaBin(tabla, &val);
 while(1) {
 musica(&j, &k, 70);
 if((PORTA ^ 0b00001111) & 0b00001111) {
 if(++l > 2){
 l = 0;
 if(++j > 15){
 j=0;
 if(++k > 2){
 k = 0;
 }
 }
 }
 musica(&j, &k, 70);
 if((PORTA ^ 0b00001111) & 0b00001111) {
 i = (PORTA ^ 0b00001111) & 0b00001111;
 if(i == val) {
 apagaDisplay();
 PORTC = 0x6D;
 Sound_Play(notas[0]*2, 90);
 Sound_Play(notas[1]*2, 90);
 Sound_Play(notas[2]*2, 90);
 apagaDisplay();
 adivinaBin(tabla, &val);
 }else{
 PORTC = tabla[i];
 }
 }
 }else{
 PORTC = tabla[val];
 }
 if(++l > 3){
 l = 0;
 if(++j > 15){
 j=0;
 if(++k > 2){
 k = 0;
 }
 }
 }
 }
}

void main() {
 unsigned char tabla[] = {0x77, 0x41, 0x3B, 0x6B, 0x4D, 0x6E, 0x7E, 0x43, 0x7F, 0x6F, 0x5F, 0x7C, 0x36, 0x79, 0x3E, 0x1E};
 TRISA = 0x0F;
 PORTA = 0x0F;
 TRISC = 0x00;
 PORTC = 0x00;
 ANSEL = 0X00;
 ANSELH = 0x00;

 TRISB.RB7 = 0;
 PORTB.RB7 = 0;
 Sound_Init(&PORTB,7);
 if(((PORTA ^ 0b00001111) & 0b00001111) == 1){
 actividad0f(tabla);
 }else{
 presentacion();
 juegoBinario(tabla);
 }
}
