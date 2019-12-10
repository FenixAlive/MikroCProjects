unsigned long cuenta = 0;

void main() {
//Option reg RBPU, INTEDG, T0CS, T0SE, PSA, PS2, PS1, PS2
//SE ESTAN MODIFICANDO EN ESTE REGISTRO DEL PIN 0 AL 5, 6 Y 7 SE DEJAN IGUAL
// psa 0:2 0x00 = 1:256 = 8Mhz / fosc/4 = 2Mhz x sec y un aumento de cuenta
// cada 65,536 oscilaciones
OPTION_REG &= 0b00010111; //confirmo los que quiero que se queden en 0
OPTION_REG |= 0b00010111; //confirmo los que quiero en 1

//INTCON  GIE, PEIE, T0IE, INTE, RBIE, T0IF, INTF, RBIF
INTCON |= 0b10100000; //interrupcion local
TMR0 = 0x00;
TRISD &= 0x01;
PORTD &= 0x01;
}

void interrupt(){
  if(INTCON & 0b00000100){
    //cada 500 milisegundos aprox enciende el led y apaga
    ++cuenta = cuenta > 15 ? 0 : cuenta;
    PORTD ^= !cuenta ? 0x01 : 0x00;
    INTCON &= 0b11111011; //limpiar bandera de interrupcion
  }
}