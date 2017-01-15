;===============================================================
; setting up some general symbols we use in our code
;================================================================

ints     = 4

ball_x     = $200
ball_y     = ball_x + ints

ball_x_speed = ball_y + ints
ball_y_speed = ball_x_speed + ints

ball_x_acc = ball_y_speed + ints
ball_y_acc = ball_x_acc + ints

;============================================================
; symbols
;============================================================

screen_ram      = $0400     ; location of screen ram
init_sid        = $11ed     ; init routine for music
play_sid        = $1004     ; play music routine
delay_counter   = $90       ; used to time color switch in the border
pra             = $dc00     ; CIA#1 (Port Register A)
prb             = $dc01     ; CIA#1 (Port Register B)
ddra            = $dc02     ; CIA#1 (Data Direction Register A)
ddrb            = $dc03     ; CIA#1 (Data Direction Register B)

; Sprite registers
sprite0_addr   = $07f8

; coords
sprite0_x_coord = $d000
sprite0_y_coord = $d001
