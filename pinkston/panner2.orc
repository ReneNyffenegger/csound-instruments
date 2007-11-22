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
  ipanfn    =  p9
  icps      =  cpspch(ipitch)
  aw1       linen     iamp,irise,p3,idecay
  kleft     oscil1i   0,1,p3,ipanfn
  aw4       oscili    aw1,icps,ifn
  kright    =  1 - kleft
  kright    =  sqrt(kright)
  kleft     =  sqrt(kleft)
  aw2       =  kleft * aw4
  aw3       =  aw4 * kright
            outs      aw2,aw3
endin
