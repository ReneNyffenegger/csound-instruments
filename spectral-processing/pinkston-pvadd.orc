;==============================================
; Example pvadd instruments built in class
;
; Instr 1 is a simple implementation, with
;    p-fields for n bins, offset, and incr
; Instr 2 uses 2 pvadd opcodes, with independent
;    time pointers and envelopes, allowing the
;    mixing of different portions of the spectra
;    from two different sounds.
; RP
;===============================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1
  isine     =  1
  ilength   =  p4
  igain     =  ampdb(p5)
  ishift    =  p6
  ifile     =  p7
  inbins    =  p8
  ibin1     =  p9
  incr      =  p10
  ktime     line      0, p3, ilength
  asig      pvadd     ktime, ishift, ifile, isine, inbins, ibin1, incr
  asig      linen     asig,.01,p3,.1
            out       asig*igain
endin

instr   2       ;mix two pvadds
  isine     =  1
  ilen1     =  p4
  idur1     =  (p5 == 0 ? p3 : p5)
  itime1    =  (p6 == 0 ? ilen1 : p6)
  igain1    =  ampdb(p7)
  ishift1   =  p8
  ifile1    =  p9
  inbins1   =  p10
  i1bin1    =  p11
  incr1     =  p12
  ilen2     =  p13
  idur2     =  (p14 == 0 ? p3 : p14)
  itime2    =  (p15 == 0 ? ilen2 : p15)
  igain2    =  ampdb(p16)
  ishift2   =  p17
  ifile2    =  p18
  inbins2   =  p19
  i1bin2    =  p20
  incr2     =  p21
  ienv1     =  p22
  ienv2     =  p23
  ktime1    linseg    0, idur1, itime1, p3-idur1, ilen1
  ktime2    linseg    0, idur2, itime2, p3-idur2, ilen2
  asig1     pvadd     ktime1, ishift1, ifile1, isine, inbins1, i1bin1, incr1
  kgate1    oscil1i   0,igain1,p3,ienv1
  asig1     =  asig1*kgate1
  asig2     pvadd     ktime2, ishift2, ifile2, isine, inbins2, i1bin2, incr2
  kgate2    oscil1i   0,igain2,p3,ienv2
  asig2     =  asig2*kgate2
  asig      linen     asig1+asig2,.01,p3,.1
            out       asig
endin