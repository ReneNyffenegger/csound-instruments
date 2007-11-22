; TSCST11.ORC  WAVESHAPER
;              (c) Rajmil Fischman, 1997
;---------------------------------------
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 12            ; BASIC WAVESHAPING INSTRUMENT
;-------------------------------             ;PARAMETER LIST
; p4 : AMPLITUDE
; p5 : FREQUENCY
; p6 : ATTACK
; p7 : DECAY
; p8 : OSCILLATOR FUNCTION
; p9 : WAVESHAPING FUNCTION
;-------------------------------
  ioffset   =  ftlen(p9)/2-1                      ; OFFSET
  kenv      linen     p4, p6, p3, p7              ; ENVELOPE
  ain       oscil     ioffset, p5, p8             ; INPUT 
  awsh      tablei    ain,p9,0,ioffset            ; WAVESHAPING VALUE
            out       kenv*awsh                   ; OUTPUT
endin

