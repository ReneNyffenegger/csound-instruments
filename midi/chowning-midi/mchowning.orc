;chowning.o
; THIS INSTRUMENT IMPLEMENTS SIMPLE FREQUENCY MODULATION TO PRODUCE
;        TIME-VARYING SPECTRA.
;THE SPECIFIC VALUES AND INSTRUMENT DESIGN COME FROM JOHN M. CHOWNING'S ARTICLE
;"THE SYNTHESIS OF COMPLEX AUDIO SPECTRA BY MEANS OF FREQUENCY MODULATION"

instr     1

; p4  = AMPLITUDE OF OUTPUT WAVE
; p5  = CARRIER FREQUENCY SPECIFIED IN HZ
; p6  = MODULATING FREQUENCY SPECIFIED IN HZ
; p7  = MODULATION INDEX 1
; p8  = MODULATION INDEX 2
; p9  = CARRIER ENVELOPE FUNCTION
; p10 = MODULATOR ENVELOPE FUNCTION
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01

  i1        =  1/.6                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  0 * 440                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (5-0) * 440                        ; CALCULATES DEVIATION FOR INDEX 2

  ampcar    oscil     10000,i1,2                  ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscil     i3,i1,2                     ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2,knote,1           ; MODULATING OSCILLATOR
  asig      oscili    ampcar,knote+amod,1         ; CARRIER OSCILLATOR
            out       asig*kgate
endin

; THIS IS A DOUBLE CARRIER FM INSTRUMENT USED TO PLACE A FORMANT PEAK IN THE SPECTRUM
; THE SPECIFIC VALUES AND INSTRUMENT DESIGN COME FROM JOHN M. CHOWNING'S ARTICLE
; "THE SYNTHESIS OF COMPLEX AUDIO SPECTRA BY MEANS OF FREQUENCY MODULATION"

instr     2

; p4  = AMPLITUDE OF OUTPUT WAVE
; p5  = CARRIER FREQUENCY SPECIFIED IN HZ
; p6  = MODULATING FREQUENCY SPECIFIED IN HZ
; p7  = MODULATION INDEX 1
; p8  = MODULATION INDEX 2
; p9  = CARRIER ENVELOPE FUNCTION
; p10 = MODULATOR ENVELOPE FUNCTION
; p11 = AMPLITUDE SCALER FOR SECOND CARRIER
; p12 = MODULATION INDEX SCALER FOR SECOND CARRIER
; p13 = FREQUENCY OF SECOND CARRIER SPECIFIED IN HZ
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01

  i1        =  1/.6                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  0 * 440                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (5-0) * 440                        ; CALCULATES DEVIATION FOR INDEX 2

  ampcar    oscil     10000,i1,2                  ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscil     i3,i1,2                     ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2,knote,1           ; MODULATING OSCILLATOR
  asig1     oscili    ampcar,knote+amod,1         ; CARRIER OSCILLATOR
  asig2     oscili    ampcar*.2,2100+(amod*.5),1  ; SECOND CARRIER OSCILLATOR
            out       (asig1+asig2)*kgate
endin
