
_main:

;Lab3.c,1 :: 		void main() {
;Lab3.c,3 :: 		TRISC.RC0 = 0;
	BCF        TRISC+0, 0
;Lab3.c,5 :: 		while(1){
L_main0:
;Lab3.c,12 :: 		PORTC.RC0 ^= 1;
	MOVLW      1
	XORWF      PORTC+0, 1
;Lab3.c,14 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
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
;Lab3.c,15 :: 		}
	GOTO       L_main0
;Lab3.c,16 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
