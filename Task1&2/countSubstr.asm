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
	
	mov	ebx, 0
	mov	eax, 1
	int 	80h
;_______________________________________
; int slen(string msg)

slen:
	push	ebx
	mov	ebx, eax
nextchar:
	cmp	byte [eax], 0
	jz	finished
	inc	eax
	jmp	nextchar
finished:
	sub	eax, ebx
	pop	ebx
	ret
;________________________________________
; void sprint(string msg)

sprint:
	push 	edx
	push	ecx
	push	ebx
	push	eax
	call	slen		; eax <- slen
	
	mov	edx, eax
	pop	eax		; eax <- string
	
	mov	ecx, eax
	mov	ebx, 1
	mov	eax, 4
	int 	80h
	
	pop	ebx
	pop	ecx
	pop	edx
	ret
;_________________________________________
; void sprintLF(string msg)

sprintLF:
	call 	sprint
	
	push	eax
	mov	eax, 0ah
	push	eax
	mov	eax, esp
	call	sprint
	pop	eax
	pop	eax
	ret
;__________________________________________
;void iprint(int num)

iprint:
	push	eax
	push	ecx
	push	edx
	push	esi
	mov	ecx, 0		;counter of how many bytes we need to print in the end
	
divideLoop:
	inc	ecx		; count each byte to print - number of characters
	mov	edx, 0
	mov	esi, 10
	idiv	esi		; div eax by esi
	add	edx, 48
	push	edx
	cmp	eax, 0
	jnz	divideLoop
printLoop:
	dec	ecx
	mov	eax, esp
	call 	sprint
	pop	eax
	cmp	ecx, 0
	jnz	printLoop
	
	pop	esi
	pop	edx
	pop	ecx
	pop	eax
	ret
;___________________________________________
; void iprintLF(int num)

iprintLF:
	call iprint
	
	push	eax
	mov	eax, 0ah
	push	eax
	mov	eax, esp
	call	sprint
	pop	eax
	pop	eax
	ret		
