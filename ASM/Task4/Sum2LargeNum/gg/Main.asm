INCLUDE	Irvine32.inc
.386
.stack 4096
	CharToInt_add PROTO,
		char1: BYTE,
		char2: BYTE
	revArr PROTO,
		pArr: PTR BYTE
.data
	msg1	db	"Nhap so a: ", 0
	msg2	db	"Nhap so b: ", 0
	msg3 db	"Tong: ", 0
	msg4 db	"Hieu: ", 0
	a	byte	100000	DUP(0)
	lena	dword	?
	b	byte	100000	DUP(0)
	lenb	dword	?
	sum	byte	100000	DUP(0)
	diff	byte	100000	DUP(0)
.code
main	PROC
	mov	edx, OFFSET msg1
	call	WriteString

	; nhap chuoi so a
	mov	edx, OFFSET a
	mov	ecx, (LENGTHOF a) - 1
	call	ReadString
	mov	lena, eax

	mov	edx, OFFSET msg2
	call	WriteString

	; nhap chuoi so b
	mov	edx, OFFSET b
	mov	ecx, (LENGTHOF b) - 1
	call	ReadString
	mov	lenb, eax

	INVOKE	revArr, ADDR a
	INVOKE	revArr, ADDR b

	;mov	edx, OFFSET a
	;call	WriteString
	;call Crlf

	;mov	edx, OFFSET b
	;call WriteString
	;call Crlf

	; pre-loop index init
	mov	esi, 0
	mov	ebx, 0

	cmp	lena, eax
	jge	Alonger				; lenA >= lenB

	mov	ecx, lenb				; lenA < lenB
	xor	eax, eax
	xor	edx, edx

LB1:
	INVOKE	CharToInt_add, b[esi], a[ebx]
	mov		sum[esi], al

	inc		esi
	inc		ebx

	cmp		ebx, lena
	je		lastStepB
	loop		LB1
lastStepB:
	dec		ecx							; TH LENGTHOF b < LENGTHOF a
LB2:
	INVOKE	CharToInt_add, b[esi], '0'
	mov		sum[esi], al
						;call	WriteChar
						;call	Crlf
	inc		esi
	loop		LB2

	jmp		LA_EQU
Alonger:						; lenA >= lenB
	mov	ecx, lena

	xor	eax, eax
	xor	edx, edx
LA1:
	INVOKE	CharToInt_add, a[esi], b[ebx]
	mov		sum[esi], al

	inc		esi
	inc		ebx

	cmp		ebx, lenb
	je		lastStepA
	loop		LA1
	
lastStepA:
	cmp		esi, lena
	je		LA_EQU						; TH LENGTHOF b = LENGTHOF a
	dec		ecx							; TH LENGTHOF b < LENGTHOF a
LA2:
	INVOKE	CharToInt_add, a[esi], '0'
	mov		sum[esi], al
						;call	WriteChar
						;call	Crlf
	inc		esi
	loop		LA2
LA_EQU:
	cmp		dl, 1
	je		DL_EQU_1
	jmp		in_ra
DL_EQU_1:
	mov		sum[esi], '1'

in_ra:
	mov		edx, OFFSET msg3
	call		WriteString

	INVOKE	revArr, ADDR sum
	mov	edx, OFFSET sum
	call	WriteString
	call Crlf
	exit

main ENDP

;________________________________
CharToInt_add PROC USES ebx,
	char1: BYTE,
	char2: BYTE
; IN - 2 arg
;	- dl , 1 [0]
; OUT - al - int - sum of 2 char
;	 - dl - int - 1 or 0
; dau vao la char1 va char2 dc luu vao al -> sum = ah -> check xem input khac num ko? -> dec -> cong vao sum-bl
; ->bl > 10 ? sub bl, 10; ah = 1 : ah = 0; -> char
;________________________________
	mov	bl, dl			; sum
	xor	al, al
	mov	al, char1

	; check char1
	cmp     al, 48          ; compare ebx register's lower half value against ascii value 48 (char value 0)
	jl      _finished       ; jump if less than to label finished
	cmp     al, 57          ; compare ebx register's lower half value against ascii value 57 (char value 9)
	jg      _finished

	sub	al, 48			; asscii to num
	add	bl, al

	xor	al, al
	mov	al, char2

	; check char2
	cmp     al, 48          ; compare ebx register's lower half value against ascii value 48 (char value 0)
	jl      _finished       ; jump if less than to label finished
	cmp     al, 57          ; compare ebx register's lower half value against ascii value 57 (char value 9)
	jg      _finished

	sub	al, 48			; asscii to num
	add	bl, al
	
	cmp	bl, 10
	jl	lessThan10
	mov	dl, 1
	sub	bl, 10
	add	bl, 48
	mov	al, bl
	ret
lessThan10:
	mov	dl, 0
	add	bl, 48
	mov	al, bl
	ret
_finished:
	exit	
CharToInt_add ENDP
;____________________________
revArr PROC USES edi eax ecx esi,
	pArr: PTR BYTE,
; IN - pArr
; 

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