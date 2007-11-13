sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     2814
iend      =         p4
ktime     line      0, p3, iend
          ktableseg p5, p3, p6
asig      vpvoc     ktime, 1, "violin.pvc"
          out       asig
          endin      
