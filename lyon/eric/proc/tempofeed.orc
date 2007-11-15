  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1 ; mono in
  ifile     =  p4
  iskip     =  p5
  itempo    =  p6
  isubdiv   =  p7
  ifeedback =  p8
  ideldur   =  (60.0/itempo)/isubdiv
  imax      =  ideldur * 2.01
  idk       =  .05
  igain     =  1.0
  isust     =  p3-idk
  aenv      linseg    igain, isust, igain, idk, 0.0
  asig      soundin   ifile, iskip
  addl      delayr    imax
  atap      deltap    ideldur
  asig      =  asig + (atap*ifeedback)
            delayw    asig

  aout      =  asig * aenv                        ;
            out       aout
   
endin
   