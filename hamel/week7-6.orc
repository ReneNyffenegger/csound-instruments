
; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  kenv      linseg    0, p3 * .5, 1, p3 * .5, 0   ; up-down ramp envelope
  kran      randh     50, kr                      ; produce values between -50 and 50
  kcent     line      1000, p3, 200               ; rampcentre freqency 1000 to 200
  kran      =  kran + kcent                       ; shift rand values to base frequency
  asig      oscil     kenv * p4, kran, 1          ; generate a band of noise
            out       asig
endin


