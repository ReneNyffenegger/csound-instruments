; Soundwarp instrument

instr 4

  isamp     =  p4
  iws       =  3000
  iwfn      =  3
  iover     =  20


  k1        expon     2,p3,.001
  asig      sndwarp   6000,p5+k1,1,isamp,0,iws,500,iover,iwfn,0
            outs      asig*p6,asig*(1-p6)
endin


instr 5

  isamp     =  p4
  iws       =  3000
  iwfn      =  3
  iover     =  20
        


  k1        expon     2,p3,.001
  kamp      linseg    0,0.062,0,0.5,0.7,p3,0.7
  asig      sndwarp   6000,p5+k1,1,isamp,0,iws,500,iover,iwfn,0
            outs      asig*p6,asig*(1-p6)

endin 

