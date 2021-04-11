MYCODE SEGMENT 'CODE'
ASSUME CS:MYCODE, DS:MYCODE
	HEX_STRING DB '0123456789ABCDEF' ; ������� ���������
	STR1 DB '������� ������$'
	STR2 DB '������� "Q" ��� ������: $'

  START:
	; �������� ����������� �������� DS
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

	; �����
	BUF DB 20 DUP (' ')
	
	; ������� ������
	;CALL CLRSCR;
	
	MOV CX, 10
    MAIN:
	
		; ����� ��������� � ����� ������
		MOV DX, OFFSET STR1
		CALL PUTST
		CALL CLRF
		
		LEA SI, BUF

    INPUT:
		; ������ ������� � ������
		CALL GETCH
		MOV [SI], AL
	
		; ��������� � $
		CMP AL, '$'
		JE STARTOUTPUT
		INC SI
		JMP INPUT 
		
    STARTOUTPUT:
		; �����
		MOV DX, 32
		CALL PUTCH
		MOV DX, 205
		CALL PUTCH
		MOV DX, 32
		CALL PUTCH
		
		; ���������� CX
		PUSH CX
		
		; ����� ��������� ������
		MOV CX, SI
		LEA SI, BUF
		SUB CX, SI
		MOV DX, CX
		ADD DX, 5
	SYMBOL:
		
		; ��������� ������� �� ������
		MOV AL, [SI]
		INC SI
		PUSH DX
		; ����� ������� �� �����
		CALL HEX
		
		CALL CLRF
		
		POP DX
		PUSH CX
		
		MOV CX, DX
		PUSH DX
		SPACE:
			; ����� �������
			MOV DX, 32
			CALL PUTCH
		LOOP SPACE
		POP DX
		INC DX
		POP CX
	LOOP SYMBOL
	
		; ���������� CX
		POP CX
	
		; ����� ��������� � ���������� ��� ����������� ���������
		CALL CLRF
		MOV DX, OFFSET STR2
		CALL PUTST
		CALL GETCH
		CMP AL, 'q'
		JE EXIT 
		CALL CLRF
		
	LOOP MAIN
	
    EXIT:
	; ������� ������
	CALL CLRSCR;
	
	; ����� �� ���������
	MOV AL, 0
	MOV AH, 4CH
	INT 021H
	
	; ��������� - ����� ������ �� �����
	PUTST PROC
		MOV AH, 09H
		INT 021H
		RET
	PUTST ENDP
	
	; ��������� - ����� ������� 
	PUTCH PROC
		MOV AH, 02H
		INT 021H
		RET
	PUTCH ENDP

	; ��������� - ������� ������
	CLRF PROC
		MOV   DL, 10
		CALL  PUTCH
		MOV   DL, 13
		CALL  PUTCH
		RET
	CLRF ENDP 

	; ��������� - ���� ������� 
	GETCH PROC   
		MOV AH, 01H
		INT 021H
    RET
	GETCH ENDP

	; ��������� - ������� ������ 
	CLRSCR PROC   
		MOV AX, 03
    INT 10H
    RET
	CLRSCR ENDP
	
	; ������� � 16
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
	
; ����� ��������
MYCODE ENDS	
END START