instr 1
  idur      =  p3
  ifile     =  p6
  ktransp   =  p7
  ispecenv  =  p8  
  ktime     linseg    0,idur/6,1.1,idur/6,1.2,idur/24,1.3,3*idur/24,1.6,idur/2,5
  aout      pvoc      ktime, ktransp, ifile, ispecenv
            out       aout
endin
