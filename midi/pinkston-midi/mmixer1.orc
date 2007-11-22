;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         MASTER MIXER AND PANNER                       ;
;                                                       ;
;         P3 = DURATION                                 ;
;         P4 = AMPLITUDE FACTOR FOR SIGNAL              ;
;     P5 = PANNING FUNCTION FOR SIGNAL                  ;
;     P6 = ENVLPX ATTACK FOR SIGNAL                     ;
;     P7 = ENVLPX DECAY FOR SIGNAL                      ;
;     P8 = SOUNDIN FILE NUMBER                          ;
;     P9 = SKIPTIME                                     ;
;                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  nchnls    =  2

instr          1
            massign   1,1
  knote     cpsmidib  
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  a1        soundin   5,0
  kenv      envlpx    8,4,3,.01,5,1,.01
  asig      =  a1*kenv
  kramp     oscil1i   0.0,1,3,4
  kfacl     =  kramp
  kfacr     =  1-kramp
  alft      =  asig*kfacl  
  arght     =  asig*kfacr  
            outs      alft*kgate,arght*kgate
endin
