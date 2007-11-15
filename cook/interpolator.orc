  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr    1 ; Interpolator - Set kr to wanted rate

  ilevl     =  p4                                 ; Output level

  ain       soundin   "sample1.wav"

  kin       downsamp  ain                         ; Convert to kr
  aout      interp    kin                         ; Interpolate at kr
            out       aout*ilevl                  ; Level and output

endin