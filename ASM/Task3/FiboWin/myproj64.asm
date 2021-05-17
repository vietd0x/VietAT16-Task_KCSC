ExitProcess PROTO
ReadInt64 PROTO
ReadString PROTO
WriteString PROTO
WriteDec PROTO
Crlf PROTO

.data
	msg	BYTE		"Nhap N:  ", 0
	n	BYTE		?
	f	QWORD	100		DUP(0)
.code

Main PROC
	mov		rdx, OFFSET msg
	call		WriteString

	call		ReadInt64
	mov		rcx, rax
							;call		WriteInt64
	mov		rax, OFFSET f
	call		fibo_arr

	call		print_arr
	call		ExitProcess
Main ENDP
;_____________________________________
; EAX - input : fibo array DWORD_array
; ECX - input : n
; ESI - output: so fibo thu n
; ebx | esi | eax
;______________________________________
fibo_arr PROC
	push		rbx
	push		rcx
	push		rax

	mov		rbx, 0
	mov		rsi, 1
	add		rax, TYPE QWORD
	mov		[rax], rsi

	dec		rcx					; tru di 1 lan loop do da assign f[0] = 0 o .data
L00p:
	add		rax, TYPE QWORD
	add		[rax], rbx
	add		[rax], rsi

	mov		rbx, rsi
	mov		rsi, [rax]
	loop		L00p

	pop		rax
	pop		rcx
	pop		rbx
	ret
fibo_arr ENDP

;________________________________________
;ECX - input : so ptu in ra
;EAX - input : OFFSET of array
;________________________________________
print_arr PROC
	push		rcx
	push		rax
	push		rbx
	mov		rbx, rax		; offset array = ebx

	;inc		ecx			; so fibo thu n thi in ra n+1 so
L00p:
	mov		rax, [rbx]
	call		WriteDec
	call		Crlf
	add		rbx, TYPE QWORD
	loop		L00p

	pop		rbx
	pop		rax
	pop		rcx
	ret
print_arr ENDP
END
