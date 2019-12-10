
_main:

;seguidor3.c,22 :: 		void main() {
;seguidor3.c,23 :: 		ANSEL = 0xFF;
	MOVLW      255
	MOVWF      ANSEL+0
;seguidor3.c,24 :: 		ANSELH = 0x00; //por ahora solo los 8 sensores como analogos
	CLRF       ANSELH+0
;seguidor3.c,25 :: 		C1ON_bit = 0;               // apago comparadores
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;seguidor3.c,26 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;seguidor3.c,28 :: 		TRISA  = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;seguidor3.c,30 :: 		OPTION_REG &= 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;seguidor3.c,33 :: 		TRISB = 0x7F;
	MOVLW      127
	MOVWF      TRISB+0
;seguidor3.c,34 :: 		PORTB = 0x7F;
	MOVLW      127
	MOVWF      PORTB+0
;seguidor3.c,35 :: 		TRISC = 0x00;                          // salidas puerto C
	CLRF       TRISC+0
;seguidor3.c,36 :: 		PORTC = 0x00;                          // poner PORTC en 0
	CLRF       PORTC+0
;seguidor3.c,38 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;seguidor3.c,39 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;seguidor3.c,41 :: 		iniciar_seguidor();
	CALL       _iniciar_seguidor+0
;seguidor3.c,42 :: 		cambiar_velocidad();
	CALL       _cambiar_velocidad+0
;seguidor3.c,43 :: 		while(1){
L_main0:
;seguidor3.c,44 :: 		leer_sensores();
	CALL       _leer_sensores+0
;seguidor3.c,45 :: 		controlador();
	CALL       _controlador+0
;seguidor3.c,46 :: 		actuadores();
	CALL       _actuadores+0
;seguidor3.c,47 :: 		}
	GOTO       L_main0
;seguidor3.c,48 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_iniciar_seguidor:

;seguidor3.c,50 :: 		void iniciar_seguidor(){
;seguidor3.c,51 :: 		if(!(PORTB & 0x02)){
	BTFSC      PORTB+0, 1
	GOTO       L_iniciar_seguidor2
;seguidor3.c,53 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;seguidor3.c,54 :: 		}
L_iniciar_seguidor2:
;seguidor3.c,56 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;seguidor3.c,57 :: 		PORTD.RD0 = direccion_motores[0];
	BTFSC      _direccion_motores+0, 0
	GOTO       L__iniciar_seguidor35
	BCF        PORTD+0, 0
	GOTO       L__iniciar_seguidor36
L__iniciar_seguidor35:
	BSF        PORTD+0, 0
L__iniciar_seguidor36:
;seguidor3.c,58 :: 		PORTD.RD1 = !direccion_motores[0];
	MOVF       _direccion_motores+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__iniciar_seguidor37
	BCF        PORTD+0, 1
	GOTO       L__iniciar_seguidor38
L__iniciar_seguidor37:
	BSF        PORTD+0, 1
L__iniciar_seguidor38:
;seguidor3.c,59 :: 		PORTD.RD2 = direccion_motores[1];
	BTFSC      _direccion_motores+1, 0
	GOTO       L__iniciar_seguidor39
	BCF        PORTD+0, 2
	GOTO       L__iniciar_seguidor40
L__iniciar_seguidor39:
	BSF        PORTD+0, 2
L__iniciar_seguidor40:
;seguidor3.c,60 :: 		PORTD.RD3 = !direccion_motores[1];
	MOVF       _direccion_motores+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__iniciar_seguidor41
	BCF        PORTD+0, 3
	GOTO       L__iniciar_seguidor42
L__iniciar_seguidor41:
	BSF        PORTD+0, 3
L__iniciar_seguidor42:
;seguidor3.c,61 :: 		PWM1_Init(10000);                    // Initializar PWM1
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;seguidor3.c,62 :: 		PWM2_Init(10000);                    // Initializar PWM2
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;seguidor3.c,63 :: 		PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;seguidor3.c,64 :: 		PWM2_Start();                       // start PWM2
	CALL       _PWM2_Start+0
;seguidor3.c,65 :: 		}
L_end_iniciar_seguidor:
	RETURN
; end of _iniciar_seguidor

_cambiar_velocidad:

;seguidor3.c,67 :: 		void cambiar_velocidad(){
;seguidor3.c,68 :: 		if(!(PORTB & 0x04)){
	BTFSC      PORTB+0, 2
	GOTO       L_cambiar_velocidad3
;seguidor3.c,69 :: 		velocidad = 210;
	MOVLW      210
	MOVWF      _velocidad+0
;seguidor3.c,70 :: 		}
L_cambiar_velocidad3:
;seguidor3.c,71 :: 		}
L_end_cambiar_velocidad:
	RETURN
; end of _cambiar_velocidad

_leer_sensores:

;seguidor3.c,73 :: 		void leer_sensores(){
;seguidor3.c,74 :: 		char cuantosSam = 9;
	MOVLW      9
	MOVWF      leer_sensores_cuantosSam_L0+0
;seguidor3.c,76 :: 		for(i=0;i<8;i++){
	CLRF       _i+0
	CLRF       _i+1
L_leer_sensores4:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores45
	MOVLW      8
	SUBWF      _i+0, 0
L__leer_sensores45:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores5
;seguidor3.c,77 :: 		sensoresPrin[i] = 0;
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
;seguidor3.c,76 :: 		for(i=0;i<8;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor3.c,78 :: 		}
	GOTO       L_leer_sensores4
L_leer_sensores5:
;seguidor3.c,80 :: 		for(i=0;i<cuantosSam;i++){
	CLRF       _i+0
	CLRF       _i+1
L_leer_sensores7:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores46
	MOVF       leer_sensores_cuantosSam_L0+0, 0
	SUBWF      _i+0, 0
L__leer_sensores46:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores8
;seguidor3.c,81 :: 		for(j=0;j<8;j++){
	CLRF       _j+0
	CLRF       _j+1
L_leer_sensores10:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leer_sensores47
	MOVLW      8
	SUBWF      _j+0, 0
L__leer_sensores47:
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores11
;seguidor3.c,82 :: 		sensoresPrin[j] += ADC_Read(j) / cuantosSam;
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
;seguidor3.c,81 :: 		for(j=0;j<8;j++){
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;seguidor3.c,83 :: 		}
	GOTO       L_leer_sensores10
L_leer_sensores11:
;seguidor3.c,80 :: 		for(i=0;i<cuantosSam;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor3.c,84 :: 		}
	GOTO       L_leer_sensores7
L_leer_sensores8:
;seguidor3.c,85 :: 		}
L_end_leer_sensores:
	RETURN
; end of _leer_sensores

_controlador:

;seguidor3.c,87 :: 		void controlador(){
;seguidor3.c,88 :: 		float suma = 0;
	CLRF       controlador_suma_L0+0
	CLRF       controlador_suma_L0+1
	CLRF       controlador_suma_L0+2
	CLRF       controlador_suma_L0+3
	CLRF       controlador_deriv_L0+0
	CLRF       controlador_deriv_L0+1
	CLRF       controlador_deriv_L0+2
	CLRF       controlador_deriv_L0+3
;seguidor3.c,90 :: 		for(i=0;i<4;i++){
	CLRF       _i+0
	CLRF       _i+1
L_controlador13:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador49
	MOVLW      4
	SUBWF      _i+0, 0
L__controlador49:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador14
;seguidor3.c,91 :: 		suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
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
;seguidor3.c,90 :: 		for(i=0;i<4;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;seguidor3.c,92 :: 		}
	GOTO       L_controlador13
L_controlador14:
;seguidor3.c,93 :: 		deriv = Kd * (suma - derivAnt);
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
	MOVWF      controlador_deriv_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_deriv_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_deriv_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_deriv_L0+3
;seguidor3.c,94 :: 		derivAnt = suma;
	MOVF       controlador_suma_L0+0, 0
	MOVWF      _derivAnt+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      _derivAnt+1
	MOVF       controlador_suma_L0+2, 0
	MOVWF      _derivAnt+2
	MOVF       controlador_suma_L0+3, 0
	MOVWF      _derivAnt+3
;seguidor3.c,95 :: 		if(deriv > 7000){
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
	MOVLW      192
	MOVWF      R0+1
	MOVLW      90
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
;seguidor3.c,96 :: 		deriv = 7000;
	MOVLW      0
	MOVWF      controlador_deriv_L0+0
	MOVLW      192
	MOVWF      controlador_deriv_L0+1
	MOVLW      90
	MOVWF      controlador_deriv_L0+2
	MOVLW      139
	MOVWF      controlador_deriv_L0+3
;seguidor3.c,97 :: 		}else if(deriv < -7000){
	GOTO       L_controlador17
L_controlador16:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      218
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
;seguidor3.c,98 :: 		deriv = -7000;
	MOVLW      0
	MOVWF      controlador_deriv_L0+0
	MOVLW      192
	MOVWF      controlador_deriv_L0+1
	MOVLW      218
	MOVWF      controlador_deriv_L0+2
	MOVLW      139
	MOVWF      controlador_deriv_L0+3
;seguidor3.c,99 :: 		}
L_controlador18:
L_controlador17:
;seguidor3.c,100 :: 		integral += Ki*suma;
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
;seguidor3.c,101 :: 		if(integral > 3000){
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
	MOVLW      138
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador19
;seguidor3.c,102 :: 		integral = 3000;
	MOVLW      0
	MOVWF      _integral+0
	MOVLW      128
	MOVWF      _integral+1
	MOVLW      59
	MOVWF      _integral+2
	MOVLW      138
	MOVWF      _integral+3
;seguidor3.c,103 :: 		}else if(integral < -3000){
	GOTO       L_controlador20
L_controlador19:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      128
	MOVWF      R4+1
	MOVLW      187
	MOVWF      R4+2
	MOVLW      138
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
;seguidor3.c,104 :: 		integral = -3000;
	MOVLW      0
	MOVWF      _integral+0
	MOVLW      128
	MOVWF      _integral+1
	MOVLW      187
	MOVWF      _integral+2
	MOVLW      138
	MOVWF      _integral+3
;seguidor3.c,105 :: 		}
L_controlador21:
L_controlador20:
;seguidor3.c,106 :: 		suma =  (Kp * suma + deriv + integral )*255 / 10000;
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
	MOVWF      controlador_suma_L0+0
	MOVF       R0+1, 0
	MOVWF      controlador_suma_L0+1
	MOVF       R0+2, 0
	MOVWF      controlador_suma_L0+2
	MOVF       R0+3, 0
	MOVWF      controlador_suma_L0+3
;seguidor3.c,108 :: 		if( suma > 30){
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
	MOVLW      112
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlador22
;seguidor3.c,109 :: 		direccion_motores[0] = 0;
	CLRF       _direccion_motores+0
;seguidor3.c,110 :: 		direccion_motores[1] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+1
;seguidor3.c,111 :: 		ultima_vuelta = 0;
	CLRF       _ultima_vuelta+0
;seguidor3.c,112 :: 		}else if (suma < -30){
	GOTO       L_controlador23
L_controlador22:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      240
	MOVWF      R4+2
	MOVLW      131
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
	GOTO       L_controlador24
;seguidor3.c,113 :: 		direccion_motores[0] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+0
;seguidor3.c,114 :: 		direccion_motores[1] = 0;
	CLRF       _direccion_motores+1
;seguidor3.c,115 :: 		ultima_vuelta = 1;
	MOVLW      1
	MOVWF      _ultima_vuelta+0
;seguidor3.c,116 :: 		suma = -suma;
	MOVLW      0
	XORWF      controlador_suma_L0+0, 1
	MOVLW      0
	XORWF      controlador_suma_L0+1, 1
	MOVLW      128
	XORWF      controlador_suma_L0+2, 1
	MOVLW      0
	XORWF      controlador_suma_L0+3, 1
;seguidor3.c,117 :: 		}else{
	GOTO       L_controlador25
L_controlador24:
;seguidor3.c,118 :: 		if(sensoresPrin[7] < 700 && sensoresPrin[0] < 700 && sensoresPrin[3] > 600 && sensoresPrin[4] > 600){
	MOVLW      128
	XORWF      _sensoresPrin+15, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      2
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador50
	MOVLW      188
	SUBWF      _sensoresPrin+14, 0
L__controlador50:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador28
	MOVLW      128
	XORWF      _sensoresPrin+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      2
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador51
	MOVLW      188
	SUBWF      _sensoresPrin+0, 0
L__controlador51:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador28
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sensoresPrin+7, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador52
	MOVF       _sensoresPrin+6, 0
	SUBLW      88
L__controlador52:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador28
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sensoresPrin+9, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador53
	MOVF       _sensoresPrin+8, 0
	SUBLW      88
L__controlador53:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador28
L__controlador32:
;seguidor3.c,119 :: 		direccion_motores[0] = 0;
	CLRF       _direccion_motores+0
;seguidor3.c,120 :: 		direccion_motores[1] = 0;
	CLRF       _direccion_motores+1
;seguidor3.c,121 :: 		suma = velocidad;
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
;seguidor3.c,122 :: 		}else{
	GOTO       L_controlador29
L_controlador28:
;seguidor3.c,123 :: 		suma = 80;
	MOVLW      0
	MOVWF      controlador_suma_L0+0
	MOVLW      0
	MOVWF      controlador_suma_L0+1
	MOVLW      32
	MOVWF      controlador_suma_L0+2
	MOVLW      133
	MOVWF      controlador_suma_L0+3
;seguidor3.c,124 :: 		direccion_motores[0] = ultima_vuelta;
	MOVF       _ultima_vuelta+0, 0
	MOVWF      _direccion_motores+0
;seguidor3.c,125 :: 		direccion_motores[1] = !ultima_vuelta;
	MOVF       _ultima_vuelta+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      _direccion_motores+1
;seguidor3.c,126 :: 		}
L_controlador29:
;seguidor3.c,127 :: 		}
L_controlador25:
L_controlador23:
;seguidor3.c,128 :: 		suma = suma > 255 ? 255 : suma;
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
	GOTO       L_controlador30
	MOVLW      255
	MOVWF      ?FLOC___controladorT91+0
	GOTO       L_controlador31
L_controlador30:
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
	MOVWF      ?FLOC___controladorT91+0
L_controlador31:
	MOVF       ?FLOC___controladorT91+0, 0
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
;seguidor3.c,129 :: 		pwm_motores[0] = (char) suma;
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
;seguidor3.c,130 :: 		pwm_motores[1] = (char) suma;
	MOVF       R0+0, 0
	MOVWF      _pwm_motores+1
;seguidor3.c,131 :: 		sumaAnt = suma;
	MOVF       FLOC__controlador+0, 0
	MOVWF      _sumaAnt+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      _sumaAnt+1
	MOVF       FLOC__controlador+2, 0
	MOVWF      _sumaAnt+2
	MOVF       FLOC__controlador+3, 0
	MOVWF      _sumaAnt+3
;seguidor3.c,132 :: 		}
L_end_controlador:
	RETURN
; end of _controlador

_actuadores:

;seguidor3.c,134 :: 		void actuadores(){
;seguidor3.c,136 :: 		PORTD.RD0 = direccion_motores[0];
	BTFSC      _direccion_motores+0, 0
	GOTO       L__actuadores55
	BCF        PORTD+0, 0
	GOTO       L__actuadores56
L__actuadores55:
	BSF        PORTD+0, 0
L__actuadores56:
;seguidor3.c,137 :: 		PORTD.RD1 = !direccion_motores[0];
	MOVF       _direccion_motores+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__actuadores57
	BCF        PORTD+0, 1
	GOTO       L__actuadores58
L__actuadores57:
	BSF        PORTD+0, 1
L__actuadores58:
;seguidor3.c,138 :: 		PORTD.RD2 = direccion_motores[1];
	BTFSC      _direccion_motores+1, 0
	GOTO       L__actuadores59
	BCF        PORTD+0, 2
	GOTO       L__actuadores60
L__actuadores59:
	BSF        PORTD+0, 2
L__actuadores60:
;seguidor3.c,139 :: 		PORTD.RD3 = !direccion_motores[1];
	MOVF       _direccion_motores+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__actuadores61
	BCF        PORTD+0, 3
	GOTO       L__actuadores62
L__actuadores61:
	BSF        PORTD+0, 3
L__actuadores62:
;seguidor3.c,141 :: 		PWM1_Set_Duty(pwm_motores[0]);
	MOVF       _pwm_motores+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;seguidor3.c,142 :: 		PWM2_Set_Duty(pwm_motores[1]);
	MOVF       _pwm_motores+1, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;seguidor3.c,143 :: 		}
L_end_actuadores:
	RETURN
; end of _actuadores
