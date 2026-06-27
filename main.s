	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 2	sdk_version 14, 2
	.globl	_arena_malloc_init              ; -- Begin function arena_malloc_init
	.p2align	2
_arena_malloc_init:                     ; @arena_malloc_init
	.cfi_startproc
; %bb.:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #16]
	str	x1, [sp, #8]
	ldr	x0, [sp, #8]
	bl	_malloc
	ldr	x8, [sp, #16]
	str	x0, [x8]
	ldr	x8, [sp, #16]
	ldr	x8, [x8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB0_2
	b	LBB0_1
LBB0_1:
	ldr	x8, [sp, #16]
	str	xzr, [x8, #8]
	ldr	x8, [sp, #16]
	str	xzr, [x8, #16]
                                        ; kill: def $x8 killed $xzr
	stur	xzr, [x29, #-8]
	b	LBB0_3
LBB0_2:
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #16]
	str	x8, [x9, #8]
	ldr	x8, [sp, #16]
	str	xzr, [x8, #16]
	ldr	x8, [sp, #16]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	b	LBB0_3
LBB0_3:
	ldur	x0, [x29, #-8]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_alloc_arena                    ; -- Begin function alloc_arena
	.p2align	2
_alloc_arena:                           ; @alloc_arena
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	str	x0, [sp, #64]
	str	x1, [sp, #56]
	str	x2, [sp, #48]
	ldr	x8, [sp, #48]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB1_2
	b	LBB1_1
LBB1_1:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #72]
	b	LBB1_7
LBB1_2:
	ldr	x8, [sp, #64]
	ldr	x8, [x8]
	str	x8, [sp, #40]
	ldr	x8, [sp, #40]
	ldr	x9, [sp, #64]
	ldr	x9, [x9, #16]
	add	x8, x8, x9
	str	x8, [sp, #32]
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #32]
	ldr	x11, [sp, #48]
	udiv	x10, x9, x11
	mul	x10, x10, x11
	subs	x9, x9, x10
	subs	x8, x8, x9
	ldr	x10, [sp, #48]
	udiv	x9, x8, x10
	mul	x9, x9, x10
	subs	x8, x8, x9
	str	x8, [sp, #24]
	ldr	x8, [sp, #64]
	ldr	x8, [x8, #16]
	ldr	x9, [sp, #24]
	add	x8, x8, x9
	str	x8, [sp, #16]
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #64]
	ldr	x9, [x9, #8]
	subs	x8, x8, x9
	cset	w8, ls
	tbnz	w8, #0, LBB1_4
	b	LBB1_3
LBB1_3:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #72]
	b	LBB1_7
LBB1_4:
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #64]
	ldr	x9, [x9, #8]
	ldr	x10, [sp, #16]
	subs	x9, x9, x10
	subs	x8, x8, x9
	cset	w8, ls
	tbnz	w8, #0, LBB1_6
	b	LBB1_5
LBB1_5:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #72]
	b	LBB1_7
LBB1_6:
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #56]
	add	x8, x8, x9
	ldr	x9, [sp, #64]
	str	x8, [x9, #16]
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #32]
	add	x8, x8, x9
	str	x8, [sp, #8]
	ldr	x8, [sp, #8]
	str	x8, [sp, #72]
	b	LBB1_7
LBB1_7:
	ldr	x0, [sp, #72]
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_string_init                    ; -- Begin function string_init
	.p2align	2
_string_init:                           ; @string_init
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x8, [sp]                        ; 8-byte Folded Spill
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	mov	x2, #1
	bl	_alloc_arena
	ldr	x9, [sp]                        ; 8-byte Folded Reload
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	strb	wzr, [x8]
	ldr	x8, [sp, #8]
	str	x8, [x9]
	str	xzr, [x9, #8]
	ldr	x8, [sp, #16]
	str	x8, [x9, #16]
	ldur	x8, [x29, #-8]
	str	x8, [x9, #24]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
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
	mov	x8, x0
	str	x8, [sp, #8]
	ldr	x8, [x0]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str@PAGE
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_append_string_arr              ; -- Begin function append_string_arr
	.p2align	2
_append_string_arr:                     ; @append_string_arr
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #16]
	str	x1, [sp, #8]
	ldr	x0, [sp, #8]
	ldr	x8, [sp, #16]
	ldr	x1, [x8, #16]
	bl	_strnlen
	str	x0, [sp]
	ldr	x8, [sp, #16]
	ldr	x8, [x8, #8]
	ldr	x9, [sp, #16]
	ldr	x9, [x9, #16]
	subs	x8, x8, x9
	cset	w8, lo
	tbnz	w8, #0, LBB4_2
	b	LBB4_1
LBB4_1:
	mov	w8, #0
	and	w8, w8, #0x1
	and	w8, w8, #0x1
	sturb	w8, [x29, #-1]
	b	LBB4_5
LBB4_2:
	ldr	x8, [sp]
	ldr	x9, [sp, #16]
	ldr	x9, [x9, #16]
	ldr	x10, [sp, #16]
	ldr	x10, [x10, #8]
	subs	x9, x9, x10
	subs	x9, x9, #1
	subs	x8, x8, x9
	cset	w8, ls
	tbnz	w8, #0, LBB4_4
	b	LBB4_3
LBB4_3:
	mov	w8, #0
	and	w8, w8, #0x1
	and	w8, w8, #0x1
	sturb	w8, [x29, #-1]
	b	LBB4_5
LBB4_4:
	ldr	x8, [sp, #16]
	ldr	x8, [x8]
	ldr	x9, [sp, #16]
	ldr	x9, [x9, #8]
	add	x0, x8, x9
	ldr	x1, [sp, #8]
	ldr	x8, [sp]
	add	x2, x8, #1
	mov	x3, #-1
	bl	___memmove_chk
	ldr	x10, [sp]
	ldr	x9, [sp, #16]
	ldr	x8, [x9, #8]
	add	x8, x8, x10
	str	x8, [x9, #8]
	mov	w8, #1
	and	w8, w8, #0x1
	and	w8, w8, #0x1
	sturb	w8, [x29, #-1]
	b	LBB4_5
LBB4_5:
	ldurb	w8, [x29, #-1]
	and	w0, w8, #0x1
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #144
	.cfi_def_cfa_offset 144
	stp	x29, x30, [sp, #128]            ; 16-byte Folded Spill
	add	x29, sp, #128
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	wzr, [x29, #-4]
	sub	x0, x29, #32
	str	x0, [sp]                        ; 8-byte Folded Spill
	stur	xzr, [x29, #-32]
	stur	xzr, [x29, #-24]
	stur	xzr, [x29, #-16]
	mov	x1, #700
	bl	_arena_malloc_init
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	mov	x1, #200
	mov	x2, #1
	bl	_alloc_arena
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	add	x8, sp, #64
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	mov	x1, #75
	bl	_string_init
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	adrp	x1, l_.str.1@PAGE
	add	x1, x1, l_.str.1@PAGEOFF
	bl	_append_string_arr
	mov	w8, #1
	and	w8, w0, w8
	strb	w8, [sp, #63]
	ldrb	w8, [sp, #63]
	tbnz	w8, #0, LBB5_2
	b	LBB5_1
LBB5_1:
	adrp	x0, l_.str.2@PAGE
	add	x0, x0, l_.str.2@PAGEOFF
	bl	_printf
	mov	w8, #1
	stur	w8, [x29, #-4]
	b	LBB5_3
LBB5_2:
	ldr	q0, [sp, #64]
	add	x0, sp, #16
	str	q0, [sp, #16]
	ldr	q0, [sp, #80]
	str	q0, [sp, #32]
	bl	_print_string
	adrp	x0, l_.str.3@PAGE
	add	x0, x0, l_.str.3@PAGEOFF
	bl	_printf
	b	LBB5_3
LBB5_3:
	ldur	w0, [x29, #-4]
	ldp	x29, x30, [sp, #128]            ; 16-byte Folded Reload
	add	sp, sp, #144
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_file                       ; -- Begin function get_file
	.p2align	2
_get_file:                              ; @get_file
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	adrp	x0, l_.str.4@PAGE
	add	x0, x0, l_.str.4@PAGEOFF
	adrp	x1, l_.str.5@PAGE
	add	x1, x1, l_.str.5@PAGEOFF
	bl	_fopen
	str	x0, [sp, #16]
	ldr	x8, [sp, #16]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB6_2
	b	LBB6_1
LBB6_1:
	adrp	x0, l_.str.6@PAGE
	add	x0, x0, l_.str.6@PAGEOFF
	bl	_printf
	b	LBB6_2
LBB6_2:
	ldur	x0, [x29, #-8]
	ldr	x3, [sp, #16]
	mov	x1, #1
	mov	x2, #99
	bl	_fread
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	subs	x8, x8, #1
	cset	w8, hs
	tbnz	w8, #0, LBB6_4
	b	LBB6_3
LBB6_3:
	adrp	x0, l_.str.7@PAGE
	add	x0, x0, l_.str.7@PAGEOFF
	bl	_printf
	b	LBB6_4
LBB6_4:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #8]
	add	x8, x8, x9
	strb	wzr, [x8]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"(%s)"

	.section	__TEXT,__const
l_.str.1:                               ; @.str.1
	.asciz	"when the music fades\000"

	.section	__TEXT,__cstring,cstring_literals
l_.str.2:                               ; @.str.2
	.asciz	"\n failed to add string"

l_.str.3:                               ; @.str.3
	.asciz	"\n soli deo gloria, string & arena alloc"

l_.str.4:                               ; @.str.4
	.asciz	"./upstream-1brc/measurements.txt"

l_.str.5:                               ; @.str.5
	.asciz	"r"

l_.str.6:                               ; @.str.6
	.asciz	"Error opening file\n"

l_.str.7:                               ; @.str.7
	.asciz	"Error reading file\n"

.subsections_via_symbols
