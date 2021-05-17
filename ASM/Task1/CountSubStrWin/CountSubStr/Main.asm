INCLUDE	Irvine32.inc

.386
.stack 4096

.data
	askStrA	BYTE		"Nhap vao chuoi a: ", 0
	askStrB	BYTE		"Nhap vao chuoi b: ", 0
	msg1		BYTE		"Vi tri xuat hien: ", 0
	msg2		BYTE		"So lan xuat hien: ", 0
	num		DWORD	0
	a		BYTE		255	DUP(?)
	lenA		DWORD	?
	b		BYTE		255	DUP(?)
	lenB		DWORD	?
.code
main	PROC
	; in chuoi askStrA
	mov		edx, OFFSET askStrA
	call		WriteString

	; nhap chuoi a
	mov		edx, OFFSET a
	mov		ecx, (LENGTHOF a) - 1
	call		ReadString
	mov		lenA, eax

	; in chuoi askStrB
	mov		edx, OFFSET askStrB
	call		WriteString

	; nhap chuoi b
	mov		edx, OFFSET b
	mov		ecx, (LENGTHOF b) - 1
	call		ReadString
	mov		lenB, eax
	
	; in chuoi msg1
	mov		edx, OFFSET msg1
	call		WriteString

	; ecx = lenB - lenA to loop
	sub		eax, lenA
	mov		ecx,	eax

	dec		lenA					; lenA = max index of string a
	mov		esi, 0
outerLoop:
	cmp		esi, ecx
	jg		quit
	mov		ebx, 0
innerLoop:
	push		esi
	push		ebx
	add		esi, ebx

	push		edx
	push		eax
	movzx	edx,  b[esi]
	movzx	eax,  a[ebx]
	cmp		dl, al

	pop		eax
	pop		ebx
	pop		ebx
	pop		esi

	je		equal
	jmp		innerLoopDone
equal:
	cmp		ebx, lenA
	jl		cmp_again
	jmp		in_vi_tri
in_vi_tri:
	push		eax
	mov		eax, esi
	call		WriteInt
	call		Crlf
	pop		eax

	inc		num
	jmp		innerLoopDone
cmp_again:
	inc		ebx
	jmp		innerLoop
innerLoopDone:
	inc		esi
	jmp		outerLoop
quit:
	mov		edx, OFFSET msg2
	call		WriteString

	mov		eax, num
	call		WriteInt

	exit
main ENDP
END main