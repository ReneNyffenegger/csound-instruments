instr          2
  icps      cpsmidi   
  k1        linseg    3.060,42*.4,3.060,42*.6,3.060*.9
  k2        linseg    5000,42*.95,5000,42*.05,5000*.01
  a1        pluck     k1,icps,icps,0,1,0,0
  imax      ampmidi   10000, 100
  kgate     linenr    imax, 0, 1, .01
            out       a1*kgate
endin
