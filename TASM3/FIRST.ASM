MYCODE SEGMENT 'CODE'
 ASSUME CS:MYCODE, DS:MYCODE
FIR DW '�'
SEC DW '�'
THR DW '�'
START:
; ����㧪� ᥣ���⭮�� ॣ���� DS
 PUSH CS
 POP DS           
 MOV BX,0
; cls
CALL CLRS
; �뢮� ������ ᨬ���� �� ��࠭
 MOV DX, [DS:BX]
 ADD BX, 2
 
 CALL PUTCH
 CALL CRLF
 MOV DX, [DS:BX]
 ADD BX, 4  
 
 CALL PUTCH
 CALL CRLF
 ADD DX, [DS:BX]

 CALL PUTCH
 CALL CRLF
; �������� �����襭�� �ணࠬ��
MOV AH, 01H
INT 021H
; ��室 �� �ணࠬ��
 MOV AL, 0
 MOV AH, 4CH
 INT 21H
CRLF PROC
 MOV DL , 10
 CALL PUTCH
 MOV DL , 13
 CALL PUTCH
 RET
CRLF ENDP
; ��楤�� �뢮�� ������ ᨬ����
PUTCH PROC NEAR
 MOV AH , 02H
 INT 021H
 RETN
PUTCH ENDP  
;��楤�� ���⪨ ��࠭� 
CLRS PROC
 MOV AX, 03
 INT 10H
 RET
CLRS ENDP 
MYCODE ENDS
END START