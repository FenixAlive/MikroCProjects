
_main:

;seguidor4.c,25 :: 		void main() {
;seguidor4.c,26 :: 		ANSEL = 0xFF;
	MOVLW      255
	MOVWF      ANSEL+0
;seguidor4.c,27 :: 		ANSELH = 0x00; //por ahora solo los 8 sensores como analogos
	CLRF       ANSELH+0
;seguidor4.c,28 :: 		C1ON_bit = 0;               // apago comparadores
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;seguidor4.c,29 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;seguidor4.c,31 :: 		TRISA  = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;seguidor4.c,33 :: 		OPTION_REG &= 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;seguidor4.c,36 :: 		TRISB = 0x7F;
	MOVLW      127
	MOVWF      TRISB+0
;seguidor4.c,37 :: 		PORTB = 0x7F;
	MOVLW      127
	MOVWF      PORTB+0
;seguidor4.c,38 :: 		TRISC = 0x00;                          // salidas puerto C
	CLRF       TRISC+0
;seguidor4.c,39 :: 		PORTC = 0x00;                          // poner PORTC en 0
	CLRF       PORTC+0
;seguidor4.c,41 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;seguidor4.c,42 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;seguidor4.c,44 :: 		iniciar_seguidor();
	CALL       _iniciar_seguidor+0
;seguidor4.c,45 :: 		cambiar_velocidad();
	CALL       _cambiar_velocidad+0
;seguidor4.c,46 :: 		while(1){
L_main0:
;seguidor4.c,47 :: 		leer_sensores();
	CALL       _leer_sensores+0
;seguidor4.c,48 :: 		controlador();
	CALL       _controlador+0
;seguidor4.c,49 :: 		actuadores();
	CALL       _actuadores+0
;seguidor4.c,50 :: 		}
	GOTO       L_main0
;seguidor4.c,51 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_iniciar_seguidor:

;seguidor4.c,53 :: 		void iniciar_seguidor(){
;seguidor4.c,54 :: 		if(!(PORTB & 0x01)){
	BTFSC      PORTB+0, 0
	GOTO       L_iniciar_seguidor2
;seguidor4.c,56 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;seguidor4.c,57 :: 		}
L_iniciar_seguidor2:
;seguidor4.c,59 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;seguidor4.c,60 :: 		PORTD.RD0 = direccion_motores[0];
	BTFSC      _direccion_motores+0, 0
	GOTO       L__iniciar_seguidor59
	BCF        PORTD+0, 0
	GOTO       L__iniciar_seguidor60
L__iniciar_seguidor59:
	BSF        PORTD+0, 0
L__iniciar_seguidor60:
;seguidor4.c,61 :: 		PORTD.RD1 = !direccion_motores[0];
	MOVF       _direccion_motores+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__iniciar_seguidor61
	BCF        PORTD+0, 1
	GOTO       L__iniciar_seguidor62
L__iniciar_seguidor61:
	BSF        PORTD+0, 1
L__iniciar_seguidor62:
;seguidor4.c,62 :: 		PORTD.RD2 = direccion_motores[1];
	BTFSC      _direccion_motores+1, 0
	GOTO       L__iniciar_seguidor63
	BCF        PORTD+0, 2
	GOTO       L__iniciar_seguidor64
L__iniciar_seguidor63:
	BSF        PORTD+0, 2
L__iniciar_seguidor64:
;seguidor4.c,63 :: 		PORTD.RD3 = !direccion_motores[1];
	MOVF       _direccion_motores+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__iniciar_seguidor65
	BCF        PORTD+0, 3
	GOTO       L__iniciar_seguidor66
L__iniciar_seguidor65:
	BSF        PORTD+0, 3
L__iniciar_seguidor66:
;seguidor4.c,64 :: 		PWM1_Init(5000);                    // Initializar PWM1
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;seguidor4.c,65 :: 		PWM2_Init(5000);                    // Initializar PWM2
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;seguidor4.c,66 :: 		PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;seguidor4.c,67 :: 		PWM2_Start();                       // start PWM2
	CALL       _PWM2_Start+0
;seguidor4.c,68 :: 		}
L_end_iniciar_seguidor:
	RETURN
; end of _iniciar_seguidor

_cambiar_velocidad:

;seguidor4.c,70 :: 		void cambiar_velocidad(){
;seguidor4.c,71 :: 		if(!(PORTB & 0x02)){
	BTFSC      PORTB+0, 1
	GOTO       L_cambiar_velocidad3
;seguidor4.c,72 :: 		velocidad = 100; //120;
	MOVLW      100
	MOVWF      _velocidad+0
;seguidor4.c,73 :: 		Kd=0.024;
	MOVLW      166
	MOVWF      _Kd+0
	MOVLW      155
	MOVWF      _Kd+1
	MOVLW      68
	MOVWF      _Kd+2
	MOVLW      121
	MOVWF      _Kd+3
;seguidor4.c,74 :: 		Kp=0.79;
	MOVLW      113
	MOVWF      _Kp+0
	MOVLW      61
	MOVWF      _Kp+1
	MOVLW      74
	MOVWF      _Kp+2
	MOVLW      126
	MOVWF      _Kp+3
;seguidor4.c,75 :: 		}
L_cambiar_velocidad3:
;seguidor4.c,76 :: 		}
L_end_cambiar_velocidad:
	RETURN
; end of _cambiar_velocidad

_leer_sensores:

;seguidor4.c,78 :: 		void leer_sensores(){
;seguidor4.c,79 :: 		char cuantosSam = 7;
	MOVLW      7
	MOVWF      leer_sensores_cuantosSam_L0+0
;seguidor4.c,81 :: 		for(i=0;i<8;i++){
	CLRF       _i+0
	CLRF       _i+1
L_leer_sensores4:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores69
	MOVLW      8
	SUBWF      _i+0, 0
L__leer_sensores69:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores5
;seguidor4.c,82 :: 		sensoresPrin[i] = 0;
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
;seguidor4.c,81 :: 		for(i=0;i<8;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor4.c,83 :: 		}
	GOTO       L_leer_sensores4
L_leer_sensores5:
;seguidor4.c,85 :: 		for(i=0;i<cuantosSam;i++){
	CLRF       _i+0
	CLRF       _i+1
L_leer_sensores7:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores70
	MOVF       leer_sensores_cuantosSam_L0+0, 0
	SUBWF      _i+0, 0
L__leer_sensores70:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores8
;seguidor4.c,86 :: 		for(j=0;j<8;j++){
	CLRF       _j+0
	CLRF       _j+1
L_leer_sensores10:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores71
	MOVLW      8
	SUBWF      _j+0, 0
L__leer_sensores71:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores11
;seguidor4.c,87 :: 		sensoresPrin[j] += ADC_Read(j) / cuantosSam;
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
;seguidor4.c,86 :: 		for(j=0;j<8;j++){
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;seguidor4.c,88 :: 		}
	GOTO       L_leer_sensores10
L_leer_sensores11:
;seguidor4.c,85 :: 		for(i=0;i<cuantosSam;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor4.c,89 :: 		}
	GOTO       L_leer_sensores7
L_leer_sensores8:
;seguidor4.c,90 :: 		}
L_end_leer_sensores:
	RETURN
; end of _leer_sensores

_controlador:

;seguidor4.c,92 :: 		void controlador(){
;seguidor4.c,93 :: 		float suma = 0;
	CLRF       controlador_suma_L0+0
	CLRF       controlador_suma_L0+1
	CLRF       controlador_suma_L0+2
	CLRF       controlador_suma_L0+3
	CLRF       controlador_pwm1_L0+0
	CLRF       controlador_pwm1_L0+1
	CLRF       controlador_pwm1_L0+2
	CLRF       controlador_pwm1_L0+3
	CLRF       controlador_pwm2_L0+0
	CLRF       controlador_pwm2_L0+1
	CLRF       controlador_pwm2_L0+2
	CLRF       controlador_pwm2_L0+3
	CLRF       controlador_deriv_L0+0
	CLRF       controlador_deriv_L0+1
	CLRF       controlador_deriv_L0+2
	CLRF       controlador_deriv_L0+3
;seguidor4.c,97 :: 		for(i=0;i<4;i++){
	CLRF       _i+0
	CLRF       _i+1
L_controlador13:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador73
	MOVLW      4
	SUBWF      _i+0, 0
L__controlador73:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador14
;seguidor4.c,98 :: 		suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
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
;seguidor4.c,97 :: 		for(i=0;i<4;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor4.c,99 :: 		}
	GOTO       L_controlador13
L_controlador14:
;seguidor4.c,100 :: 		deriv = Kd * (suma - derivAnt)/0.01;
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
	MOVLW      10
	MOVWF      R4+0
	MOVLW      215
	MOVWF      R4+1
	MOVLW      35
	MOVWF      R4+2
	MOVLW      120
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      controlador_deriv_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_deriv_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_deriv_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_deriv_L0+3
;seguidor4.c,101 :: 		derivAnt= suma;
	MOVF       controlador_suma_L0+0, 0
	MOVWF      _derivAnt+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      _derivAnt+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      _derivAnt+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      _derivAnt+3
;seguidor4.c,102 :: 		if(deriv > 5000){
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
	MOVLW      64
	MOVWF      R0+1
	MOVLW      28
	MOVWF      R0+2
	MOVLW      139
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador16
;seguidor4.c,103 :: 		deriv = 5000;
	MOVLW      0
	MOVWF      controlador_deriv_L0+0
	MOVLW      64
	MOVWF      controlador_deriv_L0+1
	MOVLW      28
	MOVWF      controlador_deriv_L0+2
	MOVLW      139
	MOVWF      controlador_deriv_L0+3
;seguidor4.c,104 :: 		}else if(deriv < -5000){
	GOTO       L_controlador17
L_controlador16:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      64
	MOVWF      R4+1
	MOVLW      156
	MOVWF      R4+2
	MOVLW      139
	MOVWF      R4+3
	MOVF       controlador_deriv_L0+0, 0
	MOVWF      R0+0
	MOVF       controlador_deriv_L0+1, 0
	MOVWF      R0+1
	MOVF       controlador_deriv_L0+2, 0
	MOVWF      R0+2
	MOVF       controlador_deriv_L0+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador18
;seguidor4.c,105 :: 		deriv = -5000;
	MOVLW      0
	MOVWF      controlador_deriv_L0+0
	MOVLW      64
	MOVWF      controlador_deriv_L0+1
	MOVLW      156
	MOVWF      controlador_deriv_L0+2
	MOVLW      139
	MOVWF      controlador_deriv_L0+3
;seguidor4.c,106 :: 		}
L_controlador18:
L_controlador17:
;seguidor4.c,107 :: 		integral += Ki*suma;
	MOVF       _Ki+0, 0
	MOVWF      R0+0
	MOVF       _Ki+1, 0
	MOVWF      R0+1
	MOVF       _Ki+2, 0
	MOVWF      R0+2
	MOVF       _Ki+3, 0
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
	MOVF       _integral+0, 0
	MOVWF      R4+0
	MOVF       _integral+1, 0
	MOVWF      R4+1
	MOVF       _integral+2, 0
	MOVWF      R4+2
	MOVF       _integral+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _integral+0
	MOVF       R0+1, 0
	MOVWF      _integral+1
	MOVF       R0+2, 0
	MOVWF      _integral+2
	MOVF       R0+3, 0
	MOVWF      _integral+3
;seguidor4.c,108 :: 		if(integral > 1500){
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
	MOVLW      128
	MOVWF      R0+1
	MOVLW      59
	MOVWF      R0+2
	MOVLW      137
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador19
;seguidor4.c,109 :: 		integral = 1500;
	MOVLW      0
	MOVWF      _integral+0
	MOVLW      128
	MOVWF      _integral+1
	MOVLW      59
	MOVWF      _integral+2
	MOVLW      137
	MOVWF      _integral+3
;seguidor4.c,110 :: 		}else if(integral < -1500){
	GOTO       L_controlador20
L_controlador19:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      128
	MOVWF      R4+1
	MOVLW      187
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	MOVF       _integral+0, 0
	MOVWF      R0+0
	MOVF       _integral+1, 0
	MOVWF      R0+1
	MOVF       _integral+2, 0
	MOVWF      R0+2
	MOVF       _integral+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador21
;seguidor4.c,111 :: 		integral = -1500;
	MOVLW      0
	MOVWF      _integral+0
	MOVLW      128
	MOVWF      _integral+1
	MOVLW      187
	MOVWF      _integral+2
	MOVLW      137
	MOVWF      _integral+3
;seguidor4.c,112 :: 		}
L_controlador21:
L_controlador20:
;seguidor4.c,113 :: 		suma =  (Kp * suma + deriv + integral )*255 / 10000;
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
	MOVF       controlador_deriv_L0+0, 0
	MOVWF      R4+0
	MOVF       controlador_deriv_L0+1, 0
	MOVWF      R4+1
	MOVF       controlador_deriv_L0+2, 0
	MOVWF      R4+2
	MOVF       controlador_deriv_L0+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       _integral+0, 0
	MOVWF      R4+0
	MOVF       _integral+1, 0
	MOVWF      R4+1
	MOVF       _integral+2, 0
	MOVWF      R4+2
	MOVF       _integral+3, 0
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
;seguidor4.c,114 :: 		if( suma > velocidad){
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       FLOC__controlador+0, 0
	MOVWF      R4+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      R4+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      R4+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador22
;seguidor4.c,115 :: 		direccion_motores[0] = 0;
	CLRF       _direccion_motores+0
;seguidor4.c,116 :: 		direccion_motores[1] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+1
;seguidor4.c,117 :: 		pwm1 = suma+velocidad > 255 ? 255 : suma + velocidad;
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
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
	GOTO       L_controlador23
	MOVLW      255
	MOVWF      ?FLOC___controladorT75+0
	GOTO       L_controlador24
L_controlador23:
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R4+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R4+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R4+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___controladorT75+0
L_controlador24:
	MOVF       ?FLOC___controladorT75+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      controlador_pwm1_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_pwm1_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_pwm1_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_pwm1_L0+3
;seguidor4.c,118 :: 		pwm2 = suma-velocidad > 255 ? 255 : suma - velocidad;
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
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
	GOTO       L_controlador25
	MOVLW      255
	MOVWF      ?FLOC___controladorT83+0
	GOTO       L_controlador26
L_controlador25:
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
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
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___controladorT83+0
L_controlador26:
	MOVF       ?FLOC___controladorT83+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      controlador_pwm2_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_pwm2_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_pwm2_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_pwm2_L0+3
;seguidor4.c,119 :: 		}else if (suma < -velocidad){
	GOTO       L_controlador27
L_controlador22:
	MOVF       _velocidad+0, 0
	SUBLW      0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
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
	GOTO       L_controlador28
;seguidor4.c,120 :: 		direccion_motores[0] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+0
;seguidor4.c,121 :: 		direccion_motores[1] = 0;
	CLRF       _direccion_motores+1
;seguidor4.c,122 :: 		pwm1 = -suma-velocidad > 255 ? 255 : -suma-velocidad;
	MOVLW      0
	XORWF      controlador_suma_L0+0, 0
	MOVWF      FLOC__controlador+0
	MOVLW      0
	XORWF      controlador_suma_L0+1, 0
	MOVWF      FLOC__controlador+1
	MOVLW      128
	XORWF      controlador_suma_L0+2, 0
	MOVWF      FLOC__controlador+2
	MOVLW      0
	XORWF      controlador_suma_L0+3, 0
	MOVWF      FLOC__controlador+3
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__controlador+0, 0
	MOVWF      R0+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      R0+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      R0+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
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
	GOTO       L_controlador29
	MOVLW      255
	MOVWF      ?FLOC___controladorT98+0
	GOTO       L_controlador30
L_controlador29:
	MOVLW      0
	XORWF      controlador_suma_L0+0, 0
	MOVWF      FLOC__controlador+0
	MOVLW      0
	XORWF      controlador_suma_L0+1, 0
	MOVWF      FLOC__controlador+1
	MOVLW      128
	XORWF      controlador_suma_L0+2, 0
	MOVWF      FLOC__controlador+2
	MOVLW      0
	XORWF      controlador_suma_L0+3, 0
	MOVWF      FLOC__controlador+3
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__controlador+0, 0
	MOVWF      R0+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      R0+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      R0+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___controladorT98+0
L_controlador30:
	MOVF       ?FLOC___controladorT98+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      controlador_pwm1_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_pwm1_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_pwm1_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_pwm1_L0+3
;seguidor4.c,123 :: 		pwm2 = -suma+velocidad > 255 ? 255 : -suma+velocidad;
	MOVLW      0
	XORWF      controlador_suma_L0+0, 0
	MOVWF      FLOC__controlador+0
	MOVLW      0
	XORWF      controlador_suma_L0+1, 0
	MOVWF      FLOC__controlador+1
	MOVLW      128
	XORWF      controlador_suma_L0+2, 0
	MOVWF      FLOC__controlador+2
	MOVLW      0
	XORWF      controlador_suma_L0+3, 0
	MOVWF      FLOC__controlador+3
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       FLOC__controlador+0, 0
	MOVWF      R4+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      R4+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      R4+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
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
	GOTO       L_controlador31
	MOVLW      255
	MOVWF      ?FLOC___controladorT110+0
	GOTO       L_controlador32
L_controlador31:
	MOVLW      0
	XORWF      controlador_suma_L0+0, 0
	MOVWF      FLOC__controlador+0
	MOVLW      0
	XORWF      controlador_suma_L0+1, 0
	MOVWF      FLOC__controlador+1
	MOVLW      128
	XORWF      controlador_suma_L0+2, 0
	MOVWF      FLOC__controlador+2
	MOVLW      0
	XORWF      controlador_suma_L0+3, 0
	MOVWF      FLOC__controlador+3
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       FLOC__controlador+0, 0
	MOVWF      R4+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      R4+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      R4+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___controladorT110+0
L_controlador32:
	MOVF       ?FLOC___controladorT110+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      controlador_pwm2_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_pwm2_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_pwm2_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_pwm2_L0+3
;seguidor4.c,124 :: 		}else{
	GOTO       L_controlador33
L_controlador28:
;seguidor4.c,125 :: 		direccion_motores[0] = 0;
	CLRF       _direccion_motores+0
;seguidor4.c,126 :: 		direccion_motores[1] = 0;
	CLRF       _direccion_motores+1
;seguidor4.c,127 :: 		pwm1 = velocidad+suma > 255 ? 255 : velocidad+suma;
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
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
	GOTO       L_controlador34
	MOVLW      255
	MOVWF      ?FLOC___controladorT122+0
	GOTO       L_controlador35
L_controlador34:
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R4+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R4+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R4+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___controladorT122+0
L_controlador35:
	MOVF       ?FLOC___controladorT122+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      controlador_pwm1_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_pwm1_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_pwm1_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_pwm1_L0+3
;seguidor4.c,128 :: 		pwm2 = velocidad-suma > 255 ? 255 : velocidad-suma;
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R4+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R4+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R4+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R4+3
	CALL       _Sub_32x32_FP+0
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
	MOVWF      ?FLOC___controladorT130+0
	GOTO       L_controlador37
L_controlador36:
	MOVF       _velocidad+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R4+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R4+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      R4+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      R4+3
	CALL       _Sub_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___controladorT130+0
L_controlador37:
	MOVF       ?FLOC___controladorT130+0, 0
	MOVWF      R0+0
	CALL       _byte2double+0
	MOVF       R0+0, 0
	MOVWF      controlador_pwm2_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_pwm2_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_pwm2_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_pwm2_L0+3
;seguidor4.c,129 :: 		}
L_controlador33:
L_controlador27:
;seguidor4.c,130 :: 		if(sensoresPrin[7] > 700 && sensoresPrin[0] < 500){
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sensoresPrin+15, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador74
	MOVF       _sensoresPrin+14, 0
	SUBLW      188
L__controlador74:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador40
	MOVLW      128
	XORWF      _sensoresPrin+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador75
	MOVLW      244
	SUBWF      _sensoresPrin+0, 0
L__controlador75:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador40
L__controlador56:
;seguidor4.c,131 :: 		ultima_vuelta = 0;
	CLRF       _ultima_vuelta+0
;seguidor4.c,132 :: 		}else if(sensoresPrin[0] > 700 && sensoresPrin[7] < 500){
	GOTO       L_controlador41
L_controlador40:
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sensoresPrin+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador76
	MOVF       _sensoresPrin+0, 0
	SUBLW      188
L__controlador76:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador44
	MOVLW      128
	XORWF      _sensoresPrin+15, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador77
	MOVLW      244
	SUBWF      _sensoresPrin+14, 0
L__controlador77:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador44
L__controlador55:
;seguidor4.c,133 :: 		ultima_vuelta = 1;
	MOVLW      1
	MOVWF      _ultima_vuelta+0
;seguidor4.c,134 :: 		}
L_controlador44:
L_controlador41:
;seguidor4.c,135 :: 		if( derivAnt < 2000 && derivAnt > -2000 &&((sensoresPrin[3] + 300 > sensoresPrin[0]) && (sensoresPrin[3] - 300 < sensoresPrin[0])) && ( (sensoresPrin[4] + 300 > sensoresPrin[7]) && (sensoresPrin[4] - 300 < sensoresPrin[7]))){
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	MOVF       _derivAnt+0, 0
	MOVWF      R0+0
	MOVF       _derivAnt+1, 0
	MOVWF      R0+1
	MOVF       _derivAnt+2, 0
	MOVWF      R0+2
	MOVF       _derivAnt+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador51
	MOVF       _derivAnt+0, 0
	MOVWF      R4+0
	MOVF       _derivAnt+1, 0
	MOVWF      R4+1
	MOVF       _derivAnt+2, 0
	MOVWF      R4+2
	MOVF       _derivAnt+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      250
	MOVWF      R0+2
	MOVLW      137
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador51
	MOVLW      44
	ADDWF      _sensoresPrin+6, 0
	MOVWF      R1+0
	MOVF       _sensoresPrin+7, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      1
	MOVWF      R1+1
	MOVLW      128
	XORWF      _sensoresPrin+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador78
	MOVF       R1+0, 0
	SUBWF      _sensoresPrin+0, 0
L__controlador78:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador51
	MOVLW      44
	SUBWF      _sensoresPrin+6, 0
	MOVWF      R1+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _sensoresPrin+7, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sensoresPrin+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador79
	MOVF       _sensoresPrin+0, 0
	SUBWF      R1+0, 0
L__controlador79:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador51
L__controlador54:
	MOVLW      44
	ADDWF      _sensoresPrin+8, 0
	MOVWF      R1+0
	MOVF       _sensoresPrin+9, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      1
	MOVWF      R1+1
	MOVLW      128
	XORWF      _sensoresPrin+15, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador80
	MOVF       R1+0, 0
	SUBWF      _sensoresPrin+14, 0
L__controlador80:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador51
	MOVLW      44
	SUBWF      _sensoresPrin+8, 0
	MOVWF      R1+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _sensoresPrin+9, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sensoresPrin+15, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador81
	MOVF       _sensoresPrin+14, 0
	SUBWF      R1+0, 0
L__controlador81:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador51
L__controlador53:
L__controlador52:
;seguidor4.c,136 :: 		pwm1 = velVuelta;
	MOVF       _velVuelta+0, 0
	MOVWF      controlador_pwm1_L0+0
	MOVF       _velVuelta+1, 0
	MOVWF      controlador_pwm1_L0+1
	MOVF       _velVuelta+2, 0
	MOVWF      controlador_pwm1_L0+2
	MOVF       _velVuelta+3, 0
	MOVWF      controlador_pwm1_L0+3
;seguidor4.c,137 :: 		pwm2 = velVuelta;
	MOVF       _velVuelta+0, 0
	MOVWF      controlador_pwm2_L0+0
	MOVF       _velVuelta+1, 0
	MOVWF      controlador_pwm2_L0+1
	MOVF       _velVuelta+2, 0
	MOVWF      controlador_pwm2_L0+2
	MOVF       _velVuelta+3, 0
	MOVWF      controlador_pwm2_L0+3
;seguidor4.c,138 :: 		direccion_motores[0] = ultima_vuelta;
	MOVF       _ultima_vuelta+0, 0
	MOVWF      _direccion_motores+0
;seguidor4.c,139 :: 		direccion_motores[1] = !ultima_vuelta;
	MOVF       _ultima_vuelta+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      _direccion_motores+1
;seguidor4.c,140 :: 		}
L_controlador51:
;seguidor4.c,141 :: 		pwm_motores[0] = (char) pwm1;
	MOVF       controlador_pwm1_L0+0, 0
	MOVWF      R0+0
	MOVF       controlador_pwm1_L0+1, 0
	MOVWF      R0+1
	MOVF       controlador_pwm1_L0+2, 0
	MOVWF      R0+2
	MOVF       controlador_pwm1_L0+3, 0
	MOVWF      R0+3
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      _pwm_motores+0
;seguidor4.c,142 :: 		pwm_motores[1] = (char) pwm2;
	MOVF       controlador_pwm2_L0+0, 0
	MOVWF      R0+0
	MOVF       controlador_pwm2_L0+1, 0
	MOVWF      R0+1
	MOVF       controlador_pwm2_L0+2, 0
	MOVWF      R0+2
	MOVF       controlador_pwm2_L0+3, 0
	MOVWF      R0+3
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      _pwm_motores+1
;seguidor4.c,143 :: 		}
L_end_controlador:
	RETURN
; end of _controlador

_actuadores:

;seguidor4.c,145 :: 		void actuadores(){
;seguidor4.c,147 :: 		PORTD.RD0 = direccion_motores[0];
	BTFSC      _direccion_motores+0, 0
	GOTO       L__actuadores83
	BCF        PORTD+0, 0
	GOTO       L__actuadores84
L__actuadores83:
	BSF        PORTD+0, 0
L__actuadores84:
;seguidor4.c,148 :: 		PORTD.RD1 = !direccion_motores[0];
	MOVF       _direccion_motores+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__actuadores85
	BCF        PORTD+0, 1
	GOTO       L__actuadores86
L__actuadores85:
	BSF        PORTD+0, 1
L__actuadores86:
;seguidor4.c,149 :: 		PORTD.RD2 = direccion_motores[1];
	BTFSC      _direccion_motores+1, 0
	GOTO       L__actuadores87
	BCF        PORTD+0, 2
	GOTO       L__actuadores88
L__actuadores87:
	BSF        PORTD+0, 2
L__actuadores88:
;seguidor4.c,150 :: 		PORTD.RD3 = !direccion_motores[1];
	MOVF       _direccion_motores+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__actuadores89
	BCF        PORTD+0, 3
	GOTO       L__actuadores90
L__actuadores89:
	BSF        PORTD+0, 3
L__actuadores90:
;seguidor4.c,152 :: 		PWM1_Set_Duty(pwm_motores[0]);
	MOVF       _pwm_motores+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;seguidor4.c,153 :: 		PWM2_Set_Duty(pwm_motores[1]);
	MOVF       _pwm_motores+1, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;seguidor4.c,154 :: 		}
L_end_actuadores:
	RETURN
; end of _actuadores
