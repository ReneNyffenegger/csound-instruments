; FIG 5.24a.orc

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  i1        =  cpspch(p4)
  i2        =  int((8000/i1)+.5)
  i3        =  1/32767

  a1        linen     p5,p6,p3,p7
  k1        linen     p5,p6,p3,p7
  a2        buzz      a1,i1,i2,5
  k1        =  (k1*i3)*5000.
  a1        reson     a2,0.,k1,1,0

            out       a1
endin
