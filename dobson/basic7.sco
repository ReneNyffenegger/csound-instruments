;basic7.sco
; adds new control p10 (0...1) to set time of expression peak 
;flute
f1  0 1024  10    1     0.5   0.25  0.02
;vibrato
f2  0 1024  10    1  
i1  0  1      10000  333    333    0      0      10000  0.75
i1  1  -0.7   1000   523    pp5    np4    0      6000   0.25
i1  1.7       -0.09  8000   500    pp5    np4    pp4    5000   0.1 
i1  1.79      -0.09  9000   475    pp5    np4    pp4    5500   0.1 
i1  1.88      0.09   10000  452    pp5    0      pp4    6000   0.1 
i1  1.97      -1     20000  417    pp5    np4    0      10000  0.5
i1  2.97      1      4000   465    pp5    0      pp4    6000   0.1
e
