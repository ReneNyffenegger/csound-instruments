; TSCST8.ORC    AMPLITUDE MODULATOR
;                       (c) Rajmil Fischman, 1997
;--------------------------------------
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 10          
;-------------------------------                        ; PARAMETER LIST
;p4     : AMPLITUDE
;p5     : CARRIER
;p6     : ATTACK
;p7     : DECAY
;p8     : MODULATOR FREQUENCY
;p9     : CARRIER FUNCTION TABLE
;p10 : MODULATOR TABLE
;-------------------------------
  kenv      linen     p4, p6, p3, p7              ; ENVELOPE
  acarr     oscil     1, p5, p9                   ; CARRIER
  amod      oscil     1, p8, p10                  ; MODULATOR
  aoutm     =  acarr*amod                         ; MODULATED SIGNAL
            out       kenv*aoutm                  ; OUTPUT
endin
                                                        
