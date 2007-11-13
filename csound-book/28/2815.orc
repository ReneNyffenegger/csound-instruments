sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     2815
iend      =         p4
ktime     line      0, p3, iend
          ktableseg 2, p3*.5, 3, p3*.5, 4
asig      vpvoc     ktime, 1, "hellorcb.pvc"
          out       asig
          endin

