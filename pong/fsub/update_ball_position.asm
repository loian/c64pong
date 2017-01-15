;============================================================
; Updates ball position on screen
;============================================================

update_ball

            ; X a + b --> c
            ;+add32 ball_x_acc, ball_x_speed, ball_x_speed
            +add32 ball_x_speed, ball_x, ball_x
;
;            ; add acc to y speed
            ; TODO: cmp32 macro
            lda ball_x + 2
            cmp #$ee
            bcc keep_x_speed

            ; y - $e0
            +sub32 ball_x, xmax, r1
            +sub32 xmax, r1, ball_x
            +neg32 ball_x_speed, ball_x_speed

keep_x_speed
            ; TODO: cmp32 macro
            lda ball_x + 2
            cmp #21
            bcs keep_x_speed2

            +sub32 ball_x, xmin, r1
            +sub32 xmin, r1, ball_x
            +neg32 ball_x_speed, ball_x_speed

keep_x_speed2
            ; compute Y coord adding acceleration and speed
            +add32 ball_y_acc, ball_y_speed, ball_y_speed
            +add32 ball_y_speed, ball_y, ball_y

            lda ball_y + 2
            cmp #$e8
            bcc keep_y_speed

            ; y - $e0
            ;+sub32 ball_y, ylim, r1
            ;+sub32 ylim, r1, ball_y
            +neg32 ball_y_speed, ball_y_speed
keep_y_speed

            lda ball_x + 2 	        ; set Sprite#0 positions with X/Y coords to
            sta sprite0_x_coord   ; lower right of the screen

            lda ball_y + 2
            sta sprite0_y_coord
;            cmp #$e8
;            beq skip_acc
;
;skip_acc
            ;lda #50 ; <ball_y
            ;sta ball_y ; ball_y_coord

; load sprite pointers

            ;bcc
            ;lda >ball_x_speed
            ;add $d000
            rts                            ; do nothing in this refresh, return

xmin
    !byte $00, $00, 21, $00
xmax
    !byte $00, $00, $ee, $00
ylim
    !byte $00, $00, $e8, $00
r1
    !word 0, 0
