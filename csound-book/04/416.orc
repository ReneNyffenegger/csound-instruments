  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   416             ; GENERATE A GLOBAL AMPLITUDE ENVELOPE
  kamp      expseg    .001, .5, 1, p3/3, .8, p3/3, 6, p3/3-.5, .001
  kfr       =  440                                ; GENERATE A 3 HARMONIC WAVEFORM
  a1        oscili    kamp*5000, kfr, 1        
  a2        oscili    kamp*5000, kfr*2, 1     
  a3        oscili    kamp*5000, kfr*3, 1     
  a4        =  a       3*a3                       ; SQUARE THE SIGNAL
  a4d       delay1    a4                          ; REMOVE SOME HIGH FREQUENCIES ...
  a4dd      delay1    a4d                         ; ... BY FILTERING
  a5        =  a4/3+a4d/3+a4dd/3                  ; USE THAT AS A MODULATION TO ANOTHER...
  a6        oscil     10000, 440+a5/10, 1         ; ... OSCILLATOR
            out       a6                          ; SEND THE SIGNAL OUT
endin