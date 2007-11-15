;-------------------------------------------------------------------------------
; REVERBS DERIVED FROM THOSE PRESENTED BY BILL GARDNER
; USING NESTED ALL-PASS FILTERS.
; CODED BY HANS MIKELSON 1998
;-------------------------------------------------------------------------------

; 1. NOISE CLICK
; 2. DISK INPUT MONO
; 3. DISK INPUT STEREO
; 8. SIMPLE SUM
; 9. FEEDBACK FILTER
;10. DELAY
;11. SIMPLE ALL-PASS FILTER
;12. NESTED ALL-PASS FILTER
;13. DOUBLE NESTED ALL-PASS FILTER
;15. OUTPUT
;17. 2D FIRST ECHO
;21. SMALL ROOM REVERB
;22. MEDIUM ROOM REVERB
;23. LARGE ROOM REVERB
;25. SMALL ROOM REVERB WITH CONTROLS
;26. MEDIUM ROOM REVERB WITH CONTROLS
;27. LARGE ROOM REVERB WITH CONTROLS

;-------------------------------------------------------------------------------
; NO REVERB
;-------------------------------------------------------------------------------
;   STA  DUR  AMP  PITCH  SOUNDIN  OUTCH
i2  0.0       2.7    1.0    1      5      1    

; SMALL ROOM REVERB
;    STA  DUR  AMP  INCH
i21 0.0       2.2    1.0    1  

; MEDIUM ROOM REVERB
;    STA  DUR  AMP  INCH
;i22  0.0  2.5  1.0  1

; LARGE ROOM REVERB
;    STA  DUR  AMP  INCH
;i23  0.0  2.8  1.0  1

; 2D ECHOS
;    STA  DUR  AMP  EARX  EARY  SOURCEX  SOURCEY  WALLX  WALLY  INCH  OUTCH1  OUTCH2
i17 0.0       3.5    8      10     13     58     24     80     120    1      2      3    

;LARGE ROOM REVERB
;    STA  DUR  AMP  INCH  DECAY  DENSTY1  DENSTY2  PREFILT  HIPASS  LOPASS  OUTCH
i27 0.0       4.0    .3     2      1.50   .80    1.4    10000  5100   200    4  
i27 0.0       4.0    .3     3      1.52   .82    1.5    10100  5000   210    5  


; REVERB MIXER
;    STA  DUR  AMP  INCH1  INCH2
i91 0  4.0    1      4      5    

; CLEAR ZAK
;    STA  DUR
i99 0.0       4.0   
