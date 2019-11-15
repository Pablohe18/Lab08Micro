      .386
      .model flat, stdcall    
      option casemap :none 
      include \masm32\include\windows.INC
      include \masm32\include\user32.INC
      include \masm32\include\kernel32.INC
	  include \masm32\include\masm32.INC
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\kernel32.lib
	  includelib \masm32\lib\masm32.lib
	       ; include \masm32\include\windows.INC
            ; include \masm32\include\user32.INC
             ; include \masm32\include\kernel32.INC

.data
     DATO dword 0
	 msjGET db "Numero: ", 00
	 num db 10 DUP(0)
     msj db "El factorial del numero  "
     msjl db "  es   "     
     msjResultado db " ",0

.code
CalcularF:
    PUSH bx
    PUSH dx
    CMP ax,1
    JE CalcularFB
    MOV bx,ax
    DEC ax
    CALL CalcularF
    mul bx

CalcularFB:
    POP dx
    POP bx
    RET

removerEspacios:
    PUSH cx
    PUSH esi
    MOV cl,1
ELIMSig:
    CMP byte ptr [esi],0
    JE ELIM0
    CMP byte ptr [esi],32
    JE ELIM02
    MOV cl,0
ELIMCop:    
    MOV ch,[esi]
    MOV [edi],ch
    INC edi
ELIM01:
    INC esi
    JMP ELIMSig
ELIM02:
    CMP cl,1
    JE ELIM01
    MOV cl,1
    JMP ELIMCop
ELIM0:
    MOV esi,edi
    DEC esi
    CMP byte ptr [edi],0
    JNE ELIMLOOP
ELIMLOOP:
    MOV byte ptr [edi],0
    INC edi
    DEC esi
	;    JE CalcularFB
  ;  MOV bx,ax
  ;  DEC ax
  ;  CALL CalcularF
  ;  mul bx
    POP esi
    POP cx
    RET


bintotxt:
		PUSH ax
		PUSH bx 
		PUSH ecx
		PUSH dx
		MOV ecx,0
		MOV bx,10

		;Totxtl2:
      ;  POP ax
      ;  add ax,48
      ;  MOV [edi],al
      ;  INC edi
      ;  loop Totxtl2
      ;  JMP TotxtReturn

Totxtl:
        CMP ax,0
        JE Totxt2
        INC ecx
        MOV dx,0
        DIV bx
        PUSH dx
        JMP Totxtl
Totxt2:
        CMP ecx,0
        JE Totxt00
Totxtl2:
        POP ax
        add ax,48
        MOV [edi],al
        INC edi
        loop Totxtl2
        JMP TotxtReturn
Totxt00:
        MOV al,'0'
        MOV [edi],al
        INC edi
TotxtReturn:
        POP dx
        POP ecx
        POP bx
        POP ax
        RET




INICIO:	 
	INVOKE StdOut, addr msjGET
    INVOKE StdIn, addr num, 10         
	INVOKE StripLF, addr num     
    INVOKE atodw, addr num
    MOV DATO, eax
    MOV eax,DATO
    MOV edi,OFFSET msjl
    CALL bintotxt
    MOV eax,DATO
    CALL CalcularF
    MOV edi,OFFSET msjResultado
    CALL bintotxt
    MOV esi,OFFSET msj
    MOV edi,OFFSET msj
    CALL removerEspacios

	INVOKE StdOut, addr msj

	INVOKE ExitProcess, 0


end INICIO