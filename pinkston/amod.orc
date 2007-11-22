  sr        =  44100
  kr        =  4410
  ksmps     =  10.0
  nchnls    =  1

instr     1
  idur      =  p3
  iamp      =  p4
  icarhz    =  cpspch(p5)
  imodhz    =  cpspch(p6)
  index     =  p7
  icarfn    =  p8
  imodfn    =  p9
  indxris   =  p10
  indxdec   =  p11
  kindex    linen     index*iamp,indxris,idur,indxdec
  amodsig   oscili    kindex,imodhz,imodfn
  amodsig   =  (amodsig) + (iamp)
  asig      oscili    amodsig,icarhz,icarfn
  aout      linen     asig,1,p3,1
            out       aout
endin
