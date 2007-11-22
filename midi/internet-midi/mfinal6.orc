  nchnls    =  2

instr 1
            massign   1,1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
;   ***** NOISE *****
  k1        expseg    6000,0.4, 1
  a2        oscil     k1,knote,2
;   ***** ATTACK ****       
  k2        expseg    6000*2,0.2,1
  k3        expseg    6000*2,0.1,1
  a3        oscil     k3,knote,2
  a4        oscil     k2,knote,2
  aa1       =  (a3+a2+a4)*kgate
            outs      aa1,aa1 
endin
