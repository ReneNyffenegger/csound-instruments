  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;f1 0 N -1 1 0
;i1 0 dur atk dk
;i2 0 dur amp incr file phase
instr 1
  ia        =  p4
  id        =  p5
  is        =  p3-(ia+id)
  gaenv     linseg    0,ia,1,is,1,id,0
endin

instr 2
  itl       =  ftlen(1)
  ifile     =  p6
  iincr     =  (sr/itl)*p5
  iamp      =  p4
  iphase    =  p7
  asig      oscili    iamp,iincr,ifile,iphase
            out       asig*gaenv
endin
instr 3
  itl       =  p6
  ifile     =  1
  iincr     =  (sr/itl)*p5
  iamp      =  p4
  ia        =  p7
  id        =  p8
  is        =  p3-(ia+id)
  aenv      linseg    0,ia,1,is,1,id,0
  asig      oscili    iamp,iincr,ifile    
            out       asig*aenv
endin
instr 4
  ifile     =  1
  iamp      =  p4
  itl       =  p5
  iincr1    =  (sr/itl)*p6
  iincr2    =  (sr/itl)*p7
  ia        =  .01
  id        =  .01
  is        =  p3-(ia+id)
  kink      line      iincr1,p3,iincr2
  kenv      linseg    0,ia,1,is,1,id,0
  asig      oscili    iamp,kink,ifile     
            out       asig*kenv
endin
