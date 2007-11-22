  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1
;-------------------------------------------------
instr 1                                   ;DIRECTCONVOLUTION
  i1        =  0.002177629                        ;SMPL 1 OF SIGNAL B
  i2        =  0.032279228                        ;SMPL 2 OF SIGNAL B
  i3        =  0.153256114                        ;SMPL 3 OF SIGNAL B
  i4        =  0.304044017                        ;SMPL 4 OF SIGNAL B
  i5        =  0.304044017                        ;SMPL 5 OF SIGNAL B
  i6        =  0.153256114                        ;SMPL 6 OF SIGNAL B
  i7        =  0.032279228                        ;SMPL 7 OF SIGNAL B
  i8        =  0.002177629                        ;SMPL 8 OF SIGNAL B
  a1        soundin   "fox.aif"                   ;signal a
  a2        delay1    a1
  a3        delay1    a2
  a4        delay1    a3
  a5        delay1    a4
  a6        delay1    a5
  a7        delay1    a6
  a8        delay1    a7
            out       i1*a1+i2*a2+i3*a3+i4*a4+i5*a5+i6*a6+i7*a7+i8*a8
endin

instr 2                                   ;fft convolution
  a1        soundin   "fox.aif"                   ;signal a
  a2        convolve  a1,"eightpoint.con"         ;signal b, use cvanal to make
            out       a2*p4                       ;p4 is scaling factor
endin

