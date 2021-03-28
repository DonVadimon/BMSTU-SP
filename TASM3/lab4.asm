MYCODE SEGMENT 'CODE'
  ASSUME CS:MYCODE, DS:MYCODE
	
	HEX_STRING DB '0123456789ABCDEF' ; ������� �������������
	STARTSTR DB '������ ������ ��� ������ ������ ���������$'
	MSGSTR DB '��� ������ �� ��������� ������� "q"$'

  START:
	; �������� ����������� �������� ������ DS
    PUSH CS
    POP  DS
	  MOV  BX, OFFSET HEX_STRING
	
  MAIN:
    ; ������� ������
    CALL CLRSCR;
    
    ; ����� ������-��������� � ���, ��� ���� ������ �����
    MOV  DX, OFFSET STARTSTR
    CALL PUTST
    CALL CLRF
    
    ; ������ �� ���� ������� 
    CALL GETCH
    PUSH AX
    
    ; ����������� ����� ���� �� �����
    MOV  CX, 20
    ZALOOP:
    
      ; ����� �����
      POP   AX
      PUSH  AX
      MOV   DL, AL
      PUSH  AX
      CALL  PUTCH
      
      ; ����
      MOV   DX, 32
      CALL  PUTCH
      MOV   DX, 205
      CALL  PUTCH
      MOV   DX, 32
      CALL  PUTCH
      
      ; ����� HEX
      POP   AX
      CALL  HEX
      POP   AX
      
      ; INCREMENT �����
      INC   AL
      PUSH  AX
      
    LOOP ZALOOP
    
    ; ������ �� ����������� ���������
    MOV DX, OFFSET MSGSTR
    CALL PUTST
    CALL CLRF
    CALL GETCH
    CMP AL, 'q'
      JE EXIT
    JMP MAIN

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
		MOV AH, 08H
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
; ����� ��������
MYCODE ENDS
END START