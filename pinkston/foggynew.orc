;========================================================
; Example time-stretching instrument using Fog. Allows
; number of overlaps to be specified in the score. Based
; on Michael Clark's design from Boulanger book. RP
;========================================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1
  ipkamp    =  p4
  ipshift   =  p5
  itscale   =  p6
  igdur     =  p7
  iolaps    =  p8
  isndfn    =  p9
  iwndfn    =  p10
  igrfrq    =  1/(igdur/iolaps)
  a3        linseg    0, p3*.01, 1, p3*.9, 1, p3*.09, 0
  i1        =  sr/ftlen(isndfn)                   ;speed factor (relative to sr and table length)
  a2        phasor    i1*itscale                  ;phase input for speed
  a1        fog       ipkamp, igrfrq, ipshift, a2, 0, 0, igdur/2, igdur, igdur/2, iolaps, isndfn, iwndfn, p3, 0, 1
            out       a1*a3
endin
