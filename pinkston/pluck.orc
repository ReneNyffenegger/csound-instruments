  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  1

;======================================================
;       Simple demo instrument for pluck        
;======================================================

instr   1
  iamp      =  p4
  ifn       =  p6
  imeth     =  p7
  iparm1    =  p8
  iparm2    =  p9
  ifreq     =  cpspch(p5)
  icps      =  (p10 == 0 ? ifreq : cpspch(p10))
  asig      pluck     p4,ifreq,icps,ifn,imeth,iparm1,iparm2
  asig      linen     asig,.001,p3,.1             ;final envelope
            out       asig
endin

