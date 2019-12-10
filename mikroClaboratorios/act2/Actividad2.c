void main() {
     //Actividad 1.2 leds dip switch
     //Activo todos los puertos B como salidas
     TRISC=0x00;
     //Activo los weak pull-ups del puerto B para captar el momento en que se
     //pierde la corriente en alguno de los puertos o se mantiene
     OPTION_REG = OPTION_REG & 0x7F;
     //deshabilito la entrada analogíca del puerto B y se habilita el digital
     ANSELH = 0x00;
     //Activo el puerto B con 5 voltios
     PORTB = 0xFF;
     //Se crea un ciclo infinito
     while(1){
              //El Valor del puerto C es igual al valor recibido por el Puerto B
              PORTC=PORTB;
     }
}