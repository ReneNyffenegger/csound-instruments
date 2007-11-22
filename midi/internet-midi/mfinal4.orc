  nchnls    =  2
instr 1
            massign   1,1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,01
  k3        expseg    124,1,100
  k2        expseg    62, 0.7 , 62*0.7
  k1        expseg    20000, .7, 1500, .3,1
  a2        oscil     k3,15,2
  a1        oscil     k1,k2, 1
  aa1       =  (a1+a2)*kgate
            outs      aa1,aa1
endin
