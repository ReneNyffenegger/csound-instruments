; STRETCH DRUM.ORC

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


  garvbsig  init      0                           ; global audio reverb signal initialization

instr 50                                                                ; stretch drum

  asig      pluck     6000, 100, 30, 0, 4, .5, 4  ; Karplus-Strong “drum” algorithm
            outs      asig, asig                  ; left & right output of direct audio
  garvbsig  =  garvbsig + asig                    ; add audio to audio receiver prior to pan
endin


instr 99                                                                                ; global reverb instrument

  irvbtime  =  p4                                 ; seconds for signal to decay 60 dB

  asig2     reverb    garvbsig, irvbtime          ; put global sig into reverb
            outs1     asig2                       ; output reverb signal left
            outs2     asig2                       ; output reverb signal right
  garvbsig  =  0                                  ; reinitialize
endin
