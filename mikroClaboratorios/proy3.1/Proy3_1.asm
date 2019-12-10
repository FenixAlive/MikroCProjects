
_main:

;Proy3_1.c,25 :: 		void main() {
;Proy3_1.c,27 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;Proy3_1.c,28 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Proy3_1.c,30 :: 		OPTION_REG = OPTION_REG & 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;Proy3_1.c,32 :: 		ANSELH=0x00;
	CLRF       ANSELH+0
;Proy3_1.c,33 :: 		ANSEL = 0x00;
	CLRF       ANSEL+0
;Proy3_1.c,34 :: 		C1ON_bit = 0;                      // Desabilito comparadores
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Proy3_1.c,35 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Proy3_1.c,37 :: 		PORTB= 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Proy3_1.c,38 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;Proy3_1.c,39 :: 		PORTD = 0x01;
	MOVLW      1
	MOVWF      PORTD+0
;Proy3_1.c,42 :: 		Sound_Init(&PORTD,7);
	MOVLW      PORTD+0
	MOVWF      FARG_Sound_Init_snd_port+0
	MOVLW      7
	MOVWF      FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;Proy3_1.c,43 :: 		Sound_Play(notas[1]*3, 100);
	MOVLW      193
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,44 :: 		Sound_Play(notas[2]*3, 100);
	MOVLW      16
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,45 :: 		while(1){
L_main0:
;Proy3_1.c,46 :: 		tablero();
	CALL       _tablero+0
;Proy3_1.c,47 :: 		configuracion();
	CALL       _configuracion+0
;Proy3_1.c,48 :: 		cadaSegundo();
	CALL       _cadaSegundo+0
;Proy3_1.c,49 :: 		apretarBoton();
	CALL       _apretarBoton+0
;Proy3_1.c,51 :: 		Delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;Proy3_1.c,52 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;Proy3_1.c,53 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
;Proy3_1.c,54 :: 		}// fin while
	GOTO       L_main0
;Proy3_1.c,55 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_tablero:

;Proy3_1.c,57 :: 		void tablero(){
;Proy3_1.c,58 :: 		PORTD = PORTD >= 0x08 ? 0x01 : PORTD << 1;
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
;Proy3_1.c,60 :: 		if(!horas){
	MOVF       _horas+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_tablero6
;Proy3_1.c,61 :: 		PORTC = tabla[tiempoDisplay[++contaTiempo % 4]];
	INCF       _contaTiempo+0, 1
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
;Proy3_1.c,62 :: 		}else{
	GOTO       L_tablero7
L_tablero6:
;Proy3_1.c,63 :: 		PORTC = tabla[tiempoDisplay[(++contaTiempo % 4)+2]];
	INCF       _contaTiempo+0, 1
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
;Proy3_1.c,64 :: 		}
L_tablero7:
;Proy3_1.c,65 :: 		if(contaTiempo >= 100){
	MOVLW      100
	SUBWF      _contaTiempo+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_tablero8
;Proy3_1.c,66 :: 		if((horas && PORTD == 0x01) || (!horas && PORTD == 0x04)){
	MOVF       _horas+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__tablero125
	MOVF       PORTD+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__tablero125
	GOTO       L__tablero123
L__tablero125:
	MOVF       _horas+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__tablero124
	MOVF       PORTD+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L__tablero124
	GOTO       L__tablero123
L__tablero124:
	GOTO       L_tablero15
L__tablero123:
;Proy3_1.c,67 :: 		PORTC += tabla[11];
	MOVF       _tabla+11, 0
	ADDWF      PORTC+0, 1
;Proy3_1.c,68 :: 		}
L_tablero15:
;Proy3_1.c,69 :: 		}
L_tablero8:
;Proy3_1.c,70 :: 		}
L_end_tablero:
	RETURN
; end of _tablero

_cadaSegundo:

;Proy3_1.c,72 :: 		void cadaSegundo(){
;Proy3_1.c,74 :: 		if(contaTiempo >= 200){     //cambiar a 200
	MOVLW      200
	SUBWF      _contaTiempo+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_cadaSegundo16
;Proy3_1.c,75 :: 		contaTiempo = 0;
	CLRF       _contaTiempo+0
;Proy3_1.c,76 :: 		contar();
	CALL       _contar+0
;Proy3_1.c,77 :: 		sonarAlarma();
	CALL       _sonarAlarma+0
;Proy3_1.c,78 :: 		}
L_cadaSegundo16:
;Proy3_1.c,79 :: 		}
L_end_cadaSegundo:
	RETURN
; end of _cadaSegundo

_configuracion:

;Proy3_1.c,81 :: 		void configuracion(){
;Proy3_1.c,82 :: 		if(!(PORTB & 0x08)){
	BTFSC      PORTB+0, 3
	GOTO       L_configuracion17
;Proy3_1.c,83 :: 		if(!set){
	MOVF       _set+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_configuracion18
;Proy3_1.c,84 :: 		set = 1;
	MOVLW      1
	MOVWF      _set+0
;Proy3_1.c,85 :: 		Sound_Play(notas[0]*2, 50);
	MOVLW      184
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,86 :: 		horas = 0;
	CLRF       _horas+0
;Proy3_1.c,87 :: 		}
L_configuracion18:
;Proy3_1.c,88 :: 		if(contaTiempo > 150){
	MOVF       _contaTiempo+0, 0
	SUBLW      150
	BTFSC      STATUS+0, 0
	GOTO       L_configuracion19
;Proy3_1.c,89 :: 		if(setT == 0){
	MOVF       _setT+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_configuracion20
;Proy3_1.c,90 :: 		if(PORTD < 0x04){
	MOVLW      4
	SUBWF      PORTD+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_configuracion21
;Proy3_1.c,91 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;Proy3_1.c,92 :: 		}
L_configuracion21:
;Proy3_1.c,93 :: 		}else{
	GOTO       L_configuracion22
L_configuracion20:
;Proy3_1.c,94 :: 		if(PORTD >= 0x04){
	MOVLW      4
	SUBWF      PORTD+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_configuracion23
;Proy3_1.c,95 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;Proy3_1.c,96 :: 		}
L_configuracion23:
;Proy3_1.c,97 :: 		}
L_configuracion22:
;Proy3_1.c,98 :: 		}else{
	GOTO       L_configuracion24
L_configuracion19:
;Proy3_1.c,99 :: 		for(i = 0; i < 6; i++){
	CLRF       _i+0
L_configuracion25:
	MOVLW      6
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_configuracion26
;Proy3_1.c,100 :: 		tiempoDisplay[i] = tiempoAlarma[i];
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
;Proy3_1.c,99 :: 		for(i = 0; i < 6; i++){
	INCF       _i+0, 1
;Proy3_1.c,101 :: 		}
	GOTO       L_configuracion25
L_configuracion26:
;Proy3_1.c,102 :: 		}
L_configuracion24:
;Proy3_1.c,103 :: 		}else{
	GOTO       L_configuracion28
L_configuracion17:
;Proy3_1.c,104 :: 		if(set){
	MOVF       _set+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_configuracion29
;Proy3_1.c,105 :: 		set = 0;
	CLRF       _set+0
;Proy3_1.c,106 :: 		Sound_Play(notas[2]*2, 50);
	MOVLW      11
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,107 :: 		setT = 0;
	CLRF       _setT+0
;Proy3_1.c,108 :: 		for(i = 0; i < 6; i++){
	CLRF       _i+0
L_configuracion30:
	MOVLW      6
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_configuracion31
;Proy3_1.c,109 :: 		tiempoDisplay[i] = 0;
	MOVF       _i+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      FSR
	CLRF       INDF+0
;Proy3_1.c,108 :: 		for(i = 0; i < 6; i++){
	INCF       _i+0, 1
;Proy3_1.c,110 :: 		}
	GOTO       L_configuracion30
L_configuracion31:
;Proy3_1.c,111 :: 		}
L_configuracion29:
;Proy3_1.c,112 :: 		if(PORTB & 0x10){
	BTFSS      PORTB+0, 4
	GOTO       L_configuracion33
;Proy3_1.c,113 :: 		horas = 0;
	CLRF       _horas+0
;Proy3_1.c,114 :: 		}else{
	GOTO       L_configuracion34
L_configuracion33:
;Proy3_1.c,115 :: 		horas = 1;
	MOVLW      1
	MOVWF      _horas+0
;Proy3_1.c,116 :: 		}
L_configuracion34:
;Proy3_1.c,117 :: 		}
L_configuracion28:
;Proy3_1.c,118 :: 		}
L_end_configuracion:
	RETURN
; end of _configuracion

_contar:

;Proy3_1.c,120 :: 		void contar(){
;Proy3_1.c,121 :: 		if(PORTB & 0x08 && !pausar){
	BTFSS      PORTB+0, 3
	GOTO       L_contar37
	MOVF       _pausar+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_contar37
L__contar126:
;Proy3_1.c,122 :: 		for(i = 0; i < 6; i++){
	CLRF       _i+0
L_contar38:
	MOVLW      6
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_contar39
;Proy3_1.c,123 :: 		if(PORTB & 0x02){
	BTFSS      PORTB+0, 1
	GOTO       L_contar41
;Proy3_1.c,124 :: 		if(++tiempoDisplay[i] > limitesTiempo[i]){
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
	GOTO       L_contar42
;Proy3_1.c,125 :: 		tiempoDisplay[i] = 0;
	MOVF       _i+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      FSR
	CLRF       INDF+0
;Proy3_1.c,126 :: 		}else{
	GOTO       L_contar43
L_contar42:
;Proy3_1.c,127 :: 		break;
	GOTO       L_contar39
;Proy3_1.c,128 :: 		}
L_contar43:
;Proy3_1.c,129 :: 		}else{
	GOTO       L_contar44
L_contar41:
;Proy3_1.c,130 :: 		if(tiempoDisplay[i]-- == 0){
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
	GOTO       L_contar45
;Proy3_1.c,131 :: 		tiempoDisplay[i] = limitesTiempo[i];
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
;Proy3_1.c,132 :: 		}else{
	GOTO       L_contar46
L_contar45:
;Proy3_1.c,133 :: 		break;
	GOTO       L_contar39
;Proy3_1.c,134 :: 		}
L_contar46:
;Proy3_1.c,135 :: 		}
L_contar44:
;Proy3_1.c,122 :: 		for(i = 0; i < 6; i++){
	INCF       _i+0, 1
;Proy3_1.c,136 :: 		}
	GOTO       L_contar38
L_contar39:
;Proy3_1.c,137 :: 		}
L_contar37:
;Proy3_1.c,138 :: 		}
L_end_contar:
	RETURN
; end of _contar

_sonarAlarma:

;Proy3_1.c,140 :: 		void sonarAlarma(){
;Proy3_1.c,141 :: 		unsigned char nnota[] = {3, 5, 9, 9, 8, 9, 10, 7};
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
;Proy3_1.c,143 :: 		if(!(PORTB & 0x04) && !set){
	BTFSC      PORTB+0, 2
	GOTO       L_sonarAlarma49
	MOVF       _set+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_sonarAlarma49
L__sonarAlarma130:
;Proy3_1.c,144 :: 		char okAlarma = 1;
	MOVLW      1
	MOVWF      sonarAlarma_okAlarma_L1+0
;Proy3_1.c,145 :: 		for(i = 0; i < 6; i++){
	CLRF       _i+0
L_sonarAlarma50:
	MOVLW      6
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_sonarAlarma51
;Proy3_1.c,146 :: 		if(((PORTB & 0x02) && tiempoDisplay[i] != tiempoAlarma[i]) || (!(PORTB & 0x02) && (tiempoDisplay[i] != 0)) ){
	BTFSS      PORTB+0, 1
	GOTO       L__sonarAlarma129
	MOVF       _i+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      R2+0
	MOVF       _i+0, 0
	ADDLW      _tiempoAlarma+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORWF      R1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__sonarAlarma129
	GOTO       L__sonarAlarma127
L__sonarAlarma129:
	BTFSC      PORTB+0, 1
	GOTO       L__sonarAlarma128
	MOVF       _i+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__sonarAlarma128
	GOTO       L__sonarAlarma127
L__sonarAlarma128:
	GOTO       L_sonarAlarma59
L__sonarAlarma127:
;Proy3_1.c,147 :: 		okAlarma = 0;
	CLRF       sonarAlarma_okAlarma_L1+0
;Proy3_1.c,148 :: 		break;
	GOTO       L_sonarAlarma51
;Proy3_1.c,149 :: 		}
L_sonarAlarma59:
;Proy3_1.c,145 :: 		for(i = 0; i < 6; i++){
	INCF       _i+0, 1
;Proy3_1.c,150 :: 		}
	GOTO       L_sonarAlarma50
L_sonarAlarma51:
;Proy3_1.c,151 :: 		if(okAlarma){
	MOVF       sonarAlarma_okAlarma_L1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_sonarAlarma60
;Proy3_1.c,152 :: 		PORTC = tabla[10];
	MOVF       _tabla+10, 0
	MOVWF      PORTC+0
;Proy3_1.c,153 :: 		for(i = 0; i< 8; i++){
	CLRF       _i+0
L_sonarAlarma61:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_sonarAlarma62
;Proy3_1.c,154 :: 		Sound_Play(notas[nnota[i]]*2, tempo[i]);
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
;Proy3_1.c,153 :: 		for(i = 0; i< 8; i++){
	INCF       _i+0, 1
;Proy3_1.c,155 :: 		}
	GOTO       L_sonarAlarma61
L_sonarAlarma62:
;Proy3_1.c,156 :: 		}
L_sonarAlarma60:
;Proy3_1.c,157 :: 		revisarContador();
	CALL       _revisarContador+0
;Proy3_1.c,158 :: 		}
L_sonarAlarma49:
;Proy3_1.c,159 :: 		}
L_end_sonarAlarma:
	RETURN
; end of _sonarAlarma

_revisarContador:

;Proy3_1.c,161 :: 		void revisarContador(){
;Proy3_1.c,162 :: 		unsigned char j = 0;
	CLRF       revisarContador_j_L0+0
;Proy3_1.c,163 :: 		for(i = 5; i>=0; i--){
	MOVLW      5
	MOVWF      _i+0
L_revisarContador64:
	MOVLW      0
	SUBWF      _i+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_revisarContador65
;Proy3_1.c,164 :: 		if(tiempoDisplay[i] > tiempoAlarma[i]){
	MOVF       _i+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       _i+0, 0
	ADDLW      _tiempoAlarma+0
	MOVWF      FSR
	MOVF       R1+0, 0
	SUBWF      INDF+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_revisarContador67
;Proy3_1.c,165 :: 		for(j = 0; j< 6; j++){
	CLRF       revisarContador_j_L0+0
L_revisarContador68:
	MOVLW      6
	SUBWF      revisarContador_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_revisarContador69
;Proy3_1.c,166 :: 		if(PORTB & 0x02){
	BTFSS      PORTB+0, 1
	GOTO       L_revisarContador71
;Proy3_1.c,167 :: 		tiempoDisplay[j] = 0;
	MOVF       revisarContador_j_L0+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      FSR
	CLRF       INDF+0
;Proy3_1.c,168 :: 		}else{
	GOTO       L_revisarContador72
L_revisarContador71:
;Proy3_1.c,169 :: 		tiempoDisplay[j] = tiempoAlarma[j];
	MOVF       revisarContador_j_L0+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      R1+0
	MOVF       revisarContador_j_L0+0, 0
	ADDLW      _tiempoAlarma+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Proy3_1.c,170 :: 		}
L_revisarContador72:
;Proy3_1.c,165 :: 		for(j = 0; j< 6; j++){
	INCF       revisarContador_j_L0+0, 1
;Proy3_1.c,171 :: 		}
	GOTO       L_revisarContador68
L_revisarContador69:
;Proy3_1.c,172 :: 		break;
	GOTO       L_revisarContador65
;Proy3_1.c,173 :: 		}else if(tiempoDisplay[i] < tiempoAlarma[i]){
L_revisarContador67:
	MOVF       _i+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       _i+0, 0
	ADDLW      _tiempoAlarma+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_revisarContador74
;Proy3_1.c,174 :: 		break;
	GOTO       L_revisarContador65
;Proy3_1.c,175 :: 		}
L_revisarContador74:
;Proy3_1.c,163 :: 		for(i = 5; i>=0; i--){
	DECF       _i+0, 1
;Proy3_1.c,176 :: 		}
	GOTO       L_revisarContador64
L_revisarContador65:
;Proy3_1.c,177 :: 		}
L_end_revisarContador:
	RETURN
; end of _revisarContador

_apretarBoton:

;Proy3_1.c,179 :: 		void apretarBoton(){
;Proy3_1.c,180 :: 		if((PORTB & 0x08)){
	BTFSS      PORTB+0, 3
	GOTO       L_apretarBoton75
;Proy3_1.c,181 :: 		if (!(PORTB & 0x40)){
	BTFSC      PORTB+0, 6
	GOTO       L_apretarBoton76
;Proy3_1.c,182 :: 		Sound_Play(notas[3]*2, 50);
	MOVLW      75
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,183 :: 		if (!(PORTB & 0x40)){
	BTFSC      PORTB+0, 6
	GOTO       L_apretarBoton77
;Proy3_1.c,184 :: 		Sound_Play(notas[5]*2, 50);
	MOVLW      186
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,185 :: 		pausar ^= 1;
	MOVLW      1
	XORWF      _pausar+0, 1
;Proy3_1.c,186 :: 		}
L_apretarBoton77:
;Proy3_1.c,187 :: 		}
L_apretarBoton76:
;Proy3_1.c,188 :: 		if (!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_apretarBoton78
;Proy3_1.c,189 :: 		Sound_Play(notas[5]*2, 50);
	MOVLW      186
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,190 :: 		if (!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_apretarBoton79
;Proy3_1.c,191 :: 		Sound_Play(notas[7]*2, 50);
	MOVLW      112
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,192 :: 		if(!(PORTB & 0x02) && !(PORTB & 0x04)){
	BTFSC      PORTB+0, 1
	GOTO       L_apretarBoton82
	BTFSC      PORTB+0, 2
	GOTO       L_apretarBoton82
L__apretarBoton131:
;Proy3_1.c,193 :: 		for(i = 0; i< 6; i++){
	CLRF       _i+0
L_apretarBoton83:
	MOVLW      6
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_apretarBoton84
;Proy3_1.c,194 :: 		tiempoDisplay[i] = tiempoAlarma[i];
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
;Proy3_1.c,193 :: 		for(i = 0; i< 6; i++){
	INCF       _i+0, 1
;Proy3_1.c,195 :: 		}
	GOTO       L_apretarBoton83
L_apretarBoton84:
;Proy3_1.c,196 :: 		}else{
	GOTO       L_apretarBoton86
L_apretarBoton82:
;Proy3_1.c,197 :: 		pausar = 0;
	CLRF       _pausar+0
;Proy3_1.c,198 :: 		for(i = 0; i< 6; i++){
	CLRF       _i+0
L_apretarBoton87:
	MOVLW      6
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_apretarBoton88
;Proy3_1.c,199 :: 		tiempoDisplay[i] = 0;
	MOVF       _i+0, 0
	ADDLW      _tiempoDisplay+0
	MOVWF      FSR
	CLRF       INDF+0
;Proy3_1.c,198 :: 		for(i = 0; i< 6; i++){
	INCF       _i+0, 1
;Proy3_1.c,200 :: 		}
	GOTO       L_apretarBoton87
L_apretarBoton88:
;Proy3_1.c,201 :: 		}
L_apretarBoton86:
;Proy3_1.c,202 :: 		}
L_apretarBoton79:
;Proy3_1.c,203 :: 		}
L_apretarBoton78:
;Proy3_1.c,204 :: 		}else{
	GOTO       L_apretarBoton90
L_apretarBoton75:
;Proy3_1.c,205 :: 		if(!(PORTB & 0x10)){
	BTFSC      PORTB+0, 4
	GOTO       L_apretarBoton91
;Proy3_1.c,206 :: 		if (!(PORTB & 0x40)){
	BTFSC      PORTB+0, 6
	GOTO       L_apretarBoton92
;Proy3_1.c,207 :: 		Sound_Play(notas[3]*2, 50);
	MOVLW      75
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,208 :: 		if (!(PORTB & 0x40)){
	BTFSC      PORTB+0, 6
	GOTO       L_apretarBoton93
;Proy3_1.c,209 :: 		Sound_Play(notas[5]*2, 50);
	MOVLW      186
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,210 :: 		setT++;
	INCF       _setT+0, 1
;Proy3_1.c,211 :: 		}
L_apretarBoton93:
;Proy3_1.c,212 :: 		}
	GOTO       L_apretarBoton94
L_apretarBoton92:
;Proy3_1.c,213 :: 		else if (!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_apretarBoton95
;Proy3_1.c,214 :: 		Sound_Play(notas[5]*2, 50);
	MOVLW      186
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,215 :: 		if (!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_apretarBoton96
;Proy3_1.c,216 :: 		Sound_Play(notas[7]*2, 50);
	MOVLW      112
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,217 :: 		setT--;
	DECF       _setT+0, 1
;Proy3_1.c,218 :: 		}
L_apretarBoton96:
;Proy3_1.c,219 :: 		}
L_apretarBoton95:
L_apretarBoton94:
;Proy3_1.c,220 :: 		if(setT > 2){
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _setT+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_apretarBoton97
;Proy3_1.c,221 :: 		setT = 0;
	CLRF       _setT+0
;Proy3_1.c,222 :: 		}else if(setT < 0){
	GOTO       L_apretarBoton98
L_apretarBoton97:
	MOVLW      128
	XORWF      _setT+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_apretarBoton99
;Proy3_1.c,223 :: 		setT = 2;
	MOVLW      2
	MOVWF      _setT+0
;Proy3_1.c,224 :: 		}
L_apretarBoton99:
L_apretarBoton98:
;Proy3_1.c,225 :: 		if(setT == 2){
	MOVF       _setT+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_apretarBoton100
;Proy3_1.c,226 :: 		horas = 1;
	MOVLW      1
	MOVWF      _horas+0
;Proy3_1.c,227 :: 		}else{
	GOTO       L_apretarBoton101
L_apretarBoton100:
;Proy3_1.c,228 :: 		horas = 0;
	CLRF       _horas+0
;Proy3_1.c,229 :: 		}
L_apretarBoton101:
;Proy3_1.c,230 :: 		}else{
	GOTO       L_apretarBoton102
L_apretarBoton91:
;Proy3_1.c,231 :: 		unsigned char valfor[] = {0,0};
	CLRF       apretarBoton_valfor_L2+0
	CLRF       apretarBoton_valfor_L2+1
;Proy3_1.c,232 :: 		if(setT==0){
	MOVF       _setT+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_apretarBoton103
;Proy3_1.c,233 :: 		valfor[0] = 0;
	CLRF       apretarBoton_valfor_L2+0
;Proy3_1.c,234 :: 		valfor[1] = 2;
	MOVLW      2
	MOVWF      apretarBoton_valfor_L2+1
;Proy3_1.c,235 :: 		}else if(setT == 1){
	GOTO       L_apretarBoton104
L_apretarBoton103:
	MOVF       _setT+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_apretarBoton105
;Proy3_1.c,236 :: 		valfor[0] = 2;
	MOVLW      2
	MOVWF      apretarBoton_valfor_L2+0
;Proy3_1.c,237 :: 		valfor[1] = 4;
	MOVLW      4
	MOVWF      apretarBoton_valfor_L2+1
;Proy3_1.c,238 :: 		}else if(setT == 2){
	GOTO       L_apretarBoton106
L_apretarBoton105:
	MOVF       _setT+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_apretarBoton107
;Proy3_1.c,239 :: 		valfor[0] = 4;
	MOVLW      4
	MOVWF      apretarBoton_valfor_L2+0
;Proy3_1.c,240 :: 		valfor[1] = 6;
	MOVLW      6
	MOVWF      apretarBoton_valfor_L2+1
;Proy3_1.c,241 :: 		}
L_apretarBoton107:
L_apretarBoton106:
L_apretarBoton104:
;Proy3_1.c,242 :: 		if (!(PORTB & 0x40)){
	BTFSC      PORTB+0, 6
	GOTO       L_apretarBoton108
;Proy3_1.c,243 :: 		Sound_Play(notas[3]*2, 50);
	MOVLW      75
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,244 :: 		if (!(PORTB & 0x40)){
	BTFSC      PORTB+0, 6
	GOTO       L_apretarBoton109
;Proy3_1.c,245 :: 		Sound_Play(notas[5]*2, 50);
	MOVLW      186
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,246 :: 		for(i = valfor[0]; i < valfor[1]; i++){
	MOVF       apretarBoton_valfor_L2+0, 0
	MOVWF      _i+0
L_apretarBoton110:
	MOVF       apretarBoton_valfor_L2+1, 0
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_apretarBoton111
;Proy3_1.c,247 :: 		if(tiempoAlarma[i]-- == 0){
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
	GOTO       L_apretarBoton113
;Proy3_1.c,248 :: 		tiempoAlarma[i] = limitesTiempo[i];
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
;Proy3_1.c,249 :: 		}else{
	GOTO       L_apretarBoton114
L_apretarBoton113:
;Proy3_1.c,250 :: 		break;
	GOTO       L_apretarBoton111
;Proy3_1.c,251 :: 		}
L_apretarBoton114:
;Proy3_1.c,246 :: 		for(i = valfor[0]; i < valfor[1]; i++){
	INCF       _i+0, 1
;Proy3_1.c,252 :: 		}
	GOTO       L_apretarBoton110
L_apretarBoton111:
;Proy3_1.c,253 :: 		}
L_apretarBoton109:
;Proy3_1.c,254 :: 		}
	GOTO       L_apretarBoton115
L_apretarBoton108:
;Proy3_1.c,255 :: 		else if (!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_apretarBoton116
;Proy3_1.c,256 :: 		Sound_Play(notas[5]*2, 50);
	MOVLW      186
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,257 :: 		if (!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_apretarBoton117
;Proy3_1.c,258 :: 		Sound_Play(notas[0]*3, 50);
	MOVLW      148
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      50
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;Proy3_1.c,259 :: 		for(i = valfor[0]; i < valfor[1]; i++){
	MOVF       apretarBoton_valfor_L2+0, 0
	MOVWF      _i+0
L_apretarBoton118:
	MOVF       apretarBoton_valfor_L2+1, 0
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_apretarBoton119
;Proy3_1.c,260 :: 		if(++tiempoAlarma[i] > limitesTiempo[i]){
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
	GOTO       L_apretarBoton121
;Proy3_1.c,261 :: 		tiempoAlarma[i] = 0;
	MOVF       _i+0, 0
	ADDLW      _tiempoAlarma+0
	MOVWF      FSR
	CLRF       INDF+0
;Proy3_1.c,262 :: 		}else{
	GOTO       L_apretarBoton122
L_apretarBoton121:
;Proy3_1.c,263 :: 		break;
	GOTO       L_apretarBoton119
;Proy3_1.c,264 :: 		}
L_apretarBoton122:
;Proy3_1.c,259 :: 		for(i = valfor[0]; i < valfor[1]; i++){
	INCF       _i+0, 1
;Proy3_1.c,265 :: 		}
	GOTO       L_apretarBoton118
L_apretarBoton119:
;Proy3_1.c,266 :: 		}
L_apretarBoton117:
;Proy3_1.c,267 :: 		}
L_apretarBoton116:
L_apretarBoton115:
;Proy3_1.c,268 :: 		}
L_apretarBoton102:
;Proy3_1.c,269 :: 		}
L_apretarBoton90:
;Proy3_1.c,270 :: 		}
L_end_apretarBoton:
	RETURN
; end of _apretarBoton
