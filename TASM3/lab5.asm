MYCODE SEGMENT 'CODE'
ASSUME CS:MYCODE, DS:MYCODE
	HEX_STRING DB '0123456789ABCDEF' ; íÄÅãàñÄ äéÑàêéÇäà
	STR1 DB 'ÇÇÖÑàíÖ ëíêéäì$'
	STR2 DB 'çÄÜåàíÖ "Q" Ñãü ÇõïéÑÄ: $'

  START:
	; áÄÉêìáäÄ ëÖÉåÖçíçéÉé êÖÉàëíêÄ DS
	PUSH CS
	POP DS
	MOV BX, OFFSET HEX_STRING
	
	;PUSH DS
	;POP AX
	;PUSH AX
	;MOV DL, AH
	;MOV AH, AL
	;MOV AL, DL
	;CALL HEX
	;POP AX
	;CALL HEX	

	; ÅìîÖê
	BUF DB 20 DUP (' ')
	
	; éóàëíäÄ ùäêÄçÄ
	;CALL CLRSCR;
	
	MOV CX, 10
    MAIN:
	
		; ÇõÇéÑ ëééÅôÖçàü é ÇÇéÑÖ ëíêéäà
		MOV DX, OFFSET STR1
		CALL PUTST
		CALL CLRF
		
		LEA SI, BUF

    INPUT:
		; áÄèàëú ëàåÇééÇ Ç èÄåüíú
		CALL GETCH
		MOV [SI], AL
	
		; ëêÄÇçÖçàÖ ë $
		CMP AL, '$'
		JE STARTOUTPUT
		INC SI
		JMP INPUT 
		
    STARTOUTPUT:
		; êÄÇçé
		MOV DX, 32
		CALL PUTCH
		MOV DX, 205
		CALL PUTCH
		MOV DX, 32
		CALL PUTCH
		
		; ëéïêÄçÖçàÖ CX
		PUSH CX
		
		; ÑãàçÄ ëóàíÄççéâ ëíêéäà
		MOV CX, SI
		LEA SI, BUF
		SUB CX, SI
		MOV DX, CX
		ADD DX, 5
	SYMBOL:
		
		; èéãìóÖçàÖ ëàåÅéãÄ àá ÅìîÖêÄ
		MOV AL, [SI]
		INC SI
		PUSH DX
		; ÇõÇéÑ ëàåÇéãÄ çÄ ùäêÄç
		CALL HEX
		
		CALL CLRF
		
		POP DX
		PUSH CX
		
		MOV CX, DX
		PUSH DX
		SPACE:
			; ÇõÇéÑ èêéÅÖãÄ
			MOV DX, 32
			CALL PUTCH
		LOOP SPACE
		POP DX
		INC DX
		POP CX
	LOOP SYMBOL
	
		; àáÇãÖóÖçàÖ CX
		POP CX
	
		; ÇÇõéÑ ëééÅôÖçàü é áÄÇÖêòÖçàà àãà èêéÑéãÜÖçàà èêéÉêÄååõ
		CALL CLRF
		MOV DX, OFFSET STR2
		CALL PUTST
		CALL GETCH
		CMP AL, 'q'
		JE EXIT 
		CALL CLRF
		
	LOOP MAIN
	
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
		MOV AH, 01H
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

  XLAT

  MOV   DL, AL
	CALL  PUTCH
	POP   AX
	AND   AL, 00001111B

	XLAT

  MOV   DL, AL
	CALL  PUTCH
	MOV   DX, 104
  CALL  PUTCH
	CALL  CLRF
  RET
	HEX ENDP
	
; äéçÖñ ëÖÉåÖçíÄ
MYCODE ENDS	
END START
