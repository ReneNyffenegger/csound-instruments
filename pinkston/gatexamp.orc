  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1           ;lfo gating example
  iamp      =  p4
  icps      =  cpspch(p5)
  imodamp   =  p6                                 ;use .5 with a sine fn
  imodhz    =  p7
  imodfn    =  p8                                 ;use a sine function
  ioscfna   =  p9
  ioscfnb   =  p10
  klfo      oscili    imodamp,imodhz,imodfn
  kb        =  klfo + imodamp                     ;offset to 0-1 range
  ka        =  1 - kb                             ;inverse of kb
  asiga     oscili    ka,icps,ioscfna             ;gated sound a
  asigb     oscili    kb,icps,ioscfnb             ;inverse gated sound b
  asum      =  asiga + asigb                      ;combination
  asig      linen     asum,.2,p3,.5
  asig      =  asig * iamp
            out       asig
endin
