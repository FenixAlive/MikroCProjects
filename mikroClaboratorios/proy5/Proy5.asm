
_main:

;Proy5.c,32 :: 		void main(){
;Proy5.c,35 :: 		INTCON |= 0b10000000; //interrupcion local
	BSF        INTCON+0, 7
;Proy5.c,37 :: 		ANSEL  = 0x0F;
	MOVLW      15
	MOVWF      ANSEL+0
;Proy5.c,38 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;Proy5.c,39 :: 		TRISA = 0x0F;
	MOVLW      15
	MOVWF      TRISA+0
;Proy5.c,40 :: 		C1ON_bit = 0;                      // apago comparadores
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Proy5.c,41 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Proy5.c,43 :: 		Lcd_Init();                       // Initialize LCD
	CALL       _Lcd_Init+0
;Proy5.c,44 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Proy5.c,45 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Proy5.c,46 :: 		Lcd_Out(1,1,"Proyecto 6");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Proy5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,47 :: 		Lcd_Out(2,1,"Luis Munoz");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Proy5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,52 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;Proy5.c,53 :: 		while(1) {
L_main1:
;Proy5.c,54 :: 		analog_Read(0);
	CLRF       FARG_analog_Read_chan+0
	CLRF       FARG_analog_Read_chan+1
	CALL       _analog_Read+0
;Proy5.c,55 :: 		analog_Read(1);
	MOVLW      1
	MOVWF      FARG_analog_Read_chan+0
	MOVLW      0
	MOVWF      FARG_analog_Read_chan+1
	CALL       _analog_Read+0
;Proy5.c,56 :: 		analog_Read(2);
	MOVLW      2
	MOVWF      FARG_analog_Read_chan+0
	MOVLW      0
	MOVWF      FARG_analog_Read_chan+1
	CALL       _analog_Read+0
;Proy5.c,57 :: 		analog_Read(3);
	MOVLW      3
	MOVWF      FARG_analog_Read_chan+0
	MOVLW      0
	MOVWF      FARG_analog_Read_chan+1
	CALL       _analog_Read+0
;Proy5.c,60 :: 		Delay_us(tMues);
	MOVLW      16
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	NOP
;Proy5.c,61 :: 		Lcd_Cmd(_LCD_CLEAR);               // limpio lcd
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Proy5.c,62 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // quito cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Proy5.c,64 :: 		Lcd_Out(1,1,"R:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Proy5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,65 :: 		num2str(&analogos[0]);
	MOVLW      _analogos+0
	MOVWF      FARG_num2str_val+0
	CALL       _num2str+0
;Proy5.c,66 :: 		Lcd_Out(1,3, palabra);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _palabra+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,68 :: 		Lcd_Out(1,9,"I:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Proy5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,69 :: 		num2str(&analogos[1]);
	MOVLW      _analogos+2
	MOVWF      FARG_num2str_val+0
	CALL       _num2str+0
;Proy5.c,70 :: 		Lcd_Out(1,12, palabra);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _palabra+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,72 :: 		Lcd_Out(2,1,"L:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_Proy5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,73 :: 		num2str(&analogos[2]);
	MOVLW      _analogos+4
	MOVWF      FARG_num2str_val+0
	CALL       _num2str+0
;Proy5.c,74 :: 		Lcd_Out(2,3, palabra);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _palabra+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,76 :: 		Lcd_Out(2,9,"T:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Proy5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,77 :: 		temper = (float) (analogos[3] * 520) / 1023;
	MOVF       _analogos+6, 0
	MOVWF      R0+0
	MOVF       _analogos+7, 0
	MOVWF      R0+1
	MOVLW      8
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temper+0
	MOVF       R0+1, 0
	MOVWF      _temper+1
	MOVF       R0+2, 0
	MOVWF      _temper+2
	MOVF       R0+3, 0
	MOVWF      _temper+3
;Proy5.c,78 :: 		float2str(&temper);
	MOVLW      _temper+0
	MOVWF      FARG_float2str_val+0
	CALL       _float2str+0
;Proy5.c,79 :: 		Lcd_Out(2,12, palabra);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _palabra+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Proy5.c,81 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;Proy5.c,82 :: 		}
	GOTO       L_main1
;Proy5.c,83 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_num2str:

;Proy5.c,85 :: 		void num2str(unsigned int *val){
;Proy5.c,86 :: 		i = tamStr;
	MOVLW      5
	MOVWF      _i+0
;Proy5.c,87 :: 		if(*val){
	MOVF       FARG_num2str_val+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	INCF       FSR, 1
	IORWF      INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_num2str5
;Proy5.c,88 :: 		while(*val && i > -1){
L_num2str6:
	MOVF       FARG_num2str_val+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	INCF       FSR, 1
	IORWF      INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_num2str7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__num2str35
	MOVF       _i+0, 0
	SUBLW      255
L__num2str35:
	BTFSC      STATUS+0, 0
	GOTO       L_num2str7
L__num2str31:
;Proy5.c,89 :: 		palabra[--i] = 48 + (*val % 10);
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FLOC__num2str+0
	MOVF       FARG_num2str_val+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__num2str+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Proy5.c,90 :: 		*val /= 10;
	MOVF       FARG_num2str_val+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       FARG_num2str_val+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Proy5.c,91 :: 		}
	GOTO       L_num2str6
L_num2str7:
;Proy5.c,92 :: 		while(i > 0){
L_num2str10:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_num2str11
;Proy5.c,93 :: 		palabra[--i] = 32;
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
;Proy5.c,94 :: 		}
	GOTO       L_num2str10
L_num2str11:
;Proy5.c,95 :: 		}else{
	GOTO       L_num2str12
L_num2str5:
;Proy5.c,96 :: 		palabra[--i] = '0';
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
;Proy5.c,97 :: 		while(i > 0){
L_num2str13:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_num2str14
;Proy5.c,98 :: 		palabra[--i] = 32;
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
;Proy5.c,99 :: 		}
	GOTO       L_num2str13
L_num2str14:
;Proy5.c,100 :: 		}
L_num2str12:
;Proy5.c,101 :: 		palabra[5] = '\0';
	CLRF       _palabra+5
;Proy5.c,102 :: 		}
L_end_num2str:
	RETURN
; end of _num2str

_float2str:

;Proy5.c,104 :: 		void float2str(float *val){
;Proy5.c,105 :: 		int temp = (int) ((*val) * 100);
	MOVF       FARG_float2str_val+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+2
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+3
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      float2str_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      float2str_temp_L0+1
;Proy5.c,106 :: 		if(temp >= 10000){
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORLW      39
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__float2str37
	MOVLW      16
	SUBWF      R0+0, 0
L__float2str37:
	BTFSS      STATUS+0, 0
	GOTO       L_float2str15
;Proy5.c,107 :: 		temp = 9999;
	MOVLW      15
	MOVWF      float2str_temp_L0+0
	MOVLW      39
	MOVWF      float2str_temp_L0+1
;Proy5.c,108 :: 		}
L_float2str15:
;Proy5.c,109 :: 		i = tamStr;
	MOVLW      5
	MOVWF      _i+0
;Proy5.c,110 :: 		if(temp){
	MOVF       float2str_temp_L0+0, 0
	IORWF      float2str_temp_L0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_float2str16
;Proy5.c,111 :: 		while(temp && i > -1){
L_float2str17:
	MOVF       float2str_temp_L0+0, 0
	IORWF      float2str_temp_L0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_float2str18
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__float2str38
	MOVF       _i+0, 0
	SUBLW      255
L__float2str38:
	BTFSC      STATUS+0, 0
	GOTO       L_float2str18
L__float2str32:
;Proy5.c,112 :: 		if(i == tamStr-2){
	MOVLW      0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__float2str39
	MOVLW      3
	XORWF      _i+0, 0
L__float2str39:
	BTFSS      STATUS+0, 2
	GOTO       L_float2str21
;Proy5.c,113 :: 		palabra[--i] = '.';
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      46
	MOVWF      INDF+0
;Proy5.c,114 :: 		}else{
	GOTO       L_float2str22
L_float2str21:
;Proy5.c,115 :: 		palabra[--i] = 48 + (temp % 10);
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FLOC__float2str+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       float2str_temp_L0+0, 0
	MOVWF      R0+0
	MOVF       float2str_temp_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__float2str+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Proy5.c,116 :: 		temp /= 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       float2str_temp_L0+0, 0
	MOVWF      R0+0
	MOVF       float2str_temp_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      float2str_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      float2str_temp_L0+1
;Proy5.c,117 :: 		}
L_float2str22:
;Proy5.c,118 :: 		}
	GOTO       L_float2str17
L_float2str18:
;Proy5.c,119 :: 		while(i > 0){
L_float2str23:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_float2str24
;Proy5.c,120 :: 		palabra[--i] = 32;
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
;Proy5.c,121 :: 		}
	GOTO       L_float2str23
L_float2str24:
;Proy5.c,122 :: 		}else{
	GOTO       L_float2str25
L_float2str16:
;Proy5.c,123 :: 		palabra[--i] = '0';
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
;Proy5.c,124 :: 		while(i > 0){
L_float2str26:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_float2str27
;Proy5.c,125 :: 		palabra[--i] = 32;
	DECF       _i+0, 1
	MOVF       _i+0, 0
	ADDLW      _palabra+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
;Proy5.c,126 :: 		}
	GOTO       L_float2str26
L_float2str27:
;Proy5.c,127 :: 		}
L_float2str25:
;Proy5.c,128 :: 		palabra[5] = '\0';
	CLRF       _palabra+5
;Proy5.c,129 :: 		}
L_end_float2str:
	RETURN
; end of _float2str

_analog_Read:

;Proy5.c,131 :: 		void analog_Read(int chan){
;Proy5.c,132 :: 		temp = 0;
	CLRF       _temp+0
	CLRF       _temp+1
	CLRF       _temp+2
	CLRF       _temp+3
;Proy5.c,133 :: 		for(i=0;i<tMues;i++){
	CLRF       _i+0
L_analog_Read28:
	MOVLW      50
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_analog_Read29
;Proy5.c,134 :: 		temp += ADC_Read(chan);
	MOVF       FARG_analog_Read_chan+0, 0
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVLW      0
	MOVWF      R0+2
	MOVWF      R0+3
	MOVF       _temp+0, 0
	ADDWF      R0+0, 1
	MOVF       _temp+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _temp+1, 0
	ADDWF      R0+1, 1
	MOVF       _temp+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _temp+2, 0
	ADDWF      R0+2, 1
	MOVF       _temp+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _temp+3, 0
	ADDWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
	MOVF       R0+2, 0
	MOVWF      _temp+2
	MOVF       R0+3, 0
	MOVWF      _temp+3
;Proy5.c,133 :: 		for(i=0;i<tMues;i++){
	INCF       _i+0, 1
;Proy5.c,135 :: 		}
	GOTO       L_analog_Read28
L_analog_Read29:
;Proy5.c,136 :: 		analogos[chan] = temp/tMues;
	MOVF       FARG_analog_Read_chan+0, 0
	MOVWF      R0+0
	MOVF       FARG_analog_Read_chan+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _analogos+0
	MOVWF      FLOC__analog_Read+0
	MOVLW      50
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	MOVF       _temp+2, 0
	MOVWF      R0+2
	MOVF       _temp+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       FLOC__analog_Read+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Proy5.c,138 :: 		}
L_end_analog_Read:
	RETURN
; end of _analog_Read
