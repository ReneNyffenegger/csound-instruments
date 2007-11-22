  sr        =  44100
  kr        =  4410
  ksmps     =  10.0
  nchnls    =  2

instr     1                   ;fix cf and sweep bw
  icps      =  cpspch(p5)
  ibwmin    =  p6
  ibwvar    =  p7
  iwavefn   =  p8
  ibwfn     =  p9
  kbw       oscil1i   0,ibwvar,p3,ibwfn
  asig1     oscili    p4,icps,iwavefn
  kbw       =  (kbw) + (ibwmin)
  afltsig   butterbp  asig1,icps,kbw
  afltsig   butterbp  afltsig,icps,kbw
  afltsig   butterbp  afltsig,icps,kbw
  abalsig   balance   afltsig,asig1
  afinal    linen     abalsig,.5,p3,.5
            outs      afinal,afinal
endin

instr     2                   ;fix bw and sweep cf
  icps      =  cpspch(p5)
  icfmin    =  octpch(p6)                         ;p6 is initial cf in pch
  icfvar    =  p7                                 ; p7 is max cf var in oct
  ibw       =  (p8 > 0 ? icps/p8 : 0)             ; p8 is Q of filter
  iwavefn   =  p9
  icffn     =  p10
  kcfoct    oscil1i   0,icfvar,p3,icffn
  asig1     oscili    p4,icps,iwavefn
  kcfoct    =  (kcfoct) + (icfmin)
  kcf       =  cpsoct(kcfoct)
  afltsig   butterbp  asig1,kcf,ibw
  afltsig   butterbp  afltsig,kcf,ibw
  afltsig   butterbp  afltsig,kcf,ibw
  abalsig   balance   afltsig,asig1
  afinal    linen     abalsig,.5,p3,.5
            outs      afinal,afinal
endin

instr     3                   ;fix q and sweep cf
  icps      =  cpspch(p5)
  icfmin    =  octpch(p6)                         ;p6 is initial cf in pch
  icfvar    =  p7                                 ;p7 is max cf var in oct
  iq        =  (p8 == 0 ? 1 : p8)                 ;p8 is Q of filter
  iwavefn   =  p9
  icffn     =  p10
  kcfoct    oscil1i   0,icfvar,p3,icffn
  asig1     oscili    p4,icps,iwavefn
  kcfoct    =  (kcfoct) + (icfmin)
  kcf       =  cpsoct(kcfoct)
  kbw       =  kcf/iq                             ;bw varies with cf
  afltsig   butterbp  asig1,kcf,kbw
  afltsig   butterbp  afltsig,kcf,kbw
  afltsig   butterbp  afltsig,kcf,kbw
  abalsig   balance   afltsig,asig1
  afinal    linen     abalsig,.5,p3,.5
            outs      afinal,afinal
endin
