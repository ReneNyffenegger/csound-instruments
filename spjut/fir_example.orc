  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;-------------------------------------------------
instr     9                             ; FIR FILTER EXAMPLE
  a1        linseg    sr/8,7/sr,sr/8,1/sr,0,1,0
  a2        oscil     1,a1,1                      ; GENERATE AN IMPULSE
  a3        delay1    a2                          ; FILTER DELAY 1
  a4        delay1    a3                          ; FILTER DELAY 2
  a5        =  0.25*a2 + 0.5*a3 + 0.25*a4         ; SUMMATION
            out       a5
            display   a5,p3                       ; DISPLAY THE IMPULSE RESPONSE
            dispfft   a5,p3,4096,0,1            
          
endin
