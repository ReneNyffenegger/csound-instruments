sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

instr 1
kenv  envlpx  p5, p6, p3, p7, 60, p8, .01 , p9  ; amplitude envelope
; amplitude tremolo :
  ktremrate  line  p10, p3 , p11   ; tremolo rate envelope
  ktremolo  oscil  p12 , ktremrate, 60  ; amplitude modulation signal
    ; add non-modulated & modulated amplitude signals
kamp = ( (1. - p12) * kenv)  +  (ktremolo  * kenv)
anoise  rand  kamp
out anoise
endin

