  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;----------------------------------------
instr   1       ;example use of buzz
  ibigsin   =  1                                  ;requires a large sine wave table
  ifund     =  cpspch(p5)
  kgate     linen     p4,.1,p3,.5
  knharm    linseg    1,p3/2,p6,p3/2,1            ;vary n harmonics
  asig      buzz      kgate,ifund,knharm,ibigsin
            out       asig
endin
;-----------------------------------------
instr   2       ;example use of gbuzz
  ibigcos   =  2                                  ;requires a large cosine table
  ilow      =  (p10 == 0 ? 1 : p10)               ;lowest n harmonics for gbuzz
  ifund     =  cpspch(p5)
  kgate     linen     p4,.1,p3,.5
  knharm    linseg    p6,p3/2,p7,p3/2,p6          ;vary n harmonics
  krfac     linseg    p8,p3/2,p9,p3/2,p8          ;vary amp scale factor
            print     ilow
            display   knharm,p3
  asig      gbuzz     kgate,ifund,knharm,ilow,krfac,ibigcos
            out       asig
endin
