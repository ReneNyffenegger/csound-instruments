  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Slew limiter

  ilevl     =  p4                                 ; Output level
  islew1    =  p5                                 ; Slew rate - start
  islew2    =  p6                                 ; Slew rate - end
  kout      init      0                           ; Initialize output

  ain       soundin   "sample1.wav"

  kin       downsamp  ain                         ; Convert to kr
  kslew     expon     islew1, p3, islew2          ; Generate exponential sweep
if       kin > (kout + kslew) goto up             ; Detect slew up over limit
if       kin < (kout - kslew) goto dn             ; Detect slew down over limit
  kout      =  kin                                ; Let pass if below slew limit
            goto      out                         ; Goto output
up:
  kout      =  kout + kslew                       ; Limit slew up
            goto      out                         ; Goto output
dn:
  kout      =  kout - kslew                       ; Limit slew down
            goto      out                         ; Goto output
out:
  aout      upsamp    kout                        ; Convert to sr
            out       aout*ilevl                  ; Level and output

endin
