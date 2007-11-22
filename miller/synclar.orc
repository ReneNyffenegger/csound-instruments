;TESTING CLARINET ADDITIVE IN CLAR.SCO

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1

  k1        randi     p8,p9                       ;CONTROLS BNDWDTH 5 IS GOOD FREQ    P8=RANGE P9=FREQ
  k2        expseg    p4*.001,p3*.075,p4,p3*.915,p4,p3*.01,p4*.001
  k3        linseg    p5,p3,p6                    ;SEG FOR FREQ
  a1        oscil     k2,k3,1
  a2        reson     a1,k3,k1+p7,1,0
  k4        linseg    0,p3*.01,1,p3*.98,1,p3*.01,0
            out       a2*k4
endin
