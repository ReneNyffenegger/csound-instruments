; CODA.SCO

; p4 = amplitude of output wave
; p5 = carrier frequency specified in Hz
; p6 = modulating frequency in Hz
; p7 = modulation index 1
; p8 = modulation index 2


f1  0 1024  9     1     1     0     3     4     0     4     12    0  
;------------------------------------------------------
; sine wave with partial, strength, phase
;------------------------------------------------------

;p1 p2  p3  p4  p5  p6  p7  p8
;------------------------------------------------------
;instr  strt    dur amp cfrq    mfreq   modi1   modi2
;------------------------------------------------------
i1  0  16     2500   150    300    5      10   
i1  7  14     <      <      <      <      <    
i1  12 20     3600   300    650    10     20  


;p1 p2  p3  p4
;------------------------------------------------------
;instr  strt    dur rvbtm
;------------------------------------------------------
i99 0  67     35  
e
