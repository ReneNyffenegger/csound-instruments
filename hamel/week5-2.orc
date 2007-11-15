

; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1
  k1        phasor    2                           ; speed of phasor is 2 cps
  kptch     table     k1* 8, 2                    ; read table f-2 with phasor
  asig      oscil     p4, cpspch(p5+kptch), 1     ; oscillator
            out       asig
endin


