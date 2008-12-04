instr     1
  itransp =       1
  iend    =       p4
  ifile   =       p5
  ifn1    =       p6
  idur1   =       p7
  ifn2    =       p8
  idur2   =       p8
  ifn3    =       p10
  idur3   =       p11
  ifn4    =       p12
  ktime   line    0, p3, iend
          ktableseg   ifn1, idur1, ifn2, idur2, ifn3, idur3, ifn4   
  asig    vpvoc   ktime, itransp, ifile
          out     asig
endin
