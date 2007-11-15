; variable speed reader for overlapped reads

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr 1
  idev      =  p4
  ispeed    =  p5
  iseed     =  p6
  gkincr    randi     idev, ispeed, iseed
endin

instr 2
  idev      =  p4
  ispeed    =  p5
  iseed     =  p6
  krnd      randh     idev, ispeed, iseed
  gkincr    port      krnd,.01
endin

instr 20
  ifile     =  p4
  igain     =  p5
  ia        =  p6
  id        =  p7
  is        =  p3-(ia+id)
  iphase    =  p8
  imult     =  sr/ftlen(ifile)
  kenv      linseg    0,ia,igain,is,igain,id,0
  asig      oscili    kenv, gkincr * imult, ifile, iphase
            out       asig
endin
