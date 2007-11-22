instr     1                   ;random lfo gating instrument
  iamp      =  p4
  icps      =  cpspch(p5)
  imodamp   =  p6                                 ;use .5 for sine fn
  imodhz    =  p7
  imodfn    =  p9                                 ;use sine function
  ioscfna   =  p9
  ioscfnb   =  p10
  irndhz    =  p11
  krndval   randi     imodhz/2,irndhz             ;randomize lfo hz
  klfohz    =  imodhz/2 + krndval                 ;offset to 0 - imodhz
  klfo      oscili    imodamp,klfohz,imodfn
  kb        =  klfo + imodamp                     ;offset to 0 - 1
  ka        =  1 - kb                             ;inverse of kb
  asiga     oscili    ka,icps,ioscfna             ;gated sound a
  asigb     oscili    kb,icps,ioscfnb             ;inverse gated sound b
  asum      =  asiga + asigb                      ;combination
  asig      linen     asum,.2,p3,.5
  asig      =  asig * iamp
            out       asig
endin
