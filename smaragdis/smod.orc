  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  am        table     .001,2
  am        oscil     1, 440*am,2
  a2        oscil     15000, 660*am, 1
  a1        oscil     15000, 500*am, 2
            out       a1+a2
endin
