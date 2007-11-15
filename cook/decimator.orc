  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Bit depth / sample rate reducer

  ilevl     =  p4                                 ; Output level
  ibits     =  2^p5                               ; Bit depth (1 to 16)
  ifold     =  sr/p6                              ; Sample rate

  ain       soundin   "sample1.wav"

  kin       downsamp  ain                         ; Convert to kr
  kin       =  kin + 32768                        ; Add DC to avoid (-)
  kin       =  kin*(ibits/65536)                  ; Divide signal level
  kin       =  int(kin)                           ; Quantise
  aout      upsamp    kin                         ; Convert to sr
  aout      =  aout*(65536/ibits) - 32768         ; Scale and remove DC
  aout      fold      aout, ifold                 ; Resample
            out       aout*ilevl                  ; Level and output

endin