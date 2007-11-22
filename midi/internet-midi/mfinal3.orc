  nchnls    =  2

instr 1
            massign   1,1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  k1        expseg    17000,.3, 1
  a1        oscil     2,knote/4,1
  a2        oscil     k1,knote/4*a1,1
  a3        oscil     k1, knote, 1
  aa1       =  (a2+a3)*kgate
            outs      aa1*.5,aa1*(1-.5)
endin
