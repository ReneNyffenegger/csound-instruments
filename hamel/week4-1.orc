
; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1
  k1        expseg    .0001, .01, 1, .01, .5, p3 - .02, .001 ; decaying expseg
  k2        linseg    1, .02, 1, p3-.02, 2.5      ; rising linseg
  k3        =  k1 * k2
  asig      oscil     k3 * p4, cpspch(p5), 1      ; amp argument multiplied by max amplitude (p4) 
            out       asig                        
endin


