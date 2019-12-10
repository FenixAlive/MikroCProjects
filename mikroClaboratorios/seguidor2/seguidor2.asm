
_main:

;seguidor2.c,26 :: 		void main() {
;seguidor2.c,27 :: 		ANSEL = 0xFF;
	MOVLW      255
	MOVWF      ANSEL+0
;seguidor2.c,28 :: 		ANSELH = 0x00; //por ahora solo los 8 sensores como analogos
	CLRF       ANSELH+0
;seguidor2.c,29 :: 		C1ON_bit = 0;               // apago comparadores
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;seguidor2.c,30 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;seguidor2.c,32 :: 		TRISA  = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;seguidor2.c,34 :: 		OPTION_REG &= 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;seguidor2.c,37 :: 		TRISB = 0x7F;
	MOVLW      127
	MOVWF      TRISB+0
;seguidor2.c,38 :: 		PORTB = 0x7F;
	MOVLW      127
	MOVWF      PORTB+0
;seguidor2.c,39 :: 		TRISC = 0x00;                          // salidas puerto C
	CLRF       TRISC+0
;seguidor2.c,40 :: 		PORTC = 0x00;                          // poner PORTC en 0
	CLRF       PORTC+0
;seguidor2.c,42 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;seguidor2.c,43 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;seguidor2.c,45 :: 		iniciar_seguidor();
	CALL       _iniciar_seguidor+0
;seguidor2.c,46 :: 		cambiar_velocidad();
	CALL       _cambiar_velocidad+0
;seguidor2.c,47 :: 		if(!(PORTB & 0x08)){
	BTFSC      PORTB+0, 3
	GOTO       L_main0
;seguidor2.c,48 :: 		calibrar_sensores();
	CALL       _calibrar_sensores+0
;seguidor2.c,49 :: 		}else{
	GOTO       L_main1
L_main0:
;seguidor2.c,50 :: 		float valBlanco[] = {10,10,10,10,10,10,10,10};
;seguidor2.c,51 :: 		float valNegro[] = {1000,1000,1000,1000,1000,1000,1000,1000};
;seguidor2.c,52 :: 		}
L_main1:
;seguidor2.c,53 :: 		while(1){
L_main2:
;seguidor2.c,54 :: 		leer_sensores();
	CALL       _leer_sensores+0
;seguidor2.c,55 :: 		controlador();
	CALL       _controlador+0
;seguidor2.c,56 :: 		actuadores();
	CALL       _actuadores+0
;seguidor2.c,57 :: 		}
	GOTO       L_main2
;seguidor2.c,58 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_iniciar_seguidor:

;seguidor2.c,60 :: 		void iniciar_seguidor(){
;seguidor2.c,61 :: 		if(!(PORTB & 0x02)){
	BTFSC      PORTB+0, 1
	GOTO       L_iniciar_seguidor4
;seguidor2.c,63 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;seguidor2.c,64 :: 		}
L_iniciar_seguidor4:
;seguidor2.c,66 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;seguidor2.c,67 :: 		PORTD.RD0 = direccion_motores[0];
	BTFSC      _direccion_motores+0, 0
	GOTO       L__iniciar_seguidor41
	BCF        PORTD+0, 0
	GOTO       L__iniciar_seguidor42
L__iniciar_seguidor41:
	BSF        PORTD+0, 0
L__iniciar_seguidor42:
;seguidor2.c,68 :: 		PORTD.RD1 = !direccion_motores[0];
	MOVF       _direccion_motores+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__iniciar_seguidor43
	BCF        PORTD+0, 1
	GOTO       L__iniciar_seguidor44
L__iniciar_seguidor43:
	BSF        PORTD+0, 1
L__iniciar_seguidor44:
;seguidor2.c,69 :: 		PORTD.RD2 = direccion_motores[1];
	BTFSC      _direccion_motores+1, 0
	GOTO       L__iniciar_seguidor45
	BCF        PORTD+0, 2
	GOTO       L__iniciar_seguidor46
L__iniciar_seguidor45:
	BSF        PORTD+0, 2
L__iniciar_seguidor46:
;seguidor2.c,70 :: 		PORTD.RD3 = !direccion_motores[1];
	MOVF       _direccion_motores+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__iniciar_seguidor47
	BCF        PORTD+0, 3
	GOTO       L__iniciar_seguidor48
L__iniciar_seguidor47:
	BSF        PORTD+0, 3
L__iniciar_seguidor48:
;seguidor2.c,71 :: 		PWM1_Init(10000);                    // Initializar PWM1
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;seguidor2.c,72 :: 		PWM2_Init(10000);                    // Initializar PWM2
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;seguidor2.c,73 :: 		PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;seguidor2.c,74 :: 		PWM2_Start();                       // start PWM2
	CALL       _PWM2_Start+0
;seguidor2.c,75 :: 		}
L_end_iniciar_seguidor:
	RETURN
; end of _iniciar_seguidor

_cambiar_velocidad:

;seguidor2.c,77 :: 		void cambiar_velocidad(){
;seguidor2.c,78 :: 		if(!(PORTB & 0x04)){
	BTFSC      PORTB+0, 2
	GOTO       L_cambiar_velocidad5
;seguidor2.c,79 :: 		velocidad = 210;
	MOVLW      210
	MOVWF      _velocidad+0
;seguidor2.c,80 :: 		}
L_cambiar_velocidad5:
;seguidor2.c,81 :: 		}
L_end_cambiar_velocidad:
	RETURN
; end of _cambiar_velocidad

_calibrar_sensores:

;seguidor2.c,83 :: 		void calibrar_sensores(){
;seguidor2.c,84 :: 		int valTemp[] = {0,0,0,0,0,0,0,0};
;seguidor2.c,85 :: 		buzzer();
	CALL       _buzzer+0
;seguidor2.c,86 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_calibrar_sensores6:
	DECFSZ     R13+0, 1
	GOTO       L_calibrar_sensores6
	DECFSZ     R12+0, 1
	GOTO       L_calibrar_sensores6
	DECFSZ     R11+0, 1
	GOTO       L_calibrar_sensores6
	NOP
	NOP
;seguidor2.c,87 :: 		for(i=0;i<10;i++){
	CLRF       _i+0
	CLRF       _i+1
L_calibrar_sensores7:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibrar_sensores51
	MOVLW      10
	SUBWF      _i+0, 0
L__calibrar_sensores51:
	BTFSC      STATUS+0, 0
	GOTO       L_calibrar_sensores8
;seguidor2.c,88 :: 		leer_sensores();
	CALL       _leer_sensores+0
;seguidor2.c,89 :: 		for(j=0;j<8;j++){
	CLRF       _j+0
	CLRF       _j+1
L_calibrar_sensores10:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibrar_sensores52
	MOVLW      8
	SUBWF      _j+0, 0
L__calibrar_sensores52:
	BTFSC      STATUS+0, 0
	GOTO       L_calibrar_sensores11
;seguidor2.c,90 :: 		if(sensoresPrin[j] < valBlanco[j]){
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R3+1
	MOVF       R0+0, 0
	ADDLW      _valBlanco+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibrar_sensores53
	MOVF       R1+0, 0
	SUBWF      R3+0, 0
L__calibrar_sensores53:
	BTFSC      STATUS+0, 0
	GOTO       L_calibrar_sensores13
;seguidor2.c,91 :: 		valBlanco[j] = sensoresPrin[j];
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _valBlanco+0
	MOVWF      R2+0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;seguidor2.c,92 :: 		}
L_calibrar_sensores13:
;seguidor2.c,93 :: 		if(sensoresPrin[j] > valNegro[j]){
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R3+1
	MOVF       R0+0, 0
	ADDLW      _valNegro+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R3+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibrar_sensores54
	MOVF       R3+0, 0
	SUBWF      R1+0, 0
L__calibrar_sensores54:
	BTFSC      STATUS+0, 0
	GOTO       L_calibrar_sensores14
;seguidor2.c,94 :: 		valNegro[j] = sensoresPrin[j];
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _valNegro+0
	MOVWF      R2+0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;seguidor2.c,95 :: 		}
L_calibrar_sensores14:
;seguidor2.c,89 :: 		for(j=0;j<8;j++){
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;seguidor2.c,96 :: 		}
	GOTO       L_calibrar_sensores10
L_calibrar_sensores11:
;seguidor2.c,87 :: 		for(i=0;i<10;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor2.c,97 :: 		}
	GOTO       L_calibrar_sensores7
L_calibrar_sensores8:
;seguidor2.c,98 :: 		buzzer();
	CALL       _buzzer+0
;seguidor2.c,99 :: 		}
L_end_calibrar_sensores:
	RETURN
; end of _calibrar_sensores

_leer_sensores:

;seguidor2.c,101 :: 		void leer_sensores(){
;seguidor2.c,102 :: 		char cuantosSam = 9;
	MOVLW      9
	MOVWF      leer_sensores_cuantosSam_L0+0
;seguidor2.c,104 :: 		for(i=0;i<8;i++){
	CLRF       _i+0
	CLRF       _i+1
L_leer_sensores15:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores56
	MOVLW      8
	SUBWF      _i+0, 0
L__leer_sensores56:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores16
;seguidor2.c,105 :: 		sensoresPrin[i] = 0;
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;seguidor2.c,104 :: 		for(i=0;i<8;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor2.c,106 :: 		}
	GOTO       L_leer_sensores15
L_leer_sensores16:
;seguidor2.c,108 :: 		for(i=0;i<cuantosSam;i++){
	CLRF       _i+0
	CLRF       _i+1
L_leer_sensores18:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores57
	MOVF       leer_sensores_cuantosSam_L0+0, 0
	SUBWF      _i+0, 0
L__leer_sensores57:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores19
;seguidor2.c,109 :: 		for(j=0;j<8;j++){
	CLRF       _j+0
	CLRF       _j+1
L_leer_sensores21:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores58
	MOVLW      8
	SUBWF      _j+0, 0
L__leer_sensores58:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores22
;seguidor2.c,110 :: 		sensoresPrin[j] += ADC_Read(j) / cuantosSam;
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FLOC__leer_sensores+0
	MOVF       _j+0, 0
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       leer_sensores_cuantosSam_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16X16_U+0
	MOVF       FLOC__leer_sensores+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       FLOC__leer_sensores+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;seguidor2.c,109 :: 		for(j=0;j<8;j++){
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;seguidor2.c,111 :: 		}
	GOTO       L_leer_sensores21
L_leer_sensores22:
;seguidor2.c,108 :: 		for(i=0;i<cuantosSam;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor2.c,112 :: 		}
	GOTO       L_leer_sensores18
L_leer_sensores19:
;seguidor2.c,113 :: 		}
L_end_leer_sensores:
	RETURN
; end of _leer_sensores

_buzzer:

;seguidor2.c,115 :: 		void buzzer(){
;seguidor2.c,116 :: 		PORTB.RB7 = 1;
	BSF        PORTB+0, 7
;seguidor2.c,117 :: 		Delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_buzzer24:
	DECFSZ     R13+0, 1
	GOTO       L_buzzer24
	DECFSZ     R12+0, 1
	GOTO       L_buzzer24
	DECFSZ     R11+0, 1
	GOTO       L_buzzer24
	NOP
	NOP
;seguidor2.c,118 :: 		PORTB.RB7 = 0;
	BCF        PORTB+0, 7
;seguidor2.c,119 :: 		}
L_end_buzzer:
	RETURN
; end of _buzzer

_controlador:

;seguidor2.c,121 :: 		void controlador(){
;seguidor2.c,122 :: 		float suma = 0;
	CLRF       controlador_suma_L0+0
	CLRF       controlador_suma_L0+1
	CLRF       controlador_suma_L0+2
	CLRF       controlador_suma_L0+3
;seguidor2.c,124 :: 		for(i=0;i<4;i++){
	CLRF       _i+0
	CLRF       _i+1
L_controlador25:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador61
	MOVLW      4
	SUBWF      _i+0, 0
L__controlador61:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador26
;seguidor2.c,126 :: 		suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
	MOVF       _i+0, 0
	SUBLW      7
	MOVWF      R3+0
	MOVF       _i+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R3+1
	SUBWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R6+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R6+1
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R6+0, 0
	MOVWF      R4+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R6+1, 0
	MOVWF      R4+1
	MOVF       _i+0, 0
	SUBLW      4
	MOVWF      R0+0
	MOVF       _i+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R0+1
	SUBWF      R0+1, 1
	CALL       _Mul_16X16_U+0
	CALL       _int2double+0
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R4+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R4+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R4+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      controlador_suma_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_suma_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_suma_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_suma_L0+3
;seguidor2.c,124 :: 		for(i=0;i<4;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor2.c,127 :: 		}
	GOTO       L_controlador25
L_controlador26:
;seguidor2.c,128 :: 		deriv = Kd * (suma - derivAnt);
	MOVF       _derivAnt+0, 0
	MOVWF      R4+0
	MOVF       _derivAnt+1, 0
	MOVWF      R4+1
	MOVF       _derivAnt+2, 0
	MOVWF      R4+2
	MOVF       _derivAnt+3, 0
	MOVWF      R4+3
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R0+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R0+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R0+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       _Kd+0, 0
	MOVWF      R4+0
	MOVF       _Kd+1, 0
	MOVWF      R4+1
	MOVF       _Kd+2, 0
	MOVWF      R4+2
	MOVF       _Kd+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__controlador+0
	MOVF       R0+1, 0
	MOVWF      FLOC__controlador+1
	MOVF       R0+2, 0
	MOVWF      FLOC__controlador+2
	MOVF       R0+3, 0
	MOVWF      FLOC__controlador+3
	MOVF       controlador_suma_L0+0, 0
	MOVWF      _derivAnt+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      _derivAnt+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      _derivAnt+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      _derivAnt+3
;seguidor2.c,130 :: 		suma =  (Kp * suma + deriv )*255 / 10000;
	MOVF       _Kp+0, 0
	MOVWF      R0+0
	MOVF       _Kp+1, 0
	MOVWF      R0+1
	MOVF       _Kp+2, 0
	MOVWF      R0+2
	MOVF       _Kp+3, 0
	MOVWF      R0+3
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R4+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R4+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R4+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       FLOC__controlador+0, 0
	MOVWF      R4+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      R4+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      R4+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      64
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      140
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      controlador_suma_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_suma_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_suma_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_suma_L0+3
;seguidor2.c,131 :: 		if( suma > 50){
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      72
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador28
;seguidor2.c,132 :: 		direccion_motores[0] = 0;
	CLRF       _direccion_motores+0
;seguidor2.c,133 :: 		direccion_motores[1] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+1
;seguidor2.c,134 :: 		ultima_vuelta = 0;
	CLRF       _ultima_vuelta+0
;seguidor2.c,135 :: 		}else if (suma < -50){
	GOTO       L_controlador29
L_controlador28:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      200
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R0+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R0+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R0+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador30
;seguidor2.c,136 :: 		direccion_motores[0] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+0
;seguidor2.c,137 :: 		direccion_motores[1] = 0;
	CLRF       _direccion_motores+1
;seguidor2.c,138 :: 		ultima_vuelta = 1;
	MOVLW      1
	MOVWF      _ultima_vuelta+0
;seguidor2.c,139 :: 		suma = -suma;
	MOVLW      0
	XORWF      controlador_suma_L0+0, 1
	MOVLW      0
	XORWF      controlador_suma_L0+1, 1
	MOVLW      128
	XORWF      controlador_suma_L0+2, 1
	MOVLW      0
	XORWF      controlador_suma_L0+3, 1
;seguidor2.c,140 :: 		}else{
	GOTO       L_controlador31
L_controlador30:
;seguidor2.c,141 :: 		if(sensoresPrin[7] < 700 && sensoresPrin[0] < 700 && sensoresPrin[3] > 400 && sensoresPrin[4] > 400){
	MOVLW      128
	XORWF      _sensoresPrin+15, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      2
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador62
	MOVLW      188
	SUBWF      _sensoresPrin+14, 0
L__controlador62:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador34
	MOVLW      128
	XORWF      _sensoresPrin+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      2
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador63
	MOVLW      188
	SUBWF      _sensoresPrin+0, 0
L__controlador63:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador34
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sensoresPrin+7, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador64
	MOVF       _sensoresPrin+6, 0
	SUBLW      144
L__controlador64:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador34
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sensoresPrin+9, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador65
	MOVF       _sensoresPrin+8, 0
	SUBLW      144
L__controlador65:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador34
L__controlador38:
;seguidor2.c,142 :: 		direccion_motores[0] = 0;
	CLRF       _direccion_motores+0
;seguidor2.c,143 :: 		direccion_motores[1] = 0;
	CLRF       _direccion_motores+1
;seguidor2.c,144 :: 		suma = velocidad;
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      controlador_suma_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_suma_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_suma_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_suma_L0+3
;seguidor2.c,145 :: 		}else{
	GOTO       L_controlador35
L_controlador34:
;seguidor2.c,146 :: 		suma = 150;
	MOVLW      0
	MOVWF      controlador_suma_L0+0
	MOVLW      0
	MOVWF      controlador_suma_L0+1
	MOVLW      22
	MOVWF      controlador_suma_L0+2
	MOVLW      134
	MOVWF      controlador_suma_L0+3
;seguidor2.c,147 :: 		direccion_motores[0] = ultima_vuelta;
	MOVF       _ultima_vuelta+0, 0
	MOVWF      _direccion_motores+0
;seguidor2.c,148 :: 		direccion_motores[1] = !ultima_vuelta;
	MOVF       _ultima_vuelta+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      _direccion_motores+1
;seguidor2.c,149 :: 		}
L_controlador35:
;seguidor2.c,150 :: 		}
L_controlador31:
L_controlador29:
;seguidor2.c,151 :: 		suma = suma > 255 ? 255 : suma;
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R4+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R4+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R4+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      127
	MOVWF      R0+2
	MOVLW      134
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador36
	MOVLW      255
	MOVWF      ?FLOC___controladorT126+0
	GOTO       L_controlador37
L_controlador36:
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R0+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R0+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R0+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R0+3
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___controladorT126+0
L_controlador37:
	MOVF       ?FLOC___controladorT126+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      FLOC__controlador+0
	MOVF       R0+1, 0
	MOVWF      FLOC__controlador+1
	MOVF       R0+2, 0
	MOVWF      FLOC__controlador+2
	MOVF       R0+3, 0
	MOVWF      FLOC__controlador+3
	MOVF       FLOC__controlador+0, 0
	MOVWF      controlador_suma_L0+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      controlador_suma_L0+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      controlador_suma_L0+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      controlador_suma_L0+3
;seguidor2.c,152 :: 		pwm_motores[0] = (char) suma;
	MOVF       FLOC__controlador+0, 0
	MOVWF      R0+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      R0+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      R0+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      R0+3
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      _pwm_motores+0
;seguidor2.c,153 :: 		pwm_motores[1] = (char) suma;
	MOVF       R0+0, 0
	MOVWF      _pwm_motores+1
;seguidor2.c,154 :: 		sumaAnt = suma;
	MOVF       FLOC__controlador+0, 0
	MOVWF      _sumaAnt+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      _sumaAnt+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      _sumaAnt+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      _sumaAnt+3
;seguidor2.c,155 :: 		}
L_end_controlador:
	RETURN
; end of _controlador

_actuadores:

;seguidor2.c,157 :: 		void actuadores(){
;seguidor2.c,159 :: 		PORTD.RD0 = direccion_motores[0];
	BTFSC      _direccion_motores+0, 0
	GOTO       L__actuadores67
	BCF        PORTD+0, 0
	GOTO       L__actuadores68
L__actuadores67:
	BSF        PORTD+0, 0
L__actuadores68:
;seguidor2.c,160 :: 		PORTD.RD1 = !direccion_motores[0];
	MOVF       _direccion_motores+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__actuadores69
	BCF        PORTD+0, 1
	GOTO       L__actuadores70
L__actuadores69:
	BSF        PORTD+0, 1
L__actuadores70:
;seguidor2.c,161 :: 		PORTD.RD2 = direccion_motores[1];
	BTFSC      _direccion_motores+1, 0
	GOTO       L__actuadores71
	BCF        PORTD+0, 2
	GOTO       L__actuadores72
L__actuadores71:
	BSF        PORTD+0, 2
L__actuadores72:
;seguidor2.c,162 :: 		PORTD.RD3 = !direccion_motores[1];
	MOVF       _direccion_motores+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__actuadores73
	BCF        PORTD+0, 3
	GOTO       L__actuadores74
L__actuadores73:
	BSF        PORTD+0, 3
L__actuadores74:
;seguidor2.c,164 :: 		PWM1_Set_Duty(pwm_motores[0]);
	MOVF       _pwm_motores+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;seguidor2.c,165 :: 		PWM2_Set_Duty(pwm_motores[1]);
	MOVF       _pwm_motores+1, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;seguidor2.c,166 :: 		}
L_end_actuadores:
	RETURN
; end of _actuadores
