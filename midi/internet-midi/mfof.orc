  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


            massign   1,1

instr          1

  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,1.5,.01

  k1        oscil     2, 4, 1
  k2        linseg    0, 2/2, 0, 2/2, 1
  a1        fof       inote+inote*6, 100+k1,  500, k2, 120, .003, .017, .005,     2, 1, 2, 2
  a2        fof       inote+inote*.4, 100+k1,  850, k2, 120, .003, .017, .005, 10, 1, 2, 2
  a3        fof       inote+inote*.2, 100+k1, 2500, k2, 120, .003, .017, .005, 10, 1, 2, 2
  a4        fof       inote, 100+k1, 3500, k2, 120, .003, .017, .005, 10, 1, 2, 2
  a5        =  a1 + a2 + a3 + a4
            outs      a5*kgate,a5*kgate
  ga1       =  a5*kgate
endin
