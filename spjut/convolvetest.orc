  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;--------------------------------------------------
instr     7                   ; DIRECT IMPLEMENTATION TEST
  iharm     =  int(44100/(p4)/2)-1
  abuzz     linseg    0,0.45*p3,0,0.1*p3,10000,0.44*p3,10000,0.01*p3,0,1,0
  aran      linseg    0,0.01*p3,10000,0.44*p3,10000,0.1*p3,0,1,0
  a2        buzz      abuzz,p4,iharm,1,-1
  a3        trirand   1
  a4        =  a2+a3*aran
  a5        reson     a4,sr/100,sr/5000           ; SAME SETTINGS AS TEST IMPULSE
  a6        balance   a5,abuzz+aran
            out       a6                       
            display   a6,p3/5                     ; DISPLAY THE IMPULSE RESPONSE
            dispfft   a6,p3/5,4096,0,1            ; FREQUENCY RESPONSE
endin
;--------------------------------------------------
instr 8                       ; CONVOLUTION TEST
  iharm     =  int(44100/(p4)/2)-1
  abuzz     linseg    0,0.45*p3,0,0.1*p3,10000,0.44*p3,10000,0.01*p3,0,1,0
  aran      linseg    0,0.01*p3,10000,0.44*p3,10000,0.1*p3,0,1,0
  ahalt     linseg    0,8192/44100,0,0.001,1,p3,1
  a2        buzz      abuzz, p4,iharm,1,-1
  a3        trirand   1
  a4        =  (a2+a3*aran)/1.1
  a5        convolve  a4,"reson_100_5000.con"     ; USE cvanal TO MAKE
  adely     delay     abuzz+aran,8192/sr
  a6        balance   a5,adely
            out       a6        
            display   a6,p3/5                     ; DISPLAY THE IMPULSE RESPONSE
            dispfft   a6,p3/5, 4096, 0, 1         ; 
          
endin
