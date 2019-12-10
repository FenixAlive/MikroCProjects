
_main:

;Lab4.c,1 :: 		void main() {
;Lab4.c,3 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;Lab4.c,7 :: 		OPTION_REG = OPTION_REG & 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;Lab4.c,9 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;Lab4.c,11 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Lab4.c,13 :: 		while(1) {
L_main0:
;Lab4.c,15 :: 		if(PORTB.RB0) {
	BTFSS      PORTB+0, 0
	GOTO       L_main2
;Lab4.c,18 :: 		PORTC=PORTB & 0x77;
	MOVLW      119
	ANDWF      PORTB+0, 0
	MOVWF      PORTC+0
;Lab4.c,20 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
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
;Lab4.c,22 :: 		PORTC = 0x01;
	MOVLW      1
	MOVWF      PORTC+0
;Lab4.c,24 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;Lab4.c,25 :: 		}else {
	GOTO       L_main5
L_main2:
;Lab4.c,27 :: 		PORTC = 0;
	CLRF       PORTC+0
;Lab4.c,28 :: 		}
L_main5:
;Lab4.c,29 :: 		}
	GOTO       L_main0
;Lab4.c,32 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
