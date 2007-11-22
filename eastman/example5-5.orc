  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  ; p4 = center frequency  ; p5 = bandwidth
instr 1
  kamp      expseg    1,p6,8000,p3-(p6+p7),5000,p7,1
  anoise    rand      kamp
  kbw       expseg    p8, .5 * p3 , p9 , .5 * p3 , p10 ; bandwidth envelope
  p4        =  (p4 < 15 ? cpspch(p4) : p4)
  p5        =  (p5 < 15 ? cpspch(p5) : p5)
  kcf       expon     p4, p3, p5                  ; center frequency
  a1        reson     anoise, kcf , kbw * kcf , 1
            out       a1
endin


