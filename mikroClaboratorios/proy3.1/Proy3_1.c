//2 es do, escala mayor en fa                                                 7 la 8 si   9 do    10 re
const float notas[] = {220.0, 235.22, 261.6, 293.67, 329.63, 349.23, 392.0, 440.0, 470.4, 523.25, 587.33};
//Numeros del 0 al F y punto
unsigned char tabla[] = {0x77, 0x41, 0x3B, 0x6B, 0x4D, 0x6E, 0x7E, 0x43, 0x7F, 0x6F, 0x5F, 0x80};
unsigned char tiempoDisplay[] = {0, 0, 0, 0, 0, 0};
unsigned char tiempoAlarma[] = {9, 5, 9, 5, 0, 0};
unsigned char limitesTiempo[] = {9, 5, 9, 5, 9, 9};
unsigned char contaTiempo = 0;
char i = 0, set = 0, pausar = 0, horas = 0;
signed char setT = 0;
void tablero();
void configuracion();
void cadaSegundo();
void contar();
void sonarAlarma();
void revisarContador();
void apretarBoton();


//PORTB
//2 = reversa
//4 = alarma
//8 = configuracion
//10 = cambiar vista a horas - en set decide que cambiar
void main() {
//declaro los puertos C y D como salidas
  TRISC = 0x00;
  TRISD = 0x00;
  //activo pull-ups en puerto B
  OPTION_REG = OPTION_REG & 0x7F;
  //apago las entradas analogicas del puerto B y A
  ANSELH=0x00;
  ANSEL = 0x00;
  C1ON_bit = 0;                      // Desabilito comparadores
  C2ON_bit = 0;
  //pongo en estado Alto puerto B
  PORTB= 0xFF;
  PORTC = 0x00;
  PORTD = 0x01;

  //inicializo sonido
  Sound_Init(&PORTD,7);
  Sound_Play(notas[1]*3, 100);
  Sound_Play(notas[2]*3, 100);
  while(1){
    tablero();
    configuracion();
    cadaSegundo();
    apretarBoton();
    //tiempo de 5 milisegundos por cambio de letra por 4 letras = 20 milisegundos
    Delay_ms(3);
    PORTC = 0x00;
    Delay_ms(2);
  }// fin while
}

void tablero(){
  PORTD = PORTD >= 0x08 ? 0x01 : PORTD << 1;
  //cada 500 milisegundos pone un punto
  if(!horas){
    PORTC = tabla[tiempoDisplay[++contaTiempo % 4]];
  }else{
    PORTC = tabla[tiempoDisplay[(++contaTiempo % 4)+2]];
  }
  if(contaTiempo >= 100){
    if((horas && PORTD == 0x01) || (!horas && PORTD == 0x04)){
      PORTC += tabla[11];
    }
  }
}

void cadaSegundo(){
  //cada segundo
  if(contaTiempo >= 200){
    contaTiempo = 0;
    contar();
    sonarAlarma();
  }
}

void configuracion(){
  if(!(PORTB & 0x08)){
    if(!set){
      set = 1;
      Sound_Play(notas[0]*2, 50);
      horas = 0;
    }
    if(contaTiempo > 150){
      if(setT == 0){
        if(PORTD < 0x04){
          PORTC = 0x00;
        }
      }else{
        if(PORTD >= 0x04){
          PORTC = 0x00;
        }
      }
    }else{
      for(i = 0; i < 6; i++){
        tiempoDisplay[i] = tiempoAlarma[i];
      }
    }
  }else{
    if(set){
      set = 0;
      Sound_Play(notas[2]*2, 50);
      setT = 0;
      for(i = 0; i < 6; i++){
        tiempoDisplay[i] = 0;
      }
    }
    if(PORTB & 0x10){
      horas = 0;
    }else{
      horas = 1;
    }
  }
}

void contar(){
  if(PORTB & 0x08 && !pausar){
    for(i = 0; i < 6; i++){
      if(PORTB & 0x02){
        if(++tiempoDisplay[i] > limitesTiempo[i]){
          tiempoDisplay[i] = 0;
        }else{
          break;
        }
      }else{
        if(tiempoDisplay[i]-- == 0){
          tiempoDisplay[i] = limitesTiempo[i];
        }else{
          break;
        }
      }
    }
  }
}

