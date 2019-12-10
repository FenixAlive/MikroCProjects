
_revisaBoton:

;Lab3y4.c,1 :: 		void revisaBoton(int* presionar) {
;Lab3y4.c,3 :: 		if(!PORTD.RC7){
	BTFSC      PORTD+0, 7
	GOTO       L_revisaBoton0
;Lab3y4.c,4 :: 		delay_ms(130);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      82
	MOVWF      R12+0
	MOVLW      166
	MOVWF      R13+0
L_revisaBoton1:
	DECFSZ     R13+0, 1
	GOTO       L_revisaBoton1
	DECFSZ     R12+0, 1
	GOTO       L_revisaBoton1
	DECFSZ     R11+0, 1
	GOTO       L_revisaBoton1
	NOP
;Lab3y4.c,5 :: 		if(!PORTD.RC7){
	BTFSC      PORTD+0, 7
	GOTO       L_revisaBoton2
;Lab3y4.c,7 :: 		(*presionar) ^= 1;
	MOVF       FARG_revisaBoton_presionar+0, 0
	MOVWF      FSR
	MOVLW      1
	XORWF      INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 1
	MOVF       FARG_revisaBoton_presionar+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Lab3y4.c,9 :: 		PORTC = 0;
	CLRF       PORTC+0
;Lab3y4.c,10 :: 		}
L_revisaBoton2:
;Lab3y4.c,11 :: 		}
L_revisaBoton0:
;Lab3y4.c,12 :: 		}
L_end_revisaBoton:
	RETURN
; end of _revisaBoton

_main:

;Lab3y4.c,14 :: 		void main() {
;Lab3y4.c,17 :: 		int presionar = 0;
	CLRF       main_presionar_L0+0
	CLRF       main_presionar_L0+1
;Lab3y4.c,19 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;Lab3y4.c,21 :: 		PORTC = 0;
	CLRF       PORTC+0
;Lab3y4.c,25 :: 		OPTION_REG = OPTION_REG & 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;Lab3y4.c,27 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;Lab3y4.c,29 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Lab3y4.c,31 :: 		TRISD.RC7 = 1;
	BSF        TRISD+0, 7
;Lab3y4.c,33 :: 		while(1) {
L_main3:
;Lab3y4.c,35 :: 		revisaBoton(&presionar);
	MOVLW      main_presionar_L0+0
	MOVWF      FARG_revisaBoton_presionar+0
	CALL       _revisaBoton+0
;Lab3y4.c,37 :: 		if(presionar){
	MOVF       main_presionar_L0+0, 0
	IORWF      main_presionar_L0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;Lab3y4.c,39 :: 		if(PORTB.RB0) {
	BTFSS      PORTB+0, 0
	GOTO       L_main6
;Lab3y4.c,42 :: 		PORTC=PORTB & 0x77;
	MOVLW      119
	ANDWF      PORTB+0, 0
	MOVWF      PORTC+0
;Lab3y4.c,44 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;Lab3y4.c,46 :: 		PORTC = 0x01;
	MOVLW      1
	MOVWF      PORTC+0
;Lab3y4.c,48 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;Lab3y4.c,49 :: 		}else {
	GOTO       L_main9
L_main6:
;Lab3y4.c,51 :: 		PORTC = 0;
	CLRF       PORTC+0
;Lab3y4.c,52 :: 		}
L_main9:
;Lab3y4.c,53 :: 		} else {
	GOTO       L_main10
L_main5:
;Lab3y4.c,61 :: 		PORTC.RC0 ^= 1;
	MOVLW      1
	XORWF      PORTC+0, 1
;Lab3y4.c,63 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;Lab3y4.c,64 :: 		}
L_main10:
;Lab3y4.c,65 :: 		}
	GOTO       L_main3
;Lab3y4.c,66 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
