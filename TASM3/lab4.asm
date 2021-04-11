MYCODE SEGMENT 'CODE'
  ASSUME CS:MYCODE, DS:MYCODE
	
	HEXSTRING DB '0123456789ABCDEF' ; íÄÅãàñÄ èÖêÖäéÑàêéÇäà
	STARTSTR DB 'ÇÖÑàíÖ ëàåÇéã Ñãü çÄóÄãÄ êÄÅéíõ èêéÉêÄååõ$'
	MSGSTR DB 'Ñãü ÇõïéÑÄ àá èêéÉêÄååõ çÄÜåàíÖ "q"$'

  START:
	; áÄÉêìáäÄ ëÖÉåÖçíçéÉé êÖÉàëíêÄ ÑÄççõï DS
    PUSH CS
    POP  DS
	  MOV  BX, OFFSET HEXSTRING
	
  MAIN:
    ; éóàëíäÄ ùäêÄçÄ
    CALL CLRSCR;
    
    ; ÇõÇéÑ ëíêéäà-èéÑëäÄáäà é íéå, óíé çÄÑé ÇÇÖëíà ÅìäÇì
    MOV  DX, OFFSET STARTSTR
    CALL PUTST
    CALL CLRF
    
    ; áÄèêéë çÄ ÇÇéÑ ëàåÇéãÄ 
    CALL GETCH
    PUSH AX
    
    ; ñàäãàóÖëäàâ ÇõÇéÑ ÅìäÇ çÄ ùäêÄç
    MOV  CX, 20
    PRINT:
    
      ; ÇõÇéÑ ÅìäÇõ
      MOV   DL, AL
      PUSH  AX
      CALL  PUTCH
      
      ; íàêÖ
      MOV   DX, 32
      CALL  PUTCH
      MOV   DX, 205
      CALL  PUTCH
      MOV   DX, 32
      CALL  PUTCH
      
      ; ÇõÇéÑ HEX
      POP   AX
      CALL  HEX
      POP   AX
      
      ; INCREMENT ÅìäÇõ
      INC   AL
      PUSH  AX
      
    LOOP PRINT
    
    ; áÄèêéë çÄ èêéÑéãÜÖçàÖ èêéÉêÄååõ
    MOV DX, OFFSET MSGSTR
    CALL PUTST
    CALL CLRF
    CALL GETCH
    CMP AL, 'q'
      JE EXIT ; JUMP IF ZF FLAG IS EQUAL TO 1
    JMP MAIN

  EXIT:
    ; éóàëíäÄ ùäêÄçÄ
    CALL CLRSCR;
    
    ; ÇõïéÑ àá èêéÉêÄååõ
    MOV AL, 0
    MOV AH, 4CH
    INT 021H
	
	; èêéñÖÑìêÄ - ÇõÇéÑ ëíêéäà çÄ ùäêÄç
	PUTST PROC
		MOV AH, 09H
		INT 021H
		RET
	PUTST ENDP
	
	; èêéñÖÑìêÄ - ÇõÇéÑ ëàåÇéãÄ 
	PUTCH PROC
		MOV AH, 02H
		INT 021H
		RET
	PUTCH ENDP

	; èêéñÖÑìêÄ - èÖêÖÇéÑ ëíêéäà
	CLRF PROC
		MOV   DL, 10
		CALL  PUTCH
		MOV   DL, 13
		CALL  PUTCH
		RET
	CLRF ENDP 

	; èêéñÖÑìêÄ - ÇÇéÑ ëàåÇéãÄ 
	GETCH PROC   
		MOV AH, 08H
		INT 021H
    RET
	GETCH ENDP

	; èêéñÖÑìêÄ - éóàëíäÄ ùäêÄçÄ 
	CLRSCR PROC   
		MOV AX, 03
    INT 10H
    RET
	CLRSCR ENDP
	
	; èÖêÖÇéÑ Ç 16
	HEX PROC
	PUSH  AX
	SHR   AL, 4 ; 0035 0011 0101 -> 0000 0011

	CALL  KASTIL ; XLAT

  MOV   DL, AL
	CALL  PUTCH
	POP   AX
	AND   AL, 00001111B

	CALL  KASTIL ; XLAT

  MOV   DL, AL
	CALL  PUTCH
	MOV   DX, 104
  CALL  PUTCH
	CALL  CLRF
  RET
	HEX ENDP

  ; MY OWN XLAT
  KASTIL PROC
    PUSH  BX
    MOV   AH, 0
    ADD   BX, AX
    MOV   AL, [BX]
    POP   BX
    RET
  KASTIL ENDP

; äéçÖñ ëÖÉåÖçíÄ
MYCODE ENDS
END START