void main() {
  TRISB = 0x00;
  PORTB = 0xFF;
  Delay_ms(5000);
  PORTB = 0x00;
}