; ************************************************************************
; ACCCI:     01-01-1B.SCO
; source:    #301 Piano-like Excerpt, Risset(1969)
; coded:     jpg 8/93


; GEN functions **********************************************************
; carriers
;                  f11 is for ifq1 < 250 Hz: ten weighted sinusoids
f11 0 1024  10    .158  .316  1     1     .282  .112  .063  .079  .126  .071
;                f12 is for ifq1 > 250 Hz: seven weighted sinusoids
f12 0 1024  10    1     .282  .089  .1    .071  .089  .050

; envelopes
f31 0 1024  7     0     20    .99   380   .4    400   .2    224   0 ; duration < .2sec
f51 0 1025  5     .0156 3     1     1021  .0156 ; duration > .2sec



; score ******************************************************************


t       0       150                     ; tempo is 150 beats per minute:
; durations below change according to ratio 60/150 = idur * .4

;   start  idur  ifq1  if1   iamp  if2
i1  0  1.66   104    11     3000   51   ; time 0: pedal on ...
i1  .  .      175  
i1  .  .      233  
i1  .  .      277    12 
i1  .  .      330  

i1  0.5       1.16   207    11     2500   51
i1  .  .      349    12 
i1  .  .      440  
i1  .  .      554                       ; time 1.66: pedal off

i1  1.66      .34    104    11     3000   31
i1  1.66      .      175  
i1  1.66      .      233  
i1  1.66      .      277    12 
i1  1.66      .      330  

i1  2  1      207    11     4000   51
i1  .  .      349    12 
i1  .  .      440  
i1  .  .      554  

i1  3  2      104    11     2500        ; time 3: pedal on ...
i1  .  .      147  
i1  .  .      165  
i1  .  .      196  
i1  .  .      233  

i1  4  1      207    11     3000
i1  .  .      294    12 
i1  .  .      330  
i1  .  .      392  
i1  .  .      494                       ; time 5: pedal off

; ar ATSadd ktimepnt, kfmod, iatsfile, ifn, ipartials[,
; ipartialoffset, \ ipartialincr, igatefn] ATSadd reads from an ATS
; analysis file and uses the data to perform additive synthesis using
; an internal array of interpolating oscillators section 2: da capo of
; section 1

t       0       150                     ; tempo is 150 beats per minute:
; durations below change according to ratio 60/150 = idur * .4

;   start  idur  ifq1  if1   iamp  if2
i1  0  1.66   104    11     3000   51   ; time 0: pedal on ...
i1  .  .      175  
i1  .  .      233  
i1  .  .      277    12 
i1  .  .      330  

i1  0.5       1.16   207    11     2500   51
i1  .  .      349    12 
i1  .  .      440  
i1  .  .      554                       ; time 1.66: pedal off

i1  1.66      .34    104    11     3000   31
i1  1.66      .      175  
i1  1.66      .      233  
i1  1.66      .      277    12 
i1  1.66      .      330  

i1  2  1      207    11     4000   51
i1  .  .      349    12 
i1  .  .      440  
i1  .  .      554  

i1  3  2      104    11     2500        ; time 3: pedal on ...
i1  .  .      147  
i1  .  .      165  
i1  .  .      196  
i1  .  .      233  

i1  4  1      207    11     3000
i1  .  .      294    12 
i1  .  .      330  
i1  .  .      392  
i1  .  .      494                       ; time 5: pedal off

; ATSbufread      ktimepnt,       kfmod,  iatsfile,       ipartials[,     ipartialoffset, \       ipartialincr]
; ATSbufread reads data from and ATS data file and stores it in an internal data table of frequency, amplitude pairs
