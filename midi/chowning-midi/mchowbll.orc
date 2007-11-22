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
  kgate     linenr    iveloc,0,2,.01

; p4  = AMPLITUDE OF OUTPUT WAVE
; p5  = CARRIER FREQUENCY SPECIFIED IN HZ
; p6  = MODULATING FREQUENCY SPECIFIED IN HZ
; p7  = MODULATION INDEX 1
; p8  = MODULATION INDEX 2
; p9  = CARRIER ENVELOPE FUNCTION
; p10 = MODULATOR ENVELOPE FUNCTION
  k1        randi     10,2                        ;5,100 =BUZZY
  k2        linseg    1,5,10
  i1        =  1/5                                ; ONE CYCLE PER DURATION OF NOTE
  i2        =  1 * 440                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (10-1) * (440*.5)+11               ; CALCULATES DEVIATION FOR INDEX 2

  ampcar    oscil     100,i1,1                    ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscil     i3+k2,i1,7                  ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2+k1,knote,1        ; MODULATING OSCILLATOR ALSO K1+P6
  k3        linseg    440,5,440*.9
  asig      oscili    ampcar,k3+amod,1            ; CARRIER OSCILLATOR
  k1        linseg    100,5*.9,100,5*.1,100*.1
  ares      reson     asig,440,440*3,1
            outs      (ares *k1)*kgate, (ares*k1)*kgate
  ga1       =  (ares*k1)*kgate
endin

