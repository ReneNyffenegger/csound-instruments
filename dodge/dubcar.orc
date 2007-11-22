; dubcar.orc

; THIS INSTRUMENT IMPLEMENTS DOUBLE CARRIER FM TO IMPART A FORMANT AT 1500 Hz.

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

; p4            =               FREQ IN Hz.
; p5            =               AMP
; p6            =               MODULATION INDEX
; p7            =               fc2 AMP FACTOR

  i1        =  p6*p4                              ; IMAX
  i2        =  p7                                 ; FACTOR FOR REDUCING AMP OF fc2
  i3        =  int((1500/p4)+.5)                  ; FORMANT AT FREQ OF HARMONIC CLOSEST TO 1500 Hz
  i3        =  i3 * p4                            ; fc2
  i4        =  p4                                 ; fc1

  ampenv1   linen     i1,p3*.1,p3,p3*.9
  ampenv2   linen     p5,.01,p3,.01
  ampenv3   linen     ampenv2*.2,.04,p3,.04

  a1        oscili    ampenv1,i4,1
  a2        oscili    ampenv2,a1+p4,1
  a3        =  i2*a1
  a4        oscili    ampenv3,a3+i3,1
            out       a2+a4

endin
