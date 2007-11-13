  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Inverts waveform between alternate zero crossings

  ilevl     =  p4                                 ; Output level
  imix      =  p5                                 ; Mix: 0=Dry 1=Inverted
  kcount    init      1                           ; Initialize counter

  ain       soundin   "sample1.wav"               ; 

;   ktrig     trigger   ain, 0, 0                   ; Detect alternate zero crossings
; if       ktrig = 0 goto out                       ; If no zero cross, skip to output
if       kcount = 1 goto 2                        ; Flip count 1/2
  kgate1    =  1                                  ; Set gate to 1
  kcount    =  1                                  ; Set count to 1...
            goto      out                         ; ...then go to output
2:
  kgate1    =  -1                                 ; Set gate to -1
  kcount    =  2                                  ; Set count to 2
out:
                                         ; Output section
  aout      =  ain*(1 - imix) + ain*kgate1*imix   ; Gate input signals to splice
            out       aout*ilevl                  ; Level and output

endin