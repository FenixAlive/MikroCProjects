
_main:

;seguidor1.c,49 :: 		void main() {
;seguidor1.c,50 :: 		ANSEL = 0xFF;
	MOVLW      255
	MOVWF      ANSEL+0
;seguidor1.c,51 :: 		ANSELH = 0x00; //por ahora solo los 8 sensores como analogos
	CLRF       ANSELH+0
;seguidor1.c,52 :: 		C1ON_bit = 0;               // apago comparadores
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;seguidor1.c,53 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;seguidor1.c,55 :: 		TRISA  = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;seguidor1.c,57 :: 		OPTION_REG &= 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;seguidor1.c,60 :: 		TRISB = 0x7F;
	MOVLW      127
	MOVWF      TRISB+0
;seguidor1.c,61 :: 		PORTB = 0x7F;
	MOVLW      127
	MOVWF      PORTB+0
;seguidor1.c,62 :: 		TRISC = 0;                          // salidas puerto C
	CLRF       TRISC+0
;seguidor1.c,63 :: 		PORTC = 0;                          // poner PORTC en 0
	CLRF       PORTC+0
;seguidor1.c,66 :: 		if(!(PORTB & 0x02)){
	BTFSC      PORTB+0, 1
	GOTO       L_main0
;seguidor1.c,67 :: 		PWM1_Init(5000);                    // Initializar PWM1 a 5KHz
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;seguidor1.c,68 :: 		PWM2_Init(5000);                    // Initializar PWM2 a 5KHz
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;seguidor1.c,70 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;seguidor1.c,71 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;seguidor1.c,73 :: 		iniciar_seguidor();
	CALL       _iniciar_seguidor+0
;seguidor1.c,74 :: 		buzzer();
	CALL       _buzzer+0
;seguidor1.c,75 :: 		Delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
	NOP
;seguidor1.c,76 :: 		buzzer();
	CALL       _buzzer+0
;seguidor1.c,77 :: 		Delay_ms(300);
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
;seguidor1.c,78 :: 		buzzer();
	CALL       _buzzer+0
;seguidor1.c,79 :: 		Delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;seguidor1.c,80 :: 		while(1){
L_main4:
;seguidor1.c,81 :: 		leer_sensores();
	CALL       _leer_sensores+0
;seguidor1.c,82 :: 		controlador();
	CALL       _controlador+0
;seguidor1.c,83 :: 		actuadores();
	CALL       _actuadores+0
;seguidor1.c,84 :: 		}
	GOTO       L_main4
;seguidor1.c,85 :: 		}else{
L_main0:
;seguidor1.c,86 :: 		buzzer();
	CALL       _buzzer+0
;seguidor1.c,87 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
;seguidor1.c,88 :: 		while(1){
L_main8:
;seguidor1.c,89 :: 		if(!(PORTB & 0x08)){
	BTFSC      PORTB+0, 3
	GOTO       L_main10
;seguidor1.c,90 :: 		calibrar_sensor();
	CALL       _calibrar_sensor+0
;seguidor1.c,91 :: 		}
L_main10:
;seguidor1.c,92 :: 		}
	GOTO       L_main8
;seguidor1.c,94 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_leer_sensores:

;seguidor1.c,96 :: 		void leer_sensores(){
;seguidor1.c,97 :: 		char cuantosSam = 9;
	MOVLW      9
	MOVWF      leer_sensores_cuantosSam_L0+0
;seguidor1.c,99 :: 		for(i=0;i<8;i++){
	CLRF       _i+0
L_leer_sensores11:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores12
;seguidor1.c,100 :: 		sensoresPrin[i] = 0;
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;seguidor1.c,99 :: 		for(i=0;i<8;i++){
	INCF       _i+0, 1
;seguidor1.c,101 :: 		}
	GOTO       L_leer_sensores11
L_leer_sensores12:
;seguidor1.c,103 :: 		for(i=0;i<cuantosSam;i++){
	CLRF       _i+0
L_leer_sensores14:
	MOVF       leer_sensores_cuantosSam_L0+0, 0
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores15
;seguidor1.c,104 :: 		for(j=0;j<8;j++){
	CLRF       _j+0
L_leer_sensores17:
	MOVLW      8
	SUBWF      _j+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores18
;seguidor1.c,105 :: 		sensoresPrin[j] += ADC_Read(j);
	MOVF       _j+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FLOC__leer_sensores+0
	MOVF       _j+0, 0
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       FLOC__leer_sensores+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
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
;seguidor1.c,104 :: 		for(j=0;j<8;j++){
	INCF       _j+0, 1
;seguidor1.c,106 :: 		}
	GOTO       L_leer_sensores17
L_leer_sensores18:
;seguidor1.c,103 :: 		for(i=0;i<cuantosSam;i++){
	INCF       _i+0, 1
;seguidor1.c,107 :: 		}
	GOTO       L_leer_sensores14
L_leer_sensores15:
;seguidor1.c,109 :: 		for(i=0;i<8;i++){
	CLRF       _i+0
L_leer_sensores20:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_leer_sensores21
;seguidor1.c,110 :: 		sensoresPrin[i] /= cuantosSam;
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FLOC__leer_sensores+0
	MOVF       FLOC__leer_sensores+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVF       leer_sensores_cuantosSam_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16X16_U+0
	MOVF       FLOC__leer_sensores+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;seguidor1.c,109 :: 		for(i=0;i<8;i++){
	INCF       _i+0, 1
;seguidor1.c,111 :: 		}
	GOTO       L_leer_sensores20
L_leer_sensores21:
;seguidor1.c,112 :: 		}
L_end_leer_sensores:
	RETURN
; end of _leer_sensores

_controlador:

;seguidor1.c,169 :: 		void controlador(){
;seguidor1.c,170 :: 		int suma = 0;
	CLRF       controlador_suma_L0+0
	CLRF       controlador_suma_L0+1
	CLRF       controlador_dd_L0+0
	CLRF       controlador_dd_L0+1
;seguidor1.c,173 :: 		for(i=0;i<4;i++){
	CLRF       _i+0
L_controlador23:
	MOVLW      4
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_controlador24
;seguidor1.c,174 :: 		suma += (sensoresPrin[7-i] - sensoresPrin[i]) * (4-i);
	MOVF       _i+0, 0
	SUBLW      7
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
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
	MOVWF      R2+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R2+1
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _sensoresPrin+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R2+0, 0
	MOVWF      R4+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R2+1, 0
	MOVWF      R4+1
	MOVF       _i+0, 0
	SUBLW      4
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDWF      controlador_suma_L0+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      controlador_suma_L0+1, 1
;seguidor1.c,173 :: 		for(i=0;i<4;i++){
	INCF       _i+0, 1
;seguidor1.c,175 :: 		}
	GOTO       L_controlador23
L_controlador24:
;seguidor1.c,176 :: 		dd = suma;
	MOVF       controlador_suma_L0+0, 0
	MOVWF      controlador_dd_L0+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      controlador_dd_L0+1
;seguidor1.c,177 :: 		acumInt += suma;
	MOVF       controlador_suma_L0+0, 0
	ADDWF      _acumInt+0, 0
	MOVWF      FLOC__controlador+8
	MOVF       _acumInt+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      controlador_suma_L0+1, 0
	MOVWF      FLOC__controlador+9
	MOVF       FLOC__controlador+8, 0
	MOVWF      _acumInt+0
	MOVF       FLOC__controlador+9, 0
	MOVWF      _acumInt+1
;seguidor1.c,179 :: 		suma = (Kp*suma+ Kd*(suma-errorAnt)/10 + Ki*acumInt)*255/10000;
	MOVF       controlador_suma_L0+0, 0
	MOVWF      R0+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FLOC__controlador+4
	MOVF       R0+1, 0
	MOVWF      FLOC__controlador+5
	MOVF       R0+2, 0
	MOVWF      FLOC__controlador+6
	MOVF       R0+3, 0
	MOVWF      FLOC__controlador+7
	MOVF       _Kp+0, 0
	MOVWF      R0+0
	MOVF       _Kp+1, 0
	MOVWF      R0+1
	MOVF       _Kp+2, 0
	MOVWF      R0+2
	MOVF       _Kp+3, 0
	MOVWF      R0+3
	MOVF       FLOC__controlador+4, 0
	MOVWF      R4+0
	MOVF       FLOC__controlador+5, 0
	MOVWF      R4+1
	MOVF       FLOC__controlador+6, 0
	MOVWF      R4+2
	MOVF       FLOC__controlador+7, 0
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
	MOVF       _errorAnt+0, 0
	MOVWF      R4+0
	MOVF       _errorAnt+1, 0
	MOVWF      R4+1
	MOVF       _errorAnt+2, 0
	MOVWF      R4+2
	MOVF       _errorAnt+3, 0
	MOVWF      R4+3
	MOVF       FLOC__controlador+4, 0
	MOVWF      R0+0
	MOVF       FLOC__controlador+5, 0
	MOVWF      R0+1
	MOVF       FLOC__controlador+6, 0
	MOVWF      R0+2
	MOVF       FLOC__controlador+7, 0
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
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
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
	MOVWF      FLOC__controlador+0
	MOVF       R0+1, 0
	MOVWF      FLOC__controlador+1
	MOVF       R0+2, 0
	MOVWF      FLOC__controlador+2
	MOVF       R0+3, 0
	MOVWF      FLOC__controlador+3
	MOVF       FLOC__controlador+8, 0
	MOVWF      R0+0
	MOVF       FLOC__controlador+9, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVF       _Ki+0, 0
	MOVWF      R4+0
	MOVF       _Ki+1, 0
	MOVWF      R4+1
	MOVF       _Ki+2, 0
	MOVWF      R4+2
	MOVF       _Ki+3, 0
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
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FLOC__controlador+0
	MOVF       R0+1, 0
	MOVWF      FLOC__controlador+1
	MOVF       FLOC__controlador+0, 0
	MOVWF      controlador_suma_L0+0
	MOVF       FLOC__controlador+1, 0
	MOVWF      controlador_suma_L0+1
;seguidor1.c,181 :: 		errorAnt = dd;
	MOVF       controlador_dd_L0+0, 0
	MOVWF      R0+0
	MOVF       controlador_dd_L0+1, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _errorAnt+0
	MOVF       R0+1, 0
	MOVWF      _errorAnt+1
	MOVF       R0+2, 0
	MOVWF      _errorAnt+2
	MOVF       R0+3, 0
	MOVWF      _errorAnt+3
;seguidor1.c,183 :: 		suma = suma > 255 ? 255 : suma;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FLOC__controlador+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador36
	MOVF       FLOC__controlador+0, 0
	SUBLW      255
L__controlador36:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador26
	MOVLW      255
	MOVWF      ?FLOC___controladorT57+0
	CLRF       ?FLOC___controladorT57+1
	GOTO       L_controlador27
L_controlador26:
	MOVF       controlador_suma_L0+0, 0
	MOVWF      ?FLOC___controladorT57+0
	MOVF       controlador_suma_L0+1, 0
	MOVWF      ?FLOC___controladorT57+1
L_controlador27:
	MOVF       ?FLOC___controladorT57+0, 0
	MOVWF      controlador_suma_L0+0
	MOVF       ?FLOC___controladorT57+1, 0
	MOVWF      controlador_suma_L0+1
;seguidor1.c,184 :: 		suma += velocidad;
	MOVF       _velocidad+0, 0
	ADDWF      ?FLOC___controladorT57+0, 0
	MOVWF      R1+0
	MOVF       ?FLOC___controladorT57+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      controlador_suma_L0+0
	MOVF       R1+1, 0
	MOVWF      controlador_suma_L0+1
;seguidor1.c,185 :: 		if( suma > 0){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador37
	MOVF       R1+0, 0
	SUBLW      0
L__controlador37:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador28
;seguidor1.c,186 :: 		direccion_motores[0] = 0;
	CLRF       _direccion_motores+0
;seguidor1.c,187 :: 		direccion_motores[1] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+1
;seguidor1.c,188 :: 		}else if (suma < 0){
	GOTO       L_controlador29
L_controlador28:
	MOVLW      128
	XORWF      controlador_suma_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__controlador38
	MOVLW      0
	SUBWF      controlador_suma_L0+0, 0
L__controlador38:
	BTFSC      STATUS+0, 0
	GOTO       L_controlador30
;seguidor1.c,189 :: 		direccion_motores[0] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+0
;seguidor1.c,190 :: 		direccion_motores[1] = 0;
	CLRF       _direccion_motores+1
;seguidor1.c,191 :: 		suma = -suma;
	MOVF       controlador_suma_L0+0, 0
	SUBLW      0
	MOVWF      controlador_suma_L0+0
	MOVF       controlador_suma_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       controlador_suma_L0+1
	SUBWF      controlador_suma_L0+1, 1
;seguidor1.c,192 :: 		}else{
	GOTO       L_controlador31
L_controlador30:
;seguidor1.c,193 :: 		direccion_motores[0] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+0
;seguidor1.c,194 :: 		direccion_motores[1] = 1;
	MOVLW      1
	MOVWF      _direccion_motores+1
;seguidor1.c,195 :: 		}
L_controlador31:
L_controlador29:
;seguidor1.c,197 :: 		pwm_motores[0] =  suma;
	MOVF       controlador_suma_L0+0, 0
	MOVWF      _pwm_motores+0
;seguidor1.c,198 :: 		pwm_motores[1] =  suma;
	MOVF       controlador_suma_L0+0, 0
	MOVWF      _pwm_motores+1
;seguidor1.c,199 :: 		}
L_end_controlador:
	RETURN
; end of _controlador

_actuadores:

;seguidor1.c,202 :: 		void actuadores(){
;seguidor1.c,205 :: 		PORTD.RD0 = direccion_motores[0];
	BTFSC      _direccion_motores+0, 0
	GOTO       L__actuadores40
	BCF        PORTD+0, 0
	GOTO       L__actuadores41
L__actuadores40:
	BSF        PORTD+0, 0
L__actuadores41:
;seguidor1.c,206 :: 		PORTD.RD1 = !direccion_motores[0];
	MOVF       _direccion_motores+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__actuadores42
	BCF        PORTD+0, 1
	GOTO       L__actuadores43
L__actuadores42:
	BSF        PORTD+0, 1
L__actuadores43:
;seguidor1.c,207 :: 		PORTD.RD2 = direccion_motores[1];
	BTFSC      _direccion_motores+1, 0
	GOTO       L__actuadores44
	BCF        PORTD+0, 2
	GOTO       L__actuadores45
L__actuadores44:
	BSF        PORTD+0, 2
L__actuadores45:
;seguidor1.c,208 :: 		PORTD.RD3 = !direccion_motores[1];
	MOVF       _direccion_motores+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__actuadores46
	BCF        PORTD+0, 3
	GOTO       L__actuadores47
L__actuadores46:
	BSF        PORTD+0, 3
L__actuadores47:
;seguidor1.c,210 :: 		PWM1_Set_Duty(pwm_motores[0]);        // Set current duty for PWM1
	MOVF       _pwm_motores+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;seguidor1.c,211 :: 		PWM2_Set_Duty(pwm_motores[1]);       // Set current duty for PWM2
	MOVF       _pwm_motores+1, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;seguidor1.c,212 :: 		}
L_end_actuadores:
	RETURN
; end of _actuadores

_iniciar_seguidor:

;seguidor1.c,214 :: 		void iniciar_seguidor(){
;seguidor1.c,216 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;seguidor1.c,218 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;seguidor1.c,220 :: 		PORTD.RD0 = direccion_motores[0];
	BTFSC      _direccion_motores+0, 0
	GOTO       L__iniciar_seguidor49
	BCF        PORTD+0, 0
	GOTO       L__iniciar_seguidor50
L__iniciar_seguidor49:
	BSF        PORTD+0, 0
L__iniciar_seguidor50:
;seguidor1.c,221 :: 		PORTD.RD1 = !direccion_motores[0];
	MOVF       _direccion_motores+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__iniciar_seguidor51
	BCF        PORTD+0, 1
	GOTO       L__iniciar_seguidor52
L__iniciar_seguidor51:
	BSF        PORTD+0, 1
L__iniciar_seguidor52:
;seguidor1.c,222 :: 		PORTD.RD2 = direccion_motores[1];
	BTFSC      _direccion_motores+1, 0
	GOTO       L__iniciar_seguidor53
	BCF        PORTD+0, 2
	GOTO       L__iniciar_seguidor54
L__iniciar_seguidor53:
	BSF        PORTD+0, 2
L__iniciar_seguidor54:
;seguidor1.c,223 :: 		PORTD.RD3 = !direccion_motores[1];
	MOVF       _direccion_motores+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__iniciar_seguidor55
	BCF        PORTD+0, 3
	GOTO       L__iniciar_seguidor56
L__iniciar_seguidor55:
	BSF        PORTD+0, 3
L__iniciar_seguidor56:
;seguidor1.c,224 :: 		PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;seguidor1.c,225 :: 		PWM2_Start();                       // start PWM2
	CALL       _PWM2_Start+0
;seguidor1.c,226 :: 		PWM1_Set_Duty(pwm_motores[0]);        // Set current duty for PWM1
	MOVF       _pwm_motores+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;seguidor1.c,227 :: 		PWM2_Set_Duty(pwm_motores[1]);       // Set current duty for PWM2
	MOVF       _pwm_motores+1, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;seguidor1.c,228 :: 		}
L_end_iniciar_seguidor:
	RETURN
; end of _iniciar_seguidor

_calibrar_sensor:

;seguidor1.c,230 :: 		void calibrar_sensor(){buzzer();}
	CALL       _buzzer+0
L_end_calibrar_sensor:
	RETURN
; end of _calibrar_sensor

_velocidades:

;seguidor1.c,267 :: 		void velocidades(){}
L_end_velocidades:
	RETURN
; end of _velocidades

_buzzer:

;seguidor1.c,269 :: 		void buzzer(){
;seguidor1.c,270 :: 		PORTB.RB7 = 1;
	BSF        PORTB+0, 7
;seguidor1.c,271 :: 		Delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_buzzer32:
	DECFSZ     R13+0, 1
	GOTO       L_buzzer32
	DECFSZ     R12+0, 1
	GOTO       L_buzzer32
	DECFSZ     R11+0, 1
	GOTO       L_buzzer32
	NOP
	NOP
;seguidor1.c,272 :: 		PORTB.RB7 = 0;
	BCF        PORTB+0, 7
;seguidor1.c,273 :: 		}
L_end_buzzer:
	RETURN
; end of _buzzer