void sonarAlarma(){
  unsigned char nnota[] = {3, 5, 9, 9, 8, 9, 10, 7};
  const tempo[] = {400, 400, 900, 270, 130, 270, 130, 900};
  if(!(PORTB & 0x04) && !set){
    char okAlarma = 1;
    for(i = 0; i < 6; i++){
      if(((PORTB & 0x02) && tiempoDisplay[i] != tiempoAlarma[i]) || (!(PORTB & 0x02) && (tiempoDisplay[i] != 0)) ){
        okAlarma = 0;
        break;
      }
    }
    if(okAlarma){
      PORTC = tabla[10];
      for(i = 0; i< 8; i++){
        Sound_Play(notas[nnota[i]]*2, tempo[i]);
      }
    }
    revisarContador();
  }
}

void revisarContador(){
  unsigned char j = 0;
  for(i = 5; i>=0; i--){
    if(tiempoDisplay[i] > tiempoAlarma[i]){
      for(j = 0; j< 6; j++){
        if(PORTB & 0x02){
            tiempoDisplay[j] = 0;
         }else{
            tiempoDisplay[j] = tiempoAlarma[j];
         }
      }
      break;
    }else if(tiempoDisplay[i] < tiempoAlarma[i]){
      break;
    }
  }
}

void apretarBoton(){
  if((PORTB & 0x08)){
    if (!(PORTB & 0x40)){
      Sound_Play(notas[3]*2, 50);
      if (!(PORTB & 0x40)){
        Sound_Play(notas[5]*2, 50);
        pausar ^= 1;
      }
    }
    if (!(PORTB & 0x80)){
      Sound_Play(notas[5]*2, 50);
      if (!(PORTB & 0x80)){
        Sound_Play(notas[7]*2, 50);
        if(!(PORTB & 0x02) && !(PORTB & 0x04)){
          for(i = 0; i< 6; i++){
            tiempoDisplay[i] = tiempoAlarma[i];
          }
        }else{
          pausar = 0;
          for(i = 0; i< 6; i++){
            tiempoDisplay[i] = 0;
          }
        }
      }
    }
  }else{
    if(!(PORTB & 0x10)){
      if (!(PORTB & 0x40)){
        Sound_Play(notas[3]*2, 50);
        if (!(PORTB & 0x40)){
          Sound_Play(notas[5]*2, 50);
          setT++;
        }
      }
      else if (!(PORTB & 0x80)){
        Sound_Play(notas[5]*2, 50);
        if (!(PORTB & 0x80)){
          Sound_Play(notas[7]*2, 50);
          setT--;
        }
      }
      if(setT > 2){
        setT = 0;
      }else if(setT < 0){
        setT = 2;
      }
      if(setT == 2){
        horas = 1;
      }else{
        horas = 0;
      }
    }else{
      unsigned char valfor[] = {0,0};
      if(setT==0){
        valfor[0] = 0;
        valfor[1] = 2;
      }else if(setT == 1){
        valfor[0] = 2;
        valfor[1] = 4;
      }else if(setT == 2){
        valfor[0] = 4;
        valfor[1] = 6;
      }
      if (!(PORTB & 0x40)){
        Sound_Play(notas[3]*2, 50);
        if (!(PORTB & 0x40)){
          Sound_Play(notas[5]*2, 50);
          for(i = valfor[0]; i < valfor[1]; i++){
            if(tiempoAlarma[i]-- == 0){
              tiempoAlarma[i] = limitesTiempo[i];
            }else{
              break;
            }
          }
        }
      }
      else if (!(PORTB & 0x80)){
        Sound_Play(notas[5]*2, 50);
        if (!(PORTB & 0x80)){
          Sound_Play(notas[0]*3, 50);
          for(i = valfor[0]; i < valfor[1]; i++){
            if(++tiempoAlarma[i] > limitesTiempo[i]){
              tiempoAlarma[i] = 0;
            }else{
              break;
            }
          }
        }
      }
    }
  }
}