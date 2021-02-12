INCLUDE	Irvine32.inc
.386
.stack 4096
	CharToInt_add PROTO,
		char1: BYTE,
		char2: BYTE
	revArr PROTO,
		pArr: PTR BYTE
	CharToInt_sub PROTO,
		char1: BYTE,
		char2: BYTE
	Arr_compare	PROTO,
		pA: PTR BYTE,
		pB: PTR BYTE
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
;----------------------------------------------------
	; pre-loop index init
	mov	esi, 0
	mov	ebx, 0

	cmp	lena, eax
	jge	Alonger_SUM				; lenA >= lenB

	mov	ecx, lenb				; lenA < lenB
	xor	eax, eax
	xor	edx, edx

LB1_SUM:
	INVOKE	CharToInt_add, b[esi], a[ebx]
	mov		sum[esi], al

	inc		esi
	inc		ebx

	cmp		ebx, lena
	je		lastStepB_SUM
	loop		LB1_SUM
lastStepB_SUM:
	dec		ecx
LB2_SUM:
	INVOKE	CharToInt_add, b[esi], '0'
	mov		sum[esi], al
	inc		esi
	loop		LB2_SUM

	jmp		LA_EQU_SUM
;-------------------------------------------------------------
Alonger_SUM:						; lenA >= lenB
	mov	ecx, lena

	xor	eax, eax
	xor	edx, edx
LA1_SUM:
	INVOKE	CharToInt_add, a[esi], b[ebx]
	mov		sum[esi], al

	inc		esi
	inc		ebx

	cmp		ebx, lenb
	je		lastStepA_SUM
	loop		LA1_SUM
	
lastStepA_SUM:
	cmp		esi, lena
	je		LA_EQU_SUM						; TH LENGTHOF b = LENGTHOF a
	dec		ecx								; TH LENGTHOF b < LENGTHOF a
LA2_SUM:
	INVOKE	CharToInt_add, a[esi], '0'
	mov		sum[esi], al
	inc		esi
	loop		LA2_SUM
LA_EQU_SUM:
	cmp		dl, 1
	je		DL_EQU_1
	jmp		in_ra_tong
DL_EQU_1:
	mov		sum[esi], '1'

in_ra_tong:
	mov		edx, OFFSET msg3
	call		WriteString

	INVOKE	revArr, ADDR sum

	mov		edx, OFFSET sum
	call		WriteString
	call		Crlf

;------------------------------SUB---------------------------------
; pre-loop index init

	mov		esi, 0
	mov		ebx, 0
	mov		eax, lenb

	cmp		lena, eax
	jge		Alonger_SUB				; lenA >= lenB
	jmp		reB1
reB:
	INVOKE	revArr, ADDR a
	INVOKE	revArr, ADDR b
reB1:
	; lenA < lenB
	mov		ecx, lenb						
	xor		eax, eax
	xor		edx, edx
	mov		esi, 0
	mov		ebx, 0
LB1_SUB:
	INVOKE	CharToInt_sub, b[esi], a[ebx]
	mov		diff[esi], ah

	inc		esi
	inc		ebx

	cmp		ebx, lena
	je		lastStepB_SUB
	loop		LB1_SUB
lastStepB_SUB:
	cmp		esi, lenb
	je		LB_EQU_SUB
	dec		ecx
LB2_SUB:
	INVOKE	CharToInt_sub, b[esi], '0'
	mov		diff[esi], ah
	inc		esi
	loop		LB2_SUB
	
LB_EQU_SUB:
	jmp		in_ra_hieu
Alonger_SUB:						; lenA >= lenB
	mov	ecx, lena

	xor	eax, eax
	xor	edx, edx
LA1_SUB:
	INVOKE	CharToInt_sub, a[esi], b[ebx]
	mov		diff[esi], ah

	inc		esi
	inc		ebx

	cmp		ebx, lenb
	je		lastStepA_SUB
	loop		LA1_SUB
lastStepA_SUB:
	cmp		esi, lena
	je		LA_EQU_SUB						; TH LENGTHOF b = LENGTHOF a
	dec		ecx
LA2_SUB:
	INVOKE	CharToInt_sub, a[esi], '0'
	mov		diff[esi], ah
	inc		esi
	loop		LA2_SUB
	jmp		in_ra_hieu
LA_EQU_SUB:
	INVOKE	Arr_compare, ADDR a, ADDR b
	je		equal
	ja		in_ra_hieu
	jb		reB						;b_larger, lenA = lenB    232_123_wrong????
in_ra_hieu:
	xor		edx, edx
	mov		edx, OFFSET msg4
	call		WriteString

	INVOKE	revArr, ADDR diff
	xor		edx, edx
	mov		edx, OFFSET diff
	call		WriteString
	call		Crlf
	exit
equal:
	xor		edx, edx
	mov		edx, OFFSET msg4
	call		WriteString

	mov		al, '0'
	call		WriteChar
	call		Crlf
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
;________________________________
CharToInt_sub PROC USES ebx,
	char1: BYTE,
	char2: BYTE
; IN - 2 arg [char1 - char2]
;	- dh , 10 or 0
; OUT - ah - int - diff of 2 char
;	 - dh - int - 10 or 0
; ah -char1, bl -char2
;________________________________
	;mov	bl, dh
	xor	ah, ah
	mov	ah, char1

	; check char1
	cmp     ah, 48          ; compare ebx register's lower half value against ascii value 48 (char value 0)
	jl      _finished       ; jump if less than to label finished
	cmp     ah, 57          ; compare ebx register's lower half value against ascii value 57 (char value 9)
	jg      _finished

	sub		ah, 48			; asscii to num

	xor		bl, bl
	mov		bl, char2

	; check char2
	cmp     bl, 48          ; compare ebx register's lower half value against ascii value 48 (char value 0)
	jl      _finished       ; jump if less than to label finished
	cmp     bl, 57          ; compare ebx register's lower half value against ascii value 57 (char value 9)
	jg      _finished

	sub		bl, 48			; asscii to num
	add		bl, dh
	cmp		ah, bl 
	jge		ch1greaterThanCH2		; char2 <= char1

	; char1 < char2
	add		ah, 10
	sub		ah, bl
	add		ah, 48				; num -> asscii
	mov		dh, 1

	mov		al, bl
	ret
ch1greaterThanCH2:
	sub	ah, bl
	add	ah, 48				; num -> asscii
	mov	dh, 0
	ret
_finished:
	exit	
CharToInt_sub ENDP
;____________________________
revArr PROC USES edi eax ecx esi,
	pArr: PTR BYTE,
; IN - pArr
; 
	mov		edi, pArr
	INVOKE	Str_length, edi		; puts length in EAX

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
;------------------------------------------
Arr_compare	PROC USES eax edx esi edi,
	pA: PTR BYTE,
	pB: PTR BYTE
; OUT: revArr 
;	je	equal
;	ja	a > b
;	jb	a < b
;------------------------------
	mov		esi, pA
	mov		edi, pB

	INVOKE	revArr, esi
	INVOKE	revArr, edi

	;mov		edx, esi
	;call		WriteString
	;call		Crlf

	;mov		edx, edi
	;call		WriteString
	;call		Crlf
L1:
	mov		al, [esi]
	mov		dl, [edi]
	cmp		al, 0
	jne		L2
	cmp		dl, 0
	jne		L2
	jmp		L3
L2:
	inc		esi
	inc		edi
	cmp		al, dl
	je		L1
L3:
	ret
Arr_compare ENDP

END main