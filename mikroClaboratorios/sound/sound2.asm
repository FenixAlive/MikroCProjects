
_tono:

;sound2.c,1 :: 		int tono(int t) {
;sound2.c,2 :: 		}
L_end_tono:
	RETURN
; end of _tono

_main:

;sound2.c,3 :: 		void main() {
;sound2.c,4 :: 		int t[4] = {0, 0, 0, 0};
	CLRF       main_t_L0+0
	CLRF       main_t_L0+1
	CLRF       main_t_L0+2
	CLRF       main_t_L0+3
	CLRF       main_t_L0+4
	CLRF       main_t_L0+5
	CLRF       main_t_L0+6
	CLRF       main_t_L0+7
	MOVLW      126
	MOVWF      main_nota_L0+0
	MOVLW      1
	MOVWF      main_nota_L0+1
	MOVLW      84
	MOVWF      main_nota_L0+2
	MOVLW      1
	MOVWF      main_nota_L0+3
	MOVLW      47
	MOVWF      main_nota_L0+4
	MOVLW      1
	MOVWF      main_nota_L0+5
	MOVLW      30
	MOVWF      main_nota_L0+6
	MOVLW      1
	MOVWF      main_nota_L0+7
	MOVLW      255
	MOVWF      main_nota_L0+8
	MOVLW      0
	MOVWF      main_nota_L0+9
	MOVLW      227
	MOVWF      main_nota_L0+10
	MOVLW      0
	MOVWF      main_nota_L0+11
	MOVLW      202
	MOVWF      main_nota_L0+12
	MOVLW      0
	MOVWF      main_nota_L0+13
	CLRF       main_vNota_L0+0
	CLRF       main_vNota_L0+1
	CLRF       main_tiempo_L0+0
	CLRF       main_tiempo_L0+1
	CLRF       main_tiempo_L0+2
	CLRF       main_tiempo_L0+3
;sound2.c,8 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;sound2.c,9 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;sound2.c,10 :: 		while(1){
L_main0:
;sound2.c,11 :: 		tiempo++;
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
;sound2.c,12 :: 		if(tiempo == 1000){
	MOVLW      0
	MOVWF      R0+0
	XORWF      main_tiempo_L0+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       R0+0, 0
	XORWF      main_tiempo_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVLW      3
	XORWF      main_tiempo_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       main_tiempo_L0+0, 0
	XORLW      232
L__main9:
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;sound2.c,13 :: 		if(vNota<7){
	MOVLW      128
	XORWF      main_vNota_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVLW      7
	SUBWF      main_vNota_L0+0, 0
L__main10:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;sound2.c,14 :: 		vNota++;
	INCF       main_vNota_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_vNota_L0+1, 1
;sound2.c,15 :: 		}else{
	GOTO       L_main4
L_main3:
;sound2.c,16 :: 		vNota=0;
	CLRF       main_vNota_L0+0
	CLRF       main_vNota_L0+1
;sound2.c,17 :: 		break;
	GOTO       L_main1
;sound2.c,18 :: 		}
L_main4:
;sound2.c,19 :: 		}
L_main2:
;sound2.c,20 :: 		if(t[0] == nota[vNota]){
	MOVF       main_vNota_L0+0, 0
	MOVWF      R0+0
	MOVF       main_vNota_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      main_nota_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVF       main_t_L0+1, 0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVF       R1+0, 0
	XORWF      main_t_L0+0, 0
L__main11:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;sound2.c,21 :: 		t[0] = 0;
	CLRF       main_t_L0+0
	CLRF       main_t_L0+1
;sound2.c,22 :: 		PORTD ^= 0x01;
	MOVLW      1
	XORWF      PORTD+0, 1
;sound2.c,23 :: 		}
L_main5:
;sound2.c,28 :: 		delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	NOP
;sound2.c,29 :: 		t[0]++;
	INCF       main_t_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_t_L0+1, 1
;sound2.c,30 :: 		t[1]++;
	INCF       main_t_L0+2, 1
	BTFSC      STATUS+0, 2
	INCF       main_t_L0+3, 1
;sound2.c,31 :: 		t[2]++;
	INCF       main_t_L0+4, 1
	BTFSC      STATUS+0, 2
	INCF       main_t_L0+5, 1
;sound2.c,32 :: 		t[3]++;
	INCF       main_t_L0+6, 1
	BTFSC      STATUS+0, 2
	INCF       main_t_L0+7, 1
;sound2.c,33 :: 		}
	GOTO       L_main0
L_main1:
;sound2.c,34 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
