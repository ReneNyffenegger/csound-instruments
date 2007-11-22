; ************************************************************************
; ACCCI:      02-44-1.SCO
; coded:      jpg 9/93

; GEN functions **********************************************************
; carrier
f11 0 513   9     1     1     0   

; bell shaped control function         ; "named" soundfiles for GEN 01 are
f71 0 513   1     "88-01-1.tab"     0     0     0 ; possible since Csound 1992
; Using an earlier Csound version, one needs to adapt 
; this to fit the soundin.x mechanism.

; exponential envelope
f51 0 513   5     1024  512   1         ; post-normalized

; score ******************************************************************
;     idur  ifq   iamp
i1  1  120    3900   10000
e
