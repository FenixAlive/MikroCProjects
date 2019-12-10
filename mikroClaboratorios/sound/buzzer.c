
void main() {
     //oscilador a 8mhz
     OSCCON = 0b01110111;
     // Initialize the pin RC3 for playing sound
     Sound_Init(&PORTD, 0);
     //Sound_Play(unsigned freq_in_hz, unsigned duration_ms);
     Sound_Play(440, 3000);
     Sound_Init(&PORTD, 1);
     Sound_Play(480, 3000);
     //delay_ms(250);
}