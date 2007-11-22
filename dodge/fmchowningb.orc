  sr        =  44100                              ; ===============================
  kr        =  4410                               ; the IEEE Chowning FM article                                  
  ksmps     =  10                                 ; chowning1.orc                 
  nchnls    =  1                                  ; ===============================                                                                               

instr 1
  idur      =  p3                                 ; DURATION OF NOTE
  imodur    =  1/p3                               ; FREQ OF MOD ENVELOPE OSC IN Hz (1/dur)
  icardur   =  1/p3                               ; FREQ OF CAR ENVELOPE OSC IN Hz (1/dur)         
  iamp      =  p4                                 ; AMPLITUDE OF FM SIGNAL
  ifreqcar  =  p5                                 ; FREQUENCY OF CARRIER IN Hz
  ifreqmod  =  p6                                 ; FREQUENCY OF MODULATOR IN Hz
  ibaseindex   =      p7 * p6                     ; SET STEADY STATE MOD INDEX (p7 = 0,...,n)  
  ipeakindex   =      p8 * p6                     ; SET PEAK OF DYNAMIC INDEX (p8 = 0,...,n)
  ioffsetindex =      ipeakindex - ibaseindex     ; CALCULATE OFFSET OF DYNAMIC MOD INDEX
  imodampfun   =      p9                          ; SET MODULATOR ENVELOPE FUNCTION
  icarampfun   =      p10                         ; SET CARRIER ENVELOPE FUNCTION
  imodsigfun   =      p11                         ; SET MODULATOR WAVE FUNCTION
  icarsigfun   =      p12                         ; SET CARRIER WAVE FUNCTION
  
  kampmod   oscil     ioffsetindex, imodur, imodampfun
  kampcar   oscil     iamp, icardur, icarampfun
  amodsig   oscil     kampmod + ibaseindex, ifreqmod, imodsigfun      
  afmsig    oscil     kampcar, ifreqcar + amodsig, icarsigfun
            out       afmsig
endin
