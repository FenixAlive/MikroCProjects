
_main:

;Proy4.c,25 :: 		void main(){
;Proy4.c,31 :: 		OPTION_REG.T0CS = 1;
	BSF        OPTION_REG+0, 5
;Proy4.c,32 :: 		OPTION_REG.T0SE = 1;
	BSF        OPTION_REG+0, 4
;Proy4.c,33 :: 		OPTION_REG.PSA = 1;
	BSF        OPTION_REG+0, 3
;Proy4.c,34 :: 		OPTION_REG.PS2 = 0;
	BCF        OPTION_REG+0, 2
;Proy4.c,35 :: 		OPTION_REG.PS1 = 0;
	BCF        OPTION_REG+0, 1
;Proy4.c,36 :: 		OPTION_REG.PS0 = 0;
	BCF        OPTION_REG+0, 0
;Proy4.c,39 :: 		INTCON |= 0b10100000; //interrupcion local
	MOVLW      160
	IORWF      INTCON+0, 1
;Proy4.c,41 :: 		ANSEL  = 0;                        // Configure AN pins as digital I/O
	CLRF       ANSEL+0
;Proy4.c,42 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Proy4.c,43 :: 		C1ON_bit = 0;                      // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Proy4.c,44 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Proy4.c,45 :: 		Lcd_Init();                       // Initialize LCD
	CALL       _Lcd_Init+0
;Proy4.c,46 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Proy4.c,47 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Proy4.c,48 :: 		Lcd_Out(1,1,"Frecunciometro");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Proy4+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy4.c,49 :: 		while(1) {
L_main0:
;Proy4.c,50 :: 		cuenta = 0;
	CLRF       _cuenta+0
	CLRF       _cuenta+1
	CLRF       _cuenta+2
	CLRF       _cuenta+3
;Proy4.c,51 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;Proy4.c,52 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
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
;Proy4.c,53 :: 		numfrec = cuenta*256+TMR0;
	MOVF       _cuenta+2, 0
	MOVWF      R0+3
	MOVF       _cuenta+1, 0
	MOVWF      R0+2
	MOVF       _cuenta+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR0+0, 0
	MOVWF      _numfrec+0
	CLRF       _numfrec+1
	CLRF       _numfrec+2
	CLRF       _numfrec+3
	MOVF       R0+0, 0
	ADDWF      _numfrec+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      _numfrec+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      _numfrec+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      _numfrec+3, 1
;Proy4.c,54 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Proy4.c,55 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Proy4.c,56 :: 		Lcd_Out(1,1,"Frec:");                 // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Proy4+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy4.c,57 :: 		num2str();
	CALL       _num2str+0
;Proy4.c,58 :: 		Lcd_Out(1,7, palabra);                 // Write text in second row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _palabra+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy4.c,60 :: 		}
	GOTO       L_main0
;Proy4.c,61 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_num2str:

;Proy4.c,63 :: 		void num2str(){
;Proy4.c,64 :: 		i = 10;
	MOVLW      10
	MOVWF      _i+0
;Proy4.c,65 :: 		if(numfrec){
	MOVF       _numfrec+0, 0
	IORWF      _numfrec+1, 0
	IORWF      _numfrec+2, 0
	IORWF      _numfrec+3, 0
	BTFSC      STATUS+0, 2
	GOTO       L_num2str3
;Proy4.c,66 :: 		while(numfrec && i > -1){
L_num2str4:
	MOVF       _numfrec+0, 0
	IORWF      _numfrec+1, 0
	IORWF      _numfrec+2, 0
	IORWF      _numfrec+3, 0
	BTFSC      STATUS+0, 2
	GOTO       L_num2str5
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__num2str17
	MOVF       _i+0, 0
	SUBLW      255
L__num2str17:
	BTFSC      STATUS+0, 0
	GOTO       L_num2str5
L__num2str14:
;Proy4.c,67 :: 		palabra[--i] = 48 + (numfrec % 10);
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FLOC__num2str+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _numfrec+0, 0
	MOVWF      R0+0
	MOVF       _numfrec+1, 0
	MOVWF      R0+1
	MOVF       _numfrec+2, 0
	MOVWF      R0+2
	MOVF       _numfrec+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__num2str+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Proy4.c,68 :: 		numfrec /= 10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _numfrec+0, 0
	MOVWF      R0+0
	MOVF       _numfrec+1, 0
	MOVWF      R0+1
	MOVF       _numfrec+2, 0
	MOVWF      R0+2
	MOVF       _numfrec+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _numfrec+0
	MOVF       R0+1, 0
	MOVWF      _numfrec+1
	MOVF       R0+2, 0
	MOVWF      _numfrec+2
	MOVF       R0+3, 0
	MOVWF      _numfrec+3
;Proy4.c,69 :: 		}
	GOTO       L_num2str4
L_num2str5:
;Proy4.c,70 :: 		while(i > 0){
L_num2str8:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_num2str9
;Proy4.c,71 :: 		palabra[--i] = 32;
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
;Proy4.c,72 :: 		}
	GOTO       L_num2str8
L_num2str9:
;Proy4.c,73 :: 		palabra[10] = '\0';
	CLRF       _palabra+10
;Proy4.c,74 :: 		}else{
	GOTO       L_num2str10
L_num2str3:
;Proy4.c,75 :: 		palabra[--i] = '0';
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
;Proy4.c,76 :: 		while(i > 0){
L_num2str11:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_num2str12
;Proy4.c,77 :: 		palabra[--i] = 32;
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
;Proy4.c,78 :: 		}
	GOTO       L_num2str11
L_num2str12:
;Proy4.c,79 :: 		palabra[10] = '\0';
	CLRF       _palabra+10
;Proy4.c,81 :: 		}
L_num2str10:
;Proy4.c,82 :: 		}
L_end_num2str:
	RETURN
; end of _num2str

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Proy4.c,84 :: 		void interrupt(){
;Proy4.c,85 :: 		if(INTCON & 0b00000100){
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt13
;Proy4.c,86 :: 		cuenta++;
	MOVF       _cuenta+0, 0
	MOVWF      R0+0
	MOVF       _cuenta+1, 0
	MOVWF      R0+1
	MOVF       _cuenta+2, 0
	MOVWF      R0+2
	MOVF       _cuenta+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _cuenta+0
	MOVF       R0+1, 0
	MOVWF      _cuenta+1
	MOVF       R0+2, 0
	MOVWF      _cuenta+2
	MOVF       R0+3, 0
	MOVWF      _cuenta+3
;Proy4.c,87 :: 		INTCON &= 0b11111011; //limpiar bandera de interrupcion
	MOVLW      251
	ANDWF      INTCON+0, 1
;Proy4.c,88 :: 		}
L_interrupt13:
;Proy4.c,89 :: 		}
L_end_interrupt:
L__interrupt19:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
