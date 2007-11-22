; ************************************************************************
; ACCCI:      02-44-2.SCO
; source:     endless.sco   MIT,1993
; coded:      jpg, 10/93

; GEN functions **********************************************************
; waveform
f1  0 512   10    1  
f31 0 513   7     0     512   1 
f51 0 513   5     1     512   .0009766
f71 0 2049  1     "88-01-2.tab"     0     0     0   
;    p4 of f71(GEN 01) is positive: soundfile amps are post-normalized
;    p4 negative: rescaling is skipped


; score ******************************************************************

; cycle time studies

;      idur   iamp   ifq    icycle time
i1  0  20     10000  32000  100
i1  21 .      .      .      50   
i1  42 .      .      .      25   

e



