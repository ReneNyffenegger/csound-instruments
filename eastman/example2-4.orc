  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1
; control oscillator (kenv) supplies time envelope to audio oscillator
;    score p-fields:
;    p4 =  pitch, in pch notation,
;    p5 = peak amplitude
;    p6 = function number for control oscillator envelope
;    p7 = function number for audio oscillator waveshapeinstr 1
instr 1

  kenv      oscili    p5, 1/p3, p6                ; control oscillator -- creates amplitude envelope
  a1        oscili    kenv, cpspch(p4),  p7       ; audio oscillator
            out       a1
endin
