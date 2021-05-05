MYCODE SEGMENT 'CODE'
    ASSUME CS:MYCODE, DS:DATA
	
START:
	; �������� ����������� �������� ������ DS
	MOV AX, DATA
	MOV DS, AX
	
MAIN:
	;������� ������
	CALL CLRSCR;
	
	; ����������� ������ �������
	MOV DL, OFFSET STARTSTR
	CALL PUTST
	CALL CLRF
	
	; ������� ������� � ������� ���� ����� �������� �������
	MOV CX, 0 
	MOV BX, 0
		
	CHAR_HAND:
		; �������� ����� �������
		CALL GETCH_NO_ECHO
		CMP AL, '*'
		JE EXIT
		
		; �������� �� ������������ ��������� ������ � ������� � �������� ���
		CALL HEX_TO_MACH
	
	CMP CX, 4
	JNE CHAR_HAND
	
	; ��������� �����
	PUSH BX
	
	; А���
	MOV DL, ' '
	CALL PUTCH
	MOV DL, '='
	CALL PUTCH
	MOV DL, ' '
	CALL PUTCH
	
	; ��������� �����
	MOV DX, BX
	PUSH DX
	
	; ����� �� ����� ������ 2 ��������
	MOV AL, DH
	CALL HEX
	
	; ����� �� ����� ������ 2 ��������
	POP DX
	MOV AL, DL
	CALL HEX
	
	; ����� H
	MOV DX, 'H'
	CALL PUTCH
	
	; ����
	MOV DL, ' '
	CALL PUTCH
	MOV DL, '-'
	CALL PUTCH
	MOV DL, ' '
	CALL PUTCH
	
	; ����� ����������� �����
	POP BX
	CALL MACH_TO_DEC
	CALL CLRF
	
	; �������� ����� �������
	CALL GETCH_NO_ECHO

JMP MAIN

EXIT:
	; ������� ������
	CALL CLRSCR;
	
	; ����� �������� � 𕑕
	MOV DL, OFFSET INFSTR
	CALL PUTST
	CALL CLRF
	
	; �������� ����� �������
	CALL GETCH_NO_ECHO
	
	; ������� ������
	CALL CLRSCR;
	
	; ����� �� ��𐜜�
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
	MOV DL, 10
	CALL PUTCH
	MOV DL, 13
	CALL PUTCH
	RET
CLRF ENDP 


; ��������� - ���� ������� � ���
GETCH_ECHO PROC   
	MOV AH, 01H
	INT 021H
    RET
GETCH_ECHO ENDP
	
	
; ��������� - ���� ������� ��� ���
GETCH_NO_ECHO PROC   
	MOV AH, 08H
	INT 021H
    RET
GETCH_NO_ECHO ENDP


; ��������� - ������� ������
CLRSCR PROC   
	MOV AH, 00H 
	MOV AL, 02
	INT 10H
	RET
CLRSCR ENDP


; ��������� - ������� � 16
HEX PROC
	MOV BX, OFFSET HEXSTR
	
	; ��������� ��������
	PUSH AX
	SHR AL, 4
	XLAT 
	
	; ����� ��������
	MOV DL, AL
	CALL PUTCH
	
	; ��������� ������
	POP AX
	AND AL, 00001111B
	XLAT 
	
	; ����� ������
	MOV DL, AL
	CALL PUTCH
	
	RET
HEX ENDP


; ��������� - ������� � �������� ���
HEX_TO_MACH PROC
	MOV DL, AL
	
	; �������� �� ���� �����
	CHECK_NUM:
		; �������� �� �����
		CMP AL,'0'
		JB CHECK_BIG_LET
		CMP AL,'9'
		JA CHECK_BIG_LET
		
		; ��������� �����
		SUB AL,'0' 
		PUSH AX
	JMP CORRECT
	
	; �������� �� ���� ������� �����
	CHECK_BIG_LET: 
		; �������� �� ������� �����
		CMP AL,'A' 
		JB CHECK_LIT_LET
		CMP AL,'F'
		JA CHECK_LIT_LET
		
		; ��������� �����
		SUB AL,'A' 
		ADD AL, 10  
		PUSH AX
	JMP CORRECT
	
	; �������� �� ���� ��������� �����
	CHECK_LIT_LET:
		; �������� �� ��������� �����
		CMP AL,'A' 
		JB FINISH
		CMP AL,'F'
		JA FINISH
		
		; ��������� �����
		SUB AL,'A' 
		ADD AL, 10 
		PUSH AX
	JMP CORRECT	
	
	; ���� ��������� ������ ������������� ��������
	CORRECT: 
		; ����� �� �����
		CALL PUTCH 
		
		; ���������� � BX ������ �������
		POP AX 
		MOV AH, 0    
		SHL BX, 4
		ADD BX, AX	
	; ���������� ��������
	INC CX 
	
	; ����� �� �������
	FINISH: 
	RET
HEX_TO_MACH ENDP

; ��������� - ������� � ���������� ���
MACH_TO_DEC PROC
	; AX - �������
	MOV AX, BX      	
	MOV SI, 0
	
	CYCLE:
		; DX - �������
		MOV DX, 0	
		; BX - ��������
		MOV BX, ARR[SI]	;�������� 
	
		; ����� AX �� BX, ��� ���� AX - �������, DX - �������
		DIV BX	
		; ��������� �������
		PUSH DX

		; ����� ������� �� �����
		ADD AX,'0'		
		MOV DL,AL
		CALL PUTCH

		; �������� ����� �������
		POP AX
		INC SI
		INC SI
	
		CMP SI, 10
	JB CYCLE	
RET
MACH_TO_DEC	ENDP

; ����� ��������
MYCODE ENDS


DATA SEGMENT
	STARTSTR DB, '������� ����� (HHHH) :$'
	HEXSTR DB '0123456789ABCDEF'
	ARR DW 10000, 1000, 100, 10, 1
	INFSTR DB, '��������� �����$'
DATA ENDS

END START
