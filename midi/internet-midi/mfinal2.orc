  nchnls    =  2
;   *****  H.H. *****
instr          1
            massign   1,1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
;   ***** NOISE *****
  k1        expseg    10000*.8,0.3,50
  a2        oscil     k1,knote,1
;   **** ATTACK ****    
  k2        expseg    10000*1.8,0.2,1
  a3        oscil     20,438,1
  a4        oscil     k2,1024*a3,1
  aa1       =  (a2+a4)*kgate
            outs      aa1,aa1
endin
