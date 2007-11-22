; ************************************************************************
; ACCCI:      01-41-1.SCO
; source:     511.sco  Glissandi with constant frequency differences
;             between voices, Risset(1969)
; coded:      jpg 9/93

; GEN functions **********************************************************
; waveforms
f11 0 512   9     1     1     0         ; sine
f31 0 512   7     0     128   10    256   -10   128   0 ; sawtooth
; continuous pitch control functions
f32 0 512   7     .999  50    .999  412   .85   50    .85 ; third down
f33 0 512   7     .999  20    .999  472   .235  20    .235 ; ~two octs down
f34 0 512   7     .999  25    .999  462   .06   25    .06 ; sixth down
f35 0 512   7     .25   30    .25   110   .5    60    .25   10    .25   60    .5    20    .75   222   .5

; score ******************************************************************
;                   RANDI             LFO
;                 amp control     pitch control
;instr 1  idur    iampr ifqr      iamp1  irate
i1  1  6.5    800    80     1000   3 
i1  3  .      800    150    750    .  

e
