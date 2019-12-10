#line 1 "D:/cursoPic/quinto/sound/sound2.c"
int tono(int t) {
}
void main() {
 int t[4] = {0, 0, 0, 0};
 int nota[] = {382, 340, 303, 286, 255, 227, 202};
 int vNota = 0;
 long tiempo = 0;
 TRISD = 0x00;
 PORTD = 0x00;
 while(1){
 tiempo++;
 if(tiempo == 1000){
 if(vNota<7){
 vNota++;
 }else{
 vNota=0;
 break;
 }
 }
 if(t[0] == nota[vNota]){
 t[0] = 0;
 PORTD ^= 0x01;
 }




 delay_us(10);
 t[0]++;
 t[1]++;
 t[2]++;
 t[3]++;
 }
}
