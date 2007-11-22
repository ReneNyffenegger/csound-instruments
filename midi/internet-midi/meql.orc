  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


            massign   1,1

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,1,.01

  k1        expseg    15000*.001,10*.2,15000,10*.7,15000,10*.1,15000*.001 ;AMP SEG
  k2        expseg    16.2,10*.02,16.2*.5         ;INDEX SEG
  kpan      oscil     1,1/10,5                    ;P9 GIVES F # PAN FUNCTION
  k3        oscil     1,.5,1                      ;SMALL VIBRATO TO PITCH
  asig      foscili   k1,1,knote+k3,600,k2,1,0
  ga1       =  asig
            outs      (asig*sqrt(kpan))*kgate, (asig*sqrt(1-kpan))*kgate

endin




