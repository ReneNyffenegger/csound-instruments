  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  inote     =  cpspch( p4)
  ifc       =  p5
  ifm       =  p6
  id        =  p7*ifm                             ;p7 = Imax
  iamp      =  p8

  km        oscil     id,1/p3,p9
  kc        oscil     iamp,1/p3,p10

  am        oscil     km,ifm,1
  ac        oscil     kc,(ifc+am),1

            out       ac
endin
