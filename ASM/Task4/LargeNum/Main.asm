INCLUDE	Irvine32.inc

.386
.stack 4096
ExitProcess PROTO, deExitCode: DWORD
Swap PROTO,			; procedure prototype
	pValX:PTR BYTE,
	pValY:PTR BYTE
revArr PROTO,
		pArr: PTR BYTE
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

	INVOKE Swap, ADDR a, ADDR b

	mov	edx, OFFSET a
	call	WriteString
	call Crlf

	mov	edx, OFFSET b
	call WriteString
	call Crlf

	INVOKE ExitProcess, 0
main ENDP

;____________________________
Swap PROC USES edi,
	pArrA:PTR BYTE,
	pArrB:PTR BYTE
;____________________________
	xor	edi, edi

	mov	edx, pArrA
	xchg	[edx], pArrB
	mov	pArrA, [edx]
	ret
Swap ENDP



;____________________________
revArr PROC USES edi eax ecx esi,
	pArr: PTR BYTE,
; IN - ECX - len
	mov		edi, pArr
	INVOKE	Str_length, edi		; puts length in EAX
	;add		edi,eax                  ; point to null byte at end

	mov		ecx, eax
	mov		esi, 0
stackIt:
	xor		eax, eax

	mov		al, [edi + esi]
	push		eax
	inc		esi
	loop		stackIt

	INVOKE	Str_length, edi		; puts length in EAX
	mov		ecx, eax
	mov		esi, 0
popIt:
	pop		eax
	mov  BYTE PTR [edi+esi], al
	inc		esi
	loop		popIt

	ret
revArr ENDP
END main