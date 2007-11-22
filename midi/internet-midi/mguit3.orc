  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


            massign   1,1

instr          1

  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,1,.01
  kamp      linseg    0.0, 0.015, inote*2, 2-0.035, inote*2, 0.02, 0.0
  asig      pluck     kamp, inote, inote, 0, 6
            outs      asig*kgate,asig*kgate
  ga1       =  asig*kgate
endin
