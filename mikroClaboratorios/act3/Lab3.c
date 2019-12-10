void main() {
     //Inicializo el pin 0 del puerto C como salida
  TRISC.RC0 = 0;
  // hago un ciclo infinito
  while(1){
    //Hago operación xor con el pin 0 del puerto C con el valor 1
    //Tabla de verdad:
    //|__RC0__|__1__|__=__|
    //|___0___|__1__|__1__|
    //|___1___|__1__|__0__|
    //de manera que va cambiando de 1 a 0 intermietentemente en cada ciclo while
    PORTC.RC0 ^= 1;
    //Hago un retardo de 250 milisegundos para notar el parpadeo
    delay_ms(250);
  }
}