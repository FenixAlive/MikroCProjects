void revisaBoton(int* presionar) {
  //si esta presionado reviso que este bien presionado con un doble if
  if(!PORTD.RC7){
    delay_ms(130);
    if(!PORTD.RC7){
      // si el valor de presionar es 1 lo hago 0 y si no lo hago 1
      (*presionar) ^= 1;
      //Pongo el puerto C en Cero para empezar
      PORTC = 0;
    }
  }
}

void main() {
   //Declaro variable para saber si el boton para cambiar de actividad
   //esta presionado
   int presionar = 0;
   // se configura al puerto C como salida
   TRISC = 0x00;
   //Pongo el puerto C en Cero para empezar
   PORTC = 0;
   //Se activan los weak pull-ups para detectar entrada de voltaje del puerto B
   // es el bit 8 (mas significativo del registro OPTION_REG y se debe poner en
   //cero para activar el pull-up
   OPTION_REG = OPTION_REG & 0x7F;
   // se pone el puerto B como entrada digital
   ANSELH = 0x00;
   //Activo el puerto B con un voltaje alto, activando los pull-ups
   PORTB = 0xFF;
   //Hago que el puerto D tenga en el pin 7 una entrada
   TRISD.RC7 = 1;
   //comienza ciclo infinito
   while(1) {
     //llamo función para ver si esta presionado el boton
     revisaBoton(&presionar);
     //si vale 1 presionado hago laboratorio 4
     if(presionar){
       //reviso el pin 0 del puerto B para ver si esta activada la alarma
       if(PORTB.RB0) {
         //Aplico un enmascaramiento para igualar los pines activos del puerto B
         //con los pines que me interesan 0b01110111 en el puerto C
         PORTC=PORTB & 0x77;
         //hago una espera de 250 milisegundos antes de hacer otra cosa
         delay_ms(250);
         //Apago todo en el puerto C y solo dejo encendida la alarma
         PORTC = 0x01;
         //Otra espera de 250 milisegundos lo cual da un efecto de parpadeo
         delay_ms(250);
       }else {
         //si no esta prendida la alarma apagar todo el puerto C
         PORTC = 0;
       }
     } else {
     //Si presionado vale 0 hago laboratorio 3
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
}