; Risset Siren #510

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

i1        =         1/p6
i2        =         1/p10
i3        =         1/p12
i4        =         1/p16
a1        =         0
k1        oscil     p5, i1, 5
a1        oscili    a1 + p4, k1, 1
a1        =         a1

k2        randi     p7, p8
k3        oscil     p9, i2, 6
a2        oscili    k2, k3, 1

k4        oscil     p11, i3, 7
a3        oscili    p13, k4, 2

k5        oscil     p15, i4, 8
a4        oscili    p14, k5, 1

a5        =         a1 + a2 + a3 + a4

          out       a5 * 10
          endin
