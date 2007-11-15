  sr        =  44100
  kr        =  882
  ksmps     =  50

; sequencer on foscil
instr 1
  igain     =  7000

  isine     =  5
  itsize1   =  p4
  itsize2   =  p5
  itsize3   =  p6
  itsize4   =  p7

  ispeed1   =  p8
  ispeed2   =  p9
  ispeed3   =  p10
  ispeed4   =  p11

  k1        phasor    ispeed1
  k2        phasor    ispeed2
  k3        phasor    ispeed3
  k4        phasor    ispeed4
        
  kcar      table     k1*itsize1,1
  kindex    table     k2*itsize2,2
  kcm       table     k3*itsize3,3
  kcps      table     k4*itsize4,4
        
  afm       foscil    igain, kcar, kcps, kcm, kindex, isine
;       adel1 delay afm, .03
;       adel2 delay afm, .07
;       amix = afm+adel1+adel2
;       out amix
            out       afm
endin