
_musica:

;lab5.c,4 :: 		void musica(unsigned char *idx, unsigned char *cual, const int tiempo){
;lab5.c,5 :: 		switch (*cual){
	GOTO       L_musica0
;lab5.c,6 :: 		case 0:
L_musica2:
;lab5.c,7 :: 		if(*idx < 8){
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVLW      8
	SUBWF      INDF+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_musica3
;lab5.c,8 :: 		if( *idx % 2 ){
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	BTFSS      R1+0, 0
	GOTO       L_musica4
;lab5.c,9 :: 		Sound_Play(notas[0], tiempo);
	MOVLW      220
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	CLRF       FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,10 :: 		}else{
	GOTO       L_musica5
L_musica4:
;lab5.c,11 :: 		Sound_Play(notas[(*idx+1)/2], tiempo);
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVF       R1+0, 0
	MOVWF      R3+0
	MOVF       R1+1, 0
	MOVWF      R3+1
	RRF        R3+1, 1
	RRF        R3+0, 1
	BCF        R3+1, 7
	BTFSC      R3+1, 6
	BSF        R3+1, 7
	BTFSS      R3+1, 7
	GOTO       L__musica55
	BTFSS      STATUS+0, 0
	GOTO       L__musica55
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
L__musica55:
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _notas+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_notas+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+2
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+3
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVF       R0+1, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,12 :: 		}
L_musica5:
;lab5.c,13 :: 		}else{
	GOTO       L_musica6
L_musica3:
;lab5.c,14 :: 		if( *idx % 2 ){
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	BTFSS      R1+0, 0
	GOTO       L_musica7
;lab5.c,15 :: 		Sound_Play(notas[4], tiempo);
	MOVLW      73
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,16 :: 		}else{
	GOTO       L_musica8
L_musica7:
;lab5.c,17 :: 		Sound_Play(notas[(15-*idx)/2], tiempo);
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBLW      15
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVF       R1+0, 0
	MOVWF      R3+0
	MOVF       R1+1, 0
	MOVWF      R3+1
	RRF        R3+1, 1
	RRF        R3+0, 1
	BCF        R3+1, 7
	BTFSC      R3+1, 6
	BSF        R3+1, 7
	BTFSS      R3+1, 7
	GOTO       L__musica56
	BTFSS      STATUS+0, 0
	GOTO       L__musica56
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
L__musica56:
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _notas+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_notas+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+2
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+3
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVF       R0+1, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,18 :: 		}
L_musica8:
;lab5.c,19 :: 		}
L_musica6:
;lab5.c,20 :: 		break;
	GOTO       L_musica1
;lab5.c,21 :: 		case 1:
L_musica9:
;lab5.c,22 :: 		if(*idx % 2){
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	BTFSS      R1+0, 0
	GOTO       L_musica10
;lab5.c,23 :: 		Sound_Play(notas[4], tiempo);
	MOVLW      73
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,24 :: 		}else{
	GOTO       L_musica11
L_musica10:
;lab5.c,25 :: 		if(*idx<8){
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVLW      8
	SUBWF      INDF+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_musica12
;lab5.c,26 :: 		Sound_Play(notas[4-((*idx+1)/2)], tiempo);
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	BTFSS      R0+1, 7
	GOTO       L__musica57
	BTFSS      STATUS+0, 0
	GOTO       L__musica57
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
L__musica57:
	MOVF       R0+0, 0
	SUBLW      4
	MOVWF      R3+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R3+1
	SUBWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _notas+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_notas+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+2
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+3
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVF       R0+1, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,27 :: 		}else{
	GOTO       L_musica13
L_musica12:
;lab5.c,28 :: 		Sound_Play(notas[8-((*idx+1)/2)], tiempo);
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	BTFSS      R0+1, 7
	GOTO       L__musica58
	BTFSS      STATUS+0, 0
	GOTO       L__musica58
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
L__musica58:
	MOVF       R0+0, 0
	SUBLW      8
	MOVWF      R3+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R3+1
	SUBWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _notas+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_notas+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+2
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+3
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVF       R0+1, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,29 :: 		}
L_musica13:
;lab5.c,30 :: 		}
L_musica11:
;lab5.c,31 :: 		break;
	GOTO       L_musica1
;lab5.c,32 :: 		case 2:
L_musica14:
;lab5.c,33 :: 		if(*idx % 2){
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	BTFSS      R1+0, 0
	GOTO       L_musica15
;lab5.c,34 :: 		if(*idx<8){
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVLW      8
	SUBWF      INDF+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_musica16
;lab5.c,35 :: 		Sound_Play(notas[4], tiempo);
	MOVLW      73
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,36 :: 		}else if (*idx == 14) {
	GOTO       L_musica17
L_musica16:
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      14
	BTFSS      STATUS+0, 2
	GOTO       L_musica18
;lab5.c,37 :: 		Sound_Play(notas[8], tiempo);
	MOVLW      237
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,38 :: 		}else{
	GOTO       L_musica19
L_musica18:
;lab5.c,39 :: 		Sound_Play(notas[9], tiempo);
	MOVLW      11
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,40 :: 		}
L_musica19:
L_musica17:
;lab5.c,41 :: 		}else{
	GOTO       L_musica20
L_musica15:
;lab5.c,42 :: 		if(*idx<8){
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVLW      8
	SUBWF      INDF+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_musica21
;lab5.c,43 :: 		Sound_Play(notas[0], tiempo);
	MOVLW      220
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	CLRF       FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,44 :: 		}else{
	GOTO       L_musica22
L_musica21:
;lab5.c,45 :: 		Sound_Play(notas[(*idx+1)/2], tiempo);
	MOVF       FARG_musica_idx+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVF       R1+0, 0
	MOVWF      R3+0
	MOVF       R1+1, 0
	MOVWF      R3+1
	RRF        R3+1, 1
	RRF        R3+0, 1
	BCF        R3+1, 7
	BTFSC      R3+1, 6
	BSF        R3+1, 7
	BTFSS      R3+1, 7
	GOTO       L__musica59
	BTFSS      STATUS+0, 0
	GOTO       L__musica59
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
L__musica59:
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _notas+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_notas+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+2
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+3
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVF       R0+1, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_musica_tiempo+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_musica_tiempo+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,46 :: 		}
L_musica22:
;lab5.c,47 :: 		}
L_musica20:
;lab5.c,48 :: 		break;
	GOTO       L_musica1
;lab5.c,49 :: 		}
L_musica0:
	MOVF       FARG_musica_cual+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_musica2
	MOVF       FARG_musica_cual+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_musica9
	MOVF       FARG_musica_cual+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_musica14
L_musica1:
;lab5.c,51 :: 		}
L_end_musica:
	RETURN
