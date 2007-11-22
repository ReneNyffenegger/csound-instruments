; TSCST1.ORC    SIMPLE OSCILLATOR
;               (c) Rajmil Fischman, 1997
;---------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
                    
instr 1
;--------PARAMETER LIST-----------------------              
; p4: AMPLITUDE
; p5: FREQUENCY
; p6: FUNCTION TABLE
;-------------------------------;
  kenv      linen     p4,0.1,p3,0.2               ; ENVELOPE
  aout      oscili    kenv,p5,p6                  ; OSCILLATOR
            out       aout                        ; OUTPUT
endin
                                             
