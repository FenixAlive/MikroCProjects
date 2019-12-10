
_main:

;RelojBinario.c,1 :: 		void main() {
;RelojBinario.c,3 :: 		long tiempo = 0;
	CLRF       main_tiempo_L0+0
	CLRF       main_tiempo_L0+1
	CLRF       main_tiempo_L0+2
	CLRF       main_tiempo_L0+3
	CLRF       main_temp_L0+0
	CLRF       main_temp_L0+1
	CLRF       main_temp_L0+2
	CLRF       main_temp_L0+3
	CLRF       main_set_L0+0
	CLRF       main_set_L0+1
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;RelojBinario.c,11 :: 		ANSEL = 0x00;
	CLRF       ANSEL+0
;RelojBinario.c,12 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;RelojBinario.c,15 :: 		TRISA &= 0xC0;
	MOVLW      192
	ANDWF      TRISA+0, 1
;RelojBinario.c,16 :: 		TRISC &= 0xC0;
	MOVLW      192
	ANDWF      TRISC+0, 1
;RelojBinario.c,17 :: 		TRISD &= 0xE0;
	MOVLW      224
	ANDWF      TRISD+0, 1
;RelojBinario.c,19 :: 		TRISB.RB7 = 1;
	BSF        TRISB+0, 7
;RelojBinario.c,21 :: 		TRISB.RB6 = 0;
	BCF        TRISB+0, 6
;RelojBinario.c,24 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;RelojBinario.c,26 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;RelojBinario.c,28 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;RelojBinario.c,29 :: 		PORTB.RB6 = 0;
	BCF        PORTB+0, 6
;RelojBinario.c,31 :: 		while(1) {
L_main0:
;RelojBinario.c,33 :: 		if(!PORTB.RB7) {
	BTFSC      PORTB+0, 7
	GOTO       L_main2
;RelojBinario.c,34 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
	NOP
;RelojBinario.c,35 :: 		if(!PORTB.RB7) {
	BTFSC      PORTB+0, 7
	GOTO       L_main4
;RelojBinario.c,36 :: 		for(i = 0; i<13;i++){
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main5:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main36
	MOVLW      13
	SUBWF      main_i_L0+0, 0
L__main36:
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;RelojBinario.c,37 :: 		delay_ms(70);
	MOVLW      182
	MOVWF      R12+0
	MOVLW      208
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	NOP
;RelojBinario.c,38 :: 		if(PORTB.RB7){
	BTFSS      PORTB+0, 7
	GOTO       L_main9
;RelojBinario.c,39 :: 		temp++;
	MOVF       main_temp_L0+0, 0
	MOVWF      R0+0
	MOVF       main_temp_L0+1, 0
	MOVWF      R0+1
	MOVF       main_temp_L0+2, 0
	MOVWF      R0+2
	MOVF       main_temp_L0+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      main_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temp_L0+1
	MOVF       R0+2, 0
	MOVWF      main_temp_L0+2
	MOVF       R0+3, 0
	MOVWF      main_temp_L0+3
;RelojBinario.c,40 :: 		break;
	GOTO       L_main6
;RelojBinario.c,41 :: 		}
L_main9:
;RelojBinario.c,36 :: 		for(i = 0; i<13;i++){
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;RelojBinario.c,42 :: 		}
	GOTO       L_main5
L_main6:
;RelojBinario.c,43 :: 		}
L_main4:
;RelojBinario.c,44 :: 		if(!PORTB.RB7) {
	BTFSC      PORTB+0, 7
	GOTO       L_main10
;RelojBinario.c,45 :: 		PORTB.RB6 = 0;
	BCF        PORTB+0, 6
;RelojBinario.c,46 :: 		for(i=0;i<3;i++){
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main11:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main37
	MOVLW      3
	SUBWF      main_i_L0+0, 0
L__main37:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
;RelojBinario.c,47 :: 		PORTB.RB6 ^= 1;
	MOVLW      64
	XORWF      PORTB+0, 1
;RelojBinario.c,48 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
;RelojBinario.c,46 :: 		for(i=0;i<3;i++){
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;RelojBinario.c,49 :: 		}
	GOTO       L_main11
L_main12:
;RelojBinario.c,50 :: 		set ++;
	INCF       main_set_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_set_L0+1, 1
;RelojBinario.c,51 :: 		if(set == 1){
	MOVLW      0
	XORWF      main_set_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main38
	MOVLW      1
	XORWF      main_set_L0+0, 0
L__main38:
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;RelojBinario.c,53 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;RelojBinario.c,54 :: 		temp = PORTD & 0b00011111;
	MOVLW      31
	ANDWF      PORTD+0, 0
	MOVWF      main_temp_L0+0
	CLRF       main_temp_L0+1
	MOVLW      0
	ANDWF      main_temp_L0+1, 1
	MOVLW      0
	MOVWF      main_temp_L0+1
	MOVWF      main_temp_L0+2
	MOVWF      main_temp_L0+3
;RelojBinario.c,55 :: 		}else if(set == 2){
	GOTO       L_main16
L_main15:
	MOVLW      0
	XORWF      main_set_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main39
	MOVLW      2
	XORWF      main_set_L0+0, 0
L__main39:
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;RelojBinario.c,57 :: 		PORTD = temp & 0b00011111;
	MOVLW      31
	ANDWF      main_temp_L0+0, 0
	MOVWF      PORTD+0
;RelojBinario.c,58 :: 		temp = PORTC & 0b00111111;
	MOVLW      63
	ANDWF      PORTC+0, 0
	MOVWF      main_temp_L0+0
	CLRF       main_temp_L0+1
	MOVLW      0
	ANDWF      main_temp_L0+1, 1
	MOVLW      0
	MOVWF      main_temp_L0+1
	MOVWF      main_temp_L0+2
	MOVWF      main_temp_L0+3
;RelojBinario.c,59 :: 		}else if(set == 3){
	GOTO       L_main18
L_main17:
	MOVLW      0
	XORWF      main_set_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main40
	MOVLW      3
	XORWF      main_set_L0+0, 0
L__main40:
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;RelojBinario.c,61 :: 		set = 0;
	CLRF       main_set_L0+0
	CLRF       main_set_L0+1
;RelojBinario.c,62 :: 		PORTB.RB6 = 0;
	BCF        PORTB+0, 6
;RelojBinario.c,63 :: 		PORTC = temp & 0b00111111;
	MOVLW      63
	ANDWF      main_temp_L0+0, 0
	MOVWF      PORTC+0
;RelojBinario.c,64 :: 		tiempo = (((long) PORTD)*60 + ((long) temp))*60*10;
	MOVF       PORTD+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVLW      60
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       main_temp_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       main_temp_L0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     main_temp_L0+1, 0
	ADDWF      R0+1, 1
	MOVF       main_temp_L0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     main_temp_L0+2, 0
	ADDWF      R0+2, 1
	MOVF       main_temp_L0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     main_temp_L0+3, 0
	ADDWF      R0+3, 1
	MOVLW      60
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      main_tiempo_L0+0
	MOVF       R0+1, 0
	MOVWF      main_tiempo_L0+1
	MOVF       R0+2, 0
	MOVWF      main_tiempo_L0+2
	MOVF       R0+3, 0
	MOVWF      main_tiempo_L0+3
;RelojBinario.c,65 :: 		temp = 0;
	CLRF       main_temp_L0+0
	CLRF       main_temp_L0+1
	CLRF       main_temp_L0+2
	CLRF       main_temp_L0+3
;RelojBinario.c,66 :: 		}else{
	GOTO       L_main20
L_main19:
;RelojBinario.c,67 :: 		PORTB.RB6 = 0;
	BCF        PORTB+0, 6
;RelojBinario.c,68 :: 		set = 0;
	CLRF       main_set_L0+0
	CLRF       main_set_L0+1
;RelojBinario.c,69 :: 		temp = 0;
	CLRF       main_temp_L0+0
	CLRF       main_temp_L0+1
	CLRF       main_temp_L0+2
	CLRF       main_temp_L0+3
;RelojBinario.c,70 :: 		}
L_main20:
L_main18:
L_main16:
;RelojBinario.c,71 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	DECFSZ     R11+0, 1
	GOTO       L_main21
	NOP
	NOP
;RelojBinario.c,72 :: 		}
L_main10:
;RelojBinario.c,73 :: 		}
L_main2:
;RelojBinario.c,74 :: 		switch (set) {
	GOTO       L_main22
;RelojBinario.c,75 :: 		case 0:
L_main24:
;RelojBinario.c,77 :: 		PORTA = (tiempo/10) % 60;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       main_tiempo_L0+0, 0
	MOVWF      R0+0
	MOVF       main_tiempo_L0+1, 0
	MOVWF      R0+1
	MOVF       main_tiempo_L0+2, 0
	MOVWF      R0+2
	MOVF       main_tiempo_L0+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVLW      60
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;RelojBinario.c,78 :: 		PORTC = (tiempo/(600)) % 60;
	MOVLW      88
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       main_tiempo_L0+0, 0
	MOVWF      R0+0
	MOVF       main_tiempo_L0+1, 0
	MOVWF      R0+1
	MOVF       main_tiempo_L0+2, 0
	MOVWF      R0+2
	MOVF       main_tiempo_L0+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVLW      60
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;RelojBinario.c,79 :: 		PORTD = (tiempo/(36000)) % 24;
	MOVLW      160
	MOVWF      R4+0
	MOVLW      140
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       main_tiempo_L0+0, 0
	MOVWF      R0+0
	MOVF       main_tiempo_L0+1, 0
	MOVWF      R0+1
	MOVF       main_tiempo_L0+2, 0
	MOVWF      R0+2
	MOVF       main_tiempo_L0+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVLW      24
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;RelojBinario.c,80 :: 		break;
	GOTO       L_main23
;RelojBinario.c,81 :: 		case 1:
L_main25:
;RelojBinario.c,82 :: 		if(temp > 23){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_temp_L0+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main41
	MOVF       main_temp_L0+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main41
	MOVF       main_temp_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main41
	MOVF       main_temp_L0+0, 0
	SUBLW      23
L__main41:
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;RelojBinario.c,83 :: 		temp = 0;
	CLRF       main_temp_L0+0
	CLRF       main_temp_L0+1
	CLRF       main_temp_L0+2
	CLRF       main_temp_L0+3
;RelojBinario.c,84 :: 		}
L_main26:
;RelojBinario.c,86 :: 		if(tiempo % 8){
	MOVLW      8
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       main_tiempo_L0+0, 0
	MOVWF      R0+0
	MOVF       main_tiempo_L0+1, 0
	MOVWF      R0+1
	MOVF       main_tiempo_L0+2, 0
	MOVWF      R0+2
	MOVF       main_tiempo_L0+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	IORWF      R0+2, 0
	IORWF      R0+3, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main27
;RelojBinario.c,87 :: 		PORTD = temp;
	MOVF       main_temp_L0+0, 0
	MOVWF      PORTD+0
;RelojBinario.c,88 :: 		}else{
	GOTO       L_main28
L_main27:
;RelojBinario.c,89 :: 		PORTD = 0xFF;
	MOVLW      255
	MOVWF      PORTD+0
;RelojBinario.c,90 :: 		}
L_main28:
;RelojBinario.c,91 :: 		break;
	GOTO       L_main23
;RelojBinario.c,92 :: 		case 2:
L_main29:
;RelojBinario.c,93 :: 		if(temp > 59){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_temp_L0+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main42
	MOVF       main_temp_L0+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main42
	MOVF       main_temp_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main42
	MOVF       main_temp_L0+0, 0
	SUBLW      59
L__main42:
	BTFSC      STATUS+0, 0
	GOTO       L_main30
;RelojBinario.c,94 :: 		temp = 0;
	CLRF       main_temp_L0+0
	CLRF       main_temp_L0+1
	CLRF       main_temp_L0+2
	CLRF       main_temp_L0+3
;RelojBinario.c,95 :: 		}
L_main30:
;RelojBinario.c,97 :: 		if(tiempo % 8){
	MOVLW      8
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       main_tiempo_L0+0, 0
	MOVWF      R0+0
	MOVF       main_tiempo_L0+1, 0
	MOVWF      R0+1
	MOVF       main_tiempo_L0+2, 0
	MOVWF      R0+2
	MOVF       main_tiempo_L0+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	IORWF      R0+2, 0
	IORWF      R0+3, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main31
;RelojBinario.c,98 :: 		PORTC = temp & 0b00111111;
	MOVLW      63
	ANDWF      main_temp_L0+0, 0
	MOVWF      PORTC+0
;RelojBinario.c,99 :: 		}else{
	GOTO       L_main32
L_main31:
;RelojBinario.c,100 :: 		PORTC = 0xFF;
	MOVLW      255
	MOVWF      PORTC+0
;RelojBinario.c,101 :: 		}
L_main32:
;RelojBinario.c,102 :: 		break;
	GOTO       L_main23
;RelojBinario.c,103 :: 		default:
L_main33:
;RelojBinario.c,104 :: 		break;
	GOTO       L_main23
;RelojBinario.c,106 :: 		}
L_main22:
	MOVLW      0
	XORWF      main_set_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main43
	MOVLW      0
	XORWF      main_set_L0+0, 0
L__main43:
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVLW      0
	XORWF      main_set_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVLW      1
	XORWF      main_set_L0+0, 0
L__main44:
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVLW      0
	XORWF      main_set_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVLW      2
	XORWF      main_set_L0+0, 0
L__main45:
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	GOTO       L_main33
L_main23:
;RelojBinario.c,107 :: 		delay_us(98500);
	MOVLW      0
	MOVWF      R12+0
	MOVLW      215
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
;RelojBinario.c,108 :: 		tiempo ++;
	MOVF       main_tiempo_L0+0, 0
	MOVWF      R0+0
	MOVF       main_tiempo_L0+1, 0
	MOVWF      R0+1
	MOVF       main_tiempo_L0+2, 0
	MOVWF      R0+2
	MOVF       main_tiempo_L0+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      main_tiempo_L0+0
	MOVF       R0+1, 0
	MOVWF      main_tiempo_L0+1
	MOVF       R0+2, 0
	MOVWF      main_tiempo_L0+2
	MOVF       R0+3, 0
	MOVWF      main_tiempo_L0+3
;RelojBinario.c,109 :: 		}
	GOTO       L_main0
;RelojBinario.c,110 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
