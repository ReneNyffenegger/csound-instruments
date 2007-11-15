; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  ist       =  cpspch(p5)                         ; start pitch
  iend      =  cpspch(p5 + 1.00)                  ; end pitch
  kpitch    line      ist, p3, iend               ; gliss from start to end
  kenv      linseg    0, p3/2, p4, p3/2, 0        ; up-down envelope 
  krand     randi     kpitch *.03, kr             ; a band of frequencies
  aindex    phasor    kpitch + krand              ; read table at pitch rate
  asig      table     aindex * 1024, 1            ; index table
            out       asig * kenv                 ; output signal
endin


