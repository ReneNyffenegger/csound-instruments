  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  1

instr   1               ;smooth portamento in octaves
  kcntrl    line      p6,p7,p8                    ;p6 & p8 are values in octaves
  kgate     linen     p4,.1,p3,.2
  ipitch    =  octpch(p5)                         ;p5 of score is in pch
  kpitch    =  ipitch+kcntrl
  asignal   oscili    kgate,cpsoct(kpitch),1
            out       asignal
endin

instr   2               ;portamento in cycles per second
  kcntrl    line      p6,p7,p8                    ;p6 & p8 are values in herttz
  kgate     linen     p4,.1,p3,.2
  ipitch    =  cpspch(p5)                         ;p5 of score is in pch
  kpitch    =  ipitch+kcntrl
  asignal   oscili    kgate,kpitch,1
            out       asignal
endin

instr   3               ;exponential portamento in octaves
  kcntrl    expon     p6,p7,p8                    ;p6 & p8 are values in octaves
  kgate     linen     p4,.1,p3,.2
  ipitch    =  octpch(p5)                         ;p5 of score is in pch
  kpitch    =  ipitch+kcntrl
  asignal   oscili    kgate,cpsoct(kpitch),1
            out       asignal
endin

instr   4               ;ADSR envelope unit with linseg
  idur1     =  .05                                ;attack duration
  idur2     =  .75                                ;initial decay time
  idur4     =  2                                  ;final decay time
  idur3     =  p3-idur4-idur2-idur1               ;compute sustain dur
  kgate     linseg    0,idur1,1,idur2,.5,idur3,.5,idur4,0
  kgate     =  kgate*p4
  asignal   oscili    kgate,cpspch(p5),1
            out       asignal
endin

instr   5               ;ADSR envelope unit with expseg
  idur1     =  .05                                ;attack duration
  idur2     =  .75                                ;initial decay time
  idur4     =  2                                  ;final decay time
  idur3     =  p3-idur4-idur2-idur1               ;compute sustain dur
  kgate     expseg    .001,idur1,1,idur2,.5,idur3,.5,idur4,.001
  kgate     =  kgate*p4
  asignal   oscili    kgate,cpspch(p5),1
            out       asignal
endin
