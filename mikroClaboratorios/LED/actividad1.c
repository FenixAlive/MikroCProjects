void main() {
      //Actividad 1
      //Se declaran todos los pines del puerto c como outputs
     TRISC=0x00;
     //se activan los leds del puerto c 0, 2, 4, 6, en binario es el 01010101 y
     //en hexadecimal el 055, en decimal el 85
     PORTC=0x055;
}