  sr        =  44100                              ; SAMPLE RATE
  kr        =  4410                               ; CONTROL RATE
  ksmps     =  10
  nchnls    =  1                                  ; NUMBER OF CHANNELS

instr 1             ; ****STEPFEBACK****
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  ifbamt    =  p6                                 ; AMOUNT OF FEEDBACK
  ifltstart =  p7
  ifltend   =  p8
  garvb     init      0

  kampenv   linen     iamp, p3*.3, p3, p3*.05
; asig    soundin   "soundin.wav"
  asig      oscili    kampenv, inote, 2
  afb       delayr    0.001
  arev      reverb    asig+0.15*(afb*ifbamt), 1.5
            delayw    arev
  abal      balance   arev, asig
        
  ksweep    line      ifltstart, p3, ifltend
  aflt      reson     abal, ksweep, 5
  garvb     =  aflt
            out       aflt

endin

; **************************************************
instr 11            ; REVERB
  a1        reverb    garvb, 3.5
            out       a1
  garvb     =  0

endin
