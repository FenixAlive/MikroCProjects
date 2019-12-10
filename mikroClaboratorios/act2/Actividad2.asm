
_main:

;Actividad2.c,1 :: 		void main() {
;Actividad2.c,2 :: 		TRISC=0x00;
	CLRF       TRISC+0
;Actividad2.c,4 :: 		OPTION_REG = OPTION_REG & 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;Actividad2.c,5 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;Actividad2.c,6 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Actividad2.c,7 :: 		while(1){
L_main0:
;Actividad2.c,8 :: 		PORTC=PORTB;
	MOVF       PORTB+0, 0
	MOVWF      PORTC+0
;Actividad2.c,9 :: 		}
	GOTO       L_main0
;Actividad2.c,10 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
