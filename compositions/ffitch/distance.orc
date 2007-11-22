;;;; *************** Drums and Different Canons *************
;;;;
;;;; Orchestra file for distant harmonies
;;;;

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

  gasnd1    init      0
  gasnd2    init      0

;;;;    Instrument 1:   Basic drum
;;;;
;;;;  This is a glissando version of the drums

instr 1,2
  i2        =  cpsoct(p4)                         ; Base frequency        
  i3        =  cpsoct(p5)                         ; end frequency
  k1        line      i2,p3,i3                    ; glissando frequency
  i1        =  1/p3                               ; once per duration - for envelopes
  i6        =  (p6)                               ; these three assignments balance the three
  i4        =  (p6)/3                             ; branches of the drum instrument
  i5        =  (p6)/2.1                           ;

                                ; branch 1 - NOISE
  a1        oscili    i6,i1,2                     ; generate steep exponential envelope
  a1        randi     a1,i2/2                     ; generate band of noise with freq. given by p5
  a1        oscili    a1,500,4                    ; use noise band for amp input - ring mod.

                                ; branch 2 - INHARM
  a2        oscili    i4,i1,2                     ; steep envelope with lower amplitude than a1
  a2        oscili    a2,i2*.1,3                  ; generate inharmonic partials - 1,1.6,2.2,2.3

                                ; branch 3 - FUND
  a3        oscili    i5,i1,1                     ; decay of f1 is less steep than f2
  a3        oscili    a3,k1,4                     ; generates fundamental tone

                                ; global envelope to prevent clicking
  a4        linseg    1,p3-.05,1,.05,0,.01,0
  a5        =  a4*(a1+a2+a3)
;;      display a5, p3
  a6        =  a5*p7
  a7        =  a5*(1-p7)
            outs      a6, a7
  gasnd1    =  gasnd1 + a6 * 0.2
  gasnd2    =  gasnd2 + a7 * 0.2
endin

instr 80
;Start  dur     start   final   amp     loc
;p2     p3      p4      p5      p6      p7
  i1        =  cpsoct(p4)                         ; Start frequency       
  i2        =  cpsoct(p5)                         ; end frequency
  kglis     line      i1,p3,i2                    ; glissando frequency
  k1        expseg    .0001,4.0,p6,p3-4.0,.001    ;env
  k25       linseg    1,4.0,1,p3-4.0,3
  k1        =  k25*k1
  k10       linseg    2.25,4.0,3,p3-4.0,2         ;power to partials
  a1        gbuzz     k1,kglis,k10,0,35,4
  a2        reson     a1,500,50,1                 ;filt
  a3        reson     a2,1500,100,1               ;filt
  a4        reson     a3,2500,150,1               ;filt
  a5        reson     a4,3500,150,1               ;filt
  a6        balance   a5,a1
  a7        =  a6*p7
  a8        =  a6*(1-p7)
            outs      a7,a8
  gasnd1    =  gasnd1 + a7 * 0.2
  gasnd2    =  gasnd2 + a8 * 0.2

endin

instr 4
;Start  dur     Base    tenor   amp     loc
;p2     p3      p4      p5      p6      p7
  i2        =  cpsoct(p4)                         ; Base frequency        
  i3        =  cpsoct(p5)                         ; Tenor frequency
  i1        =  1/p3                               ; once per duration - for envelopes
  i6        =  (p6)                               ; these three assignments balance the three
  i4        =  (p6)/3                             ; branches of the drum instrument
  i5        =  (p6)/2.1                           ;

                                ; branch 1 - NOISE
  a1        oscili    i6,i1,2                     ; generate steep exponential envelope
  a1        randi     a1,i2/2                     ; generate band of noise with freq. given by p5
  a1        oscili    a1,500,4                    ; use noise band for amp input - ring mod.

                                ; branch 2 - INHARM
  a2        oscili    i4,i1,2                     ; steep envelope with lower amplitude than a1
  a2        oscili    a2,i2*.1,3                  ; generate inharmonic partials - 1,1.6,2.2,2.3

                                ; branch 3 - FUND
  a3        oscili    i5,i1,1                     ; decay of f1 is less steep than f2
  a3        oscili    a3,i3,4                     ; generates fundamental tone

  a8        oscili    i5,i1,1                     ; decay of f1 is less steep than f2
  a8        oscili    a3,i2,4                     ; generates fundamental tone

                                ; global envelope to prevent clicking
  a4        linseg    1,p3-.05,1,.05,0,.01,0
  a5        =  a4*(a1+a2+a3)
  a6        =  a5*p7
  a7        =  a5*(1-p7)
            outs      a6, a7
  gasnd1    =  gasnd1 + a6 * 0.125
  gasnd2    =  gasnd2 + a7 * 0.125
endin

instr   99
  asig1     reverb    gasnd1, p4
  asig2     reverb    gasnd2, p4
            outs      asig1, asig2
  gasnd     =  0
endin


