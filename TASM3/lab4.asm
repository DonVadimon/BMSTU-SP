MYCODE SEGMENT 'CODE'
  ASSUME CS:MYCODE, DS:MYCODE
	
	HEXSTRING DB '0123456789ABCDEF' ; ������� �������������
	STARTSTR DB '������ ������ ��� ������ ������ ���������$'
	MSGSTR DB '��� ������ �� ��������� ������� "q"$'

  START:
	; �������� ����������� �������� ������ DS
    PUSH CS
    POP  DS
	  MOV  BX, OFFSET HEXSTRING
	
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
    PRINT:
    
      ; ����� �����
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
      
    LOOP PRINT
    
    ; ������ �� ����������� ���������
    MOV DX, OFFSET MSGSTR
    CALL PUTST
    CALL CLRF
    CALL GETCH
    CMP AL, 'q'
      JE EXIT ; JUMP IF ZF FLAG IS EQUAL TO 1
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
	SHR   AL, 4 ; 0035 = 0011 0101 -> 0000 0011

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

; ����� ��������
MYCODE ENDS
END START