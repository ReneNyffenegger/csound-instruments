  nchnls    =  2

            massign   1,1

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01

  kvrate    linseg    .005, .1/4, .005, .1/2, 1, .1/4, .005
  kvdpth    linseg    .005, .1/4, .005, .1/2, 1, .1/4, .005
  kvib      oscil     .2*kvdpth, 0*kvrate, 1    
  kport     phasor    1/.1
  kenv      expseg    1, .1/2, .5, .1/2, 1
  arngmod   foscil    ampdb(82),knote, .5, 1.5, 2, 1
  asig      oscil     arngmod*kenv, cpsoct(14+kvib+(0*kport)), 1
            outs      asig*kgate,asig*kgate
endin
