MYCODE SEGMENT 'CODE'
  ASSUME CS:MYCODE, DS:MYCODE
	
	HEX_STRING DB '0123456789ABCDEF' ; ’€‹ˆ–€ ……ŠŽ„ˆŽ‚Šˆ
	STARTSTR DB '‚…„ˆ’… ‘ˆŒ‚Ž‹ „‹Ÿ €—€‹€ €Ž’› Žƒ€ŒŒ›$'
	MSGSTR DB '„‹Ÿ ‚›•Ž„€ ˆ‡ Žƒ€ŒŒ› €†Œˆ’… "q"$'

  START:
	; ‡€ƒ“‡Š€ ‘…ƒŒ…’ŽƒŽ …ƒˆ‘’€ „€›• DS
    PUSH CS
    POP  DS
	  MOV  BX, OFFSET HEX_STRING
	
  MAIN:
    ; Ž—ˆ‘’Š€ Š€€
    CALL CLRSCR;
    
    ; ‚›‚Ž„ ‘’ŽŠˆ-Ž„‘Š€‡Šˆ Ž ’ŽŒ, —’Ž €„Ž ‚‚…‘’ˆ “Š‚“
    MOV  DX, OFFSET STARTSTR
    CALL PUTST
    CALL CLRF
    
    ; ‡€Ž‘ € ‚‚Ž„ ‘ˆŒ‚Ž‹€ 
    CALL GETCH
    PUSH AX
    
    ; –ˆŠ‹ˆ—…‘Šˆ‰ ‚›‚Ž„ “Š‚ € Š€
    MOV  CX, 20
    ZALOOP:
    
      ; ‚›‚Ž„ “Š‚›
      POP   AX
      PUSH  AX
      MOV   DL, AL
      PUSH  AX
      CALL  PUTCH
      
      ; ’ˆ…
      MOV   DX, 32
      CALL  PUTCH
      MOV   DX, 205
      CALL  PUTCH
      MOV   DX, 32
      CALL  PUTCH
      
      ; ‚›‚Ž„ HEX
      POP   AX
      CALL  HEX
      POP   AX
      
      ; INCREMENT “Š‚›
      INC   AL
      PUSH  AX
      
    LOOP ZALOOP
    
    ; ‡€Ž‘ € Ž„Ž‹†…ˆ… Žƒ€ŒŒ›
    MOV DX, OFFSET MSGSTR
    CALL PUTST
    CALL CLRF
    CALL GETCH
    CMP AL, 'q'
      JE EXIT
    JMP MAIN

  EXIT:
    ; Ž—ˆ‘’Š€ Š€€
    CALL CLRSCR;
    
    ; ‚›•Ž„ ˆ‡ Žƒ€ŒŒ›
    MOV AL, 0
    MOV AH, 4CH
    INT 021H
	
	; Ž–…„“€ - ‚›‚Ž„ ‘’ŽŠˆ € Š€
	PUTST PROC
		MOV AH, 09H
		INT 021H
		RET
	PUTST ENDP
	
	; Ž–…„“€ - ‚›‚Ž„ ‘ˆŒ‚Ž‹€ 
	PUTCH PROC
		MOV AH, 02H
		INT 021H
		RET
	PUTCH ENDP

	; Ž–…„“€ - ……‚Ž„ ‘’ŽŠˆ
	CLRF PROC
		MOV   DL, 10
		CALL  PUTCH
		MOV   DL, 13
		CALL  PUTCH
		RET
	CLRF ENDP 

	; Ž–…„“€ - ‚‚Ž„ ‘ˆŒ‚Ž‹€ 
	GETCH PROC   
		MOV AH, 08H
		INT 021H
    RET
	GETCH ENDP

	; Ž–…„“€ - Ž—ˆ‘’Š€ Š€€ 
	CLRSCR PROC   
		MOV AX, 03
    INT 10H
    RET
	CLRSCR ENDP
	
	; ……‚Ž„ ‚ 16
	HEX PROC
	PUSH  AX
	SHR   AL, 4
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
; ŠŽ…– ‘…ƒŒ…’€
MYCODE ENDS
END START