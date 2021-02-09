INCLUDE	Irvine32.inc

.386
.stack 4096
ExitProcess PROTO, deExitCode: DWORD
Swap PROTO,			; procedure prototype
	pValX:PTR BYTE,
	pValY:PTR BYTE
.data
	msg1	db	"Nhap so a: ", 0
	msg2	db	"Nhap so b: ", 0
	msg3 db	"Tong: ", 0
	msg4 db	"Hieu: ", 0
	a	byte	100000	DUP(0)
	lenA	dword	?
	b	byte	100000	DUP(0)
	lenB	dword	?
.code
main	PROC
	mov	edx, OFFSET msg1
	call	WriteString

	; nhap chuoi so a
	mov	edx, OFFSET a
	mov	ecx, (LENGTHOF a) - 1
	call	ReadString
	mov	lenA, eax

	mov	edx, OFFSET msg2
	call	WriteString

	; nhap chuoi so b
	mov	edx, OFFSET b
	mov	ecx, (LENGTHOF b) - 1
	call	ReadString
	mov	lenB, eax

	cmp	lenA, eax
	jge	PREL00P				; lenA >= lenB
	xchg	lenA, eax
	xchg	lenB, eax
	INVOKE Swap, ADDR a, ADDR b
PREL00P:
	mov	eax, lenA
	call	WriteDec
	call Crlf

	mov	edx, OFFSET a
	call	WriteString
	call Crlf

	mov	edx, OFFSET b
	call WriteString
	call Crlf

	INVOKE ExitProcess, 0
main ENDP

;-------------------------------------------------------
Swap PROC USES eax esi edi,
	pValX:PTR BYTE,	; pointer to first integer
	pValY:PTR BYTE	; pointer to second integer
;
; Returns: nothing
;-------------------------------------------------------
	mov esi,pValX		; get pointers
	mov edi,pValY

	mov eax,[esi]		; get first integer
		mov	edx, eax
		call WriteString
		call	Crlf
	xchg eax,[edi]		; exchange with second
	mov [esi],eax		; replace first integer
	ret
Swap ENDP

END main