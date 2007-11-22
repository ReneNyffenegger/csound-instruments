; TSCST3.SCO  PRODUCES HARMONIC SOUND FOLLOWED BY INHARMONIC ONE
;             (c) Rajmil Fischman, 1997
;---------------------------------------------------------------
;SINEWAVE
f1  0 8192  10    1  
;--------------------------------------------------------------
;            p3      p4      p5     p6,p8... p18   p7,p9... p19
;INSTR  START   DUR  OVERALL FUND   RELATIVE       RELATIVE
;                    AMP     FREQ   AMPLITUDES     FREQUENCIES
;--------------------------------------------------------------
;HARMONIC SOUND
i3  0  2      20000  280    1      1    
                        .68     2   
                        .79     3   
                        .67     4   
                        .59     5   
                        .82     6   
                        .34     7   
;INHARMONIC SOUND
i3  3  2      20000  280    1      1    
                        .68     1.35
                        .79     1.78
                        .67     2.13
                        .59     2.55
                        .82     3.23
                        .34     3.47
e
