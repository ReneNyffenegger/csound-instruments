  sr        =  8192
  kr        =  8192
  ksmps     =  1

; function builder
; f1 0 1024 10 1
; i1 0 1.0 outdur bigr-speed smallr-speed vib-speed seed1 seed2
; csoundbeta -h -f -d -o func futon1.orch futon1.s
instr 1
  ispeed1   =  p4 * p5
  ispeed2   =  p4 * p6
  ispeed3   =  p4 * p7
  iseed1    =  p8
  iseed2    =  p9
  a1        randh     .4, ispeed1, iseed1
  a2        randh     .05, ispeed2, iseed2
  a3        oscil     .05, ispeed3, 1
  a4        =  a1+a2+a3+.5
        ;out a4*32768.
            out       a4

endin
