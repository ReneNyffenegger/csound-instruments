
t       0       120   

#include "roomparams.sco"

f 1 0 524288      -1    "cym_sample-ride2.pcm"  0     6     0 ; input sample
f 2 0 16385 5     1     16385 0.01      ; window

; p4: ignored
; p5: note velocity (1 to 127)

i 1 0.0       1.0    60     127 
i 1 1.0       1.0    60     127 

i 99   0      5    

e

