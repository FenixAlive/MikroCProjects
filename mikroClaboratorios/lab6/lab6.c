//variables generales
unsigned char unidades = 0;
unsigned char decenas = 0;
unsigned char uTotal = 9;
unsigned char dTotal = 9;
unsigned char tabla[] = {0x77, 0x41, 0x3B, 0x6B, 0x4D, 0x6E, 0x7E, 0x43, 0x7F, 0x6F, 0x5F, 0x7C, 0x36, 0x79, 0x3E, 0x1E};
unsigned char parar = 0;
unsigned char presion = 0;
unsigned int pulso = 2; //poner default 2 que equivale a 200 milisegundos
unsigned char alarma = 99; //en que momento suena la alarma
unsigned char set = 0; //en que momento salimos de set
//2 es do, escala mayor en do
const float notas[] = {220.0, 246.94, 261.6, 293.67, 329.63, 349.23, 392.0, 440.0, 493.88, 523.25, 587.33};
//declaracion de funciones para contar hacia arriba, hacia abajo y para mostrar
//los valores en el display con multiplexado
void conteo_up();
void conteo_down();
void multiplexado(unsigned int veces);
void boton_presionado();

void main() {
  //declaro los puertos C y D como salidas
  TRISC = 0x00;
  TRISD = ~0x03;
  //activo pull-ups en puerto B
  OPTION_REG = OPTION_REG & 0x7F;
  //apago las entradas analogicas del puerto B
  ANSELH=0x00;
  //pongo en estado Alto del pin 1 al 4 y el 7 del puerto B
  PORTB= 0x9E;
  Sound_Init(&PORTD,7);
  while(1){
    //si esta encendido el pin 4 del puerto B esta en modo set
    if((PORTB & 0x10)){
      //conteos
      if(!parar){
        //si no esta encendido el pin 2 del puerto B hace conteo hacia arriba
        if(PORTB & 0x04){
          conteo_up();
        //si esta encendido el pin 2 hace conteo hacia abajo
        }else{
          conteo_down();
        }
      }
      //si esta encendido el pin 3 del puerto B la alarma esta encendida del temporizador
      if(unidades == uTotal && decenas == dTotal && !(PORTB & 0x08)){
        PORTD.RD1 = 1;
        PORTC = tabla[10];
        Sound_Play(notas[2]*2, 100);
        Sound_Play(notas[6]*2, 100);
        Sound_Play(notas[4]*2, 150);
        Sound_Play(notas[2]*2, 100);
        Sound_Play(notas[1]*2, 400);
        Sound_Play(notas[2]*2, 300);
        PORTD.RD1 = 0;
      }
    }
    //hace multiplexeo para mostrar los numeros en los display
    multiplexado(pulso);
  } //fin while
} //fin main

//función que va aumentando el contador de unidades y decenas en orden
void conteo_up(){
  if(++unidades > 9){
    unidades = 0;
    if(++decenas > dTotal){
      decenas = 0;
    }
  }
  if( decenas >= dTotal && unidades > uTotal){
    unidades = 0;
    decenas = 0;
  }
}
//función que va disminuyendo en orden las decenas y unidades
void conteo_down(){
  if(unidades-- == 0){
    unidades = 9;
    if(decenas-- == 0){
      decenas = dTotal;
    }
  }
}

//función que cambia cada 5 milisegundos entre las unidades y decenas para
//usar los mismos pines para mostrar datos distintos.
void multiplexado(unsigned int veces){
  veces *=10;
  PORTD.RD0 = 0;
  PORTD.RD1 = 0;
  while(veces--){
    PORTC = tabla[unidades];
    PORTD.RD1 = 1;
    delay_ms(5);
    PORTD.RD1 = 0;
    PORTC = tabla[decenas];
    //si estamos en set en temporizador pongo punto a las decenas
    if(!(PORTB & 0x10) && (PORTB & 0x08)){
      PORTC.RC7 = 1;
    }
    PORTD.RD0 = 1;
    delay_ms(5);
    PORTD.RD0 = 0;
    PORTC.RC7 = 0;
    boton_presionado();
  }
}

void boton_presionado(){
  //no estoy en configuracion
  if((PORTB & 0x10)){
    //si acabo de salir de set
    if(set){
      set = 0;
      unidades = 0;
      decenas = 0;
      parar = 0;
    }
   //si esta encendido el dip-switch del pin 1 del puerto B se detiene el conteo
    if(!(PORTB & 0x02)){
      parar = 1;
      presion = 0;
    }else{
      if(!(PORTB & 0x80)){
        Sound_Play(notas[7]*2, 70);
        if(!(PORTB & 0x80)){
          Sound_Play(notas[9]*2, 80);
          presion ^= 1;
        }
      }
      parar = presion;
    }
  }else{
    //si es la primera vez del modo set
    if(!set){
      set = 1;
      parar = 1;
    }
    if(!(PORTB & 0x08)){
      //si esta el pin 3 encendido modifico la alarma
        if(!(PORTB & 0x80)){
          Sound_Play(notas[7]*2, 70);
          if(!(PORTB & 0x80)){
            Sound_Play(notas[9]*2, 80);
            if(++alarma > 159){
              alarma = 0;
            }
          }
        }
        uTotal = alarma % 10;
        dTotal = alarma / 10;
        unidades = uTotal;
        decenas = dTotal;
    }else{
        //sino modifico la rapidez del temporizador
        if(!(PORTB & 0x80)){
          Sound_Play(notas[7]*2, 70);
          if(!(PORTB & 0x80)){
            Sound_Play(notas[9]*2, 80);
            if(++pulso > 159){
              pulso = 1;
            }
          }
        }
        unidades = pulso % 10;
        decenas = pulso / 10;
    }
  }
}