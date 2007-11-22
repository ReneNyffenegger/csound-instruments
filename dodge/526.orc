; FIG 5.26.ORC
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1

  i1        =  cpspch(p4)
  i2        =  int((80000/i1)+.5)
  i3        =  1/32767

  a1        linen     p5,p6,p3,p7
  k1        linen     p5,p6,p3,p7
  a2        buzz      a1,i1,i2,5
  a2        reson     a2,i1,i1,1,0
  a2        reson     a2,500,500,1,0
  a2        reson     a2,1500,750,1,0
  a2        reson     a2,3000,1200,1,0
  a2        balance   a2,a1
  k1        =  (k1*i3)*8000
  a1        reson     a2,0.,k1,1,0
            out       a1
     
endin
