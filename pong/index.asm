
;============================================================
; Simple Pong Game
; Inspired by code by actraiser/Dustlayer
;

; sets CPU type and output file
!cpu 6502
!to "build/pong.prg",cbm

; load macro files
!source "../lib/macros/math.asm"
; load symbol table
!source "code/config/symbols.asm"

;============================================================
; Simple BASIC loader to avoid using SYS 49152
;============================================================

* = $0801                               ; BASIC start address (#2049)
!byte $0d,$08,$dc,$07,$9e,$20,$34,$39   ; BASIC loader to start at $c000...
!byte $31,$35,$32,$00,$00,$00           ; puts BASIC line 2012 SYS 49152

address_sprites = $2000
address_chars = $3800
address_sid = $1001

* = address_sprites
!bin "sprites/ball.bin",64

* = address_sid
; !bin "resources/empty_1000.sid",, $7c+2

* = address_chars
;!bin "resources/rambo_font.ctm",384,24

;============================================================
; Code starts at $c000
;============================================================
* = $c000
!source "code/init/sprites.asm"

;============================================================
; Main routine with our custom interrupt
;============================================================
!source "code/main.asm"

; Subroutines
!source "fsub/space_press.asm"
!source "fsub/sub_clear_screen.asm"
!source "fsub/update_ball_position.asm"
!source "fsub/play_sound.asm"
