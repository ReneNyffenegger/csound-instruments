; FIG 5.21.orc
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  i1        =  1/p3
  a1        rand      p5
  k1        oscil     1.,i1,4
  k1        =  k1*p4
  k2        oscil     1.9,i1,1
  k2        =  (k2+.1)*k1
  a1        reson     a1,k1,k2,2,0
            out       a1
endin
