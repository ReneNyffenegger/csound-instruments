  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;======================================================
;       Simple demo instrument for wgpluck    
;======================================================

instr   10
  iamp      =  p4
  ifreq     =  cpspch(p5)
  kpick     init      p6
  iplk      =  p7
  idamp     =  p8
  ifilt     =  p9
  axcite    oscil     1, 1, 1
  apluck    wgpluck   ifreq, iamp, kpick, iplk, idamp, ifilt, axcite
            out       apluck
endin

;======================================================
;       Simple demo instrument for wgpluck2        
;======================================================

instr   11
  kamp      init      p4
  ifreq     =  cpspch(p5)
  kpick     init      p6
  iplk      =  p7
  kabsor    init      p8
  apluck    wgpluck2  iplk, kamp, ifreq, kpick, kabsor
            out       apluck
endin

;======================================================
;       Simple demo instrument for repluck        
;======================================================

instr   12
  iamp      =  p4
  ifreq     =  cpspch(p5)
  ipick     =  p6
  iplk      =  p7
  kabsor    init      p8
  iplkhz    =  p9
  iplkris   =  p10
  iplkdec   =  p11
  kgate     expon     1,p3,.1
  anoise    rand      iamp
start:
  agate     expseg    .001,iplkris,1,iplkdec,.0001
            timout    0,1/iplkhz,continue
            reinit    start
continue:
  axcite    =  anoise*agate
  apluck    repluck   iplk, kgate*iamp, ifreq, kgate*ipick, kabsor, axcite
            out       apluck
endin
