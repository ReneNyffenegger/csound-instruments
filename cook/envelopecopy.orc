  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Replaces envelope of one sound with that of another

  ilevl     =  p4                                 ; Output level
  kenv1     init      1                           ; Initialize output 1
  kenv2     init      1                           ; Initialize output 2

  ain1      soundin   "sample1.wav"               ; Carrier
  ain2      soundin   "sample2.wav"               ; Modulator

  kin1      downsamp  ain1                        ; Convert to kr
  kin1      mirror    kin1, 0, 32767              ; Full wave rectify
if       kin1 > kenv1 goto up1                    ; See if input larger than output
  kenv1     =  kenv1 - ((32767 - kin1)/1000)      ; Release
            goto      out1
up1:
  kenv1     =  kin1                               ; Attack
out1:
  aout1     =  ain1*(32767/(kenv1 + 1))           ; De-envelope
  kin2      downsamp  ain2                        ; Convert to kr
  kin2      mirror    kin2, 0, 32767              ; Full wave rectify
if       kin2 > kenv2 goto up2                    ; See if input larger than output
  kenv2     =  kenv2 - ((32767 - kin2)/1000)      ; Release
            goto      out2
up2:
  kenv2     =  kin2                               ; Attack
out2:
  aout2     =  aout1*(kenv2/32767)                ; Apply new envelope
            out       aout2*ilevl                 ; Level and output

endin