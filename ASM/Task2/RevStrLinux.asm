section .data
	msg1	db	'Nhap chuoi: ', 0h
	msg2	db	'Chuoi moi: ', 0h
section .bss
	s	resb	255
	rs	resb	255
section .text
	global _start:
_start:
	; in chuoi  msg1
	mov	eax, msg1
	call	sprint
	
	; nhap chuoi s
	mov	edx, 255
	mov	ecx, s
	mov	ebx, 0
	mov	eax, 3
	int 	80h
	
	; process
	mov	eax, s
	call	slen
	mov	ecx, eax
	mov	esi, 0
StackChar:
	mov	eax, [s+esi]
	push	eax
	inc	esi
	loop	StackChar
	
	mov	eax, s
	call	slen
	mov	ecx, eax
	mov	esi, 0
PopChar:
	pop	eax
	mov	[rs+esi], al
	inc	esi
	loop 	PopChar
	
	; in chuoi msg2
	mov	eax, msg2
	call	sprint
	
	; in chuoi rs
	mov	eax, rs
	call	sprint
	
	mov	ebx, 0
	mov	eax, 1
	int	80h
;__________________________
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
