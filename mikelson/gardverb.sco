;-------------------------------------------------------------------------------
; Reverbs derived from those presented by Bill Gardner
; using nested all-pass filters.
; Coded by Hans Mikelson 1998
;-------------------------------------------------------------------------------

; 1. Noise Click
; 2. Disk Input Mono
; 3. Disk Input Stereo
; 8. Simple Sum
; 9. Feedback Filter
;10. Delay
;11. Simple All-Pass Filter
;12. Nested All-Pass Filter
;13. Double Nested All-Pass Filter
;15. Output
;17. 2D First Echo
;21. Small Room Reverb
;22. Medium Room Reverb
;23. Large Room Reverb
;25. Small Room Reverb with controls
;26. Medium Room Reverb with controls
;27. Large Room Reverb with controls

;-------------------------------------------------------------------------------
; No Reverb
;-------------------------------------------------------------------------------
;   Sta  Dur  Amp  Pitch  SoundIn  OutCh
i2  0.0  2.7  0.0  .5     12       1

; Small Room Reverb
;    Sta  Dur  Amp  InCh
;i21  0.0  2.2  1.0  1

; Medium Room Reverb
;    Sta  Dur  Amp  InCh
;i22  0.0  2.5  1.0  1

; Large Room Reverb
;    Sta  Dur  Amp  InCh
;i23  0.0  2.8  1.0  1

; 2D Echos
;    Sta  Dur  Amp  EarX  EarY  SourceX  SourceY  WallX  WallY  InCh  OutCh1  OutCh2
i17  0.0  3.5  8    10    13    58       24       80     120    1     2       3

;Large Room Reverb
;    Sta  Dur  Amp  InCh  Decay  Densty1  Densty2  PreFilt  HiPass  LoPass  OutCh
i27  0.0  4.0  .3   2     1.50   .80      1.4      10000    5100    200     4
i27  0.0  4.0  .3   3     1.52   .82      1.5      10100    5000    210     5


; Reverb Mixer
;    Sta  Dur  Amp  InCh1  InCh2
i91  0    4.0  1    4      5

; Clear Zak
;    Sta  Dur
i99  0.0  4.0
