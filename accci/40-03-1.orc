; ************************************************************************
; ACCCI:      40-03-1.ORC
; synthesis:  Waveshaping(40)
;             Waveshaper Using Ring Modulation(03)
; source:     Dodge (p.145, 1985)
; coded:      jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq       =  cpspch(p5)

  a1        oscili    iamp, 1/idur, 31            ; envelope
  a2        oscili    a1, ifq, 1                  ; sinus of ring modulation

  a3        linseg    1, .04, 0, idur-.04, 0      ; very short envelope
  a4        oscili    a3, ifq*.7071, 1            ; sinus for waveshaper

   ; inline code for transfer function:
   ; f(x) = 1 + .841x - .707x**2 - .595x**3 + .5x**4 + .42x**5 -
   ;                      .354x**6 - .279x**7 + .25x**8 + .21x**9

  a5        =  a4*a4
  a6        =  a5*a4
  a7        =  a5*a5
  a8        =  a7*a4
  a9        =  a6*a6
  a10       =  a9*a4
  a11       =  a10*a4
  a12       =  a11*a4

   ; This is the polynomial representation of the transfer function

  
  a13       =  1+.841*a4-.707*a5-.595*a6+.5*a7+.42*a8-.354*a9-.297*a10+.25*a11+.21*a12

  a14       =  a13*a2                             ; ring modulation
            outs      a14,a14

endin
