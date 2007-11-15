  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 100
endin


;f1 0 8192 10 1
;i1 0 dur file depth speed
instr 1
  ivd       =  p5/2
  ivb       =  ivd+.002
  ispeed    =  p6
  ifile     =  p4
  idk       =  .01
  isust     =  p3-idk
  aenv      linseg    1, isust, 1, idk, 0
  kvib      oscili    ivd, ispeed,1 
  kvib      =  kvib + ivb
  asig      soundin   ifile,0
  addl      delayr    .5
  atap      deltapi   kvib
            delayw    asig
            out       atap*aenv
endin
