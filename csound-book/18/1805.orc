sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     1811
asig      oscil     p4, p5, 1
          out       asig
          endin      

          instr     1812
asig      oscil     p4, p5, 2
          out       asig
          endin
