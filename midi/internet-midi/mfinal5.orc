  nchnls    =  2

instr 1
            massign   1,1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  k1        expseg    10000*2,.5,100
  a2        oscil     2,knote/2,2
  a1        oscil     k1,knote*a2,1
  aa1       =  a1*kgate
            outs      aa1,aa1
endin
