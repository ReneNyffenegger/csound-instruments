  sr        =  44100
  kr        =  882
  ksmps     =  50

instr 1
  kspc      randh     300, 3, .555
  kspc      =  kspc + 600
  asig      oscil     16000, kspc, 1
            out       asig

endin