  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


            massign   1,1

instr               1

  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate2    linenr    iveloc,0,1,.01

  igatehz   =  0                                  ;DEFAULT TO ONCE PER NOTE
  ihalfamp  =  iveloc/2
  ipitch1   =  inote
  ipitch2   =  inote*2
  ibeatfreq =  10     
  idetune2  =  ipitch2 + ibeatfreq

  kgate     oscili    1,igatehz,10                ;P11 HAS GATING CONTROL FN#
  kenvlp    linenr    1,3*.02,2,.01               ;P7,P8 ARE RISE, DECAY FACS

  asig1     oscili    10000,ipitch1,9             ;SOUND ONE
  astraight2   oscili   ihalfamp,ipitch2,6        ;STRAIGHT SOUND TWO
  adetune2  oscili    ihalfamp,idetune2,6         ;DETUNED SOUND TWO
  asig2     =  astraight2 + adetune2              ;SOUND TWO 

  aout1     =  asig1 * kgate
  aout2     =  asig2 * kgate
  aoutsig   =  (aout1 + aout2) * kenvlp           ;OUTPUT THE SUM         
                
            outs      aoutsig*kgate2,aoutsig*kgate2
  ga1       =  aoutsig*kgate
endin
