  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gadrysig  init      0

instr     2307
  idryamt   =  1-p4
  iwetamt   =  p4
  asndfile  soundin   "speech1.aif", 0
  gadrysig  =  gadrysig+asndfile*iwetamt
            outs      asndfile*idryamt, asndfile*idryamt
endin

instr     2315
  ilp1      =  1/p4                               ; p4Ðp9 ARE RESONANCE FREQUENCIES
  ilp2      =  1/p5
  ilp3      =  1/p6
  ilp4      =  1/p7
  ilp5      =  1/p8
  ilp6      =  1/p9
  irvt      =  p10
  aecho1    comb      gadrysig, irvt, ilp1, 0 
  aecho2    comb      gadrysig, irvt, ilp2, 0
  aecho1    =  gadrysig+aecho1
  aecho2    =  gadrysig+aecho2
  aecho3    comb      aecho1, irvt, ilp3, 0
  aecho4    comb      aecho1, irvt, ilp4, 0
  aecho5    comb      aecho2, irvt, ilp5, 0
  aecho6    comb      aecho2, irvt, ilp6, 0
  aout1     =  (aecho1+aecho3+aecho5)*.1
  aout2     =  (aecho2+aecho4+aecho6)*.1
            outs      aout1, aout2
  gadrysig  =  0
endin

