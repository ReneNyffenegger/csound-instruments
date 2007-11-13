sr      = 44100
kr      = 4410
ksmps   = 10
nchnls  = 1
 
instr     1 ; 'Streson' resonator bank
 
ilevl     = p4/10                          ; Output level (roughly scaled)
ipitch1   = (p05 < 20 ? cpspch(p05) : p05) ; Filter 1 freq
ipitch2   = (p06 < 20 ? cpspch(p06) : p06) ; Filter 2 freq
ipitch3   = (p07 < 20 ? cpspch(p07) : p07) ; Filter 3 freq
ipitch4   = (p08 < 20 ? cpspch(p08) : p08) ; Filter 4 freq
ipitch5   = (p09 < 20 ? cpspch(p09) : p09) ; Filter 5 freq
ipitch6   = (p10 < 20 ? cpspch(p10): p10)  ; Filter 6 freq
ifdbk     = p11                            ; Filter bandwidth

ain       soundin  "sample1.wav"

ares1     streson  ain, ipitch1, ifdbk     ; Filter 1
ares2     streson  ain, ipitch2, ifdbk     ; Filter 2
ares3     streson  ain, ipitch3, ifdbk     ; Filter 3
ares4     streson  ain, ipitch4, ifdbk     ; Filter 4
ares5     streson  ain, ipitch5, ifdbk     ; Filter 5
ares6     streson  ain, ipitch6, ifdbk     ; Filter 6
aout      sum  ares1, ares2, ares3, ares4, ares5, ares6
out       aout*ilevl                       ; Level and output

endin