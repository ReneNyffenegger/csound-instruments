; ************************************************************************
; ACCCI:     02-01-7.SCO
; coded:     jpg 8/93


; GEN functions **********************************************************
; waveform
f31 0 1024  7     0     128   10    256   10    256   -10   256   -10   128   0 ;ca. square wave
f11 0 1024  10    1     .5    .3    .2    .15   .12 ;six weighted sinusoids
f12 0 1024  10    1     .2    .05       ;three weighted sinusoids

; envelopes
f32 0 512   7     .99   512   0 
f51 0 513   5     256   512   1 


; dependency harmonic content and decay time is compared 
; alternating straight 440 frequency with beats, i.e. slightly detuned


; score ******************************************************************

;   start  idur  ifq1  if1  iamp   if2

i1  0  .1     440    31     10000  51   ; section 1
i1  0  1.8    .      11     3500
i1  0  3      .      12     2000

i1  4  .1     443    31     10000  51   ; section 2
i1  4  1.8    440    11     3500
i1  4  3      441    12     2000



i1  8  .1     440    12     10000  51   ; section 3
i1  8  1.8    .      11     3500
i1  8  3      .      31     2000

i1  12 .1     443    12     10000  51   ; section 4
i1  12 1.8    440    11     3500
i1  12 3      441    31     2000



i1  16 .1     440    31     10000  51   ; section 5
i1  16 1      .      11     3500
i1  16 3.8    .      12     2000

i1  20 .1     448    31     10000  51   ; section 6
i1  20 1      440    11     3500
i1  20 3.8    444    12     2000

e


