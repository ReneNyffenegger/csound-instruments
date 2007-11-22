; FIG 3.26A.ORC
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1
  i1        =  1/p3
  i2        =  cpspch(p4)
  i3        =  p5/2
  i4        =  p5/6
  i5        =  p5/2.5

  k1        oscili    i3,i1,2
  a1        randi     k1,p6
  a1        oscili    a1,4000,3

  a2        oscili    i4,i1,2
  a2        oscili    a2,i2*.1,4

  a3        oscili    i5,i1,1
  a3        oscili    a3,i2,3

            out       a1+a2+a3

endin
