
t       0       120   

#include "roomparams.sco"

f 1 0 524288      -1    "cym_sample-hihat2.pcm" 0     6     0 ; input sample
f 2 0 16385 5     1     16385 0.01      ; window

; p4: ignored
; p5: note velocity (1 to 127)

i 1 0.0       0.03   60     110 
i 1 0.5       0.37   60     127 
i 1 1.0       0.03   60     110 
i 1 1.5       0.37   60     127 
i 1 2.0       0.37   60     127 
i 1 2.5       0.37   60     127 
i 1 3.0       0.03   60     110 
i 1 3.5       0.37   60     127 

i 99   0      5    

e

