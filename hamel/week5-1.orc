
; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1
if      (p6 == 1) kgoto envelope1
if      (p6 == 2) kgoto envelope 2
if      (p6 == 3) kgoto envelope 3
envelope1:
  k1        linseg    0, p3 *.5, 1, p3*.5, 0      ; up then down
            kgoto     mainpart
envelope2:
  k1        linseg    1, p3 *.5, 0, p3*.5, 1      ; down then up
            kgoto     mainpart                    ; jump to audio part
envelope3:
  k1        linseg    1, p3, 0                    ; down in p3
            kgoto     mainpart                    ; this is redundant
mainpart:
  asig      oscil     p4 * k1, cpspch(p5), 1      ; main oscillator
            out       asig                        ; output to file
endin


