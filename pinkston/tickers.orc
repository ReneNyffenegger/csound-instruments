  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr   1                       ;simple ticking instrument
  icps      =  cpspch(p5)                         ;oscil pitch
  ilfohz    =  p8                                 ;repeat envelope frequency
  aenvlp    linen     p4,p6,p3,p7                 ;overall envelope
  agate     oscili    aenvlp,ilfohz,p9            ;repeating envelope
  asig      oscili    agate,icps,p10
            outs      asig,asig
endin

instr   2               ;ticking instrument with timout/reinit
;initialization block
  iamp      =  p4
  icps      =  cpspch(p5)
  irise     =  p6
  idecay    =  p7
  ipkhz     =  p8
  iamfn     =  p9
  isinefn   =  p10
  ihzfn     =  p11
  ipanfn    =  p12
;performance block
  klfohz    oscil1i   0,ipkhz,p3,ihzfn            ;controls varying lfo freq
  kpanfac   oscil1i   0,1,p3,ipanfn               ;controls dynamic panning
  klfohz    init      ipkhz                       ;init for first tick
;reinitialization block
reinitstart:
  ilfodur   =  1/25                               ;tick duration is fixed
  kmicro    oscil1i   0,iamp,ilfodur,iamfn        ;envelope for each tick
            timout    0,1/i(klfohz),continue      ;varying tick rate
            reinit    reinitstart
continue:
            rireturn                              ;end of reinit block
;---------------------------------------
  aenvlp    linen     kmicro,irise,p3,idecay
  asig      oscili    aenvlp,icps,isinefn
  aleft     =  asig * sqrt(kpanfac)
  aright    =  asig * sqrt(1-kpanfac)
            outs      aleft,aright
endin

instr   3       ;version of instr 2 with pitch bend
;initialization block
  iamp      =  p4
  icps      =  cpspch(p5)
  irise     =  p6
  idecay    =  p7
  ipkhz     =  p8                                 ;max tick rate  
  iamfn     =  p9
  isinefn   =  p10
  ihzfn     =  p11
  ipanfn    =  p12
  ibend     =  p13
  ibendfn   =  p14
;performance block
  klfohz    oscil1i   0,ipkhz,p3,ihzfn
  kpanfac   oscil1i   0,1,p3,ipanfn
  kpbend    oscil1i   0,ibend,p3,ibendfn
  klfohz    init      ipkhz                       ;initial tick at max rate
;reinitialization block
reinitstart:
  ilfodur   =  1/25                               ;tick duration is fixed
  kmicro    oscil1i   0,iamp,ilfodur,iamfn        ;envelope for each tick
            timout    0,1/i(klfohz),continue      ;varying tick rate
            reinit    reinitstart
continue:
            rireturn  
;--------------------------------------
  aenvlp    linen     kmicro,irise,p3,idecay
  kcps      =  icps + kpbend * icps
  asig      oscili    aenvlp,kcps,isinefn
  aleft     =  asig * sqrt(kpanfac)
  aright    =  asig * sqrt(1-kpanfac)
            outs      aleft,aright
endin
