  sr        =  44100
  kr        =  4410
  ksmps     =  10.0
  nchnls    =  2

instr     1
  iamp      =  p4
  ipitch    =  p5
  irise     =  p6
  idecay    =  p7
  ifn       =  p8
  ilfohz    =  p9
  idepth    =  p10
  ilfofn    =  p11
  icps      =  cpspch(ipitch)
  klfo      oscili    idepth,ilfohz,ilfofn
  kamp      =  iamp + klfo
  aw1       oscili    kamp,icps,ifn
  aw2       linen     aw1,irise,p3,idecay
            outs      aw2,aw2
endin
