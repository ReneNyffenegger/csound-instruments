  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  icps      cpsmidi   
  kvol      midictrl  1, 0, 32000

  a1        oscil     kvol, icps, 1
;a1             tone            a1, 4000
            out       a1
endin
