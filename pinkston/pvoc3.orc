  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;=======================================================
; Example Instrument for Phase Vocoder Interpolation
; Similar to pvoc2.orc, but uses pvbufread and pvinterp
; Allows independent crossfading of amp and freq data
; RP
;=======================================================

instr   3
  idur      =  p3
  ipvfn1    =  p4
  ilen1     =  p5
  ipvfn2    =  p6
  ilen2     =  p7
  iamp1     =  p8
  iamp2     =  p9
  ifrq1     =  p10
  ifrq2     =  p11
;fixed amplitude and frequency prescaling data
  iascl1    =  (p12 == 0 ? 1 : p12)               ;defaults to no amp scaling
  iascl2    =  (p13 == 0 ? 1 : p13)
  ifscl1    =  p14
  ifscl2    =  p15
  ifmod     =  p16                                ;max pitch shift in semitones
  ifmfn     =  (p17 == 0 ? 1 : p17)               ;default to valid function #

; Independent timptrs for pvbufread and pvcross
  ktime1    line      0, idur, ilen1
  ktime2    line      0, idur, ilen2
; Allows a crossfade between the amp data in two analysis files
  kampi     line      iamp1, idur, iamp2    
; Allows a crossfade between the freq data in two analysis files
  kfrqi     line      ifrq1, idur, ifrq2
; Frequency modification control function
  kfctrl    oscil1i   0,ifmod,p3,ifmfn
; Frequency mod arguments from semitones to a pitch shift factor
  kfmod     =  exp(kfctrl/12*log(2))
  ifs1      =  exp(ifscl1/12*log(2))
  ifs2      =  exp(ifscl2/12*log(2))
;
            pvbufread   ktime1, ipvfn1
  apv       pvinterp  ktime2, kfmod, ipvfn2, ifs1, ifs2, iascl1, iascl2, kfrqi, kampi 
  apv       linen     apv,.1,p3,.2                ;overall envelope
            out       apv
endin
