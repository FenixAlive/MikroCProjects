
_main:

;lab8y9.c,4 :: 		void main() {
;lab8y9.c,6 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;lab8y9.c,7 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;lab8y9.c,8 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;lab8y9.c,9 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;lab8y9.c,12 :: 		TRISA.RA0 = 1;
	BSF        TRISA+0, 0
;lab8y9.c,13 :: 		ANSEL.RA0 = 1;
	BSF        ANSEL+0, 0
;lab8y9.c,15 :: 		ADCON0.ADCS1 = 1;
	BSF        ADCON0+0, 7
;lab8y9.c,16 :: 		ADCON0.ADCS0 = 1;
	BSF        ADCON0+0, 6
;lab8y9.c,17 :: 		ADCON1.ADFM = 1;
	BSF        ADCON1+0, 7
;lab8y9.c,18 :: 		ADCON0.ADON = 1;
	BSF        ADCON0+0, 0
;lab8y9.c,19 :: 		while(1){
L_main0:
;lab8y9.c,21 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
	NOP
;lab8y9.c,23 :: 		ADCON0.GO_DONE=1;
	BSF        ADCON0+0, 1
;lab8y9.c,24 :: 		while(ADCON0.GO_DONE){
L_main3:
	BTFSS      ADCON0+0, 1
	GOTO       L_main4
;lab8y9.c,26 :: 		}
	GOTO       L_main3
L_main4:
;lab8y9.c,27 :: 		if(++contprom > totprom){
	INCF       _contprom+0, 1
	MOVF       _contprom+0, 0
	SUBWF      _totprom+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;lab8y9.c,28 :: 		valsum /= totprom+1;
	MOVF       _totprom+0, 0
	ADDLW      1
	MOVWF      R4+0
	CLRF       R4+1
	BTFSC      STATUS+0, 0
	INCF       R4+1, 1
	MOVF       _valsum+0, 0
	MOVWF      R0+0
	MOVF       _valsum+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _valsum+0
	MOVF       R0+1, 0
	MOVWF      _valsum+1
;lab8y9.c,29 :: 		PORTC = valsum % 256;
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	ANDWF      R2+1, 1
	MOVF       R2+0, 0
	MOVWF      PORTC+0
;lab8y9.c,30 :: 		PORTD = valsum / 256;
	MOVF       R0+1, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	MOVWF      PORTD+0
;lab8y9.c,31 :: 		valsum = 0;
	CLRF       _valsum+0
	CLRF       _valsum+1
;lab8y9.c,32 :: 		contprom = 0;
	CLRF       _contprom+0
;lab8y9.c,33 :: 		}
L_main5:
;lab8y9.c,34 :: 		valsum += ADRESL+ADRESH*256;
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      _valsum+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _valsum+1, 1
;lab8y9.c,35 :: 		}
	GOTO       L_main0
;lab8y9.c,36 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
