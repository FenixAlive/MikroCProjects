//Elaborado por Luis Angel Muñoz Franco
void main() {
  //OPTION_REG: RBPU:7, INTEDG:6, T0CS:5, T0SE:4, PSA:3, PS2:2, PS1:1, PS0:0
  //se desactivan los pull-up, se elige el contador en terminal RA4, flanco de
  //bajada, preescala wdt 1:1
  OPTION_REG = 0b10111000;
  //puerto C como salida
  TRISC = 0x00;
  PORTC = 0x00;
  //contador 0 en 0
  TMR0 = 0x00;
  
  while(1){
    PORTC = TMR0;
  }

}
