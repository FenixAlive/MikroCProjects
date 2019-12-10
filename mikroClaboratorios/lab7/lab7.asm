
_main:

;lab7.c,2 :: 		void main() {
;lab7.c,6 :: 		OPTION_REG = 0b10111000;
	MOVLW      184
	MOVWF      OPTION_REG+0
;lab7.c,8 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;lab7.c,9 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;lab7.c,10 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;lab7.c,12 :: 		while(1){
L_main0:
;lab7.c,13 :: 		PORTC = TMR0;
	MOVF       TMR0+0, 0
	MOVWF      PORTC+0
;lab7.c,14 :: 		}
	GOTO       L_main0
;lab7.c,16 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
