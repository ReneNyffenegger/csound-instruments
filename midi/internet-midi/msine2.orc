
instr          1
            massign   1,1
  knote     cpsmidib  
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  ifreq     =  inote
  igain     =  2*10000
  irise     =  .3
  isust     =  2-(irise*2)
  kenv      linseg    0,irise,igain,isust,igain,irise,0
  asig      oscil     kenv,ifreq,1
            out       asig*kgate
endin
