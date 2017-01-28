;============================================================
; configuration of sprites
;============================================================

; two locations will be used to at the one hand store the
; current shown frame of the sprite animation and on the other
; hand to keep track of delay to slow down animation

; the sprite pointer for Sprite#0
sprite_ball_pointer		= address_sprites / $40

; those are the shared sprite colors
; we could have parsed that information from the sprites.spr file
; but for this simple single-sprite demo we can just write it down
; manually
sprite_background_color = $00
sprite_color_1  	= $01

;============================================================
; Initialize Memory Locations not related to VIC-II registers
;============================================================

; initialize counters with frame numbers
;lda #sprite_frames_ship
;sta sprite_ship_current_frame


; store the pointer in the sprite pointer register for Sprite#0
; Sprite Pointers are the last 8 bytes of Screen RAM, e.g. $07f8-$07ff
;lda #sprite_pointer_ship
;sta screen_ram + $3f8

  lda #sprite_ball_pointer
  sta sprite0_addr

  ;============================================================
  ; Initialize involved VIC-II registers
  ;============================================================

  lda #$01     ; enable Sprite#0
  sta $d015

  lda #$00     ; set hires mode for Sprite#0
  sta $d01c

  lda #$00     ; Sprite#0 has priority over background
  sta $d01b

  lda #sprite_background_color ; shared background color
  sta $d021

  lda #sprite_color_1 	 ; sprite color
  sta $d025
