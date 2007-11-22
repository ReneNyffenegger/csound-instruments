;the sco file
; Generate x seconds (ip2)of endless glissando with a x second cycle time (ip5)
; Function 03 reads soundin.21 the bell shaped curve specified by Risset in Dodge

f1  0 512   10    1  
f2  0 513   7     0     512   1 
f3  0 2048  1     21    0     6     0   
f4  0 513   5     1     512   .0009766

i1  0  60     10000  5000   120
