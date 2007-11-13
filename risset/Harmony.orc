; Risset "Harmony/Timbre" #550

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
k1        envlpx    p4, p5, p3, p6, 1, 1, .01
a1        oscili    k1, p7, 2
a2        oscili    p8, p9, 3
          out       a1 * a2
          endin

          instr 2
i1        =         1/p3
k1        oscil     p4, i1, 4
a1        oscili    k1, p5, 2
          out       a1
          endin
