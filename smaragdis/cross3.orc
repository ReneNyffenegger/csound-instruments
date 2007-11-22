  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
                              
instr 1
  a1        rand      44100
  a2        diskin    "speech1.aif", 1
  a3        cross2    a1, a2, 512, 2, 3, .25
            out       a3
endin

instr 2
  a1        diskin    "allofme.aif", 1
  a2        diskin    "speech1.aif", 1
  a3        cross2    a1, a2, 2048, 2, 3, .95
            out       a3
endin
