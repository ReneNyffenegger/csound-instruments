  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;-------------------------------------------
instr 10                           ;IIR FILTER EXAMPLE (THANKS TO RUSSELL PINKSTON)
  a1        linseg    sr/8,7/sr,sr/8,1/sr,0,1,0
  a2        oscil     1,a1, 1                     ;GENERATE AN IMPULSE
  aprev1    init      0                           ; INIT y(n-1) TO 0
  aprev2    init      0                           ; INIT y(n-2) TO 0
  ainput    =  a2
;y(n)     =         a0x(n) - b1y(n-1) - b2y(n-2)
  aoutput   =  1*ainput - 0.5*aprev1 - 0.5*aprev2
  aprev2    =  aprev1
  aprev1    =  aoutput
            out       aoutput
            display   aoutput,p3                  ;DISPLAY THE IMPULSE RESPONSE
            dispfft   aoutput,p3,4096,0,1         ;FREQUENCY RESPONSE
endin
