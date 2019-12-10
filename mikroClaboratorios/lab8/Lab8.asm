
_main:

;Lab8.c,3 :: 		void main() {
;Lab8.c,7 :: 		OPTION_REG &= 0b00010111; //confirmo los que quiero que se queden en 0
	MOVLW      23
	ANDWF      OPTION_REG+0, 1
;Lab8.c,8 :: 		OPTION_REG |= 0b00010111; //confirmo los que quiero en 1
	MOVLW      23
	IORWF      OPTION_REG+0, 1
;Lab8.c,11 :: 		INTCON |= 0b10100000; //interrupcion local
	MOVLW      160
	IORWF      INTCON+0, 1
;Lab8.c,12 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;Lab8.c,13 :: 		TRISD &= 0x01;
	MOVLW      1
	ANDWF      TRISD+0, 1
;Lab8.c,14 :: 		PORTD &= 0x01;
	MOVLW      1
	ANDWF      PORTD+0, 1
;Lab8.c,15 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Lab8.c,17 :: 		void interrupt(){
;Lab8.c,18 :: 		if(INTCON & 0b00000100){
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;Lab8.c,20 :: 		++cuenta = cuenta > 15 ? 0 : cuenta;
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
	MOVF       _cuenta+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt8
	MOVF       _cuenta+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt8
	MOVF       _cuenta+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt8
	MOVF       _cuenta+0, 0
	SUBLW      15
L__interrupt8:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
	CLRF       R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	GOTO       L_interrupt2
L_interrupt1:
	MOVF       _cuenta+0, 0
	MOVWF      R4+0
	MOVF       _cuenta+1, 0
	MOVWF      R4+1
	MOVF       _cuenta+2, 0
	MOVWF      R4+2
	MOVF       _cuenta+3, 0
	MOVWF      R4+3
L_interrupt2:
	MOVF       R4+0, 0
	MOVWF      _cuenta+0
	MOVF       R4+1, 0
	MOVWF      _cuenta+1
	MOVF       R4+2, 0
	MOVWF      _cuenta+2
	MOVF       R4+3, 0
	MOVWF      _cuenta+3
;Lab8.c,21 :: 		PORTD ^= !cuenta ? 0x01 : 0x00;
	MOVF       R4+0, 0
	IORWF      R4+1, 0
	IORWF      R4+2, 0
	IORWF      R4+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
	MOVLW      1
	MOVWF      R8+0
	GOTO       L_interrupt4
L_interrupt3:
	CLRF       R8+0
L_interrupt4:
	MOVF       R8+0, 0
	XORWF      PORTD+0, 1
;Lab8.c,22 :: 		INTCON &= 0b11111011; //limpiar bandera de interrupcion
	MOVLW      251
	ANDWF      INTCON+0, 1
;Lab8.c,23 :: 		}
L_interrupt0:
;Lab8.c,24 :: 		}
L_end_interrupt:
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
