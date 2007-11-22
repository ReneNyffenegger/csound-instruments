  nchnls    =  2

instr 1
            massign   1,1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  a1        oscil     6000,knote,1
  a2        oscil     6000,knote*.995,1
  a3        oscil     6000,knote*1.005,1
  aa1       =  (a1+a2+a3)*kgate
            outs      aa1*.5,aa1*(1-.5)     
endin
