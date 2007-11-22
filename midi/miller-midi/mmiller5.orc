  nchnls    =  2

               ;massign  1,1


instr          1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc*10, 0, .2, .1

     ;k1       expseg    p4*.8,p3*.25,p4,p3*.6,p4*.2,p3*.15,.01
  k1        expseg    500*.8, .2*.25, 500, .2*.6, 500*.2, .2*.15, .01
     ;a1       foscili   k1,1,p5,p6,p7,1,0
  a1        foscili   k1, 1, knote,  knote*1.4*iveloc, 2, 1, 0
               ;outs     a1,a1
            outs      a1*kgate, a1*kgate
endin
