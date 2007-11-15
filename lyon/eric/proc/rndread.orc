  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;f1 0 N -1 1 0
;i1 0 dur dev seed speed

instr 1
  ifile     =  1
  itl       =  ftlen(ifile)
  iop       =  1/p3
  iincr     =  (sr/itl)
  idev      =  p4 * iincr
  iseed     =  p5
  ispeed    =  p6
  iatk      =  .005
  idk       =  .02
  isust     =  p3 - (iatk+idk)

  aenv      linseg    0, iatk, 1., isust, 1., idk, 0
  kincr     randi     idev, ispeed, iseed
  kincr     =  kincr + iincr
  asig      oscili    aenv,kincr,ifile    
            out       asig
endin
