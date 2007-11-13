sr = 44100
kr = 2205
ksmps = 20
nchnls = 1

instr 2
ipitch = ( p4 < 15 ? cpspch(p4) : p4)   ; p4 can be in cps or pch
inoisewidth = (p9 < 15  ?  p9 * ipitch : p9)
inoiserate = (p10 = 0  ?  kr-1 : p10)     ; for maximum rate, use 0 in p10

kenv  envlpx p5, p6, p3, p7, 60, p8,.01  ; amplitude envelope
knoise randi  inoisewidth, inoiserate    ; for p10 any value up to kr-1 is OK
audio  oscili  kenv , ipitch + knoise, 100
out audio
endin

