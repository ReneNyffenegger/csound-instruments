  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1                                                ; EL. PIANO
  inote     cpsmidi   
  ivel      veloc     0, 30000               

  kvol      midictrl  7,  0, 1
  kpan      midictrl  10, 0, 1

  kgate     linenr    ivel, 0, .2, .01
  a1        loscil    kgate, inote, 11, 110

            outs      a1 * kpan * kvol, a1 * (1 - kpan) * kvol
endin
