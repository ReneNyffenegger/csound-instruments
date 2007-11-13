sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


gkfr      init      0                        ; INITIAL FREQUENCY
gklfo     init      0                        ; INITIAL LFO VALUE

          instr     1804 
gkfr      linseg    p5, p3*.1, p6, p3*.9, p6
          endin     

          instr     1805
gklfo     oscil     p4, p5, 1
          endin     

          instr     1806
kenv      linen     p4, 0.01, p3, 0.01
asig      oscil     kenv, gkfr*(1+gklfo), 1
          out       asig
          endin
