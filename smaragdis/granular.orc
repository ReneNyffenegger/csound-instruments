  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
          
instr 1
  ims       =  100
  ifr       =  2*1.3113
  a1        linseg    2000, 5, 100, p3 - 5, 100
  k1        linseg    .0005, 5, .3, p3 -  5, .3
  a3        grain     4000,ifr, a1, 0, 0, k1, 3, 2, .4
            out       a3
  gafx1     =  a3
endin

instr 2
  a1        line      100, p3, 0
  k1        line      20000, p3, 0   
  a2        grain     k1, 4000+p4, a1, 0, 100, .005, 1, 2, .005
            out       a2
  gafx2     =  a2
endin

instr 3
  a1        linseg    0, p3/2, 50, p3/2, 0
  k1        line      1000, p3, 20000
  a2        grain     k1, 3000, a1, 1000, 1000, .01, 1, 4, .01
            out       a2
  gafx3     =  a2
endin

instr 4
  k1        line      .01, p3, .0001
  a1        line      100, p3, 0
  a2        grain     15000, 3000, a1, 1000, 10, k1, 1, 2, .01
            out       a2
  gafx4     =  a2
endin

instr 5
  ifr       =  4*1.3113
  a1        =  4
  a2        grain     3000, p4*ifr, a1, 3000, ifr / 2, .3, 3, 4, .3
            out       a2
  gafx5     =  a2
endin

instr 6
  k1        line      .001, p3, .01
  a1        line      10, p3, 100
  a2        grain     15000, 3000+p4, a1, 1000, 10, k1, 1, 2, .01
            out       a2
  gafx6     =  a2
endin

instr 99
  afx       =  (gafx1+gafx2+gafx3+gafx4+gafx5+gafx6)/12
  a1        reverb    afx, 2
            out       a1
endin
