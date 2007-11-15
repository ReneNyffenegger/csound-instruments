

; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  kenv      expon     1, p3, .0001                ; ampitude envelope
  kvib      oscil     20, 6, 1                    ; vibrato at 6 times per second
  asig      oscil     p4 * kenv, cpspch(p5) + kvib, 1 ; audio oscillator 
            out       asig
endin


