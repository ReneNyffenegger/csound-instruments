  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
 
instr     1 ; 'Reson' filter bank
 
  ilevl     =  p4/1000                            ; Output level (roughly scaled)
  ipitch1   =  (p05 < 20 ? cpspch(p05) : p05)     ; Filter 1 freq
  ipitch2   =  (p06 < 20 ? cpspch(p06) : p06)     ; Filter 2 freq
  ipitch3   =  (p07 < 20 ? cpspch(p07) : p07)     ; Filter 3 freq
  ipitch4   =  (p08 < 20 ? cpspch(p08) : p08)     ; Filter 4 freq
  ipitch5   =  (p09 < 20 ? cpspch(p09) : p09)     ; Filter 5 freq
  ipitch6   =  (p10 < 20 ? cpspch(p10) : p10)     ; Filter 6 freq
  iband     =  p11                                ; Filter bandwidth

  ain       soundin   "sample1.wav"

  ares1     reson     ain, ipitch1, iband         ; Filter 1
  ares2     reson     ain, ipitch2, iband         ; Filter 2
  ares3     reson     ain, ipitch3, iband         ; Filter 3
  ares4     reson     ain, ipitch4, iband         ; Filter 4
  ares5     reson     ain, ipitch5, iband         ; Filter 5
  ares6     reson     ain, ipitch6, iband         ; Filter 6
  aout      sum       ares1, ares2, ares3, ares4, ares5, ares6 ; Sum filters
            out       aout*ilevl                  ; Output and level

endin