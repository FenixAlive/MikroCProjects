
_main:

;lab6.c,21 :: 		void main() {
;lab6.c,23 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;lab6.c,24 :: 		TRISD = ~0x03;
	MOVLW      252
	MOVWF      TRISD+0
;lab6.c,26 :: 		OPTION_REG = OPTION_REG & 0x7F;
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;lab6.c,28 :: 		ANSELH=0x00;
	CLRF       ANSELH+0
;lab6.c,30 :: 		PORTB= 0x9E;
	MOVLW      158
	MOVWF      PORTB+0
;lab6.c,31 :: 		Sound_Init(&PORTD,7);
	MOVLW      PORTD+0
	MOVWF      FARG_Sound_Init_snd_port+0
	MOVLW      7
	MOVWF      FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;lab6.c,32 :: 		while(1){
L_main0:
;lab6.c,34 :: 		if((PORTB & 0x10)){
	BTFSS      PORTB+0, 4
	GOTO       L_main2
;lab6.c,36 :: 		if(!parar){
	MOVF       _parar+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;lab6.c,38 :: 		if(PORTB & 0x04){
	BTFSS      PORTB+0, 2
	GOTO       L_main4
;lab6.c,39 :: 		conteo_up();
	CALL       _conteo_up+0
;lab6.c,41 :: 		}else{
	GOTO       L_main5
L_main4:
;lab6.c,42 :: 		conteo_down();
	CALL       _conteo_down+0
;lab6.c,43 :: 		}
L_main5:
;lab6.c,44 :: 		}
L_main3:
;lab6.c,46 :: 		if(unidades == uTotal && decenas == dTotal && !(PORTB & 0x08)){
	MOVF       _unidades+0, 0
	XORWF      _uTotal+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main8
	MOVF       _decenas+0, 0
	XORWF      _dTotal+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main8
	BTFSC      PORTB+0, 3
	GOTO       L_main8
L__main39:
;lab6.c,47 :: 		PORTD.RD1 = 1;
	BSF        PORTD+0, 1
;lab6.c,48 :: 		PORTC = tabla[10];
	MOVF       _tabla+10, 0
	MOVWF      PORTC+0
;lab6.c,49 :: 		Sound_Play(notas[2]*2, 100);
	MOVLW      11
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,50 :: 		Sound_Play(notas[6]*2, 100);
	MOVLW      16
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,51 :: 		Sound_Play(notas[4]*2, 150);
	MOVLW      147
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      150
	MOVWF      FARG_Sound_Play_duration_ms+0
	CLRF       FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,52 :: 		Sound_Play(notas[2]*2, 100);
	MOVLW      11
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,53 :: 		Sound_Play(notas[1]*2, 400);
	MOVLW      237
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      144
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,54 :: 		Sound_Play(notas[2]*2, 300);
	MOVLW      11
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      44
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,55 :: 		PORTD.RD1 = 0;
	BCF        PORTD+0, 1
;lab6.c,56 :: 		}
L_main8:
;lab6.c,57 :: 		}
L_main2:
;lab6.c,59 :: 		multiplexado(pulso);
	MOVF       _pulso+0, 0
	MOVWF      FARG_multiplexado_veces+0
	MOVF       _pulso+1, 0
	MOVWF      FARG_multiplexado_veces+1
	CALL       _multiplexado+0
;lab6.c,60 :: 		} //fin while
	GOTO       L_main0
;lab6.c,61 :: 		} //fin main
L_end_main:
	GOTO       $+0
; end of _main

_conteo_up:

;lab6.c,64 :: 		void conteo_up(){
;lab6.c,65 :: 		if(++unidades > 9){
	INCF       _unidades+0, 1
	MOVF       _unidades+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_conteo_up9
;lab6.c,66 :: 		unidades = 0;
	CLRF       _unidades+0
;lab6.c,67 :: 		if(++decenas > dTotal){
	INCF       _decenas+0, 1
	MOVF       _decenas+0, 0
	SUBWF      _dTotal+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_conteo_up10
;lab6.c,68 :: 		decenas = 0;
	CLRF       _decenas+0
;lab6.c,69 :: 		}
L_conteo_up10:
;lab6.c,70 :: 		}
L_conteo_up9:
;lab6.c,71 :: 		if( decenas >= dTotal && unidades > uTotal){
	MOVF       _dTotal+0, 0
	SUBWF      _decenas+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_conteo_up13
	MOVF       _unidades+0, 0
	SUBWF      _uTotal+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_conteo_up13
L__conteo_up40:
;lab6.c,72 :: 		unidades = 0;
	CLRF       _unidades+0
;lab6.c,73 :: 		decenas = 0;
	CLRF       _decenas+0
;lab6.c,74 :: 		}
L_conteo_up13:
;lab6.c,75 :: 		}
L_end_conteo_up:
	RETURN
; end of _conteo_up

_conteo_down:

