; Öëãà äéÑ óÖíçõâ íé ÇõÇéÑàíú, Öëãà çÖóÖíçõâ - çÖ ÇõÇéÑàíú
; ÑéããÄê çÖ ÇõÇéÑàíú

MYCODE SEGMENT 'CODE'
ASSUME CS:MYCODE, DS:MYCODE
	HEX_STRING DB '0123456789ABCDEF' ; íÄÅãàñÄ äéÑàêéÇäà
	STARTMSG DB 'ÇÇÖÑàíÖ ëíêéäì$'
	ENDMSG DB 'çÄÜåàíÖ "q" Ñãü ÇõïéÑÄ: $'

  START:
	; áÄÉêìáäÄ ëÖÉåÖçíçéÉé êÖÉàëíêÄ DS
	PUSH CS
	POP DS
	MOV BX, OFFSET HEX_STRING

	; ÅìîÖê
	BUF DB 20 DUP (' ')
	
	; éóàëíäÄ ùäêÄçÄ
	CALL CLRSCR
	
	MOV CX, 10
  MAIN:

		; ÇõÇéÑ ëééÅôÖçàü é ÇÇéÑÖ ëíêéäà
		MOV DX, OFFSET STARTMSG
		CALL PUTSTR
		CALL CLRF
		
		LEA SI, BUF

    INPUT:
		; áÄèàëú ëàåÇéãéÇ Ç èÄåüíú
		CALL GETCH
		MOV [SI], AL
	
		; ëêÄÇçÖçàÖ ë $
		CMP AL, '$'
		JE STARTOUTPUT
		INC SI
		JMP INPUT
		
    STARTOUTPUT:
    ; BACKSPACE
    MOV DX, 08
		CALL PUTCH
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
    SYMBOL:
      
      ; èéãìóÖçàÖ ëàåÅéãÄ àá ÅìîÖêÄ
      MOV AL, [SI]
      INC SI
      ; ÇõÇéÑ ëàåÇéãÄ çÄ ùäêÄç
      CALL HEX
      
      ; SPACE
      MOV DX, 32
      CALL PUTCH
      
    LOOP SYMBOL
    
		; àáÇãÖóÖçàÖ CX
		POP CX
	
		; ÇÇõéÑ ëééÅôÖçàü é áÄÇÖêòÖçàà àãà èêéÑéãÜÖçàà èêéÉêÄååõ
		CALL CLRF
		MOV DX, OFFSET ENDMSG
		CALL PUTSTR
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
	PUTSTR PROC
		MOV AH, 09H
		INT 021H
		RET
	PUTSTR ENDP
	
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

  SAR AL, 01
  JNC ISEVEN

  MOV DX, 08
  CALL PUTCH
  JMP TERMINATE

  ISEVEN:
	CALL  PUTCH
	MOV   DX, 104
  CALL  PUTCH
  
  TERMINATE:
  RET
	HEX ENDP
	
; äéçÖñ ëÖÉåÖçíÄ
MYCODE ENDS	
END START
