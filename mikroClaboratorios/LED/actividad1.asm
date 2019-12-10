
_main:

;actividad1.c,1 :: 		void main() {
;actividad1.c,3 :: 		TRISC=0x00;
	CLRF       TRISC+0
;actividad1.c,5 :: 		PORTC=0x055;
	MOVLW      85
	MOVWF      PORTC+0
;actividad1.c,8 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
