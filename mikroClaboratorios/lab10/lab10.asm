
_main:

;lab10.c,25 :: 		void main() {
;lab10.c,26 :: 		ANSEL  = 0;                     // Configuro pines analogos apagados
	CLRF       ANSEL+0
;lab10.c,27 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;lab10.c,29 :: 		Lcd_Init();                       // Initializo LCD
	CALL       _Lcd_Init+0
;lab10.c,30 :: 		Lcd_Cmd(_LCD_CLEAR);               // limpio pantalla
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lab10.c,31 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // apago cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lab10.c,32 :: 		Lcd_Out(1,1,"Laboratorio 10");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_lab10+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lab10.c,33 :: 		Lcd_Out(2,1,"  Luis Munoz");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_lab10+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lab10.c,35 :: 		UART1_Init(9600);               // Initializo UART a 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;lab10.c,36 :: 		Delay_ms(100);                  // espero a que se estabilice la conexión
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;lab10.c,38 :: 		UART1_Write_Text("Laboratorio 10");
	MOVLW      ?lstr3_lab10+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;lab10.c,39 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;lab10.c,40 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;lab10.c,41 :: 		UART1_Write_Text("Luis Munoz");
	MOVLW      ?lstr4_lab10+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;lab10.c,42 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;lab10.c,43 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;lab10.c,44 :: 		while (1) {
L_main1:
;lab10.c,45 :: 		if (UART1_Data_Ready()) {     // si recibo información
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;lab10.c,46 :: 		uart_rd = UART1_Read();     // lee el bit de información
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;lab10.c,47 :: 		escribir_letra();           //guardalo en el array
	CALL       _escribir_letra+0
;lab10.c,48 :: 		Lcd_Cmd(_LCD_CLEAR);               // limpio lcd
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lab10.c,49 :: 		Lcd_Out(1,1,text1);        //escribe en pantalla el nuevo texto
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lab10.c,50 :: 		Lcd_Out(2,1,text2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lab10.c,51 :: 		UART1_Write(uart_rd);       // regresa la letra a la computadora
	MOVF       _uart_rd+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;lab10.c,52 :: 		}
L_main3:
;lab10.c,54 :: 		}
	GOTO       L_main1
;lab10.c,55 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_limpiar_texto:

;lab10.c,57 :: 		void limpiar_texto(char texto[]){
;lab10.c,58 :: 		char j = 0;
	CLRF       limpiar_texto_j_L0+0
;lab10.c,59 :: 		for(j=0;j<17;j++){
	CLRF       limpiar_texto_j_L0+0
L_limpiar_texto4:
	MOVLW      17
	SUBWF      limpiar_texto_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_limpiar_texto5
;lab10.c,60 :: 		texto[j] = '\0';
	MOVF       limpiar_texto_j_L0+0, 0
	ADDWF      FARG_limpiar_texto_texto+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;lab10.c,59 :: 		for(j=0;j<17;j++){
	INCF       limpiar_texto_j_L0+0, 1
;lab10.c,61 :: 		}
	GOTO       L_limpiar_texto4
L_limpiar_texto5:
;lab10.c,62 :: 		}
L_end_limpiar_texto:
	RETURN
; end of _limpiar_texto

_escribir_letra:

;lab10.c,64 :: 		void escribir_letra(){
;lab10.c,65 :: 		if(!i && k == 1){
	MOVF       _i+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_escribir_letra9
	MOVF       _k+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_escribir_letra9
L__escribir_letra24:
;lab10.c,66 :: 		limpiar_texto(text1);
	MOVLW      _text1+0
	MOVWF      FARG_limpiar_texto_texto+0
	CALL       _limpiar_texto+0
;lab10.c,67 :: 		limpiar_texto(text2);
	MOVLW      _text2+0
	MOVWF      FARG_limpiar_texto_texto+0
	CALL       _limpiar_texto+0
;lab10.c,68 :: 		text1[i] = '_';
	MOVF       _i+0, 0
	ADDLW      _text1+0
	MOVWF      FSR
	MOVLW      95
	MOVWF      INDF+0
;lab10.c,69 :: 		}
L_escribir_letra9:
;lab10.c,70 :: 		if(uart_rd == '°'){
	MOVF       _uart_rd+0, 0
	XORLW      176
	BTFSS      STATUS+0, 2
	GOTO       L_escribir_letra10
;lab10.c,71 :: 		limpiar_texto(text1);
	MOVLW      _text1+0
	MOVWF      FARG_limpiar_texto_texto+0
	CALL       _limpiar_texto+0
;lab10.c,72 :: 		limpiar_texto(text2);
	MOVLW      _text2+0
	MOVWF      FARG_limpiar_texto_texto+0
	CALL       _limpiar_texto+0
;lab10.c,73 :: 		i = 0;
	CLRF       _i+0
;lab10.c,74 :: 		k = 1;
	MOVLW      1
	MOVWF      _k+0
;lab10.c,75 :: 		text1[i] = '_';
	MOVF       _i+0, 0
	ADDLW      _text1+0
	MOVWF      FSR
	MOVLW      95
	MOVWF      INDF+0
;lab10.c,76 :: 		}else if(uart_rd == '¬'){
	GOTO       L_escribir_letra11
L_escribir_letra10:
	MOVF       _uart_rd+0, 0
	XORLW      172
	BTFSS      STATUS+0, 2
	GOTO       L_escribir_letra12
;lab10.c,77 :: 		if(k == 2){
	MOVF       _k+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_escribir_letra13
;lab10.c,78 :: 		if(i == 0){
	MOVF       _i+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_escribir_letra14
;lab10.c,79 :: 		text2[i] = '\0';
	MOVF       _i+0, 0
	ADDLW      _text2+0
	MOVWF      FSR
	CLRF       INDF+0
;lab10.c,80 :: 		k = 1;
	MOVLW      1
	MOVWF      _k+0
;lab10.c,81 :: 		i = 15;
	MOVLW      15
	MOVWF      _i+0
;lab10.c,82 :: 		text1[i] = '_';
	MOVF       _i+0, 0
	ADDLW      _text1+0
	MOVWF      FSR
	MOVLW      95
	MOVWF      INDF+0
;lab10.c,83 :: 		}else{
	GOTO       L_escribir_letra15
L_escribir_letra14:
;lab10.c,84 :: 		text2[i] = '\0';
	MOVF       _i+0, 0
	ADDLW      _text2+0
	MOVWF      FSR
	CLRF       INDF+0
;lab10.c,85 :: 		text2[--i] = '_';
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _text2+0
	MOVWF      FSR
	MOVLW      95
	MOVWF      INDF+0
;lab10.c,86 :: 		}
L_escribir_letra15:
;lab10.c,87 :: 		}else{
	GOTO       L_escribir_letra16
L_escribir_letra13:
;lab10.c,88 :: 		if(i){
	MOVF       _i+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_escribir_letra17
;lab10.c,89 :: 		text1[i] = '\0';
	MOVF       _i+0, 0
	ADDLW      _text1+0
	MOVWF      FSR
	CLRF       INDF+0
;lab10.c,90 :: 		text1[--i] = '_';
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _text1+0
	MOVWF      FSR
	MOVLW      95
	MOVWF      INDF+0
;lab10.c,91 :: 		}
L_escribir_letra17:
;lab10.c,92 :: 		}
L_escribir_letra16:
;lab10.c,93 :: 		}else{
	GOTO       L_escribir_letra18
L_escribir_letra12:
;lab10.c,94 :: 		if(k == 1){
	MOVF       _k+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_escribir_letra19
;lab10.c,95 :: 		text1[i] = uart_rd;
	MOVF       _i+0, 0
	ADDLW      _text1+0
	MOVWF      FSR
	MOVF       _uart_rd+0, 0
	MOVWF      INDF+0
;lab10.c,96 :: 		text1[i+1] = '_';
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _text1+0
	MOVWF      FSR
	MOVLW      95
	MOVWF      INDF+0
;lab10.c,97 :: 		}else{
	GOTO       L_escribir_letra20
L_escribir_letra19:
;lab10.c,98 :: 		text2[i] = uart_rd;
	MOVF       _i+0, 0
	ADDLW      _text2+0
	MOVWF      FSR
	MOVF       _uart_rd+0, 0
	MOVWF      INDF+0
;lab10.c,99 :: 		text2[i+1] = '_';
	MOVF       _i+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _text2+0
	MOVWF      FSR
	MOVLW      95
	MOVWF      INDF+0
;lab10.c,100 :: 		}
L_escribir_letra20:
;lab10.c,101 :: 		if(++i > 15){
	INCF       _i+0, 1
	MOVF       _i+0, 0
	SUBLW      15
	BTFSC      STATUS+0, 0
	GOTO       L_escribir_letra21
;lab10.c,102 :: 		i = 0;
	CLRF       _i+0
;lab10.c,103 :: 		if(k > 1){
	MOVF       _k+0, 0
	SUBLW      1
	BTFSC      STATUS+0, 0
	GOTO       L_escribir_letra22
;lab10.c,104 :: 		k = 1;
	MOVLW      1
	MOVWF      _k+0
;lab10.c,105 :: 		text2[16] = '\0';
	CLRF       _text2+16
;lab10.c,106 :: 		}else{
	GOTO       L_escribir_letra23
L_escribir_letra22:
;lab10.c,107 :: 		k = 2;
	MOVLW      2
	MOVWF      _k+0
;lab10.c,108 :: 		text2[i] = '_';
	MOVF       _i+0, 0
	ADDLW      _text2+0
	MOVWF      FSR
	MOVLW      95
	MOVWF      INDF+0
;lab10.c,109 :: 		text1[16] = '\0';
	CLRF       _text1+16
;lab10.c,110 :: 		}
L_escribir_letra23:
;lab10.c,111 :: 		}
L_escribir_letra21:
;lab10.c,112 :: 		}
L_escribir_letra18:
L_escribir_letra11:
;lab10.c,114 :: 		}
L_end_escribir_letra:
	RETURN
; end of _escribir_letra
