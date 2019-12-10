DEFINE LOADER_USED 1
org 0
clrf PCLATH

goto _main
_main:

;proy3.c,29 ::                 void main() {
;proy3.c,31 ::                 TRISC = 0x00;
        CLRF       TRISC+0
;proy3.c,32 ::                 TRISD = 0x00;
        CLRF       TRISD+0
;proy3.c,34 ::                 OPTION_REG = OPTION_REG & 0x7F;
        MOVLW      127
        ANDWF      OPTION_REG+0, 1
;proy3.c,36 ::                 ANSELH=0x00;
        CLRF       ANSELH+0
;proy3.c,37 ::                 ANSEL = 0x00;
        CLRF       ANSEL+0
;proy3.c,38 ::                 C1ON_bit = 0;                      // Desabilito comparadores
        BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;proy3.c,39 ::                 C2ON_bit = 0;
        BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;proy3.c,41 ::                 PORTB= 0xFF;
        MOVLW      255
        MOVWF      PORTB+0
;proy3.c,42 ::                 PORTC = 0x00;
        CLRF       PORTC+0
;proy3.c,43 ::                 PORTD = 0x01;
        MOVLW      1
        MOVWF      PORTD+0
;proy3.c,46 ::                 Sound_Init(&PORTD,7);
        MOVLW      PORTD+0
        MOVWF      FARG_Sound_Init_snd_port+0
        MOVLW      7
        MOVWF      FARG_Sound_Init_snd_pin+0
        CALL       _Sound_Init+0
;proy3.c,47 ::                 Sound_Play(notas[8]*2, 100);
        MOVLW      172
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      3
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      100
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,48 ::                 Sound_Play(notas[9]*2, 100);
        MOVLW      22
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      4
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      100
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,50 ::                 while(1){
L_main0:
;proy3.c,51 ::                 tablero();
        CALL       _tablero+0
;proy3.c,52 ::                 configuracion();
        CALL       _configuracion+0
;proy3.c,53 ::                 cadaSegundo();
        CALL       _cadaSegundo+0
;proy3.c,54 ::                 apretarBoton();
        CALL       _apretarBoton+0
;proy3.c,56 ::                 delay_ms(3);
        MOVLW      8
        MOVWF      R12+0
        MOVLW      201
        MOVWF      R13+0
L_main2:
        DECFSZ     R13+0, 1
        GOTO       L_main2
        DECFSZ     R12+0, 1
        GOTO       L_main2
        NOP
        NOP
;proy3.c,57 ::                 PORTC = 0x00;
        CLRF       PORTC+0
;proy3.c,58 ::                 delay_ms(2);
        MOVLW      6
        MOVWF      R12+0
        MOVLW      48
        MOVWF      R13+0
L_main3:
        DECFSZ     R13+0, 1
        GOTO       L_main3
        DECFSZ     R12+0, 1
        GOTO       L_main3
        NOP
;proy3.c,59 ::                 }// fin while
        GOTO       L_main0
;proy3.c,60 ::                 }//fin main
L_end_main:
        GOTO       $+0
; end of _main

_tablero:

;proy3.c,62 ::                 void tablero(){
;proy3.c,63 ::                 PORTD = PORTD >= 0x08 ? 0x01 : PORTD << 1;
        MOVLW      8
        SUBWF      PORTD+0, 0
        BTFSS      STATUS+0, 0
        GOTO       L_tablero4
        MOVLW      1
        MOVWF      R2+0
        MOVLW      0
        MOVWF      R2+1
        GOTO       L_tablero5
L_tablero4:
        MOVF       PORTD+0, 0
        MOVWF      R2+0
        CLRF       R2+1
        RLF        R2+0, 1
        RLF        R2+1, 1
        BCF        R2+0, 0
L_tablero5:
        MOVF       R2+0, 0
        MOVWF      PORTD+0
;proy3.c,65 ::                 if(!horas){
        MOVF       _horas+0, 0
        BTFSS      STATUS+0, 2
        GOTO       L_tablero6
;proy3.c,66 ::                 if(++contaTiempo >= 100 && PORTD == 0x04){
        INCF       _contaTiempo+0, 1
        MOVLW      100
        SUBWF      _contaTiempo+0, 0
        BTFSS      STATUS+0, 0
        GOTO       L_tablero9
        MOVF       PORTD+0, 0
        XORLW      4
        BTFSS      STATUS+0, 2
        GOTO       L_tablero9
L__tablero154:
;proy3.c,67 ::                 PORTC = tabla[tiempoDisplay[contaTiempo % 4]]+ tabla[16];
        MOVLW      3
        ANDWF      _contaTiempo+0, 0
        MOVWF      R0+0
        MOVF       R0+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R0+0, 0
        ADDLW      _tabla+0
        MOVWF      FSR
        MOVF       _tabla+16, 0
        ADDWF      INDF+0, 0
        MOVWF      PORTC+0
;proy3.c,68 ::                 }else{
        GOTO       L_tablero10
L_tablero9:
;proy3.c,69 ::                 PORTC = tabla[tiempoDisplay[contaTiempo % 4]];
        MOVLW      3
        ANDWF      _contaTiempo+0, 0
        MOVWF      R0+0
        MOVF       R0+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R0+0, 0
        ADDLW      _tabla+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      PORTC+0
;proy3.c,70 ::                 }
L_tablero10:
;proy3.c,71 ::                 }else{
        GOTO       L_tablero11
L_tablero6:
;proy3.c,72 ::                 if(++contaTiempo >= 100 && PORTD == 0x04){
        INCF       _contaTiempo+0, 1
        MOVLW      100
        SUBWF      _contaTiempo+0, 0
        BTFSS      STATUS+0, 0
        GOTO       L_tablero14
        MOVF       PORTD+0, 0
        XORLW      4
        BTFSS      STATUS+0, 2
        GOTO       L_tablero14
L__tablero153:
;proy3.c,73 ::                 PORTC = tabla[tiempoDisplay[(contaTiempo % 4)+2]]+ tabla[16];
        MOVLW      3
        ANDWF      _contaTiempo+0, 0
        MOVWF      R0+0
        MOVLW      2
        ADDWF      R0+0, 1
        CLRF       R0+1
        BTFSC      STATUS+0, 0
        INCF       R0+1, 1
        MOVF       R0+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R0+0, 0
        ADDLW      _tabla+0
        MOVWF      FSR
        MOVF       _tabla+16, 0
        ADDWF      INDF+0, 0
        MOVWF      PORTC+0
;proy3.c,74 ::                 }else{
        GOTO       L_tablero15
L_tablero14:
;proy3.c,75 ::                 PORTC = tabla[tiempoDisplay[(contaTiempo % 4)+2]];
        MOVLW      3
        ANDWF      _contaTiempo+0, 0
        MOVWF      R0+0
        MOVLW      2
        ADDWF      R0+0, 1
        CLRF       R0+1
        BTFSC      STATUS+0, 0
        INCF       R0+1, 1
        MOVF       R0+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R0+0, 0
        ADDLW      _tabla+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      PORTC+0
;proy3.c,76 ::                 }
L_tablero15:
;proy3.c,77 ::                 }
L_tablero11:
;proy3.c,78 ::                 }
L_end_tablero:
        RETURN
