  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  ga1       init      0

instr          1
  k1        expseg    p7,p3,p8
  k2        expseg    p4*.1,p3*.01,p4,p3*.99,p4*.2 ;AMP SEG
  k3        expseg    p5,p3*.05,p5*1.1,p3*.05,p5,p3*.9,p5*.4 ;FREQ SEG
  a1        oscili    k2,k3*1,1
  a2        oscili    k2,k3*1.414,1
  ga1       reson     (a1*a2),p5,k1,1,0
endin

instr          2
  k1        oscil     1,1/p3,2
            outs1     ga1*k1
            outs2     ga1*(1-k1)
endin
