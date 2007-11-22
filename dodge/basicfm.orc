; basicfm.orc

; THIS INSTRUMENT IMPLEMENTS SIMPLE FREQUENCY MODULATION TO PRODUCE TIME-VARYING SPECTRA.

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

; p4      =         CARRIER FREQUENCY
; p5      =         AMPLITUDE
; p6      =         FM FACTOR
; p7      =         

  i1        =  1/p3                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  cpspch(p4)                         ; CONVERTS PCHCLASS NOTATION TO Hz
  i3        =  i2 * p6                            ; i3 IS THE MODULATING FREQUENCY
  i4        =  i3 * p7                            ; i4 IS THE MAXIMUM FREQUENCY DEVIATION

  ampenv    oscil     p5,i1,1                     ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampdev    oscil     i4,i1,1                     ; ENVELOPE APPLIED TO FREQUENCY DEVIATION
  amod      oscili    ampdev,i3,3                 ; MODULATING OSCILLATOR
  asig      oscili    ampenv,i2+amod,3            ; CARRIER OSCILLATOR
            out       asig
endin

