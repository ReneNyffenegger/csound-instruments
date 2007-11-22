;===========================================================================
; Modular Synthesizer
;===========================================================================
; Waveforms
f1  0 8192  10    1                     ;Sine
f2  0 256   7     -1    128   -1    0     1     128   1 ;Square
f3  0 8192  7     1     8192  -1        ;Sawtooth

; Simple Trigger for VCF Envelopes
;    Sta  Dur  DurCh
i1  0.0       3.2    9  

; Keyboard Triggers
;    Sta  Dur  Amp    Pch   DurCh  AmpCh  PchCh
i2  0.0       0.2    9000   7.00   1      2      3    
i2  +  0.2    8000   7.00   1      2      3    
i2  .  0.2    6000   7.07   1      2      3    
i2  .  0.2    6000   7.00   1      2      3    
i2  .  0.4    8000   7.06   1      2      3    
i2  .  0.2    8000   7.00   1      2      3    
i2  .  0.2    9000   7.09   1      2      3    
i2  .  0.2    8000   7.09   1      2      3    
i2  .  0.2    9000   7.00   1      2      3    
i2  .  0.2    8000   7.00   1      2      3    
i2  .  0.4    6000   7.07   1      2      3    
i2  .  0.2    8000   7.05   1      2      3    
i2  .  0.2    9000   7.09   1      2      3    
i2  .  0.2    9000   7.09   1      2      3    

f20 0 1024  7     0     128   1     256   .7    384   .7    128   .3    128   0 ; Amp 
f21 0 1024  -7    420   256   160   256   120   256   80    256   420 ; Fco
f22 0 1024  -7    100   512   130   256   80    256   40 ; Rez

; Envelope
;   Sta  Dur  DurCh  Amp  Table  OutKCh
i5  0.0       3.2    1      1      20     4 ; Amp
i5  0.0       3.2    9      1      21     5 ; Fco
i5  0.0       3.2    9      1      22     6 ; Rez

; LFO
;   Sta  Dur  Amp  Fqc  Table  Offset  OutCh
i6  0  1.6    .8     1      1      0      11   

; VCO
;Ins  Sta  Dur  FqcCh  SyncIn  PWMCh  AudioOut  SyncOut  Shape  PWidth  FqcAdj
i15 0.0       1.6    3      0      11     2      8      1      0      1    
i15 1.6       1.6    3      0      0      1      7      0      0      .7   
i15 1.6       1.6    3      7      0      2      8      0      .9     1   

; VCF
;    Sta  Dur  FreqCh  RezCh   RZMix  InACh  OutACh
i20 0  3.2    5      6      .5     2      3    

; Controlled Amplifier
;    Sta  Dur  MaxCh  ContCh  InCh  OutCh
i25 0  3.2    2      4      3      4    

; Final Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100   0      3.2    4      2      .5     4      0      0    

; Clear Audio
i110   0      3.2  

