;TSCST2.ORC   SIMPLE OSCILLATOR WITH ENVELOPE
;                   (c) Rajmil Fischman, 1997
;------------------------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 2
;-------------------------------                        ; PARAMETER LIST
; p4: AMPLITUDE
; p5: FREQUENCY
; p6: ATTACK
; p7: DECAY
; p8: FUNCTION TABLE
;-------------------------------;
  kenv      linen     p4, p6, p3, p7              ; ENVELOPE
  aout      oscili    kenv, p5, p8                ; OSCILLATOR
;-------------------------------                        ; OUTPUT
            out       aout              
endin
                                                                        
