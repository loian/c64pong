;============================================================
; detect space pressed
;============================================================

WaitSpace
            LDA $CB
            CMP #$24  ;Scancode for SPACE
            BNE CheckN

            LDA #$02
            STA ball_x_speed + 2
            RTS

CheckN
            LDA $CB
            CMP #$27  ;Scancode for SPACE
            BNE ReleaseKey

            LDA #$FE
            STA ball_x_speed + 2
            LDA #$FF
            STA ball_x_speed + 3

            RTS




ReleaseKey
            LDA #$00
            STA ball_x_speed + 2
            RTS
