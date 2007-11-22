;FIGURE 4.30
;WAVESHAPER DRUM

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1
  i2        =  cpspch(p4)
;
; SCALING FACTOR CODE
;
  a1        linseg    0,.01,.5,.03,.5,.02,.7,p3-.21,.7,.15,1
;
; AUDIO CODE
;
  a2        linseg    0,.04,1,.02,.7,p3-.23,.6,.15,0
  a4        oscili    a2,p4,1
;
;
;
; IN LINE CODE FOR TRANSFER FUNCTION:
; f(x)         =         .03667*x^12+.02791*x^11-.09983*x^10-.07557*x^9+.11342*x^8+.08414*x^7
;                        -.06547*x^6-.02972*x^5+.06308*x^4+.02060*x^3-.00508*x^2+.03052*x
  a5        =  a4*a4
  a6        =  a5*a4
  a7        =  a5*a5
  a8        =  a7*a4
  a9        =  a6*a6
  a10       =  a9*a4
  a11       =  a10*a4
  a12       =  a11*a4
  a14       =  a12*a5                             ;x^11
;
  a13       =  20.48*a14-43.52*a12+12.8*a11+40.32*a10-16*a9-17.44*a8+7.2*a7+3.6*a6
  a13       =  -1.8*a5-1.27*a4-.3+a13
;
  a1        =  a13*a1*p5
;
            out       a1
;
endin
