MYCODE SEGMENT 'CODE'
 ASSUME CS:MYCODE, DS:MYCODE
FIR DW 'А'
SEC DW 'Б'
THR DW 'В'
START:
; Загрузка сегментного регистра DS
 PUSH CS
 POP DS           
 MOV BX,0
; cls
CALL CLRS
; Вывод одного символа на экран
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
; Ожидание завершения программы
MOV AH, 01H
INT 021H
; Выход из программы
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
; процедура вывода одного символа
PUTCH PROC NEAR
 MOV AH , 02H
 INT 021H
 RETN
PUTCH ENDP  
;процедура очистки экрана 
CLRS PROC
 MOV AX, 03
 INT 10H
 RET
CLRS ENDP 
MYCODE ENDS
END START