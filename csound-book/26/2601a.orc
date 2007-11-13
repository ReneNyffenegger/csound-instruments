
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     1         ; DIRECTCONVOLUTION
  i1        =  0.002177629                        ;smpl 1 of signal b
  i2        =  0.032279228                        ;smpl 2 of signal b
  i3        =  0.153256114                        ;smpl 3 of signal b
  i4        =  0.304044017                        ;smpl 4 of signal b
  i5        =  0.304044017                        ;smpl 5 of signal b
  i6        =  0.153256114                        ;smpl 6 of signal b
  i7        =  0.032279228                        ;smpl 7 of signal b
  i8        =  0.002177629                        ;smpl 8 of signal b
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

instr     2         ;FFT CONVOLUTION
  a1        soundin   "fox.aif"                   ;signal a
  a2        convolve  a1,"eightpoint.con"         ; SIGNAL B, USE cvanal TO MAKE
            out       a2*p4                       ; p4 IS SCALING FACTOR
endin                              
