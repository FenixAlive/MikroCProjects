
_main:

;Act1y2.c,1 :: 		void main() {
;Act1y2.c,3 :: 		int presionar = 0;
	CLRF       main_presionar_L0+0
	CLRF       main_presionar_L0+1
;Act1y2.c,5 :: 		TRISC=0x00;
	CLRF       TRISC+0
;Act1y2.c,8 :: 		TRISD |= 0x20;
	BSF        TRISD+0, 5
;Act1y2.c,10 :: 		OPTION_REG = OPTION_REG & 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;Act1y2.c,12 :: 		ANSEL = 0x00;
	CLRF       ANSEL+0
;Act1y2.c,13 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;Act1y2.c,16 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;Act1y2.c,18 :: 		while(1){
L_main0:
;Act1y2.c,20 :: 		if(!PORTD.RC7){
	BTFSC      PORTD+0, 7
	GOTO       L_main2
;Act1y2.c,21 :: 		delay_ms(130);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      82
	MOVWF      R12+0
	MOVLW      166
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;Act1y2.c,22 :: 		if(!PORTD.RC7){
	BTFSC      PORTD+0, 7
	GOTO       L_main4
;Act1y2.c,24 :: 		presionar = !presionar; //? 0 : 1;
	MOVF       main_presionar_L0+0, 0
	IORWF      main_presionar_L0+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      main_presionar_L0+0
	MOVWF      main_presionar_L0+1
	MOVLW      0
	MOVWF      main_presionar_L0+1
;Act1y2.c,25 :: 		}
L_main4:
;Act1y2.c,26 :: 		}
L_main2:
;Act1y2.c,27 :: 		if(presionar){
	MOVF       main_presionar_L0+0, 0
	IORWF      main_presionar_L0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;Act1y2.c,28 :: 		PORTC=PORTB;
	MOVF       PORTB+0, 0
	MOVWF      PORTC+0
;Act1y2.c,29 :: 		}else{
	GOTO       L_main6
L_main5:
;Act1y2.c,30 :: 		PORTC=0x055;
	MOVLW      85
	MOVWF      PORTC+0
;Act1y2.c,31 :: 		}
L_main6:
;Act1y2.c,33 :: 		}
	GOTO       L_main0
;Act1y2.c,34 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
