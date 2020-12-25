%include		'functions.asm'
section .data
	askStrA	db	"Nhap vao chuoi a: ", 0h
	askStrB 	db	"Nhap vao chuoi b: ", 0h
	msg1		db	"Vi tri xuat hien: ", 0h
	msg2		db	"So lan xuat hien: ", 0h
	num		db	0
section .bss
	a	resb	255
	b	resb	255
	lenA	resb	1
section .text
	global	_start
_start:
	; in ra askStrA
	mov	eax, askStrA
	call	sprint
	
	; nhap str a
	mov	edx, 255
	mov	ecx, a
	mov	ebx, 0
	mov	eax, 3
	int	80h
	
	; in ra askStrB
	mov	eax, askStrB
	call	sprint
	
	; nhap str b
	mov	edx, 255
	mov	ecx, b
	mov	ebx, 0
	mov	eax, 3
	int	80h
	
	mov	eax, a
	call	slen
	dec	eax
	dec	eax
	mov	[lenA], eax
			;mov eax, [lenA]
			;call iprintLF
;_____________________________________________	
	mov	eax, b
	call 	slen
			;call iprintLF
	mov	ecx, eax
	mov	eax, a
	call	slen
			;call iprintLF	
	sub	ecx, eax		; ecx = len b - len a
			;mov eax, ecx
			;call iprintLF
	; in msg1
	mov	eax, msg1
	call	sprintLF
		
	mov 	edx, a
	mov	eax, b
	mov	esi, 0
	
outerLoop:
	cmp	esi, ecx
	jg	exit
	mov	ebx, 0
innerLoop:
	push	esi
	push	ebx
	add	esi, ebx
		;push eax
		;call iprintLF
		;mov eax, ebx
		;call iprintLF
		
			
		;mov eax, esi
		;call iprintLF
		;pop eax
		;call iprintLF
		
	push	ecx
	mov	byte cl, [eax + esi]		; b + esi
	mov	byte ch, [edx + ebx]		; a + ebx
	cmp	cl, ch				; so sanh
	
	pop	ecx
	pop	ebx
	pop	esi
	
	je	equal
	jmp	innerLoopDone
equal:

	cmp	ebx, [lenA]
	jl	cmp_again
	jmp	in_ra
in_ra:
	push 	eax
	mov 	eax, esi
	call 	iprintLF	
	pop 	eax			; in ra vi tri
	
	inc	byte [num]
	jmp	innerLoopDone
cmp_again:
	inc ebx	
	jmp innerLoop
innerLoopDone:
	inc	esi
	jmp	outerLoop
exit:
	mov	eax, msg2
	call	sprintLF
	mov	eax, [num]
	call	iprintLF
	call 	quit