; end of _tablero

_cadaSegundo:

;proy3.c,80 ::                 void cadaSegundo(){
;proy3.c,82 ::                 if(contaTiempo >= 200){     //cambiar a 200
        MOVLW      200
        SUBWF      _contaTiempo+0, 0
        BTFSS      STATUS+0, 0
        GOTO       L_cadaSegundo16
;proy3.c,83 ::                 contaTiempo = 0;
        CLRF       _contaTiempo+0
;proy3.c,84 ::                 if(PORTB & 0x08 && !pausar){
        BTFSS      PORTB+0, 3
        GOTO       L_cadaSegundo19
        MOVF       _pausar+0, 0
        BTFSS      STATUS+0, 2
        GOTO       L_cadaSegundo19
L__cadaSegundo155:
;proy3.c,85 ::                 if(PORTB & 0x02){
        BTFSS      PORTB+0, 1
        GOTO       L_cadaSegundo20
;proy3.c,86 ::                 contarMas();
        CALL       _contarMas+0
;proy3.c,87 ::                 }else{
        GOTO       L_cadaSegundo21
L_cadaSegundo20:
;proy3.c,88 ::                 contarMenos();
        CALL       _contarMenos+0
;proy3.c,89 ::                 }
L_cadaSegundo21:
;proy3.c,90 ::                 }
L_cadaSegundo19:
;proy3.c,91 ::                 sonarAlarma();
        CALL       _sonarAlarma+0
;proy3.c,92 ::                 }
L_cadaSegundo16:
;proy3.c,93 ::                 }
L_end_cadaSegundo:
        RETURN
; end of _cadaSegundo

_configuracion:

