  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  ims       =  100
;a1       oscil     5000, 1737, 2
  a1        oscil     5000, 1/1.3113, 2
;a1       rand      5000
  a2        oscil     ims - 40, .3, 1
  a2        pow       a2, 2, ims - 40
  a2        =  a2 + 20
  a3        vdelay    a1, a2, ims
  a4        vdelay    a3, a2, ims
  a5        vdelay    a4, a2, ims
  a6        vdelay    a5, a2, ims
            out       a1+a3+a4+a5+a6
endin
