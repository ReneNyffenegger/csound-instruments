instr     1
  iamp      =  p4
  icps      =  cpspch(p5)
  imodamp   =  p6
  imodhz    =  p7
  imodfn    =  p8
  ioscfn    =  p9
  klfo      oscili    imodamp,imodhz,imodfn
  ktrem     =  klfo + 1
  kamp      =  iamp * ktrem
  kenv      linen     kamp,.2,p3,.5
  asig      oscili    kenv,icps,ioscfn
            out       asig
endin
