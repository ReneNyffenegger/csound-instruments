  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1                               ;port inst
  iamp      =  p4
  ioct1     =  octpch(p6)                         ;previous note
  ioct2     =  octpch(p5)                         ;new note
  iprate    =  p7                                 ;octaves/sec
  idist     =  abs(ioct2-ioct1)
  idur      =  (idist > 0 ? idist/iprate : 1)     ;trap zero distance
  koct      linseg    ioct1,idur,ioct2,1,ioct2    ;make the portamento
  kcps      =  cpsoct(koct)
  asig      oscili    iamp,kcps,1                 ;function 1 has the waveshape
  asig      linen     asig,.05,p3,.1
            out       asig
endin

instr   2                       ;port instr with delay
  iamp      =  p4
  ioct1     =  octpch(p6)                         ;previous note
  ioct2     =  octpch(p5)                         ;new note
  iprate    =  p7                                 ;octaves/sec
  iportfn   =  p8                                 ;fn with port shape
  idelay    =  p9
  idist     =  ioct2-ioct1
  idur      =  (idist != 0 ? abs(idist/iprate) : 1) ;trap zero distance
;koct   linseg  ioct1,idur,ioct2,1,ioct2        ;make the portamento
  koct      oscil1i   idelay,idist,idur,iportfn
  kcps      =  cpsoct(ioct1+koct)
  asig      oscili    iamp,kcps,1                 ;function 1 has the waveshape
  asig      linen     asig,.05,p3,.1
            out       asig
endin

instr   3                       ;port instr with delay and vib
  iamp      =  p4
  ioct1     =  octpch(p6)                         ;previous note
  ioct2     =  octpch(p5)                         ;new note
  iprate    =  p7                                 ;octaves/sec
  iportfn   =  p8                                 ;fn with port shape
  idelay    =  p9
  ivibwth   =  p10
  ivibrte   =  p11
  ivibfn    =  p12
  ivibdel   =  p13
  idist     =  ioct2-ioct1
  idur      =  (idist != 0 ? abs(idist/iprate) : 1) ;trap zero distance
;koct   linseg  ioct1,idur,ioct2,1,ioct2        ;make the portamento
  koct      oscil1i   idelay,idist,idur,iportfn
  kctrl     oscil1i   ivibdel,1,.5,iportfn        ;vibrato control (with delay)
  kvib      oscili    ivibwth*kctrl,ivibrte*kctrl,ivibfn ;LFO for vibrato
  kcps      =  cpsoct(ioct1+koct+kvib)
  asig      oscili    iamp,kcps,1                 ;function 1 has the waveshape
  asig      linen     asig,.05,p3,.1
            out       asig
endin

instr   4                       ;port inst version 2
  iamp      =  p4
  ioct1     =  octpch(p6)                         ;previous note
  ioct2     =  octpch(p5)                         ;new note
  iprate    =  p7                                 ;octaves/sec
  ienvdur   =  p8
  iphs      =  (ienvdur < 0 ? -1 : 0)
  idist     =  abs(ioct2-ioct1)
  idur      =  (idist > 0 ? idist/iprate : 1)     ;trap zero distance
  koct      linseg    ioct1,idur,ioct2,1,ioct2    ;make the portamento
  kcps      =  cpsoct(koct)
  asig      oscili    iamp,kcps,1,iphs            ;function 1 has the waveshape
  asig      linen     asig,.05,ienvdur,3
            out       asig
endin

instr   5                               ;FM port instr with delay and vib
  iamp      =  p4
  ioct1     =  octpch(p6)                         ;previous note
  ioct2     =  octpch(p5)                         ;new note
  iprate    =  p7                                 ;octaves/sec
  iportfn   =  p8                                 ;fn with port shape
  idelay    =  p9
  ivibwth   =  p10
  ivibrte   =  p11
  ivibfn    =  p12
  ivibdel   =  p13
  icarfac   =  p14
  imodfac   =  p15
  indvar    =  p16
  index1    =  p17
  indrise   =  p18
  indec     =  p19
  idist     =  ioct2-ioct1
  idur      =  (idist != 0 ? abs(idist/iprate) : 1) ;trap zero distance
;koct   linseg  ioct1,idur,ioct2,1,ioct2        ;make the portamento
  koct      oscil1i   idelay,idist,idur,iportfn
  kctrl     oscil1i   ivibdel,1,.5,iportfn        ;vibrato control (with delay)
  kvib      oscili    ivibwth*kctrl,ivibrte*kctrl,ivibfn ;LFO for vibrato
  kcps      =  cpsoct(ioct1+koct+kvib)
;asig   oscili  iamp,kcps,1             ;function 1 has the waveshape
  kindex    linseg    index1,indrise,index1+indvar,p3-indrise-indec,index1+indvar,indec,index1
  asig      foscili   iamp,kcps,icarfac,imodfac,kindex,3
  asig      linen     asig,.05,p3,.1
            out       asig
endin