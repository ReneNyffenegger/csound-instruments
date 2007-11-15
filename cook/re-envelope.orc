  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Replaces natural envelope with new shape

  ilevl     =  p4                                 ; Output level
  ishape    =  p5                                 ; Envelope shape
  inumbr    =  p6                                 ; Number of envelope repeats
  kenv      init      0                           ; Initialize output
  kslope    init      0                           ; Initialize slope

  ain       soundin   "sample1.wav"

  kin       downsamp  ain                         ; Convert to kr
  kin       mirror    kin, 0, 32767               ; Full wave rectify
if       kin > kenv goto up                       ; See if input exceeds output...
  kslope    =  kslope + .1                        ; Increment slope
  kenv      =  kenv - kslope                      ; Ramp down
            goto      out
up:
  kslope    =  0                                  ; Reset slope
  kenv      =  kin                                ; Ramp up
out:
  kenv1     oscili    1, inumbr/p3, ishape        ; Envelope
  aout      =  ain*(32767/kenv)                   ; De-envelope
            out       aout*ilevl*kenv1            ; Re-envelope, level and output

endin