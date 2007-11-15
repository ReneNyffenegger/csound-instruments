; variable speed reader for overlapped reads
; stereo version
; 1st instrument: mono in stereo out
; 2nd instrument: stereo in stereo out
  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2


instr 1
;f1 0 N -1 X 0 ; X is where func1 is
;f2 0 N -1 Y 0 ; Y is where func2 is
;f3 0 N+1 -1 1 0 ; store soundfile here
;i1 0 dur %of_func ; means how much of func actually contains signal

  ifunc1    =  1
  ifunc2    =  2
  isf       =  3
  iscale    =  (ftlen(3)) * p4
  igain     =  1
  ia        =  .01
  id        =  .01
  is        =  p3-(ia+id)
  aenv      linseg    0,ia,igain,is,igain,id,0
  andx1     oscili    iscale, 1.0/p3, ifunc1
  andx2     oscili    iscale, 1.0/p3, ifunc2
  asig1     tablei    andx1, isf, 0
  asig2     tablei    andx2, isf, 0
            outs      (asig1 * aenv), (asig2 * aenv)
endin

instr 2
;f1 0 N -1 X 0 ; X is where func1 is
;f2 0 N -1 Y 0 ; Y is where func2 is
;f3 0 N+1 -1 1 0 ; store chan1 of soundfile here
;f4 0 N+1 -1 2 0 ; store chan2 of soundfile here
;i1 0 dur %of_func ; means how much of func actually contains signal

  ifunc1    =  1
  ifunc2    =  2
  isf1      =  3
  isf2      =  4
  iscale    =  (ftlen(isf1)) * p4
  igain     =  1
  ia        =  .01
  id        =  .01
  is        =  p3-(ia+id)
  aenv      linseg    0,ia,igain,is,igain,id,0
  andx1     oscili    iscale, 1.0/p3, ifunc1
  andx2     oscili    iscale, 1.0/p3, ifunc2
  asig1     tablei    andx1, isf1, 0
  asig2     tablei    andx2, isf2, 0
            outs      (asig1 * aenv), (asig2 * aenv)
endin
