
_main:

;prueba11850.c,1 :: 		void main() {
;prueba11850.c,2 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;prueba11850.c,3 :: 		PORTB = 0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;prueba11850.c,4 :: 		Delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;prueba11850.c,5 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;prueba11850.c,6 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
