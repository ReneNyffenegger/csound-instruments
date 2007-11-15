  sr        =  44100
  kr        =  4410
;sr=22050
;kr=2205
  ksmps     =  10

;i1 0 dur freq amp atk dk
instr 1
  iamp      =  (5000000/p4)*.5 * p5
  inoisp    =  5000
  iseed     =  p4/10000
  irvt      =  .5
  ilooptime =  1/p4
  ilp1      =  ilooptime * .95
  ilp2      =  ilooptime * 1.05
  ircf      =  p4 + p4*1.05
  iatk      =  p6
  idk       =  p7
  isust     =  p3-(iatk+idk)
  irbw      =  ircf/50
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  anoise    randi     1.0,inoisp,iseed
  asig1     comb      anoise,irvt,ilp1
  asig2     comb      anoise,irvt,ilp2
  asig      reson     asig1+asig2,ircf,irbw,1
            out       asig*kenv
endin

;i1 0 dur amp atk dk
instr 2
  iamp      =  1.0 * 10000
  inoisp    =  5000
  iseed     =  p4/10
  ifeedback =  .7
  iatk      =  p5
  idk       =  p6
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  kfreq     oscil     1.0, 1/p3, 2
  klooptime =  .5/kfreq
  klp1      =  klooptime * .95                    ;
  klp2      =  klooptime * 1.05                   ;
  krcf      =  kfreq + (kfreq*1.05)
  kbw       =  krcf/50.
  anoise    randi     1.0,inoisp,iseed
  addl      delayr    1.0
  atap1     deltap    klp1                        ;
  atap2     deltap    klp2                        ;
  asig1     =  anoise+(atap1*ifeedback)
  asig2     =  anoise+(atap2*ifeedback)
            delayw    anoise                      ;
  asig      reson     asig1+asig2,krcf,kbw,1
            out       asig*kenv
endin
