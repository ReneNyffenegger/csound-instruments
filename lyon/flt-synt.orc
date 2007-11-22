  sr        =  22050                              ; sample rate
  kr        =  2205                               ;control rate
  ksmps     =  10
  nchnls    =  1                                  ; number of channels

; funda-freq amp hz-detune bandwidth
instr 1
  ifreq     =  p4
  iamp      =  p5 * 10000
  idetune   =  ifreq * p6                         ; SPECIFY DETUNE AS PERCENTAGE OF FREQ
  ibw       =  ifreq * p7                         ; SPECIFY BANDWIDTH AS PERCENTAGE OF FREQ

  ampenv    linen     iamp,.01,p3,.02 
  k2        line      p4*8,p3,ifreq
  k4        port      ifreq,p3/4
  a1        oscili    1.0,k4,1
  adetune   oscili    1.0,k4+idetune,1
  a2        reson     (a1+adetune)/2,k2,ibw,0

; ADDED STATEMENT FOR SHARPER RESONANT PEAK
  a2        reson     a2,k2,ibw,0

  ajust     balance   a2, a1     

; NOTE: APPLY ENVELOPE AFTER balance TO AVOID CLICK            
            out       ajust*ampenv

endin

