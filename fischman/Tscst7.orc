; TSCST7.ORC    AMPLITUDE MODULATOR
;                       (c) Rajmil Fischman, 1997
;--------------------------------------
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 8                 ; USED TO PLAY PURE SINEWAVES
;-------------------------------                        ; PARAMETER LIST
;p4     :amplitude
;p5     :carrier
;p6     :attack
;p7     :decay
;p8     :function table
;-------------------------------
  kenv      linen     p4,p6,p3,p7                 ; ENVELOPE
  aout      oscili    kenv,p5,p8                  ; OSCILLATOR
;-------------------------------                        ; OUTPUT
            out       aout
endin


instr 9                                         ; SIDEBANDS ONLY
;-------------------------------                        ; PARAMETER LIST
;p4     : amplitude
;p5     : carrier
;p6     : attack
;p7     : decay
;p8     : modulator
;p9     : function
;-------------------------------
  kenv      linen     p4,p6,p3,p7                 ; ENVELOPE
  acarr     oscili    1,p5,p9                     ; CARRIER
  amod      oscili    1,p8,p9                     ; MODULATOR
  aout      =  acarr*amod                         ; MODULATION
            out       kenv*aout                   ; OUTPUT
endin
