.MODEL tiny
.CODE
.386
ORG 100H

; MYCODE SEGMENT 'CODE'
    ; ASSUME CS:MYCODE, DS:DATA
	
START:
	; �������� ����������� �������� ������ DS
	; MOV AX, DATA
	; MOV ES, AX
	PUSH CS
	POP DS
	
MAIN:

	CALL CLRSCR;
	
	; ����������� ���������� ��������� ��������� ������
	MOV SI, 80H
	MOV CL, [SI]
	SUB CL, 1
	
	; ������ �������
	ADD SI, 2
	
	; ����� ������� ��������
	CYCLE:
		MOV AL, [SI]
		CMP AL, ' '
		JE COPY
		INC SI
	LOOP CYCLE
	
	COPY:
	; ��������� ����� ������� ��������
	MOV SI, 80H
	MOV AL, [SI]
	SUB AL, CL
	MOV CL, AL
	SUB CL, 1
		
	PUSH CX
	PUSH CX
	
	MOV SI, 80H
	MOV CL, [SI]
	SUB CL, 1	
		
	; �������� � ����� ������ ��������
	MOV SI, 80H
	ADD SI, 2
	LEA DI, BUF
	REP MOVSB
	
	PUSH ES
    POP DS
	
	MOV DX, OFFSET FIRSTSTR
	CALL PUTST
	
	; ���������� ������ ��������
	LEA DI, BUF
	LEA SI, SURNAMESTR
	POP CX
	REPE CMPSB
	JNE ISNOTEQ
	JE ISEQ

	
	ISNOTEQ:
	; ���� �� �����
	MOV DX, OFFSET WRONGFIRSTSTR
	CALL PUTST
	CALL CLRF 
	JMP SECOND
	
	; ���� �����
	ISEQ:
	MOV DX, OFFSET SUCCESSFIRSTSTR
	CALL PUTST
	MOV DX, OFFSET SURNAMESTR
	CALL PUTST
	CALL CLRF


	SECOND:
	MOV SI, OFFSET BUF
	POP CX
	ADD SI, CX
	ADD SI, 1
	MOV AL, [SI]
	CMP AL, '1'
	JE ERRORSECOND
	JNE OKSECOND
	
	OKSECOND:
	MOV DX, OFFSET SUCCESSSECONDSTR
	CALL PUTST
	CALL CLRF
	JMP EXIT
	
	ERRORSECOND:
	MOV DX, OFFSET WRONGSECONDSTR
	CALL PUTST
	CALL CLRF

EXIT:

	CALL GETCH
	
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
	
	; ��������� - ����� ������� �� �����
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

	; ��������� - ���� �������
	GETCH PROC   
		MOV AH, 08H
		INT 021H
        	RET
	GETCH ENDP

	; ��������� - ������� ������
	CLRSCR PROC   
		MOV AH, 00H 
		MOV AL, 02
		INT 10H
		RET
	CLRSCR ENDP

	
; ����� ��������
; MYCODE ENDS

; DATA SEGMENT
	BUF DB 20 DUP ('1')
	SURNAMESTR DB '��������$'
	FIRSTSTR DB '������ �������� $'
	SUCCESSFIRSTSTR DB '����� = $'
	WRONGFIRSTSTR DB '������������$'
	SUCCESSSECONDSTR DB '������ �������� ����!$'
	WRONGSECONDSTR DB '������ �������� �����������!$'
	SUCCESSTHIRDSTR DB '������� �������� ����!$'
	WRONGTHIRDSTR DB '������ �������� �����������!$'
; DATA ENDS

END START
