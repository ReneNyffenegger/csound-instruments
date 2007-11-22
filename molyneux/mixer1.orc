;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         MASTER MIXER AND PANNER                       ;
;                                                       ;
;         P3 = DURATION                                 ;
;         P4 = AMPLITUDE FACTOR FOR SIGNAL              ;
;      P5 = PANNING FUNCTION FOR SIGNAL                 ;
;      P6 = ENVLPX ATTACK FOR SIGNAL                    ;
;      P7 = ENVLPX DECAY FOR SIGNAL                     ;
;      P8 = SOUNDIN FILE NUMBER                         ;
;      P9 = SKIPTIME                                    ;
;                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr     1
  a1        soundin   p8,p9
  kenv      envlpx    p4,p6,p3,p7,5,1,.01
  asig      =  a1*kenv
  kramp     oscil1i   0.0,1,p3,p5
  kfacl     =  sqrt (kramp)
  kfacr     =  sqrt (1-kramp)
  alft      =  asig * kfacl  
  arght     =  asig * kfacr  
            outs      alft,arght
endin
