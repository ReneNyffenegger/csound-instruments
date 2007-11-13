; risset.orc
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
i1        =         p5*.3
i2        =         p4*.1
i3        =         1/p3
i4        =         p5*.8
i5        =         4

a1        randi     p5,4000
a1        oscil     a1,i3,2
a1        oscil     a1,3000,1

a2        oscil     i1,i3,2
a2        oscil     a2,i2,3

a3        oscil     i4,i3,8
a3        oscil     a3,i5,4

          out       a1+a2+a3

          endin
