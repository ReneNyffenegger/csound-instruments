  nchnls    =  2

instr          1
  ilookvol  =  1
  ip7       =  12
  ival1     table     ilookvol,2
  ival2     table     ilookvol,3
  ival3     table     ilookvol,4
  ipitch    cpsmidi   
  aseg      linseg    0,10/2,10,10,0
  asig1     buzz      10000,ipitch + aseg,(sr/2/ipitch),1
  asig2     oscili    10000,ipitch + aseg,1
  asig      =  asig1 + asig2
  afilt1    reson     asig,ival1,ival1/ip7,1
  afilt2    reson     asig,ival2,ival2/ip7,1
  afilt3    reson     asig,ival3,ival3/ip7,1
  afilt4    reson     afilt1,ival1,ival1/ip7,1
  afilt5    reson     afilt2,ival2,ival2/ip7,1
  afilt6    reson     afilt3,ival3,ival3/ip7,1
  afilt7    reson     afilt4,ival1,ival1/ip7,1
  afilt8    reson     afilt5,ival2,ival2/ip7,1
  afilt9    reson     afilt6,ival3,ival3/ip7,1
  aoutsig   =  afilt7 + afilt8 + afilt9
  asigout   balance   aoutsig,asig2
  asigenv   linen     asigout,.2,10,.2
  imax      ampmidi   1, 100
  kgate     linenr    imax, 0, .5, .01
            outs      asigenv * kgate,asigenv * kgate
endin


instr          2
  ipitch    cpsmidi   
  asaw      oscili    8000,ipitch,6
  ksweep    expseg    20,.070,22050,.3,2000,3,200,2,100
  afilt     reson     asaw,0,ksweep,1
  apole     reson     afilt,0,ksweep,1

  imax      ampmidi   1, 100
  kgate     linenr    imax, 0, .5, .01
            outs      apole*kgate, apole*kgate
endin
