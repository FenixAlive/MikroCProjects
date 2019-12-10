void main() {
   // se configura al puerto C como salida
   TRISC = 0x00;
   //Se activan los weak pull-ups para detectar entrada de voltaje del puerto B
   // es el bit 8 (mas significativo del registro OPTION_REG y se debe poner en
   //cero para activar el pull-up
   OPTION_REG = OPTION_REG & 0x7F;
   // se pone el puerto B como entrada digital
   ANSELH = 0x00;
   //Activo el puerto B con un voltaje alto, activando los pull-ups
   PORTB = 0xFF;
   //comienza ciclo infinito
   while(1) {
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
   }
}