#line 1 "D:/cursoPic/quinto/sound/buzzer.c"

void main() {

 OSCCON = 0b01110111;

 Sound_Init(&PORTD, 0);

 Sound_Play(440, 3000);
 Sound_Init(&PORTD, 1);
 Sound_Play(480, 3000);

}
