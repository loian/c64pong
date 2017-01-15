; 16 bit sum between two integers (carry not clear)
!macro add16nc a, b, c {
  lda b
  adc a
  sta c
  lda b+1
  adc a+1
  sta c+1
}

!macro add16 a, b, c {
  clc
  +add16nc a, b, c
}

!macro sub16nc a, b, c {
  lda a+1
  sbc b+1
  sta c+1
  lda a
  sbc b
  sta c
}

!macro sub16 a, b, c {
  clc
  +sub16nc a, b, c
}

!macro add32 a, b, c {
  +add16    a,    b, c
  +add16nc  a+2,  b+2, c+2
}

!macro sub32 a, b, c {
  +sub16    a+2, b+2, c+2
  +sub16nc  a, b, c
}

!macro neg32 src, dst {
		sec
		lda #0
		sbc src+0
		sta dst+0
		lda #0
		sbc src+1
		sta dst+1
		lda #0
		sbc src+2
		sta dst+2
		lda #0
		sbc src+3
		sta dst+3
}
