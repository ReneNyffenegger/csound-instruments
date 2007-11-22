  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr     1
  k1        linseg    p4*.1,p3*.2,p4,p3*.8,p4*.2
  k2        linseg    4,.2,2,p3-.2,1.9
  gk3       oscil     1,p6/p3,2
  k4        linseg    p5,p3*.1,p5*1.1,p3*.9,p5*.95
  ga1       foscili   k1,k4,3,1.007,k2,1
          ;outs1    ga1*gk3
          ;outs2    ga1*(1-gk3)                   ;TRYING TO GET DELAY ON BOTH SIDES
          ;outs2    ga1*(1-gk3)
endin


instr     3
  k1        linseg    p4*.1,p3*.2,p4,p3*.8,p4*.2
;k1       linen     p4,.2,p3,.2
  k2        linseg    4,.2,2,p3-.2,1.9
  gk3       oscil     1,p6/p3,2
  k4        linseg    p5,p3*.1,p5*.95,p3*.9,p5*1.1
  ga2       foscili   k1,k4,3,1.007,k2,1
          ;outs1    ga2*gk3
          ;outs2    ga2*(1-gk3)                   ;TRYING TO GET DELAY ON BOTH SIDES
          ;outs2    ga1*(1-gk3)
endin

instr     2
  a1        reverb    ga1+ga2,.5
            outs1     a1*(1-gk3)
            outs2     a1*gk3
endin

