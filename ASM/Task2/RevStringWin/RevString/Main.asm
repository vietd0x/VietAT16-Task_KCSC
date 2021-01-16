INCLUDE	Irvine32.inc

.386
.model flat, stdcall
.stack 4096
.data
	msg1	byte		"Nhap chuoi: ", 0
	msg2	byte		"Chuoi moi: ", 0
	s	byte		255	DUP(?), 0
	slen	SDWORD	?
	rs	byte		255	DUP(?), 0
.code
main	PROC
	; in ra msg1
	mov		edx, OFFSET msg1
	call		WriteString

	; nhap chuoi s
	mov		edx, OFFSET s
	mov		ecx, (LENGTHOF s) -1
	call		ReadString

	; dua tung ki tu cua chuoi s vao stack roi pop vao chuoi rs
	mov		ecx, eax
	mov		slen, ecx
	mov		esi, 0

	StackChar:
		movzx	eax, s[esi]
		push		eax
		inc		esi
		loop		StackChar
	mov		ecx, slen
	mov		esi, 0
	PopChar:
		pop		eax
		mov		rs[esi], al
		inc		esi
		loop		PopChar

	; in ra msg2
	mov		edx, OFFSET msg2
	call		WriteString

	; in ra ket qua
	mov		edx, OFFSET rs
	call		WriteString

	call	Crlf
	exit
main ENDP
END main


	

