; ************************************************************************
; ACCCI:     15-01-3.SCO
; coded:     jpg 8/92

; GEN functions **********************************************************
; "10-02-1.wav contains random noise with center frequency 'fqr'
; changing each second...

;       size GEN  inputfile             start
f71 0 1024  1     "10-02-1.wav"     .2    0     0 ; fqr = 10000
f72 0 1024  1     "10-02-1.wav"     1.2   0     0 ; fqr =  5000
f73 0 1024  1     "10-02-1.wav"     2.2   0     0 ; fqr =  2500
f74 0 1024  1     "10-02-1.wav"     3.2   0     0 ; fqr =  2000
f75 0 1024  1     "10-02-1.wav"     4.2   0     0 ; fqr =  1000
f76 0 1024  1     "10-02-1.wav"     5.2   0     0 ; fqr =   500
f77 0 1024  1     "10-02-1.wav"     6.2   0     0 ; fqr =   250
f78 0 1024  1     "10-02-1.wav"     7.2   0     0 ; fqr =   125
f79 0 1024  1     "10-02-1.wav"     8.2   0     0 ; fqr =    50
f80 0 1024  1     "10-02-1.wav"     9.2   0     0 ; fqr =    25


; score ******************************************************************

;            iamp    ifq   ibuf  if1
i1  0  1      8000   220    128    0    ; pluck-made random numbers
i1  2  2      .      .      .    

s

; section 2

;            iamp    ifq   ibuf  if1
i1  1  1      8000   220    128    71   ; random numbers from audio file
i1  3  .      .      .      .      72   
i1  5  .      .      .      .      73   
i1  7  .      .      .      .      74   
i1  9  .      .      .      .      75   
i1  11 .      .      .      .      76   
i1  13 .      .      .      .      77   
i1  15 .      .      .      .      78   
i1  17 .      .      .      .      79   
i1  19 .      .      .      .      80   

s

; section 3: changed ibuf to 1024

;            iamp    ifq   ibuf  if1
i1  1  1      8000   220    1024   71
i1  3  .      .      .      .      72   
i1  5  .      .      .      .      73   
i1  7  .      .      .      .      74   
i1  9  .      .      .      .      75   
i1  11 .      .      .      .      76   
i1  13 .      .      .      .      77   
i1  15 .      .      .      .      78   
i1  17 .      .      .      .      79   
i1  19 .      .      .      .      80   

e
