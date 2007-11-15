
t       0       150   

#include "formant_table.include.sco"
#include "fgen.h.sco"

; band-limited pulse
f 257 0     16384 2     1   
$FGEN128(256'1024'257'1)
; window waveform
f 1 0 256   7     0     128   1     128   0 
; formant table
$FORMANTTABLE(2)
; room parameters     mindep  maxdep  imdel   irlen   idist	seed
f 225 0     64    -2    4     60    -1    -1    1.0   4321
      1     10.0  0.05  0.92  20000 0.25  0.35  2 ; ceil
      1     2.0   0.05  0.92  20000 0.25  0.17  2 ; floor
      1     14.0  0.05  0.92  20000 0.25  0.25  2 ; front
      1     6.0   0.05  0.92  20000 0.25  0.25  2 ; rear
      1     7.0   0.05  0.92  20000 0.25  0.25  2 ; right
      1     9.0   0.05  0.92  20000 0.25  0.25  2 ; left

i 1 0  0.70   67     127    15          ; p4: pitch, p5: velocity, p6: voice (see include
i 1 4  0.70   74     127    15          ; file for voice numbers)

i 90   0      8    

e

