
;;;; *************** Drums and Different Canons *************
;;;;
;;;; Orchestra file for Grunenberg

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gasnd     init      0

instr 4,5

;Start  dur     baseamp ampinc  Noise/cps       loc       Timbre
;p2     p3      p4      p5      p6              p7        p8
; The only difference between the two drums here is the base frequency

if p1==5 igoto high
        ;; Instrument 4
  i2        =  cpspch(p8)                         ; 11; 12.5
            igoto     common

high:
   ;; Instrument 5
  i2        =  cpspch(20)

common:
  i1        =  1/p3                               ; once per duration - for envelopes
  i3        =  (p4+p5)                            ; these three assignments balance the three
  i4        =  (p4+p5)/3                          ; branches of the drum instrument
  i5        =  (p4+p5)/2.1                        ;

                                ; branch 1 - NOISE
  a1        oscili    i3,i1,2                     ; generate steep exponential envelope
  a1        randi     a1,p6/2                     ; generate band of noise with freq. given by p5
  a1        oscili    a1,500,4                    ; use noise band for amp input - ring mod.

                                ; branch 2 - INHARM
  a2        oscili    i4,i1,2                     ; steep envelope with lower amplitude than a1
  a2        oscili    a2,i2*.1,3                  ; generate inharmonic partials - 1,1.6,2.2,2.3

                                ; branch 3 - FUND
  a3        oscili    i5,i1,1                     ; decay of f1 is less steep than f2
  a3        oscili    a3,i2,4                     ; generates fundamental tone

                                ; global envelope to prevent clicking
  a4        linseg    1,p3-.05,1,.05,0,.01,0
  a5        =  a4*(a1+a2+a3)
  a6        =  a5*p7
  a7        =  a5*(1-p7)
            outs      a6, a7
        ;; Delay these signals to provide a little of the effect
  a8        delay1    a7*p7
  a9        delay1    a7*(1-p7)
            outs      a8, a9
  gasnd     =  gasnd + a5 * 0.25
endin

instr 6
;; The parameter i2 seems to control basic sound type
;;              15.2 has a metalic ring 15.1 is more wooden
;;              15.0 is rather like 15.1
  i2        =  cpspch(15.1+p5/1000)
  i1        =  1/p3                               ; once per duration - for envelopes
  i3        =  p4                                 ; these three assignments balance the three
  i4        =  p4                                 ; branches of the drum instrument
  i5        =  p4/6.25
                                ; branch 1 - NOISE
  a1        oscili    i3,i1,2                     ; generate steep exponential envelope
  a1        randi     a1,p5/2                     ; generate band of noise with freq. given by p5
  a1        oscili    a1,500,4                    ; use noise band for amp input - ring mod.

                                ; branch 2 - INHARM
  a2        oscili    i4,i1,2                     ; steep envelope with lower amplitude than a1
  a2        oscili    a2,i2*.2,3                  ; generate inharmonic partials - 1,1.6,2.2,2.3

                                ; branch 3 - FUND
  a3        oscili    i5,i1,1                     ; decay of f1 is less steep than f2
  a3        oscili    a3,i2,4                     ; generates fundamental tone

                                ; global envelope to prevent clicking
  a4        linseg    1,p3-.05,1,.05,0,.01,0
  a5        =  a4*(a1+a2+a3)
  a6        =  a5*p6
  a7        =  a5*(1-p6)
            outs      a6, a7
        ;; Delay these signals to provide a little of the effect
  a8        delay1    a7*p6
  a9        delay1    a7*(1-p6)
            outs      a8, a9
  gasnd     =  gasnd + a5 * 0.1
endin

instr   99
  asig      reverb    gasnd, p4
            outs      asig, asig
  gasnd     =  0
endin


