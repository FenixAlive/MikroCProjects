
//2 es do, escala mayor en fa
const float notas[] = {220.0, 235.22, 261.6, 293.67, 329.63, 349.23, 392.0, 440.0, 470.4, 523.25, 587.33};
//Numeros del 0 al F y punto
unsigned char tabla[] = {0x77, 0x41, 0x3B, 0x6B, 0x4D, 0x6E, 0x7E, 0x43, 0x7F, 0x6F, 0x5F, 0x7C, 0x36, 0x79, 0x3E, 0x1E, 0x80};
unsigned char tiempoDisplay[] = {0, 0, 0, 0, 0, 0};
unsigned char tiempoAlarma[] = {9, 5, 9, 5, 0, 0};
unsigned char limitesTiempo[] = {9, 5, 9, 5, 9, 9};
unsigned char contaTiempo = 0;
char i = 0, set = 0, pausar = 0, horas = 0, setT = 0;

void tablero();
void configuracion();
void cadaSegundo();
void contarMas();
void contarMenos();
void sonarAlarma();
void revisarContador();
void apretarBoton();
void aumentarAlarma();
void disminuirAlarma();

//PORTB
//2 = reversa
//4 = alarma
//8 = configuracion
//10 = cambiar vista a horas

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
  Sound_Play(notas[8]*2, 100);
  Sound_Play(notas[9]*2, 100);

  while(1){
    tablero();
    configuracion();
    cadaSegundo();
    apretarBoton();
    //tiempo de 5 milisegundos por cambio de letra por 4 letras = 20 milisegundos
    delay_ms(3);
    PORTC = 0x00;
    delay_ms(2);
  }// fin while
}//fin main

void tablero(){
  PORTD = PORTD >= 0x08 ? 0x01 : PORTD << 1;
  //cada 500 milisegundos pone un punto
  if(!horas){
    if(++contaTiempo >= 100 && PORTD == 0x04){
      PORTC = tabla[tiempoDisplay[contaTiempo % 4]]+ tabla[16];
    }else{
      PORTC = tabla[tiempoDisplay[contaTiempo % 4]];
    }
  }else{
    if(++contaTiempo >= 100 && PORTD == 0x04){
      PORTC = tabla[tiempoDisplay[(contaTiempo % 4)+2]]+ tabla[16];
    }else{
      PORTC = tabla[tiempoDisplay[(contaTiempo % 4)+2]];
    }
  }
}

void cadaSegundo(){
  //cada segundo
  if(contaTiempo >= 200){     //cambiar a 200
    contaTiempo = 0;
    if(PORTB & 0x08 && !pausar){
      if(PORTB & 0x02){
        contarMas();
      }else{
        contarMenos();
      }
    }
    sonarAlarma();
  }
}

void configuracion(){
  if(!(PORTB & 0x08)){
    if(!set){
      set = 1;
      Sound_Play(notas[7], 50);
      horas = 0;
    }
    if(contaTiempo > 150){
      if(setT = 0){
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
      Sound_Play(notas[9], 50);
      for(i = 0; i < 4; i++){
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

void contarMas(){
    for(i = 0; i < 4; i++){
      if(++tiempoDisplay[i] > limitesTiempo[i]){
        tiempoDisplay[i] = 0;
      }else{
        break;
      }
    }
}
void contarMenos(){
    for(i = 0; i < 4; i++){
      if(tiempoDisplay[i]-- == 0){
        tiempoDisplay[i] = limitesTiempo[i];
      }else{
        break;
      }
    }
}

void sonarAlarma(){
  unsigned char nnota[] = {3, 5, 9, 9, 8, 9, 10, 7};
  const tempo[] = {400, 400, 900, 270, 130, 270, 130, 900};
  if(!(PORTB & 0x04) && !set){
    char okAlarma = 1;
    if(PORTB & 0x02){
      for(i = 0; i < 4; i++){
        if(tiempoDisplay[i] != tiempoAlarma[i]){
          okAlarma = 0;
          break;
        }
      }
    }else{
      for(i = 0; i < 4; i++){
        if(tiempoDisplay[i] != 0){
          okAlarma = 0;
          break;
        }
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
  unsigned char igualar = 0;
  if(tiempoDisplay[3] > tiempoAlarma[3]){
    igualar = 1;
  }else if(tiempoDisplay[3] == tiempoAlarma[3]){
    if(tiempoDisplay[2] > tiempoAlarma[2]){
      igualar = 1;
    }else if(tiempoDisplay[2] == tiempoAlarma[2]){
      if(tiempoDisplay[1] > tiempoAlarma[1]){
        igualar = 1;
      }else if(tiempoDisplay[1] == tiempoAlarma[1]){
        if(tiempoDisplay[0] >= tiempoAlarma[0]){
          igualar = 1;
        }
      }
    }
  }
  if(PORTB & 0x02){
    if(igualar){
      for(i = 0; i< 4; i++){
        tiempoDisplay[i] = 0;
      }
    }
  }else{
    if(igualar){
      for(i = 0; i< 4; i++){
        tiempoDisplay[i] = tiempoAlarma[i];
      }
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
          for(i = 0; i< 4; i++){
            tiempoDisplay[i] = tiempoAlarma[i];
          }
        }else{
          pausar = 0;
          for(i = 0; i< 4; i++){
            tiempoDisplay[i] = 0;
          }
        }
      }
    }
  }else{
    if(!(PORTB & 0xC0)){
      Sound_Play(notas[9]*2, 50);
      if(!(PORTB & 0xC0)){
        Sound_Play(notas[10]*2, 50);
        if(++setT > 2){
          setT = 0;
          horas = 0;
        }else if(setT == 2){
          horas = 1;
        }
      }
    }else{
      if (!(PORTB & 0x40)){
        Sound_Play(notas[3]*2, 50);
        if (!(PORTB & 0x40)){
          Sound_Play(notas[5]*2, 50);
          disminuirAlarma();
        }
      }
      if (!(PORTB & 0x80)){
        Sound_Play(notas[5]*2, 50);
        if (!(PORTB & 0x80)){
          Sound_Play(notas[7]*2, 50);
          aumentarAlarma();
        }
      }
    }
  }
}

void aumentarAlarma(){
  if(setT==0){
    for(i = 0; i < 2; i++){
      if(++tiempoAlarma[i] > limitesTiempo[i]){
        tiempoAlarma[i] = 0;
      }else{
        break;
      }
    }
  }else if(setT == 1){
    for(i = 2; i < 4; i++){
      if(++tiempoAlarma[i] > limitesTiempo[i]){
        tiempoAlarma[i] = 0;
      }else{
        break;
      }
    }
  }else if(setT == 2){
    for(i = 4; i < 6; i++){
      if(++tiempoAlarma[i] > limitesTiempo[i]){
        tiempoAlarma[i] = 0;
      }else{
        break;
      }
    }
  }
}

void disminuirAlarma(){
  if(setT==0){
    for(i = 0; i < 2; i++){
      if(tiempoAlarma[i]-- == 0){
        tiempoAlarma[i] = limitesTiempo[i];
      }else{
        break;
      }
    }
  }else if(setT == 1){
    for(i = 2; i < 4; i++){
      if(tiempoAlarma[i]-- == 0){
        tiempoAlarma[i] = limitesTiempo[i];
      }else{
        break;
      }
    }
  }else if(setT == 2){
    for(i = 4; i < 6; i++){
      if(tiempoAlarma[i]-- == 0){
        tiempoAlarma[i] = limitesTiempo[i];
      }else{
        break;
      }
    }
  }
}