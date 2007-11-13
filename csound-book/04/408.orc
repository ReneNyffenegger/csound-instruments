  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   408             
  a1        oscil     32000, 440, 1               ; GENERATE THE MODULATING SIGNAL
  a2        oscil     32000, 440+a1, 1            ; GENERATE THE MODULATED CARRIER SIGNAL
            out       a2                          ; AND PLAY THE OUTPUT
endin           
