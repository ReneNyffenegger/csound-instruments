  nchnls    =  2

instr          1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc*4, 0, .2, .1

     ;k1       expseg    p4*.001,p3*.2,p4,p3*.7,p4,p3*.1,p4*.001
  k1        expseg    2500*.001, .5*.2, 2500, .5*.7, 2500, .5*.1, 2500*.001
     ;k2       expseg    p7,p3*.02,p7*.5
  k2        expseg    4.2, .5*.02, 4.2*.5
     ;k3       oscil     10,p8,1
  k3        oscil     10, .5, 1
     ;k4       oscil     1,1/p3,2
  k4        oscil     1, 1/.5, 2
     ;a1       foscili   k1,1,p5+k3,p6,k2,1,0
  a1        foscili   k1, 1, knote+k3, knote*.66*iveloc, k2, 1, 0
               ;outs     a1,a1
            outs      a1*kgate, a1*kgate
endin
