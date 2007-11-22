  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  kfreq     expseg    5*p4,p3/2,0.9*p4,p3/2,5*p4
  a1        oscil     20000,p4,1
  a2        butterbr  a1,kfreq,kfreq/5
            out       a2
endin
