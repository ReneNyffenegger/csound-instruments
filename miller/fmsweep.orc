;FM WITH FREQ SWEEP
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1
  k1        linseg    0,p3*.8,1,p3*.2,.1
  k2        linseg    0,p3*.5,p6,p3*.5,0
  k3        linseg    p5,p3*.5,p5*1.2,p3*.4,p5*.8,p3*.3,p5*1.1,p3*.2,p5*.9,p3*.1,p5
  a1        foscil    k1*p4,k3,p7,p8,k2,1
            out       a1*.85
endin

instr          2
  k1        linseg    0,p3*.4,.8,p3*.2,.1,p3*.3,1,p3*.1,.5
  k2        linseg    0,p3*.8,p6,p3*.2,0
  k3        linseg    p5*.85,p3*.4,p5*1,p3*.2,p5*1.1,p3*.4,p5*.2
  a1        foscil    k1*p4,k3,p7,p8,k2,1
            out       a1*.85
endin

instr          3

  k1        linseg    0,p3*.5,.5,p3*.4,1,p3*.1,.7 ;AMP SEG
  k2        linseg    0,p3*.4,.5,p3*.2,.3,p3*.4,1 ;MOD INDX SEG
  k3        linseg    1,p3*.3,.5,p3*.3,.8,p3*.3,.2,p3*.1,0 ;FREQ SEG
  a1        foscil    k1*p4,k3,p7,p8,k2,1
            out       a1*.85
endin
