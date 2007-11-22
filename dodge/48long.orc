; FIG 4.8.long.orc
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  i1        =  1/p3
  i2        =  cpspch(p4)
  i3        =  i1*p6
  i4        =  i3*p7

  a1        oscil     p5,i1,2
  a2        oscil     i4,i1,1
  a2        oscili    a2,i3,3
  a1        oscili    a1,i2+a2,3

            out       a1

endin
