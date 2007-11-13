  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1601
  kband     line      p5, p3, p6
  aenv      linseg    0, p3*.01, 1, p3*.8, .6, p3*.1, 0
  a1        rand      p4
  abp       butterbp  a1, 333, kband
            out       abp*aenv
endin 

