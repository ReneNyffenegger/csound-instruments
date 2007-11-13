  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1

instr    1 ; Random vowel FOF instrument

  ileng     =  p3  
  ilevl     =  p4*10000                           ; Output level
  ipitch    =  cpspch(p5)                         ; Pitch
  ivibr     =  p6                                 ; Vibrato rate
  ivibd     =  p7                                 ; Vibrato depth
  irate     =  p8                                 ; Random vowel rate
  idet      =  p9                                 ; Detune

  kenv      linseg    0, .1, 1, p3 - .2, 1, .1, 0 ; Envelope
  iseed     =  rnd(1)
  krnd      randi     .5, irate, iseed            ; Generate random signal
  krnd      =  krnd + .5                          ; Make positive
  kvib      linseg    0, p3, ivibd                ; Generate ramp to fade in vibrato
  kvib      oscil     kvib, ivibr, 1              ; Generate vibrato
  k1f       table     krnd, 11, 1                 ; Read formant frequency 1
  k2f       table     krnd, 12, 1                 ; Read formant frequency 2
  k3f       table     krnd, 13, 1                 ; Read formant frequency 3
  k4f       table     krnd, 14, 1                 ; Read formant frequency 4
  k5f       table     krnd, 15, 1                 ; Read formant frequency 5
  k1b       table     krnd, 21, 1                 ; Read formant bandwidth 1
  k2b       table     krnd, 22, 1                 ; Read formant bandwidth 2
  k3b       table     krnd, 23, 1                 ; Read formant bandwidth 3
  k4b       table     krnd, 24, 1                 ; Read formant bandwidth 4
  k5b       table     krnd, 25, 1                 ; Read formant bandwidth 5
  kpitch    =  ipitch + idet + kvib               ; Sum pitch sources
  a1        fof       1.0, kpitch, k1f, 0, k1b, .003, .02, .007, 1000, 1, 2, ileng
  a2        fof       0.7, kpitch, k2f, 0, k2b, .003, .02, .007, 1000, 1, 2, ileng
  a3        fof       0.5, kpitch, k3f, 0, k3b, .003, .02, .007, 1000, 1, 2, ileng
  a4        fof       0.4, kpitch, k4f, 0, k4b, .003, .02, .007, 1000, 1, 2, ileng
  a5        fof       0.3, kpitch, k5f, 0, k5b, .003, .02, .007, 1000, 1, 2, ileng
  aout      sum       a1, a2, a3, a4, a5          ; Sum formants
            out       aout*ilevl*kenv             ; Level, envelope and output

endin
