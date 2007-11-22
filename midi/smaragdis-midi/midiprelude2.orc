  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  icps      cpsmidi   
  iamp      =  15000
  a1        pluck     iamp, icps, icps, 0, 1
            out       a1
endin
