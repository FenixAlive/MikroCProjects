
_main:

;navidad.c,4 :: 		void main() {
;navidad.c,5 :: 		ANSEL  = 0x01;
	MOVLW      1
	MOVWF      ANSEL+0
;navidad.c,6 :: 		C1ON_bit = 0;               // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;navidad.c,7 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;navidad.c,8 :: 		TRISA  = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;navidad.c,9 :: 		OPTION_REG = OPTION_REG & 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;navidad.c,10 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;navidad.c,11 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;navidad.c,13 :: 		TRISC = 0x01;
	MOVLW      1
	MOVWF      TRISC+0
;navidad.c,14 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;navidad.c,15 :: 		if(!PORTB.RB2){
	BTFSC      PORTB+0, 2
	GOTO       L_main0
;navidad.c,16 :: 		while(1){
L_main1:
;navidad.c,17 :: 		if(!(PORTB.RB1)){
	BTFSC      PORTB+0, 1
	GOTO       L_main3
;navidad.c,18 :: 		luz = 0;
	CLRF       _luz+0
	CLRF       _luz+1
	CLRF       _luz+2
	CLRF       _luz+3
;navidad.c,19 :: 		for(i=0;i<5;i++){
	CLRF       _i+0
	CLRF       _i+1
L_main4:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main20
	MOVLW      5
	SUBWF      _i+0, 0
L__main20:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;navidad.c,20 :: 		luz += ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       _luz+0, 0
	MOVWF      R4+0
	MOVF       _luz+1, 0
	MOVWF      R4+1
	MOVF       _luz+2, 0
	MOVWF      R4+2
	MOVF       _luz+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _luz+0
	MOVF       R0+1, 0
	MOVWF      _luz+1
	MOVF       R0+2, 0
	MOVWF      _luz+2
	MOVF       R0+3, 0
	MOVWF      _luz+3
;navidad.c,19 :: 		for(i=0;i<5;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;navidad.c,21 :: 		}
	GOTO       L_main4
L_main5:
;navidad.c,22 :: 		luz = luz / 5;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _luz+0, 0
	MOVWF      R0+0
	MOVF       _luz+1, 0
	MOVWF      R0+1
	MOVF       _luz+2, 0
	MOVWF      R0+2
	MOVF       _luz+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _luz+0
	MOVF       R0+1, 0
	MOVWF      _luz+1
	MOVF       R0+2, 0
	MOVWF      _luz+2
	MOVF       R0+3, 0
	MOVWF      _luz+3
;navidad.c,23 :: 		if(luz < 600){
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      22
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main7
;navidad.c,24 :: 		if(PORTC && 0x01){
	MOVF       PORTC+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
L__main18:
;navidad.c,25 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
;navidad.c,26 :: 		if(PORTC && 0x01){
	MOVF       PORTC+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
L__main17:
;navidad.c,27 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
;navidad.c,28 :: 		Delay_ms(30000);
	MOVLW      2
	MOVWF      R10+0
	MOVLW      49
	MOVWF      R11+0
	MOVLW      98
	MOVWF      R12+0
	MOVLW      69
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	DECFSZ     R10+0, 1
	GOTO       L_main15
;navidad.c,29 :: 		}
L_main14:
;navidad.c,30 :: 		}
L_main10:
;navidad.c,31 :: 		}
L_main7:
;navidad.c,32 :: 		PORTC.RC1 = 0;
	BCF        PORTC+0, 1
;navidad.c,33 :: 		}else{
	GOTO       L_main16
L_main3:
;navidad.c,34 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
;navidad.c,35 :: 		}
L_main16:
;navidad.c,36 :: 		}
	GOTO       L_main1
;navidad.c,37 :: 		}
L_main0:
;navidad.c,38 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
