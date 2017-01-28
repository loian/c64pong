;============================================================
; Updates ball position on screen
;============================================================

update_ball
;            ; add acc to y speed
            ; TODO: cmp32 macro
            ; lt32: a < b? label1 : label2
bkp1
            ldx ball_x_speed + 3  ; check x_speed (s)
            bpl speed_gt_0        ; s > 0 ? check xmax collision
            bmi speed_lt_0        ; s < 0 ? check xmin collision
            jmp update_x_coord    ; s = 0 ? skip collision checks
speed_lt_0:
            jmp check_xmin
speed_gt_0:
            +gt32 ball_x, xmax, invert_x_speed_xmax, update_x_coord
invert_x_speed_xmax:
;            ; y - $e0
            +sub32 ball_x, xmax, r1
            +sub32 xmax, r1, ball_x
            jmp neg_ball_x_speed
check_xmin:
            +lt32 ball_x, xmin, invert_x_speed_xmin, update_x_coord
invert_x_speed_xmin:
;            ; y - $e0
            +sub32 xmin, ball_x, r1
            +sub32 xmin, r1, ball_x
neg_ball_x_speed:
            +neg32 ball_x_speed, ball_x_speed
update_x_coord:
            ; Finally compute new sprite position
            +add32 ball_x_acc, ball_x_speed, ball_x_speed
            +add32 ball_x_speed, ball_x, ball_x

check_y_bound:
            lda ball_y_speed + 3 ; if speed is negative, do not check for ylim bound
            bpl y_speed_gt_0        ; s > 0 ? check xmax collision
            jmp update_y_coord    ; s = 0 ? skip collision checks
y_speed_gt_0:
            +gt32 ball_y, ymax, invert_y_speed_ymax, update_y_coord
invert_y_speed_ymax:
            ;            ; y - $e0
            +sub32 ball_y, ymax, r1
            +sub32 ymax, r1, ball_y
            +neg32 ball_y_speed, ball_y_speed

            lda #3                ; request playback
            sta effect
update_y_coord:
            +add32 ball_y_acc, ball_y_speed, ball_y_speed
            +add32 ball_y_speed, ball_y, ball_y
            ; Finally compute new sprite position
update_sprite
            lda ball_x + 3
            and #$01              ; keep only the first bit
            sta r3                ; save it for later
            lda $d010             ; read sprites 0-7 high bits
            and #$fe              ; clear only first bit (spr0_high_pos)
            ora r3                ; set it as it should be
            sta $d010             ; save coords with new position set
            lda ball_x + 2 	        ; set Sprite#0 positions with X/Y coords to
            sta sprite0_x_coord   ; lower right of the screen
            lda ball_y + 2
            sta sprite0_y_coord
            rts
ball_x
    !byte 00, 00, 60, 00  ; ball_x
ball_y
    !byte 00, 00, 90, 00 	; ball_y
ball_x_speed
    !byte 0, 00, 3, 0
ball_y_speed
    !word 0, 0
ball_x_acc
    !word 0, 0
ball_y_acc
    !byte $0, $30, $00, $00	; ball_y_acc
yattr
    !byte $00, $60, 00, 00
xmin
    !byte $00, $00, 24, $00
xmax
    !byte $00, $00, $42, $01
ymax
    !byte $00, $00, $e3, $00
r1
    !word 0, 0
r2
    !word 0, 0
r3  !word 0, 0

zero
    !byte 00, 00, 60, 00  ; ball_x
