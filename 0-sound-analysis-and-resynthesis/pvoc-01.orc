instr 1
  idur      =  p3
  ifile     =  p6
  ktransp   =  p7
  ispecenv  =  p8  
  ktime     line      p4, idur, p5
  aout      pvoc      ktime, ktransp, ifile, ispecenv
            out       aout
endin
