void main() {
     //variable que revisa que ejercicio hacer la inicializo en cero
     // para comenzar con la actividad 1
     int presionar = 0;
     //Hago que todo el puerto c sea de salida
     TRISC=0x00;
     //Hago que el puerto D tenga en el pin 7 una entrada y las demas se queden
     //como ya estan
     TRISD |= 0x20;
     //Option_Reg habilita los weak pull-ups del puerto B
     OPTION_REG = OPTION_REG & 0x7F;
     //Deshabilito las entradas analogicas y habilito las entradas digitales
      ANSEL = 0x00;
     ANSELH = 0x00;
     //Hago que todo el puerto B tenga tensión alta y cuando un pin tenga
     //conexion a tierra el pull-up marque que se esta activando ese pin
     PORTB = 0xFF;
      
     while(1){
              //si esta presionado reviso que este bien presionado con un doble if
              if(!PORTD.RC7){
                delay_ms(130);
                if(!PORTD.RC7){
                  // si el valor de presionar es 1 lo hago 0 y si no lo hago 1
                  presionar = !presionar;
                }
              }
              // si el valor de presionar es 1 entonces hago la actividad 2
              // si el valor es cero entonces hago la actividad 1
              if(presionar){
                    PORTC=PORTB;
              }else{
                    PORTC=0x055;
              }

     }
}