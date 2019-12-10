
_main:

;led.c,1 :: 		void main() {
;led.c,3 :: 		TRISC=0x00;
	CLRF       TRISC+0
;led.c,5 :: 		PORTC=0x055;
	MOVLW      85
	MOVWF      PORTC+0
;led.c,14 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
