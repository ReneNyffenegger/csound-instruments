  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr    1 ; Circular Pan

  ilevl     =  p4                                 ; Output level
  irate     =  p5                                 ; Pan rate
  ilr       =  p6/2                               ; Left to Right depth
  ifb       =  p7/2                               ; Front to Back depth
  ipos      =  p8/360                             ; Start position in degrees: 0/360=Nearest
  idir      =  p9/2                               ; Direction

  ain       soundin   "sample1.wav"

  klfo1     oscili    ilr, irate, 1, ipos + idir  ; L to R sine
  klfo1     =  klfo1 + .5                         ; Scale
  klfo2     oscili    ifb, irate, 1, ipos + .75   ; F to B cosine
  klfo2     =  1 - (klfo2 + ifb)                  ; Scale
  ain       =  ain*klfo2                          ; F to B modulation
  al        =  ain*sqrt(klfo1)                    ; L pan
  ar        =  ain*sqrt(1 - klfo1)                ; R pan
            outs      al*ilevl, ar*ilevl          ; Level and output

endin