;proy3.c,95 ::                 void configuracion(){
;proy3.c,96 ::                 if(!(PORTB & 0x08)){
        BTFSC      PORTB+0, 3
        GOTO       L_configuracion22
;proy3.c,97 ::                 if(!set){
        MOVF       _set+0, 0
        BTFSS      STATUS+0, 2
        GOTO       L_configuracion23
;proy3.c,98 ::                 set = 1;
        MOVLW      1
        MOVWF      _set+0
;proy3.c,99 ::                 Sound_Play(notas[7], 50);
        MOVLW      184
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      1
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,100 ::                 horas = 0;
        CLRF       _horas+0
;proy3.c,101 ::                 }
L_configuracion23:
;proy3.c,102 ::                 if(contaTiempo > 150){
        MOVF       _contaTiempo+0, 0
        SUBLW      150
        BTFSC      STATUS+0, 0
        GOTO       L_configuracion24
;proy3.c,103 ::                 if(setT = 0){
        CLRF       _setT+0
;proy3.c,107 ::                 }else{
L_configuracion25:
;proy3.c,108 ::                 if(PORTD >= 0x04){
        MOVLW      4
        SUBWF      PORTD+0, 0
        BTFSS      STATUS+0, 0
        GOTO       L_configuracion28
;proy3.c,109 ::                 PORTC = 0x00;
        CLRF       PORTC+0
;proy3.c,110 ::                 }
L_configuracion28:
;proy3.c,112 ::                 }else{
        GOTO       L_configuracion29
L_configuracion24:
;proy3.c,113 ::                 for(i = 0; i < 6; i++){
        CLRF       _i+0
L_configuracion30:
        MOVLW      6
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_configuracion31
;proy3.c,114 ::                 tiempoDisplay[i] = tiempoAlarma[i];
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
;proy3.c,113 ::                 for(i = 0; i < 6; i++){
        INCF       _i+0, 1
;proy3.c,115 ::                 }
        GOTO       L_configuracion30
L_configuracion31:
;proy3.c,116 ::                 }
L_configuracion29:
;proy3.c,117 ::                 }else{
        GOTO       L_configuracion33
L_configuracion22:
;proy3.c,118 ::                 if(set){
        MOVF       _set+0, 0
        BTFSC      STATUS+0, 2
        GOTO       L_configuracion34
;proy3.c,119 ::                 set = 0;
        CLRF       _set+0
;proy3.c,120 ::                 Sound_Play(notas[9], 50);
        MOVLW      11
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      2
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,121 ::                 for(i = 0; i < 4; i++){
        CLRF       _i+0
L_configuracion35:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_configuracion36
;proy3.c,122 ::                 tiempoDisplay[i] = 0;
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        CLRF       INDF+0
;proy3.c,121 ::                 for(i = 0; i < 4; i++){
        INCF       _i+0, 1
;proy3.c,123 ::                 }
        GOTO       L_configuracion35
L_configuracion36:
;proy3.c,124 ::                 }
L_configuracion34:
;proy3.c,125 ::                 if(PORTB & 0x10){
        BTFSS      PORTB+0, 4
        GOTO       L_configuracion38
;proy3.c,126 ::                 horas = 0;
        CLRF       _horas+0
;proy3.c,127 ::                 }else{
        GOTO       L_configuracion39
L_configuracion38:
;proy3.c,128 ::                 horas = 1;
        MOVLW      1
        MOVWF      _horas+0
;proy3.c,129 ::                 }
L_configuracion39:
;proy3.c,130 ::                 }
L_configuracion33:
;proy3.c,131 ::                 }
L_end_configuracion:
        RETURN
; end of _configuracion

_contarMas:

;proy3.c,133 ::                 void contarMas(){
;proy3.c,134 ::                 for(i = 0; i < 4; i++){
        CLRF       _i+0
L_contarMas40:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_contarMas41
;proy3.c,135 ::                 if(++tiempoDisplay[i] > limitesTiempo[i]){
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      R1+0
        MOVF       R1+0, 0
        MOVWF      FSR
        INCF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _limitesTiempo+0
        MOVWF      FSR
        MOVF       R1+0, 0
        SUBWF      INDF+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_contarMas43
;proy3.c,136 ::                 tiempoDisplay[i] = 0;
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        CLRF       INDF+0
;proy3.c,137 ::                 }else{
        GOTO       L_contarMas44
L_contarMas43:
;proy3.c,138 ::                 break;
        GOTO       L_contarMas41
;proy3.c,139 ::                 }
L_contarMas44:
;proy3.c,134 ::                 for(i = 0; i < 4; i++){
        INCF       _i+0, 1
;proy3.c,140 ::                 }
        GOTO       L_contarMas40
L_contarMas41:
;proy3.c,141 ::                 }
L_end_contarMas:
        RETURN
; end of _contarMas

_contarMenos:

;proy3.c,142 ::                 void contarMenos(){
;proy3.c,143 ::                 for(i = 0; i < 4; i++){
        CLRF       _i+0
L_contarMenos45:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_contarMenos46
;proy3.c,144 ::                 if(tiempoDisplay[i]-- == 0){
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      R2+0
        MOVF       R2+0, 0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        DECF       R1+0, 0
        MOVWF      R0+0
        MOVF       R2+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
        MOVF       R1+0, 0
        XORLW      0
        BTFSS      STATUS+0, 2
        GOTO       L_contarMenos48
;proy3.c,145 ::                 tiempoDisplay[i] = limitesTiempo[i];
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _limitesTiempo+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
;proy3.c,146 ::                 }else{
        GOTO       L_contarMenos49
L_contarMenos48:
;proy3.c,147 ::                 break;
        GOTO       L_contarMenos46
;proy3.c,148 ::                 }
L_contarMenos49:
;proy3.c,143 ::                 for(i = 0; i < 4; i++){
        INCF       _i+0, 1
;proy3.c,149 ::                 }
        GOTO       L_contarMenos45
L_contarMenos46:
;proy3.c,150 ::                 }
L_end_contarMenos:
        RETURN
; end of _contarMenos

_sonarAlarma:

;proy3.c,152 ::                 void sonarAlarma(){
;proy3.c,153 ::                 unsigned char nnota[] = {3, 5, 9, 9, 8, 9, 10, 7};
        MOVLW      3
        MOVWF      sonarAlarma_nnota_L0+0
        MOVLW      5
        MOVWF      sonarAlarma_nnota_L0+1
        MOVLW      9
        MOVWF      sonarAlarma_nnota_L0+2
        MOVLW      9
        MOVWF      sonarAlarma_nnota_L0+3
        MOVLW      8
        MOVWF      sonarAlarma_nnota_L0+4
        MOVLW      9
        MOVWF      sonarAlarma_nnota_L0+5
        MOVLW      10
        MOVWF      sonarAlarma_nnota_L0+6
        MOVLW      7
        MOVWF      sonarAlarma_nnota_L0+7
;proy3.c,155 ::                 if(!(PORTB & 0x04) && !set){
        BTFSC      PORTB+0, 2
        GOTO       L_sonarAlarma52
        MOVF       _set+0, 0
        BTFSS      STATUS+0, 2
        GOTO       L_sonarAlarma52
L__sonarAlarma156:
;proy3.c,156 ::                 char okAlarma = 1;
        MOVLW      1
        MOVWF      sonarAlarma_okAlarma_L1+0
;proy3.c,157 ::                 if(PORTB & 0x02){
        BTFSS      PORTB+0, 1
        GOTO       L_sonarAlarma53
;proy3.c,158 ::                 for(i = 0; i < 4; i++){
        CLRF       _i+0
L_sonarAlarma54:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_sonarAlarma55
;proy3.c,159 ::                 if(tiempoDisplay[i] != tiempoAlarma[i]){
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      FSR
        MOVF       R1+0, 0
        XORWF      INDF+0, 0
        BTFSC      STATUS+0, 2
        GOTO       L_sonarAlarma57
;proy3.c,160 ::                 okAlarma = 0;
        CLRF       sonarAlarma_okAlarma_L1+0
;proy3.c,161 ::                 break;
        GOTO       L_sonarAlarma55
;proy3.c,162 ::                 }
L_sonarAlarma57:
;proy3.c,158 ::                 for(i = 0; i < 4; i++){
        INCF       _i+0, 1
;proy3.c,163 ::                 }
        GOTO       L_sonarAlarma54
L_sonarAlarma55:
;proy3.c,164 ::                 }else{
        GOTO       L_sonarAlarma58
L_sonarAlarma53:
;proy3.c,165 ::                 for(i = 0; i < 4; i++){
        CLRF       _i+0
L_sonarAlarma59:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_sonarAlarma60
;proy3.c,166 ::                 if(tiempoDisplay[i] != 0){
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        XORLW      0
        BTFSC      STATUS+0, 2
        GOTO       L_sonarAlarma62
;proy3.c,167 ::                 okAlarma = 0;
        CLRF       sonarAlarma_okAlarma_L1+0
;proy3.c,168 ::                 break;
        GOTO       L_sonarAlarma60
;proy3.c,169 ::                 }
L_sonarAlarma62:
;proy3.c,165 ::                 for(i = 0; i < 4; i++){
        INCF       _i+0, 1
;proy3.c,170 ::                 }
        GOTO       L_sonarAlarma59
L_sonarAlarma60:
;proy3.c,171 ::                 }
L_sonarAlarma58:
;proy3.c,172 ::                 if(okAlarma){
        MOVF       sonarAlarma_okAlarma_L1+0, 0
        BTFSC      STATUS+0, 2
        GOTO       L_sonarAlarma63
;proy3.c,173 ::                 PORTC = tabla[10];
        MOVF       _tabla+10, 0
        MOVWF      PORTC+0
;proy3.c,174 ::                 for(i = 0; i< 8; i++){
        CLRF       _i+0
L_sonarAlarma64:
        MOVLW      8
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_sonarAlarma65
;proy3.c,175 ::                 Sound_Play(notas[nnota[i]]*2, tempo[i]);
        MOVF       _i+0, 0
        ADDLW      sonarAlarma_nnota_L0+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R3+0
        MOVF       R3+0, 0
        MOVWF      R0+0
        CLRF       R0+1
        RLF        R0+0, 1
        RLF        R0+1, 1
        BCF        R0+0, 0
        RLF        R0+0, 1
        RLF        R0+1, 1
        BCF        R0+0, 0
        MOVLW      _notas+0
        ADDWF      R0+0, 1
        MOVLW      hi_addr(_notas+0)
        BTFSC      STATUS+0, 0
        ADDLW      1
        ADDWF      R0+1, 1
        MOVF       R0+0, 0
        MOVWF      ___DoICPAddr+0
        MOVF       R0+1, 0
        MOVWF      ___DoICPAddr+1
        CALL       _____DoICP+0
        MOVWF      R0+0
        INCF       ___DoICPAddr+0, 1
        BTFSC      STATUS+0, 2
        INCF       ___DoICPAddr+1, 1
        CALL       _____DoICP+0
        MOVWF      R0+1
        INCF       ___DoICPAddr+0, 1
        BTFSC      STATUS+0, 2
        INCF       ___DoICPAddr+1, 1
        CALL       _____DoICP+0
        MOVWF      R0+2
        INCF       ___DoICPAddr+0, 1
        BTFSC      STATUS+0, 2
        INCF       ___DoICPAddr+1, 1
        CALL       _____DoICP+0
        MOVWF      R0+3
        MOVLW      0
        MOVWF      R4+0
        MOVLW      0
        MOVWF      R4+1
        MOVLW      0
        MOVWF      R4+2
        MOVLW      128
        MOVWF      R4+3
        CALL       _Mul_32x32_FP+0
        CALL       _double2word+0
        MOVF       R0+0, 0
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVF       R0+1, 0
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVF       _i+0, 0
        MOVWF      R0+0
        CLRF       R0+1
        RLF        R0+0, 1
        RLF        R0+1, 1
        BCF        R0+0, 0
        MOVLW      sonarAlarma_tempo_L0+0
        ADDWF      R0+0, 1
        MOVLW      hi_addr(sonarAlarma_tempo_L0+0)
        BTFSC      STATUS+0, 0
        ADDLW      1
        ADDWF      R0+1, 1
        MOVF       R0+0, 0
        MOVWF      ___DoICPAddr+0
        MOVF       R0+1, 0
        MOVWF      ___DoICPAddr+1
        CALL       _____DoICP+0
        MOVWF      FARG_Sound_Play_duration_ms+0
        INCF       ___DoICPAddr+0, 1
        BTFSC      STATUS+0, 2
        INCF       ___DoICPAddr+1, 1
        CALL       _____DoICP+0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,174 ::                 for(i = 0; i< 8; i++){
        INCF       _i+0, 1
;proy3.c,176 ::                 }
        GOTO       L_sonarAlarma64
L_sonarAlarma65:
;proy3.c,177 ::                 }
L_sonarAlarma63:
;proy3.c,178 ::                 revisarContador();
        CALL       _revisarContador+0
;proy3.c,179 ::                 }
L_sonarAlarma52:
;proy3.c,180 ::                 }
L_end_sonarAlarma:
        RETURN
; end of _sonarAlarma

_revisarContador:

;proy3.c,182 ::                 void revisarContador(){
;proy3.c,183 ::                 unsigned char igualar = 0;
        CLRF       revisarContador_igualar_L0+0
;proy3.c,184 ::                 if(tiempoDisplay[3] > tiempoAlarma[3]){
        MOVF       _tiempoDisplay+3, 0
        SUBWF      _tiempoAlarma+3, 0
        BTFSC      STATUS+0, 0
        GOTO       L_revisarContador67
;proy3.c,185 ::                 igualar = 1;
        MOVLW      1
        MOVWF      revisarContador_igualar_L0+0
;proy3.c,186 ::                 }else if(tiempoDisplay[3] == tiempoAlarma[3]){
        GOTO       L_revisarContador68
L_revisarContador67:
        MOVF       _tiempoDisplay+3, 0
        XORWF      _tiempoAlarma+3, 0
        BTFSS      STATUS+0, 2
        GOTO       L_revisarContador69
;proy3.c,187 ::                 if(tiempoDisplay[2] > tiempoAlarma[2]){
        MOVF       _tiempoDisplay+2, 0
        SUBWF      _tiempoAlarma+2, 0
        BTFSC      STATUS+0, 0
        GOTO       L_revisarContador70
;proy3.c,188 ::                 igualar = 1;
        MOVLW      1
        MOVWF      revisarContador_igualar_L0+0
;proy3.c,189 ::                 }else if(tiempoDisplay[2] == tiempoAlarma[2]){
        GOTO       L_revisarContador71
L_revisarContador70:
        MOVF       _tiempoDisplay+2, 0
        XORWF      _tiempoAlarma+2, 0
        BTFSS      STATUS+0, 2
        GOTO       L_revisarContador72
;proy3.c,190 ::                 if(tiempoDisplay[1] > tiempoAlarma[1]){
        MOVF       _tiempoDisplay+1, 0
        SUBWF      _tiempoAlarma+1, 0
        BTFSC      STATUS+0, 0
        GOTO       L_revisarContador73
;proy3.c,191 ::                 igualar = 1;
        MOVLW      1
        MOVWF      revisarContador_igualar_L0+0
;proy3.c,192 ::                 }else if(tiempoDisplay[1] == tiempoAlarma[1]){
        GOTO       L_revisarContador74
L_revisarContador73:
        MOVF       _tiempoDisplay+1, 0
        XORWF      _tiempoAlarma+1, 0
        BTFSS      STATUS+0, 2
        GOTO       L_revisarContador75
;proy3.c,193 ::                 if(tiempoDisplay[0] >= tiempoAlarma[0]){
        MOVF       _tiempoAlarma+0, 0
        SUBWF      _tiempoDisplay+0, 0
        BTFSS      STATUS+0, 0
        GOTO       L_revisarContador76
;proy3.c,194 ::                 igualar = 1;
        MOVLW      1
        MOVWF      revisarContador_igualar_L0+0
;proy3.c,195 ::                 }
L_revisarContador76:
;proy3.c,196 ::                 }
L_revisarContador75:
L_revisarContador74:
;proy3.c,197 ::                 }
L_revisarContador72:
L_revisarContador71:
;proy3.c,198 ::                 }
L_revisarContador69:
L_revisarContador68:
;proy3.c,199 ::                 if(PORTB & 0x02){
        BTFSS      PORTB+0, 1
        GOTO       L_revisarContador77
;proy3.c,200 ::                 if(igualar){
        MOVF       revisarContador_igualar_L0+0, 0
        BTFSC      STATUS+0, 2
        GOTO       L_revisarContador78
;proy3.c,201 ::                 for(i = 0; i< 4; i++){
        CLRF       _i+0
L_revisarContador79:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_revisarContador80
;proy3.c,202 ::                 tiempoDisplay[i] = 0;
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        CLRF       INDF+0
;proy3.c,201 ::                 for(i = 0; i< 4; i++){
        INCF       _i+0, 1
;proy3.c,203 ::                 }
        GOTO       L_revisarContador79
L_revisarContador80:
;proy3.c,204 ::                 }
L_revisarContador78:
;proy3.c,205 ::                 }else{
        GOTO       L_revisarContador82
L_revisarContador77:
;proy3.c,206 ::                 if(igualar){
        MOVF       revisarContador_igualar_L0+0, 0
        BTFSC      STATUS+0, 2
        GOTO       L_revisarContador83
;proy3.c,207 ::                 for(i = 0; i< 4; i++){
        CLRF       _i+0
L_revisarContador84:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_revisarContador85
;proy3.c,208 ::                 tiempoDisplay[i] = tiempoAlarma[i];
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
;proy3.c,207 ::                 for(i = 0; i< 4; i++){
        INCF       _i+0, 1
;proy3.c,209 ::                 }
        GOTO       L_revisarContador84
L_revisarContador85:
;proy3.c,210 ::                 }
L_revisarContador83:
;proy3.c,211 ::                 }
L_revisarContador82:
;proy3.c,212 ::                 }
L_end_revisarContador:
        RETURN
; end of _revisarContador

_apretarBoton:

;proy3.c,214 ::                 void apretarBoton(){
;proy3.c,215 ::                 if((PORTB & 0x08)){
        BTFSS      PORTB+0, 3
        GOTO       L_apretarBoton87
;proy3.c,216 ::                 if (!(PORTB & 0x40)){
        BTFSC      PORTB+0, 6
        GOTO       L_apretarBoton88
;proy3.c,217 ::                 Sound_Play(notas[3]*2, 50);
        MOVLW      75
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      2
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,218 ::                 if (!(PORTB & 0x40)){
        BTFSC      PORTB+0, 6
        GOTO       L_apretarBoton89
;proy3.c,219 ::                 Sound_Play(notas[5]*2, 50);
        MOVLW      186
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      2
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,220 ::                 pausar ^= 1;
        MOVLW      1
        XORWF      _pausar+0, 1
;proy3.c,221 ::                 }
L_apretarBoton89:
;proy3.c,222 ::                 }
L_apretarBoton88:
;proy3.c,223 ::                 if (!(PORTB & 0x80)){
        BTFSC      PORTB+0, 7
        GOTO       L_apretarBoton90
;proy3.c,224 ::                 Sound_Play(notas[5]*2, 50);
        MOVLW      186
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      2
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,225 ::                 if (!(PORTB & 0x80)){
        BTFSC      PORTB+0, 7
        GOTO       L_apretarBoton91
;proy3.c,226 ::                 Sound_Play(notas[7]*2, 50);
        MOVLW      112
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      3
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,227 ::                 if(!(PORTB & 0x02) && !(PORTB & 0x04)){
        BTFSC      PORTB+0, 1
        GOTO       L_apretarBoton94
        BTFSC      PORTB+0, 2
        GOTO       L_apretarBoton94
L__apretarBoton157:
;proy3.c,228 ::                 for(i = 0; i< 4; i++){
        CLRF       _i+0
L_apretarBoton95:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_apretarBoton96
;proy3.c,229 ::                 tiempoDisplay[i] = tiempoAlarma[i];
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
;proy3.c,228 ::                 for(i = 0; i< 4; i++){
        INCF       _i+0, 1
;proy3.c,230 ::                 }
        GOTO       L_apretarBoton95
L_apretarBoton96:
;proy3.c,231 ::                 }else{
        GOTO       L_apretarBoton98
L_apretarBoton94:
;proy3.c,232 ::                 pausar = 0;
        CLRF       _pausar+0
;proy3.c,233 ::                 for(i = 0; i< 4; i++){
        CLRF       _i+0
L_apretarBoton99:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_apretarBoton100
;proy3.c,234 ::                 tiempoDisplay[i] = 0;
        MOVF       _i+0, 0
        ADDLW      _tiempoDisplay+0
        MOVWF      FSR
        CLRF       INDF+0
;proy3.c,233 ::                 for(i = 0; i< 4; i++){
        INCF       _i+0, 1
;proy3.c,235 ::                 }
        GOTO       L_apretarBoton99
L_apretarBoton100:
;proy3.c,236 ::                 }
L_apretarBoton98:
;proy3.c,237 ::                 }
L_apretarBoton91:
;proy3.c,238 ::                 }
L_apretarBoton90:
;proy3.c,239 ::                 }else{
        GOTO       L_apretarBoton102
L_apretarBoton87:
;proy3.c,240 ::                 if(!(PORTB & 0xC0)){
        MOVLW      192
        ANDWF      PORTB+0, 0
        MOVWF      R0+0
        BTFSS      STATUS+0, 2
        GOTO       L_apretarBoton103
;proy3.c,241 ::                 Sound_Play(notas[9]*2, 50);
        MOVLW      22
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      4
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,242 ::                 if(!(PORTB & 0xC0)){
        MOVLW      192
        ANDWF      PORTB+0, 0
        MOVWF      R0+0
        BTFSS      STATUS+0, 2
        GOTO       L_apretarBoton104
;proy3.c,243 ::                 Sound_Play(notas[10]*2, 50);
        MOVLW      150
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      4
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,244 ::                 if(++setT > 2){
        INCF       _setT+0, 1
        MOVF       _setT+0, 0
        SUBLW      2
        BTFSC      STATUS+0, 0
        GOTO       L_apretarBoton105
;proy3.c,245 ::                 setT = 0;
        CLRF       _setT+0
;proy3.c,246 ::                 horas = 0;
        CLRF       _horas+0
;proy3.c,247 ::                 }else if(setT == 2){
        GOTO       L_apretarBoton106
L_apretarBoton105:
        MOVF       _setT+0, 0
        XORLW      2
        BTFSS      STATUS+0, 2
        GOTO       L_apretarBoton107
;proy3.c,248 ::                 horas = 1;
        MOVLW      1
        MOVWF      _horas+0
;proy3.c,249 ::                 }
L_apretarBoton107:
L_apretarBoton106:
;proy3.c,250 ::                 }
L_apretarBoton104:
;proy3.c,251 ::                 }else{
        GOTO       L_apretarBoton108
L_apretarBoton103:
;proy3.c,252 ::                 if (!(PORTB & 0x40)){
        BTFSC      PORTB+0, 6
        GOTO       L_apretarBoton109
;proy3.c,253 ::                 Sound_Play(notas[3]*2, 50);
        MOVLW      75
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      2
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,254 ::                 if (!(PORTB & 0x40)){
        BTFSC      PORTB+0, 6
        GOTO       L_apretarBoton110
;proy3.c,255 ::                 Sound_Play(notas[5]*2, 50);
        MOVLW      186
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      2
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,256 ::                 disminuirAlarma();
        CALL       _disminuirAlarma+0
;proy3.c,257 ::                 }
L_apretarBoton110:
;proy3.c,258 ::                 }
L_apretarBoton109:
;proy3.c,259 ::                 if (!(PORTB & 0x80)){
        BTFSC      PORTB+0, 7
        GOTO       L_apretarBoton111
;proy3.c,260 ::                 Sound_Play(notas[5]*2, 50);
        MOVLW      186
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      2
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,261 ::                 if (!(PORTB & 0x80)){
        BTFSC      PORTB+0, 7
        GOTO       L_apretarBoton112
;proy3.c,262 ::                 Sound_Play(notas[7]*2, 50);
        MOVLW      112
        MOVWF      FARG_Sound_Play_freq_in_hz+0
        MOVLW      3
        MOVWF      FARG_Sound_Play_freq_in_hz+1
        MOVLW      50
        MOVWF      FARG_Sound_Play_duration_ms+0
        MOVLW      0
        MOVWF      FARG_Sound_Play_duration_ms+1
        CALL       _Sound_Play+0
;proy3.c,263 ::                 aumentarAlarma();
        CALL       _aumentarAlarma+0
;proy3.c,264 ::                 }
L_apretarBoton112:
;proy3.c,265 ::                 }
L_apretarBoton111:
;proy3.c,266 ::                 }
L_apretarBoton108:
;proy3.c,267 ::                 }
L_apretarBoton102:
;proy3.c,268 ::                 }
L_end_apretarBoton:
        RETURN
; end of _apretarBoton

_aumentarAlarma:

;proy3.c,270 ::                 void aumentarAlarma(){
;proy3.c,271 ::                 if(setT==0){
        MOVF       _setT+0, 0
        XORLW      0
        BTFSS      STATUS+0, 2
        GOTO       L_aumentarAlarma113
;proy3.c,272 ::                 for(i = 0; i < 2; i++){
        CLRF       _i+0
L_aumentarAlarma114:
        MOVLW      2
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_aumentarAlarma115
;proy3.c,273 ::                 if(++tiempoAlarma[i] > limitesTiempo[i]){
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R1+0
        MOVF       R1+0, 0
        MOVWF      FSR
        INCF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _limitesTiempo+0
        MOVWF      FSR
        MOVF       R1+0, 0
        SUBWF      INDF+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_aumentarAlarma117
;proy3.c,274 ::                 tiempoAlarma[i] = 0;
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      FSR
        CLRF       INDF+0
;proy3.c,275 ::                 }else{
        GOTO       L_aumentarAlarma118
L_aumentarAlarma117:
;proy3.c,276 ::                 break;
        GOTO       L_aumentarAlarma115
;proy3.c,277 ::                 }
L_aumentarAlarma118:
;proy3.c,272 ::                 for(i = 0; i < 2; i++){
        INCF       _i+0, 1
;proy3.c,278 ::                 }
        GOTO       L_aumentarAlarma114
L_aumentarAlarma115:
;proy3.c,279 ::                 }else if(setT == 1){
        GOTO       L_aumentarAlarma119
L_aumentarAlarma113:
        MOVF       _setT+0, 0
        XORLW      1
        BTFSS      STATUS+0, 2
        GOTO       L_aumentarAlarma120
;proy3.c,280 ::                 for(i = 2; i < 4; i++){
        MOVLW      2
        MOVWF      _i+0
L_aumentarAlarma121:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_aumentarAlarma122
;proy3.c,281 ::                 if(++tiempoAlarma[i] > limitesTiempo[i]){
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R1+0
        MOVF       R1+0, 0
        MOVWF      FSR
        INCF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _limitesTiempo+0
        MOVWF      FSR
        MOVF       R1+0, 0
        SUBWF      INDF+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_aumentarAlarma124
;proy3.c,282 ::                 tiempoAlarma[i] = 0;
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      FSR
        CLRF       INDF+0
;proy3.c,283 ::                 }else{
        GOTO       L_aumentarAlarma125
L_aumentarAlarma124:
;proy3.c,284 ::                 break;
        GOTO       L_aumentarAlarma122
;proy3.c,285 ::                 }
L_aumentarAlarma125:
;proy3.c,280 ::                 for(i = 2; i < 4; i++){
        INCF       _i+0, 1
;proy3.c,286 ::                 }
        GOTO       L_aumentarAlarma121
L_aumentarAlarma122:
;proy3.c,287 ::                 }else if(setT == 2){
        GOTO       L_aumentarAlarma126
L_aumentarAlarma120:
        MOVF       _setT+0, 0
        XORLW      2
        BTFSS      STATUS+0, 2
        GOTO       L_aumentarAlarma127
;proy3.c,288 ::                 for(i = 4; i < 6; i++){
        MOVLW      4
        MOVWF      _i+0
L_aumentarAlarma128:
        MOVLW      6
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_aumentarAlarma129
;proy3.c,289 ::                 if(++tiempoAlarma[i] > limitesTiempo[i]){
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R1+0
        MOVF       R1+0, 0
        MOVWF      FSR
        INCF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _limitesTiempo+0
        MOVWF      FSR
        MOVF       R1+0, 0
        SUBWF      INDF+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_aumentarAlarma131
;proy3.c,290 ::                 tiempoAlarma[i] = 0;
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      FSR
        CLRF       INDF+0
;proy3.c,291 ::                 }else{
        GOTO       L_aumentarAlarma132
L_aumentarAlarma131:
;proy3.c,292 ::                 break;
        GOTO       L_aumentarAlarma129
;proy3.c,293 ::                 }
L_aumentarAlarma132:
;proy3.c,288 ::                 for(i = 4; i < 6; i++){
        INCF       _i+0, 1
;proy3.c,294 ::                 }
        GOTO       L_aumentarAlarma128
L_aumentarAlarma129:
;proy3.c,295 ::                 }
L_aumentarAlarma127:
L_aumentarAlarma126:
L_aumentarAlarma119:
;proy3.c,296 ::                 }
L_end_aumentarAlarma:
        RETURN
; end of _aumentarAlarma

_disminuirAlarma:

;proy3.c,298 ::                 void disminuirAlarma(){
;proy3.c,299 ::                 if(setT==0){
        MOVF       _setT+0, 0
        XORLW      0
        BTFSS      STATUS+0, 2
        GOTO       L_disminuirAlarma133
;proy3.c,300 ::                 for(i = 0; i < 2; i++){
        CLRF       _i+0
L_disminuirAlarma134:
        MOVLW      2
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_disminuirAlarma135
;proy3.c,301 ::                 if(tiempoAlarma[i]-- == 0){
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R2+0
        MOVF       R2+0, 0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        DECF       R1+0, 0
        MOVWF      R0+0
        MOVF       R2+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
        MOVF       R1+0, 0
        XORLW      0
        BTFSS      STATUS+0, 2
        GOTO       L_disminuirAlarma137
;proy3.c,302 ::                 tiempoAlarma[i] = limitesTiempo[i];
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _limitesTiempo+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
;proy3.c,303 ::                 }else{
        GOTO       L_disminuirAlarma138
L_disminuirAlarma137:
;proy3.c,304 ::                 break;
        GOTO       L_disminuirAlarma135
;proy3.c,305 ::                 }
L_disminuirAlarma138:
;proy3.c,300 ::                 for(i = 0; i < 2; i++){
        INCF       _i+0, 1
;proy3.c,306 ::                 }
        GOTO       L_disminuirAlarma134
L_disminuirAlarma135:
;proy3.c,307 ::                 }else if(setT == 1){
        GOTO       L_disminuirAlarma139
L_disminuirAlarma133:
        MOVF       _setT+0, 0
        XORLW      1
        BTFSS      STATUS+0, 2
        GOTO       L_disminuirAlarma140
;proy3.c,308 ::                 for(i = 2; i < 4; i++){
        MOVLW      2
        MOVWF      _i+0
L_disminuirAlarma141:
        MOVLW      4
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_disminuirAlarma142
;proy3.c,309 ::                 if(tiempoAlarma[i]-- == 0){
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R2+0
        MOVF       R2+0, 0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        DECF       R1+0, 0
        MOVWF      R0+0
        MOVF       R2+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
        MOVF       R1+0, 0
        XORLW      0
        BTFSS      STATUS+0, 2
        GOTO       L_disminuirAlarma144
;proy3.c,310 ::                 tiempoAlarma[i] = limitesTiempo[i];
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _limitesTiempo+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
;proy3.c,311 ::                 }else{
        GOTO       L_disminuirAlarma145
L_disminuirAlarma144:
;proy3.c,312 ::                 break;
        GOTO       L_disminuirAlarma142
;proy3.c,313 ::                 }
L_disminuirAlarma145:
;proy3.c,308 ::                 for(i = 2; i < 4; i++){
        INCF       _i+0, 1
;proy3.c,314 ::                 }
        GOTO       L_disminuirAlarma141
L_disminuirAlarma142:
;proy3.c,315 ::                 }else if(setT == 2){
        GOTO       L_disminuirAlarma146
L_disminuirAlarma140:
        MOVF       _setT+0, 0
        XORLW      2
        BTFSS      STATUS+0, 2
        GOTO       L_disminuirAlarma147
;proy3.c,316 ::                 for(i = 4; i < 6; i++){
        MOVLW      4
        MOVWF      _i+0
L_disminuirAlarma148:
        MOVLW      6
        SUBWF      _i+0, 0
        BTFSC      STATUS+0, 0
        GOTO       L_disminuirAlarma149
;proy3.c,317 ::                 if(tiempoAlarma[i]-- == 0){
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R2+0
        MOVF       R2+0, 0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R1+0
        DECF       R1+0, 0
        MOVWF      R0+0
        MOVF       R2+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
        MOVF       R1+0, 0
        XORLW      0
        BTFSS      STATUS+0, 2
        GOTO       L_disminuirAlarma151
;proy3.c,318 ::                 tiempoAlarma[i] = limitesTiempo[i];
        MOVF       _i+0, 0
        ADDLW      _tiempoAlarma+0
        MOVWF      R1+0
        MOVF       _i+0, 0
        ADDLW      _limitesTiempo+0
        MOVWF      FSR
        MOVF       INDF+0, 0
        MOVWF      R0+0
        MOVF       R1+0, 0
        MOVWF      FSR
        MOVF       R0+0, 0
        MOVWF      INDF+0
;proy3.c,319 ::                 }else{
        GOTO       L_disminuirAlarma152
L_disminuirAlarma151:
;proy3.c,320 ::                 break;
        GOTO       L_disminuirAlarma149
;proy3.c,321 ::                 }
L_disminuirAlarma152:
;proy3.c,316 ::                 for(i = 4; i < 6; i++){
        INCF       _i+0, 1
;proy3.c,322 ::                 }
        GOTO       L_disminuirAlarma148
L_disminuirAlarma149:
;proy3.c,323 ::                 }
L_disminuirAlarma147:
L_disminuirAlarma146:
L_disminuirAlarma139:
;proy3.c,324 ::                 }
L_end_disminuirAlarma:
        RETURN
; end of _disminuirAlarma