;lab6.c,77 :: 		void conteo_down(){
;lab6.c,78 :: 		if(unidades-- == 0){
	MOVF       _unidades+0, 0
	MOVWF      R1+0
	DECF       _unidades+0, 1
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_conteo_down14
;lab6.c,79 :: 		unidades = 9;
	MOVLW      9
	MOVWF      _unidades+0
;lab6.c,80 :: 		if(decenas-- == 0){
	MOVF       _decenas+0, 0
	MOVWF      R1+0
	DECF       _decenas+0, 1
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_conteo_down15
;lab6.c,81 :: 		decenas = dTotal;
	MOVF       _dTotal+0, 0
	MOVWF      _decenas+0
;lab6.c,82 :: 		}
L_conteo_down15:
;lab6.c,83 :: 		}
L_conteo_down14:
;lab6.c,84 :: 		}
L_end_conteo_down:
	RETURN
; end of _conteo_down

_multiplexado:

;lab6.c,88 :: 		void multiplexado(unsigned int veces){
;lab6.c,89 :: 		veces *=10;
	MOVF       FARG_multiplexado_veces+0, 0
	MOVWF      R0+0
	MOVF       FARG_multiplexado_veces+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_multiplexado_veces+0
	MOVF       R0+1, 0
	MOVWF      FARG_multiplexado_veces+1
;lab6.c,90 :: 		PORTD.RD0 = 0;
	BCF        PORTD+0, 0
;lab6.c,91 :: 		PORTD.RD1 = 0;
	BCF        PORTD+0, 1
;lab6.c,92 :: 		while(veces--){
L_multiplexado16:
	MOVF       FARG_multiplexado_veces+0, 0
	MOVWF      R0+0
	MOVF       FARG_multiplexado_veces+1, 0
	MOVWF      R0+1
	MOVLW      1
	SUBWF      FARG_multiplexado_veces+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_multiplexado_veces+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_multiplexado17
;lab6.c,93 :: 		PORTC = tabla[unidades];
	MOVF       _unidades+0, 0
	ADDLW      _tabla+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;lab6.c,94 :: 		PORTD.RD1 = 1;
	BSF        PORTD+0, 1
;lab6.c,95 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_multiplexado18:
	DECFSZ     R13+0, 1
	GOTO       L_multiplexado18
	DECFSZ     R12+0, 1
	GOTO       L_multiplexado18
	NOP
	NOP
;lab6.c,96 :: 		PORTD.RD1 = 0;
	BCF        PORTD+0, 1
;lab6.c,97 :: 		PORTC = tabla[decenas];
	MOVF       _decenas+0, 0
	ADDLW      _tabla+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;lab6.c,99 :: 		if(!(PORTB & 0x10) && (PORTB & 0x08)){
	BTFSC      PORTB+0, 4
	GOTO       L_multiplexado21
	BTFSS      PORTB+0, 3
	GOTO       L_multiplexado21
L__multiplexado41:
;lab6.c,100 :: 		PORTC.RC7 = 1;
	BSF        PORTC+0, 7
;lab6.c,101 :: 		}
L_multiplexado21:
;lab6.c,102 :: 		PORTD.RD0 = 1;
	BSF        PORTD+0, 0
;lab6.c,103 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_multiplexado22:
	DECFSZ     R13+0, 1
	GOTO       L_multiplexado22
	DECFSZ     R12+0, 1
	GOTO       L_multiplexado22
	NOP
	NOP
;lab6.c,104 :: 		PORTD.RD0 = 0;
	BCF        PORTD+0, 0
;lab6.c,105 :: 		PORTC.RC7 = 0;
	BCF        PORTC+0, 7
;lab6.c,106 :: 		boton_presionado();
	CALL       _boton_presionado+0
;lab6.c,107 :: 		}
	GOTO       L_multiplexado16
L_multiplexado17:
;lab6.c,108 :: 		}
L_end_multiplexado:
	RETURN
; end of _multiplexado

_boton_presionado:

