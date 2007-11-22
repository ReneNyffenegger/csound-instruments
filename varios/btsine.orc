; resibois
; BEATING SINE WAVES
;
;  THRESHOLD = 15000
;
;  P4 = OSCILLATOR AMPLITUDE
;  P5 = UPPER GAIN
;  P6 = LOWER GAIN

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  ig1       init      p5
  ig2       init      p6
  it1       init      1
  it2       init      1
  kthresh   init      7500

  aosc1     oscil     p4/2,440,1
  aosc2     oscil     p4/2,445,1
  aosc      =  aosc1+aosc2
  aout      dam       aosc,kthresh,ig1,ig2,it1,it2
            out       aout

endin