; end of _musica

_apagaDisplay:

;lab5.c,54 :: 		void apagaDisplay(){
;lab5.c,55 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;lab5.c,56 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_apagaDisplay23:
	DECFSZ     R13+0, 1
	GOTO       L_apagaDisplay23
	DECFSZ     R12+0, 1
	GOTO       L_apagaDisplay23
	NOP
	NOP
;lab5.c,57 :: 		}
L_end_apagaDisplay:
	RETURN
; end of _apagaDisplay

_presentacion:

;lab5.c,59 :: 		void presentacion(){
;lab5.c,61 :: 		unsigned char k = 1;
	MOVLW      1
	MOVWF      presentacion_k_L0+0
	CLRF       presentacion_i_L0+0
;lab5.c,63 :: 		for(;i<8;i++){
L_presentacion24:
	MOVLW      8
	SUBWF      presentacion_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_presentacion25
;lab5.c,64 :: 		PORTC = pres[i];
	MOVF       presentacion_i_L0+0, 0
	ADDLW      presentacion_pres_L0+0
	MOVWF      R0+0
	MOVLW      hi_addr(presentacion_pres_L0+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;lab5.c,65 :: 		musica(&i,&k,230);
	MOVLW      presentacion_i_L0+0
	MOVWF      FARG_musica_idx+0
	MOVLW      presentacion_k_L0+0
	MOVWF      FARG_musica_cual+0
	MOVLW      230
	MOVWF      FARG_musica_tiempo+0
	CLRF       FARG_musica_tiempo+1
	CALL       _musica+0
;lab5.c,63 :: 		for(;i<8;i++){
	INCF       presentacion_i_L0+0, 1
;lab5.c,66 :: 		}
	GOTO       L_presentacion24
L_presentacion25:
;lab5.c,67 :: 		apagaDisplay();
	CALL       _apagaDisplay+0
;lab5.c,68 :: 		}
L_end_presentacion:
	RETURN
; end of _presentacion

_actividad0f:

;lab5.c,70 :: 		void actividad0f(unsigned char tabla[]){
;lab5.c,71 :: 		unsigned char i, j=1, k=0;
	MOVLW      1
	MOVWF      actividad0f_j_L0+0
	CLRF       actividad0f_k_L0+0
;lab5.c,74 :: 		while(1){
L_actividad0f27:
;lab5.c,75 :: 		for(i=0; i<16; i++){
	CLRF       actividad0f_i_L0+0
L_actividad0f29:
	MOVLW      16
	SUBWF      actividad0f_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_actividad0f30
;lab5.c,76 :: 		PORTC = tabla[i];
	MOVF       actividad0f_i_L0+0, 0
	ADDWF      FARG_actividad0f_tabla+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;lab5.c,77 :: 		if((j==20)){
	MOVF       actividad0f_j_L0+0, 0
	XORLW      20
	BTFSS      STATUS+0, 2
	GOTO       L_actividad0f32
;lab5.c,78 :: 		k=2;
	MOVLW      2
	MOVWF      actividad0f_k_L0+0
;lab5.c,79 :: 		if(i==15){
	MOVF       actividad0f_i_L0+0, 0
	XORLW      15
	BTFSS      STATUS+0, 2
	GOTO       L_actividad0f33
;lab5.c,80 :: 		j=0;
	CLRF       actividad0f_j_L0+0
;lab5.c,81 :: 		}
L_actividad0f33:
;lab5.c,82 :: 		}else if((j==10)){
	GOTO       L_actividad0f34
L_actividad0f32:
	MOVF       actividad0f_j_L0+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_actividad0f35
;lab5.c,83 :: 		k=2;
	MOVLW      2
	MOVWF      actividad0f_k_L0+0
;lab5.c,84 :: 		}else if(!(j%5)){
	GOTO       L_actividad0f36
L_actividad0f35:
	MOVLW      5
	MOVWF      R4+0
	MOVF       actividad0f_j_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_actividad0f37
;lab5.c,85 :: 		k=1;
	MOVLW      1
	MOVWF      actividad0f_k_L0+0
;lab5.c,86 :: 		}else{
	GOTO       L_actividad0f38
L_actividad0f37:
;lab5.c,87 :: 		k=0;
	CLRF       actividad0f_k_L0+0
;lab5.c,88 :: 		}
L_actividad0f38:
L_actividad0f36:
L_actividad0f34:
;lab5.c,89 :: 		musica(&i,&k,tempo);
	MOVLW      actividad0f_i_L0+0
	MOVWF      FARG_musica_idx+0
	MOVLW      actividad0f_k_L0+0
	MOVWF      FARG_musica_cual+0
	MOVLW      230
	MOVWF      FARG_musica_tiempo+0
	MOVLW      0
	MOVWF      FARG_musica_tiempo+1
	CALL       _musica+0
;lab5.c,75 :: 		for(i=0; i<16; i++){
	INCF       actividad0f_i_L0+0, 1
;lab5.c,90 :: 		}
	GOTO       L_actividad0f29
L_actividad0f30:
;lab5.c,91 :: 		j++;
	INCF       actividad0f_j_L0+0, 1
;lab5.c,92 :: 		}
	GOTO       L_actividad0f27
;lab5.c,93 :: 		}
L_end_actividad0f:
	RETURN
; end of _actividad0f

_adivinaBin:

;lab5.c,95 :: 		void adivinaBin(unsigned char tabla[], unsigned char *val){
;lab5.c,97 :: 		*val = rand() % 15 + 1;
	CALL       _rand+0
	MOVLW      15
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	INCF       R0+0, 1
	MOVF       FARG_adivinaBin_val+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;lab5.c,98 :: 		PORTC = tabla[*val];
	MOVF       FARG_adivinaBin_val+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDWF      FARG_adivinaBin_tabla+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;lab5.c,99 :: 		}
L_end_adivinaBin:
	RETURN
; end of _adivinaBin

_juegoBinario:

;lab5.c,101 :: 		void juegoBinario(unsigned char tabla[]){
;lab5.c,103 :: 		unsigned char i, j=0, k = 0, l = 0;
	CLRF       juegoBinario_j_L0+0
	CLRF       juegoBinario_k_L0+0
	CLRF       juegoBinario_l_L0+0
;lab5.c,105 :: 		srand(PORTA);
	MOVF       PORTA+0, 0
	MOVWF      FARG_srand_x+0
	CLRF       FARG_srand_x+1
	CALL       _srand+0
;lab5.c,106 :: 		adivinaBin(tabla, &val);
	MOVF       FARG_juegoBinario_tabla+0, 0
	MOVWF      FARG_adivinaBin_tabla+0
	MOVLW      juegoBinario_val_L0+0
	MOVWF      FARG_adivinaBin_val+0
	CALL       _adivinaBin+0
;lab5.c,107 :: 		while(1) {
L_juegoBinario39:
;lab5.c,108 :: 		musica(&j, &k, 70);
	MOVLW      juegoBinario_j_L0+0
	MOVWF      FARG_musica_idx+0
	MOVLW      juegoBinario_k_L0+0
	MOVWF      FARG_musica_cual+0
	MOVLW      70
	MOVWF      FARG_musica_tiempo+0
	MOVLW      0
	MOVWF      FARG_musica_tiempo+1
	CALL       _musica+0
;lab5.c,109 :: 		if((PORTA ^ 0b00001111) & 0b00001111) {
	MOVLW      15
	XORWF      PORTA+0, 0
	MOVWF      R0+0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_juegoBinario41
;lab5.c,110 :: 		if(++l > 2){
	INCF       juegoBinario_l_L0+0, 1
	MOVF       juegoBinario_l_L0+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L_juegoBinario42
;lab5.c,111 :: 		l = 0;
	CLRF       juegoBinario_l_L0+0
;lab5.c,112 :: 		if(++j > 15){
	INCF       juegoBinario_j_L0+0, 1
	MOVF       juegoBinario_j_L0+0, 0
	SUBLW      15
	BTFSC      STATUS+0, 0
	GOTO       L_juegoBinario43
;lab5.c,113 :: 		j=0;
	CLRF       juegoBinario_j_L0+0
;lab5.c,114 :: 		if(++k > 2){
	INCF       juegoBinario_k_L0+0, 1
	MOVF       juegoBinario_k_L0+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L_juegoBinario44
;lab5.c,115 :: 		k = 0;
	CLRF       juegoBinario_k_L0+0
;lab5.c,116 :: 		}
L_juegoBinario44:
;lab5.c,117 :: 		}
L_juegoBinario43:
;lab5.c,118 :: 		}
L_juegoBinario42:
;lab5.c,119 :: 		musica(&j, &k, 70);
	MOVLW      juegoBinario_j_L0+0
	MOVWF      FARG_musica_idx+0
	MOVLW      juegoBinario_k_L0+0
	MOVWF      FARG_musica_cual+0
	MOVLW      70
	MOVWF      FARG_musica_tiempo+0
	MOVLW      0
	MOVWF      FARG_musica_tiempo+1
	CALL       _musica+0
;lab5.c,120 :: 		if((PORTA ^ 0b00001111) & 0b00001111) {
	MOVLW      15
	XORWF      PORTA+0, 0
	MOVWF      R0+0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_juegoBinario45
;lab5.c,121 :: 		i = (PORTA ^ 0b00001111) & 0b00001111;
	MOVLW      15
	XORWF      PORTA+0, 0
	MOVWF      R0+0
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      juegoBinario_i_L0+0
;lab5.c,122 :: 		if(i == val) {
	MOVF       R1+0, 0
	XORWF      juegoBinario_val_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_juegoBinario46
;lab5.c,123 :: 		apagaDisplay();
	CALL       _apagaDisplay+0
;lab5.c,124 :: 		PORTC = 0x6D; //y
	MOVLW      109
	MOVWF      PORTC+0
;lab5.c,125 :: 		Sound_Play(notas[0]*2, 90);
	MOVLW      184
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      90
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,126 :: 		Sound_Play(notas[1]*2, 90);
	MOVLW      237
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      90
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,127 :: 		Sound_Play(notas[2]*2, 90);
	MOVLW      11
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      90
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;lab5.c,128 :: 		apagaDisplay();
	CALL       _apagaDisplay+0
;lab5.c,129 :: 		adivinaBin(tabla, &val);
	MOVF       FARG_juegoBinario_tabla+0, 0
	MOVWF      FARG_adivinaBin_tabla+0
	MOVLW      juegoBinario_val_L0+0
	MOVWF      FARG_adivinaBin_val+0
	CALL       _adivinaBin+0
;lab5.c,130 :: 		}else{
	GOTO       L_juegoBinario47
L_juegoBinario46:
;lab5.c,131 :: 		PORTC = tabla[i];
	MOVF       juegoBinario_i_L0+0, 0
	ADDWF      FARG_juegoBinario_tabla+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;lab5.c,132 :: 		}
L_juegoBinario47:
;lab5.c,133 :: 		}
L_juegoBinario45:
;lab5.c,134 :: 		}else{
	GOTO       L_juegoBinario48
L_juegoBinario41:
;lab5.c,135 :: 		PORTC = tabla[val];
	MOVF       juegoBinario_val_L0+0, 0
	ADDWF      FARG_juegoBinario_tabla+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;lab5.c,136 :: 		}
L_juegoBinario48:
;lab5.c,137 :: 		if(++l > 3){
	INCF       juegoBinario_l_L0+0, 1
	MOVF       juegoBinario_l_L0+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_juegoBinario49
;lab5.c,138 :: 		l = 0;
	CLRF       juegoBinario_l_L0+0
;lab5.c,139 :: 		if(++j > 15){
	INCF       juegoBinario_j_L0+0, 1
	MOVF       juegoBinario_j_L0+0, 0
	SUBLW      15
	BTFSC      STATUS+0, 0
	GOTO       L_juegoBinario50
;lab5.c,140 :: 		j=0;
	CLRF       juegoBinario_j_L0+0
;lab5.c,141 :: 		if(++k > 2){
	INCF       juegoBinario_k_L0+0, 1
	MOVF       juegoBinario_k_L0+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L_juegoBinario51
;lab5.c,142 :: 		k = 0;
	CLRF       juegoBinario_k_L0+0
;lab5.c,143 :: 		}
L_juegoBinario51:
;lab5.c,144 :: 		}
L_juegoBinario50:
;lab5.c,145 :: 		}
L_juegoBinario49:
;lab5.c,146 :: 		}
	GOTO       L_juegoBinario39
;lab5.c,147 :: 		}
L_end_juegoBinario:
	RETURN
; end of _juegoBinario

_main:

;lab5.c,149 :: 		void main() {
;lab5.c,150 :: 		unsigned char tabla[] = {0x77, 0x41, 0x3B, 0x6B, 0x4D, 0x6E, 0x7E, 0x43, 0x7F, 0x6F, 0x5F, 0x7C, 0x36, 0x79, 0x3E, 0x1E};
	MOVLW      119
	MOVWF      main_tabla_L0+0
	MOVLW      65
	MOVWF      main_tabla_L0+1
	MOVLW      59
	MOVWF      main_tabla_L0+2
	MOVLW      107
	MOVWF      main_tabla_L0+3
	MOVLW      77
	MOVWF      main_tabla_L0+4
	MOVLW      110
	MOVWF      main_tabla_L0+5
	MOVLW      126
	MOVWF      main_tabla_L0+6
	MOVLW      67
	MOVWF      main_tabla_L0+7
	MOVLW      127
	MOVWF      main_tabla_L0+8
	MOVLW      111
	MOVWF      main_tabla_L0+9
	MOVLW      95
	MOVWF      main_tabla_L0+10
	MOVLW      124
	MOVWF      main_tabla_L0+11
	MOVLW      54
	MOVWF      main_tabla_L0+12
	MOVLW      121
	MOVWF      main_tabla_L0+13
	MOVLW      62
	MOVWF      main_tabla_L0+14
	MOVLW      30
	MOVWF      main_tabla_L0+15
;lab5.c,151 :: 		TRISA = 0x0F;
	MOVLW      15
	MOVWF      TRISA+0
;lab5.c,152 :: 		PORTA = 0x0F;
	MOVLW      15
	MOVWF      PORTA+0
;lab5.c,153 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;lab5.c,154 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;lab5.c,155 :: 		ANSEL = 0X00;
	CLRF       ANSEL+0
;lab5.c,156 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;lab5.c,158 :: 		TRISB.RB7 = 0;
	BCF        TRISB+0, 7
;lab5.c,159 :: 		PORTB.RB7 = 0;
	BCF        PORTB+0, 7
;lab5.c,160 :: 		Sound_Init(&PORTB,7);
	MOVLW      PORTB+0
	MOVWF      FARG_Sound_Init_snd_port+0
	MOVLW      7
	MOVWF      FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;lab5.c,161 :: 		if(((PORTA ^ 0b00001111) & 0b00001111) == 1){
	MOVLW      15
	XORWF      PORTA+0, 0
	MOVWF      R0+0
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main52
;lab5.c,162 :: 		actividad0f(tabla);
	MOVLW      main_tabla_L0+0
	MOVWF      FARG_actividad0f_tabla+0
	CALL       _actividad0f+0
;lab5.c,163 :: 		}else{
	GOTO       L_main53
L_main52:
;lab5.c,164 :: 		presentacion();
	CALL       _presentacion+0
;lab5.c,165 :: 		juegoBinario(tabla);
	MOVLW      main_tabla_L0+0
	MOVWF      FARG_juegoBinario_tabla+0
	CALL       _juegoBinario+0
;lab5.c,166 :: 		}
L_main53:
;lab5.c,167 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
