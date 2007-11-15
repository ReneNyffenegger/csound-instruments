  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Random wavecycle invert

  ilevl     =  p4                                 ; Output level
  inv       =  p5*2 - 1                           ; % Inverted

  ain       soundin   "sample1.wav"

  kin       downsamp  ain                         ; Convert input to kr
  krand     rand      1                           ; Generate random signal
  kzero     trigger   kin, 0, 0                   ; Detect zero crossings
if       kzero = 0 goto output                    ; Do nothing if not zero
if       krand + inv < 0 goto invert              ; If random <0 goto invert...
  ainvert   =  1                                  ; ...if not don't invert...
            goto      output                      ; ...then goto output
invert:
  ainvert   =  -1                                 ; Invert wavecycle
output:
            out       ain*ainvert*ilevl           ; Level, invert and output

endin
