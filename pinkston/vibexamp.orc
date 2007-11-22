instr     1           ;simple vibrato example
  iamp      =  p4
  icps      =  cpspch(p5)
  imodamp   =  p6                                 ;vib width (very small!)
  imodhz    =  p7                                 ;vib rate
  imodfn    =  p8                                 ;use a sine wave
  ioscfn    =  p9
  klfo      oscili    imodamp,imodhz,imodfn
  kvib      =  klfo + 1                           ;vary around 1
  kenv      linen     iamp,.2,p3,.5
  kcps      =  icps * kvib                        ;modulate the freq
  asig      oscili    kenv,kcps,ioscfn
            out       asig
endin
