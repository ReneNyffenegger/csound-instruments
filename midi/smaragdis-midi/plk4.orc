instr     3
  icps      cpsmidi   
  k1        linseg    5000,42*.95,5000,42*.05,5000*.01
  a1        pluck     5000,icps,icps,0,1,0,0
  k2        linseg    4000,42*.85,4000,42*.15,4000*.1
  a2        reson     a1,icps,k2,0,0
  imax      ampmidi   1, 100
  kgate     linenr    imax, 0, 1, .01
            out       a2*kgate
endin
