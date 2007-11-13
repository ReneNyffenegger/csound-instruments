sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     2601    
i1        =         0.002177629    ; SAMPLE 1 OF SIGNAL B
i2        =         0.032279228    ; SAMPLE 2 OF SIGNAL B
i3        =         0.153256114    ; SAMPLE 3 OF SIGNAL B
i4        =         0.304044017    ; SAMPLE 4 OF SIGNAL B
i5        =         0.304044017    ; SAMPLE 5 OF SIGNAL B
i6        =         0.153256114    ; SAMPLE 6 OF SIGNAL B
i7        =         0.032279228    ; SAMPLE 7 OF SIGNAL B
i8        =         0.002177629    ; SAMPLE 8 OF SIGNAL B
a1        soundin   "fox.aif"      ; SIGNAL A
a2        delay1    a1   
a3        delay1    a2   
a4        delay1    a3   
a5        delay1    a4   
a6        delay1    a5   
a7        delay1    a6   
a8        delay1    a7   
          out       i1*a1 + i2*a2 + i3*a3 + i4*a4 + i5*a5 + i6*a6 + i7*a7 + i8*a8
          endin
