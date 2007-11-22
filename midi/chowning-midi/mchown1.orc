;chowning.o
; THIS INSTRUMENT IMPLEMENTS SIMPLE FREQUENCY MODULATION TO PRODUCE
;        TIME-VARYING SPECTRA.
;THE SPECIFIC VALUES AND INSTRUMENT DESIGN COME FROM JOHN M. CHOWNING'S ARTICLE
;"THE SYNTHESIS OF COMPLEX AUDIO SPECTRA BY MEANS OF FREQUENCY MODULATION"

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

            massign   1,1

instr          1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.3,.01

; p4  = AMPLITUDE OF OUTPUT WAVE
; p5  = CARRIER FREQUENCY SPECIFIED IN HZ
; p6  = MODULATING FREQUENCY SPECIFIED IN HZ
; p7  = MODULATION INDEX 1
; p8  = MODULATION INDEX 2
; p9  = CARRIER ENVELOPE FUNCTION
; p10 = MODULATOR ENVELOPE FUNCTION

  i1        =  1/.2                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  0 * 55                             ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (25-0) * 55                        ; CALCULATES DEVIATION FOR INDEX 2

  ampcar    oscil     10000,i1,6                  ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscil     i3,i1,6                     ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2,55,1              ; MODULATING OSCILLATOR
  asig      oscili    ampcar,knote+amod,1         ; CARRIER OSCILLATOR
            outs      asig*kgate,asig*kgate
  ga1       =  asig*kgate
endin

