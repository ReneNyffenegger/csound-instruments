  sr        =  44100
  kr        =  4410
  ksmps     =  10.0
  nchnls    =  2

instr     1
  iamp      =  p4
  ipitch    =  p5
  irise     =  p6
  idecay    =  p7
  ifna      =  p8
  ifnb      =  p9
  igatefn   =  p10
  icps      =  cpspch(ipitch)
  aw1       linen     iamp,irise,p3,idecay
  aw5       oscili    aw1,icps,ifnb
  aw4       oscili    aw1,icps,ifna
  kgatea    oscil1i   0,1,p3,igatefn
  kgateb    =  1 - kgatea
  aw3       =  aw5 * kgateb
  aw2       =  aw4 * kgatea
            outs      aw2,aw3
endin
