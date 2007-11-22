; ************************************************************************
; ACCCI:     01-01-3.SCO
; source:    #300 Linear and Exponential Decay Experiments,
;            Risset(1969)
; coded:     jpg 8/93


; GEN functions **********************************************************
; waveforms
f31 0 1024  7     0     128   10    256   10    256   -10   256   -10   128   0 ;ca. square wave
f11 0 1024  10    1     .5    .3    .2    .15   .12 ;six weighted sinusoids
f12 0 1024  10    1     .2    .05       ;three weighted sinusoids

; envelopes
f32 0 8192  7     1     8192  0
f51 0 8193  5     8192  8192  1

; score ******************************************************************

;   start  idur  iamp  ifq1  if1   if2
i1  1  2      8000   440    11     32   ; middle
i1  4  .      .      .      .      51   

i1  7  4      .      .      .      32   ; long
i1  12 .      .      .      .      51   

i1  17 1      .      .      .      32   ; short
i1  19 .      .      .      .      51   

i1  21 .51    .      .      .      32   ; shorter
i1  23 .      .      .      .      51   
e
