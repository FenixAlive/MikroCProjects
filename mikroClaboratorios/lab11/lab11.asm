
_main:

;lab11.c,2 :: 		void main() {
;lab11.c,4 :: 		TRISC = 0;
	CLRF       TRISC+0
;lab11.c,5 :: 		PORTC = 0;
	CLRF       PORTC+0
;lab11.c,7 :: 		PWM1_Init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;lab11.c,8 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;lab11.c,12 :: 		while (1) {
L_main0:
;lab11.c,13 :: 		PWM1_Set_Duty(duty++);
	MOVF       _duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
	INCF       _duty+0, 1
;lab11.c,14 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
;lab11.c,15 :: 		}
	GOTO       L_main0
;lab11.c,16 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
