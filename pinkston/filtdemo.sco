; Demo score for filtdemo.orc
; The original sound
i1  0  1.13   1                         ;soundin 1
; Simple moving average filter  (low-pass with Fc at SR/4)
i2  1.5       1.13   1      0    
; Simple difference filter (high-pass with Fc at SR/4)
i3  3  1.13   1      15   
; Second-order notch filter (null at SR/4, flat at 0 & Nyquist)
i4  4.5       1.13   1      .75  
; Second-order band-pass filter
i5  6  1.13   1      10   
; Second-order notch with variable cf and bw
i6  7.5       1.13   1      1000   100    1  
; First-order recursive filter with lowpass characteristic (p5 = cutoff)
i7  9  1.13   1      100    2  
; First-order recursive filter with highpass characteristic (p5 = cutoff)
i8  10.5      1.13   1      500    10 
; Second-order all-pole filter (p5 = cf, p6 = bw)
i9  12 1.13   1      300    30     1      4    
f0  14
s
; The original sound
i1  0  1.13   2                         ;soundin 2
; Simple moving average filter  (low-pass with Fc at SR/4)
i2  1.5       1.13   2      0    
; Simple difference filter (high-pass with Fc at SR/4)
i3  3  1.13   2      7    
; Second-order notch filter (null at SR/4, flat at 0 & Nyquist)
i4  4.5       1.13   2      0    
; Second-order band-pass filter
i5  6  1.13   2      5    
; Second-order notch with variable cf and bw
i6  7.5       1.13   2      1000   100    .5 
; First-order recursive filter with lowpass characteristic (p5 = cutoff)
i7  9  1.13   2      100    3  
; First-order recursive filter with highpass characteristic (p5 = cutoff)
i8  10.5      1.13   2      500    10 
; Second-order all-pole filter (p5 = cf, p6 = bw)
i9  12 1.13   2      500    50     1      2    
f0  14
s
; The original sound
i1  0  1.13   3                         ;soundin 3
; Simple moving average filter  (low-pass with Fc at SR/4)
i2  1.5       1.13   3      0    
; Simple difference filter (high-pass with Fc at SR/4)
i3  3  1.13   3      1    
; Second-order notch filter (null at SR/4, flat at 0 & Nyquist)
i4  4.5       1.13   3      1    
; Second-order band-pass filter
i5  6  1.13   3      1    
; Second-order notch with variable cf and bw
i6  7.5       1.13   3      1000   100    .025
; First-order recursive filter with lowpass characteristic (p5 = cutoff)
i7  9  1.13   3      100    5  
; First-order recursive filter with highpass characteristic (p5 = cutoff)
i8  10.5      1.13   3      500    3  
; Second-order all-pole filter (p5 = cf, p6 = bw)
i9  12 1.13   3      500    100    2      .75  
e
