
_main:

;buzzer.c,2 :: 		void main() {
;buzzer.c,4 :: 		OSCCON = 0b01110111;
	MOVLW      119
	MOVWF      OSCCON+0
;buzzer.c,6 :: 		Sound_Init(&PORTD, 0);
	MOVLW      PORTD+0
	MOVWF      FARG_Sound_Init_snd_port+0
	CLRF       FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;buzzer.c,8 :: 		Sound_Play(440, 3000);
	MOVLW      184
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      184
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      11
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;buzzer.c,9 :: 		Sound_Init(&PORTD, 1);
	MOVLW      PORTD+0
	MOVWF      FARG_Sound_Init_snd_port+0
	MOVLW      1
	MOVWF      FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;buzzer.c,10 :: 		Sound_Play(480, 3000);
	MOVLW      224
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      184
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      11
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;buzzer.c,12 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
