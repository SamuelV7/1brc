	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 2	sdk_version 14, 2
	.globl	_arena_malloc_init              ; -- Begin function arena_malloc_init
	.p2align	2
_arena_malloc_init:                     ; @arena_malloc_init
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x1
	mov	x20, x0
	mov	x0, x1
	bl	_malloc
	cmp	x0, #0
	csel	x8, xzr, x19, eq
	stp	x0, x8, [x20]
	str	xzr, [x20, #16]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_alloc_arena                    ; -- Begin function alloc_arena
	.p2align	2
_alloc_arena:                           ; @alloc_arena
	.cfi_startproc
; %bb.0:
	cbz	x2, LBB1_2
; %bb.1:
	ldp	x11, x10, [x0, #8]
	ldr	x8, [x0]
	add	x8, x10, x8
	neg	x9, x8
	udiv	x12, x8, x2
	madd	x9, x12, x2, x9
	add	x9, x2, x9
	udiv	x12, x9, x2
	msub	x9, x12, x2, x9
	add	x10, x9, x10
	subs	x11, x11, x10
	ccmp	x11, x1, #0, hs
	b.hs	LBB1_3
LBB1_2:
	mov	x0, #0
	ret
LBB1_3:
	add	x10, x10, x1
	str	x10, [x0, #16]
	add	x0, x9, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_string_init                    ; -- Begin function string_init
	.p2align	2
_string_init:                           ; @string_init
	.cfi_startproc
; %bb.0:
	ldp	x9, x10, [x0, #8]
	subs	x9, x9, x10
	ccmp	x9, x1, #0, hs
	b.hs	LBB2_2
; %bb.1:
	mov	x9, #0
	b	LBB2_3
LBB2_2:
	ldr	x9, [x0]
	add	x9, x10, x9
	add	x10, x10, x1
	str	x10, [x0, #16]
LBB2_3:
	strb	wzr, [x9]
	stp	x9, xzr, [x8]
	stp	x1, x0, [x8, #16]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_print_string                   ; -- Begin function print_string
	.p2align	2
_print_string:                          ; @print_string
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x8, [x0]
	str	x8, [sp]
Lloh0:
	adrp	x0, l_.str@PAGE
Lloh1:
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.globl	_append_string_arr              ; -- Begin function append_string_arr
	.p2align	2
_append_string_arr:                     ; @append_string_arr
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x20, x1
	mov	x19, x0
	ldr	x22, [x0, #16]
	mov	x0, x1
	mov	x1, x22
	bl	_strnlen
	ldr	x8, [x19, #8]
	cmp	x22, x8
	b.ls	LBB4_2
; %bb.1:
	mov	x21, x0
	mvn	x9, x8
	add	x9, x22, x9
	cmp	x0, x9
	b.ls	LBB4_3
LBB4_2:
	mov	w0, #0
	b	LBB4_4
LBB4_3:
	ldr	x9, [x19]
	add	x0, x9, x8
	add	x2, x21, #1
	mov	x1, x20
	bl	_memmove
	ldr	x8, [x19, #8]
	add	x8, x8, x21
	str	x8, [x19, #8]
	mov	w0, #1
LBB4_4:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #700
	bl	_malloc
	mov	w8, #200
	cmp	x0, #0
	csel	x8, xzr, x8, eq
	add	x8, x8, x0
	csel	x8, xzr, x8, eq
Lloh2:
	adrp	x9, l_.str.1@PAGE
Lloh3:
	add	x9, x9, l_.str.1@PAGEOFF
	ldr	q0, [x9]
	str	q0, [x8]
	ldur	x9, [x9, #13]
	stur	x9, [x8, #13]
	str	x8, [sp]
Lloh4:
	adrp	x0, l_.str@PAGE
Lloh5:
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
Lloh6:
	adrp	x0, l_.str.3@PAGE
Lloh7:
	add	x0, x0, l_.str.3@PAGEOFF
	bl	_printf
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
	.globl	_get_file                       ; -- Begin function get_file
	.p2align	2
_get_file:                              ; @get_file
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x0
Lloh8:
	adrp	x0, l_.str.4@PAGE
Lloh9:
	add	x0, x0, l_.str.4@PAGEOFF
Lloh10:
	adrp	x1, l_.str.5@PAGE
Lloh11:
	add	x1, x1, l_.str.5@PAGEOFF
	bl	_fopen
	mov	x20, x0
	cbnz	x0, LBB6_2
; %bb.1:
Lloh12:
	adrp	x0, l_str.8@PAGE
Lloh13:
	add	x0, x0, l_str.8@PAGEOFF
	bl	_puts
LBB6_2:
	mov	x0, x19
	mov	w1, #1
	mov	w2, #99
	mov	x3, x20
	bl	_fread
	mov	x20, x0
	cbnz	x0, LBB6_4
; %bb.3:
Lloh14:
	adrp	x0, l_str@PAGE
Lloh15:
	add	x0, x0, l_str@PAGEOFF
	bl	_puts
LBB6_4:
	strb	wzr, [x19, x20]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh14, Lloh15
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"(%s)"

	.section	__TEXT,__const
l_.str.1:                               ; @.str.1
	.asciz	"when the music fades\000"

	.section	__TEXT,__cstring,cstring_literals
l_.str.3:                               ; @.str.3
	.asciz	"\n soli deo gloria, string & arena alloc"

l_.str.4:                               ; @.str.4
	.asciz	"./upstream-1brc/measurements.txt"

l_.str.5:                               ; @.str.5
	.asciz	"r"

l_str:                                  ; @str
	.asciz	"Error reading file"

l_str.8:                                ; @str.8
	.asciz	"Error opening file"

.subsections_via_symbols
