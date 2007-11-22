  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
instr          1
; WAVESHAPER DRUM (P145)
  i1        =  1/p3
  i2        =  cpspch(p4)
;
;SCALING FACTOR CODE
;
  a1        oscili    p5,i1,2
  a2        oscili    a1,i2,3
;
; AUDIO CODE
;
  a3        linseg    1,.04,0,p3-.04,0
  a4        oscili    a3,i2*.7071,3
;
;
; INLINE CODE FOR TRANSFER FUNCTION:
; f(x)=1+.841x-.707x**2-.595x**3+.5x**4+.42x**5-.354x**6-.279x**7+.25x**8+.21x**9
;
  a5        =  a4*a4
  a6        =  a5*a4
  a7        =  a5*a5
  a8        =  a7*a4
  a9        =  a6*a6
  a10       =  a9*a4
  a11       =  a10*a4
  a12       =  a11*a4
;
  a13       =  1+.841*a4-.707*a5-.595*a6+.5*a7+.42*a8-.354*a9-.297*a10+.25*a11+.21*a12
;
  a14       =  a13*a2
;
            out       a14
;
endin
