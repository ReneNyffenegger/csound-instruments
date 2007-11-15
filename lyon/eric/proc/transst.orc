  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  ia        =  p4
  id        =  p5
  is        =  p3-(ia+id)
  gaenv     linseg    0,ia,1,is,1,id,0
endin

; MONO SOUND TWO WAYS
instr 2
  itl       =  ftlen(1)
  ifile     =  1
  iamp      =  p4
  iincr1    =  (sr/itl)*p5
  iincr2    =  (sr/itl)*p6
  iphase1   =  p7
  iphase2   =  p8
  aenv      =  gaenv * iamp
  asig1     oscili    aenv,iincr1,ifile,iphase1
  asig2     oscili    aenv,iincr2,ifile,iphase2
            outs      asig1, asig2
endin

; STEREO SOUND TWO WAYS
instr 3
  itl1      =  ftlen(1)
  itl2      =  ftlen(2)
  ifile1    =  1
  ifile2    =  2
  iamp      =  p4
  iincr1    =  (sr/itl1)*p5
  iincr2    =  (sr/itl2)*p6
  iphase1   =  p7
  iphase2   =  p8
  aenv      =  gaenv * iamp
  asig1     oscili    aenv,iincr1,ifile1,iphase1
  asig2     oscili    aenv,iincr2,ifile2,iphase2
            outs      asig1, asig2
endin