;lab6.c,110 :: 		void boton_presionado(){
;lab6.c,112 :: 		if((PORTB & 0x10)){
	BTFSS      PORTB+0, 4
	GOTO       L_boton_presionado23
;lab6.c,114 :: 		if(set){
	MOVF       _set+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_boton_presionado24
;lab6.c,115 :: 		set = 0;
	CLRF       _set+0
;lab6.c,116 :: 		unidades = 0;
	CLRF       _unidades+0
;lab6.c,117 :: 		decenas = 0;
	CLRF       _decenas+0
;lab6.c,118 :: 		parar = 0;
	CLRF       _parar+0
;lab6.c,119 :: 		}
L_boton_presionado24:
;lab6.c,121 :: 		if(!(PORTB & 0x02)){
	BTFSC      PORTB+0, 1
	GOTO       L_boton_presionado25
;lab6.c,122 :: 		parar = 1;
	MOVLW      1
	MOVWF      _parar+0
;lab6.c,123 :: 		presion = 0;
	CLRF       _presion+0
;lab6.c,124 :: 		}else{
	GOTO       L_boton_presionado26
L_boton_presionado25:
;lab6.c,125 :: 		if(!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_boton_presionado27
;lab6.c,126 :: 		Sound_Play(notas[7]*2, 70);
	MOVLW      112
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      70
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,127 :: 		if(!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_boton_presionado28
;lab6.c,128 :: 		Sound_Play(notas[9]*2, 80);
	MOVLW      22
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      4
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      80
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,129 :: 		presion ^= 1;
	MOVLW      1
	XORWF      _presion+0, 1
;lab6.c,130 :: 		}
L_boton_presionado28:
;lab6.c,131 :: 		}
L_boton_presionado27:
;lab6.c,132 :: 		parar = presion;
	MOVF       _presion+0, 0
	MOVWF      _parar+0
;lab6.c,133 :: 		}
L_boton_presionado26:
;lab6.c,134 :: 		}else{
	GOTO       L_boton_presionado29
L_boton_presionado23:
;lab6.c,136 :: 		if(!set){
	MOVF       _set+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_boton_presionado30
;lab6.c,137 :: 		set = 1;
	MOVLW      1
	MOVWF      _set+0
;lab6.c,138 :: 		parar = 1;
	MOVLW      1
	MOVWF      _parar+0
;lab6.c,139 :: 		}
L_boton_presionado30:
;lab6.c,140 :: 		if(!(PORTB & 0x08)){
	BTFSC      PORTB+0, 3
	GOTO       L_boton_presionado31
;lab6.c,142 :: 		if(!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_boton_presionado32
;lab6.c,143 :: 		Sound_Play(notas[7]*2, 70);
	MOVLW      112
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      70
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,144 :: 		if(!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_boton_presionado33
;lab6.c,145 :: 		Sound_Play(notas[9]*2, 80);
	MOVLW      22
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      4
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      80
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,146 :: 		if(++alarma > 159){
	INCF       _alarma+0, 1
	MOVF       _alarma+0, 0
	SUBLW      159
	BTFSC      STATUS+0, 0
	GOTO       L_boton_presionado34
;lab6.c,147 :: 		alarma = 0;
	CLRF       _alarma+0
;lab6.c,148 :: 		}
L_boton_presionado34:
;lab6.c,149 :: 		}
L_boton_presionado33:
;lab6.c,150 :: 		}
L_boton_presionado32:
;lab6.c,151 :: 		uTotal = alarma % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _alarma+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__boton_presionado+0
	MOVF       FLOC__boton_presionado+0, 0
	MOVWF      _uTotal+0
;lab6.c,152 :: 		dTotal = alarma / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _alarma+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _dTotal+0
;lab6.c,153 :: 		unidades = uTotal;
	MOVF       FLOC__boton_presionado+0, 0
	MOVWF      _unidades+0
;lab6.c,154 :: 		decenas = dTotal;
	MOVF       R0+0, 0
	MOVWF      _decenas+0
;lab6.c,155 :: 		}else{
	GOTO       L_boton_presionado35
L_boton_presionado31:
;lab6.c,157 :: 		if(!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_boton_presionado36
;lab6.c,158 :: 		Sound_Play(notas[7]*2, 70);
	MOVLW      112
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      70
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,159 :: 		if(!(PORTB & 0x80)){
	BTFSC      PORTB+0, 7
	GOTO       L_boton_presionado37
;lab6.c,160 :: 		Sound_Play(notas[9]*2, 80);
	MOVLW      22
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      4
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      80
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab6.c,161 :: 		if(++pulso > 159){
	INCF       _pulso+0, 1
	BTFSC      STATUS+0, 2
	INCF       _pulso+1, 1
	MOVF       _pulso+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__boton_presionado47
	MOVF       _pulso+0, 0
	SUBLW      159
L__boton_presionado47:
	BTFSC      STATUS+0, 0
	GOTO       L_boton_presionado38
;lab6.c,162 :: 		pulso = 1;
	MOVLW      1
	MOVWF      _pulso+0
	MOVLW      0
	MOVWF      _pulso+1
;lab6.c,163 :: 		}
L_boton_presionado38:
;lab6.c,164 :: 		}
L_boton_presionado37:
;lab6.c,165 :: 		}
L_boton_presionado36:
;lab6.c,166 :: 		unidades = pulso % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _pulso+0, 0
	MOVWF      R0+0
	MOVF       _pulso+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _unidades+0
;lab6.c,167 :: 		decenas = pulso / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _pulso+0, 0
	MOVWF      R0+0
	MOVF       _pulso+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _decenas+0
;lab6.c,168 :: 		}
L_boton_presionado35:
;lab6.c,169 :: 		}
L_boton_presionado29:
;lab6.c,170 :: 		}
L_end_boton_presionado:
	RETURN
; end of _boton_presionado
