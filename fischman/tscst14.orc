; TSCST14.ORC   FM SYNTHESIS INSTRUMENT USING FOSCIL
;               (c) Rajmil Fischman, 1997
;--------------------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 14
;--------------------------------------------;PARAMETER LIST
; p4 : AMPLITUDE
; p5 : FREQUENCY
; p6 : CARRIER/FREQUENCY
; p7 : MODULATOR/FREQUENCY
; p8 : INDEX
; p9 : OSCILLATOR FUNCTION (USUALLY A SINE WAVE)
;-----------------------------------------------
  kenv      linen     p4,.1,p3,.1                 ; ENVELOPE (ATTACK = DECAY = .1 SEC)
  aout      foscili   kenv,p5,p6,p7,p8,p9         ; FM OSCILLATOR
            out       aout                        ; OUTPUT
endin
