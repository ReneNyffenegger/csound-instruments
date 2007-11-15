  sr        =  8192
  kr        =  8192
  ksmps     =  1

; function builder
; use for slight back-forth readthrough w/resident
; 
; f1 0 1024 10 1
; i1 0 dur speed phase
; next line important for float output
; csoundbeta -h -f -d -o func futon2.orch futon2.s
instr 1
  ispeed    =  p4/p3
  iphase    =  p5
  idepth    =  p6
  adev      oscil     idepth, ispeed, 1, iphase
  aline     linseg    0, p3, 1
  aout      =  adev + aline
            out       aout

endin
