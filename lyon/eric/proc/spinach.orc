; variable speed reader for overlapped reads

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1


instr 1
;f1 0 N -1 X 0 ; X is where func is
;f2 0 N+1 -1 1 0 ; store soundfile here
;i1 0 dur %of_func ; means how much of func actually contains signal
  iscale    =  (ftlen(2)) * p4
  igain     =  1
  ia        =  .01
  id        =  .01
  is        =  p3-(ia+id)
  aenv      linseg    0,ia,igain,is,igain,id,0
  andx      oscili    iscale, 1.0/p3, 1
  asig      tablei    andx, 2, 0
            out       asig * aenv
endin
