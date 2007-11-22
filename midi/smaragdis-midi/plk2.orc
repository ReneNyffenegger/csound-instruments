instr               2
  icps      cpsmidi   
  k1        linseg    1,1,4
  a1        pluck     32000,icps, icps,0,4,.5,2   ;try 2 if 1 fails

  imax      ampmidi   1, 100
  kgate     linenr    imax, 0, .5, .001
            out       a1*kgate
endin
