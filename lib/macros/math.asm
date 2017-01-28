!macro clr32 .mem {
		 lda #0
		 sta .mem+0
		 sta .mem+1
		 sta .mem+2
		 sta .mem+3
}

; 16 bit sum between two integers (carry not clear)
!macro add16nc .a, .b, .c {
  lda .b
  adc .a
  sta .c
  lda .b+1
  adc .a+1
  sta .c+1
}

!macro add16 .a, .b, .c {
  clc
  +add16nc .a, .b, .c
}

!macro sub16nc .a, .b, .c {
  lda .a
  sbc .b
  sta .c
  lda .a+1
  sbc .b+1
  sta .c+1
}

!macro sub16 .a, .b, .c {
  sec
  +sub16nc .a, .b, .c
}

!macro add32 .a, .b, .c {
  +add16    .a,    .b, .c
  +add16nc  .a+2,  .b+2, .c+2
}

!macro sub32 .a, .b, .c {
  +sub16      .a, .b, .c
  +sub16nc    .a+2, .b+2, .c+2
}

!macro neg32 .src, .dst {
		sec
		lda #0
		sbc .src+0
		sta .dst+0
		lda #0
		sbc .src+1
		sta .dst+1
		lda #0
		sbc .src+2
		sta .dst+2
		lda #0
		sbc .src+3
		sta .dst+3
}

!macro cmp16 .a, .b {
    lda .a+1
    cmp .b+1
    bne _done
    lda .a+0
    cmp .b+0
_done
}

; COMPARE FUNCTIONS
!macro cmp32u .a, .b {
		lda .a+3
		cmp .b+3
		bne _done
		lda .a+2
		cmp .b+2
		bne _done
		lda .a+1
		cmp .b+1
		bne _done
		lda .a+0
		cmp .b+0
_done
}

;!macro asl32 .va, .r {
;  !if va != r {
;		 lda va+0
;		 asl a
;		 sta r+0
;		 lda va+1
;		 rol a
;		 sta r+1
;		 lda va+2
;		 rol a
;		 sta r+2
;		 lda va+3
;		 rol a
;		 sta r+3
;	} else {
;		 asl va+0
;		 rol va+1
;		 rol va+2
;		 rol va+3
;	}
;}

!macro asl32eq .va {
	asl .va+0
	rol .va+1
	rol .va+2
	rol .va+3
}

!macro mul32	._a, ._b, .r {
    +clr32 .r
    ldx #32
._loop
    +asl32eq .r
    +asl32eq ._a
    bcc ._next
		+add32 ._a, ._b, .r
._next
		dex
		bpl ._loop
}

!macro lt32 .a, .b, .lt, .gte {
	lda .a
	cmp .b
	lda .a+1
	sbc .b+1
	lda .a+2
	sbc .b+2
	lda .a+3
	sbc .b+3
	bvc .skip	; do not invert the N flag if oVerflow Clear
	eor $80		; invert the N flag.
.skip
  bmi .lt
	bpl .n
.n
	jmp .gte
.lt
}

!macro gt32 .a, .b, .y, .n {
	+lt32 .b, .a, .y, .n
}
