  nchnls    =  2

instr 1
            massign   1,1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  k2        expseg    2,2,440
  k1        expseg    232,2, 10000
  a6        oscil     k1,k2,2
  a5        oscil     2,2,2
  a4        oscil     7000,2,2
  a3        oscil     2,knote*1.5,1
  a2        oscil     2,knote/2,1
  a1        oscil     a4*(a2+a3),a5*a6, 1 
  aa1       =  (a1)*kgate  
            outs      aa1*.5,aa1*(1-.5)    
endin
