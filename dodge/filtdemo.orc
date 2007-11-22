  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;==============================================================================;
;      This orc implements some of the example filters given in Dodge          ;
;                                                                              ;
; Note that the kr = sr in this orchestra.  This is necessary because none of  ;
; the recursive filters (instrs 7, 8, and 9) will work otherwise.  RFP         ;
;==============================================================================;
;
instr 1                 ; UNMODIFIED PLAYBACK INSTRMENT FOR COMPARISON
  kgate     expseg    1,p3*.9,1,p3*.1,.001
  ainput    soundin   p4
            out       ainput*kgate
endin

;==============================================================================;
;       Non-recursive, all-zero, Finite Impulse Response (FIR) filters:
;==============================================================================;

instr 2                 ; 1st-ORDER LOW-PASS FILTER FROM DODGE SECOND EDITION p.201
  igain     =  (p5 != 0 ? p5 : 1)
  kgate     expseg    igain,p3*.9,igain,p3*.1,.001
  ainput    soundin   p4
  aprev     delay1    ainput                      ; NOISE SIGNAL DELAYED 1 SAMPLE
  asignal   =  .5*ainput + .5*aprev               ; AVERAGE 2 SUCCESSIVE INPUTS
            out       asignal*kgate
endin

instr 3                 ; 1st-ORDER HIGH-PASS FILTER - DODGE SECOND EDITION p.202
  igain     =  (p5 != 0 ? p5 : 1)
  kgate     expseg    igain,p3*.9,igain,p3*.1,.001
  ainput    soundin   p4
  aprev     delay1    ainput                      ; NOISE SIGNAL DELAYED 1 SAMPLE
  asignal   =  .5*ainput - .5*aprev               ; DIFFERENCE OF 2 INPUTS
            out       asignal*kgate
endin

instr 4                 ; 2nd-ORDER NOTCH FILTER - DODGE SECOND EDITION p.202
  igain     =  (p5 != 0 ? p5 : 1)
  kgate     expseg    igain,p3*.9,igain,p3*.1,.001
  ainput    soundin   p4                          ; x(n)
  aprev1    delay1    ainput                      ; x(n-1)
  aprev2    delay1    aprev1                      ; x(n-2)
  asignal   =  .5*ainput + .5*aprev2              ; y(n) = .5x(n) - .5x(n-2)
            out       asignal*kgate
endin

instr 5                 ; 2nd-ORDER BAND-PASS FILTER - DODGE SECOND EDITION p.203
  igain     =  (p5 != 0 ? p5 : 1)
  kgate     expseg    igain,p3*.9,igain,p3*.1,.001
  ainput    soundin   p4                          ; x(n)
  aprev1    delay1    ainput                      ; x(n-1)
  aprev2    delay1    aprev1                      ; x(n-2)
  asignal   =  .5*ainput - .5*aprev2              ; y(n) = .5x(n) - .5x(n-2)
            out       asignal*kgate
endin

instr 6       ; 2nd-ORDER ALL-ZERO BR FILTER - DODGE SECOND EDITION p.203-205
  igain     =  (p7 != 0 ? p7 : 1)
; CALCULATE THE COEFFICIENTS FROM cf AND bw IN p5 AND p6
  i2pi      =  6.2831853
  ibw       =  p6
  icf       =  p5
  ic2       =  exp(-i2pi*ibw/sr)
  ic1       =  (-4*ic2/(1 + ic2))*cos(i2pi*icf/sr)
  iscl      =  1 + ic1 + ic2
  ia0       =  1/iscl
  ia1       =  ic1/iscl
  ia2       =  ic2/iscl
  kgate     expseg    igain,p3*.9,igain,p3*.1,.001
  ainput    soundin   p4                          ; x(n)
  aprev1    delay1    ainput                      ; x(n-1)
  aprev2    delay1    aprev1                      ; x(n-2)
                                                                        ; y(n) = a0x(n) + a1x(n-1) + a2x(n-2)
  asignal   =  ia0*ainput + ia1*aprev1 + ia2*aprev2
            out       asignal*kgate
endin


;==============================================================================;
;       Recursive, all-pole, Infinite Impulse Response (IIR) filters:
;==============================================================================;

instr 7                 ; 1st-ORDER RECURSIVE FILTER - DODGE SECOND EDITION p.209-211
  igain     =  (p6 != 0 ? p6 : 1)
; CALCULATE THE COEFFICIENTS FOR LOW-PASS FILTER FROM THE CUTOFF FREQ (p5):
  i2pi      =  6.2831853
  ifc       =  p5
  ic        =  2 - cos(i2pi*ifc/sr)
  ib        =  sqrt(ic*ic - 1) - ic
  ia        =  1 + ib
  kgate     expseg    igain,p3*.9,igain,p3*.1,.001
  aoutput   init      0                           ; init y(n-1) to 0
  ainput    soundin   p4                          ; x(n)
  aoutput   =  ia*ainput - ib*aoutput             ; y(n) = ia*x(n) - ib*y(n-1)
            out       aoutput*kgate
endin

instr 8
  igain     =  (p6 != 0 ? p6 : 1)
; CALCULATE THE COEFFICIENTS FOR HIGH-PASS FILTER FROM THE CUTOFF FREQ (p5):
  i2pi      =  6.2831853
  ifc       =  p5
  ic        =  2 - cos(i2pi*ifc/sr)
  ib        =  ic - sqrt(ic*ic - 1)
  ia        =  1 - ib
  kgate     expseg    igain,p3*.9,igain,p3*.1,.001
  aoutput   init      0                           ; init y(n-1) to 0
  ainput    soundin   p4                          ; x(n)
  aoutput   =  ia*ainput - ib*aoutput             ; y(n) = ia*x(n) - ib*y(n-1)
            out       aoutput*kgate
endin

instr 9                 ; 2nd-ORDER ALL-POLE FILTER - DODGE SECOND EDITION p. 211-212
  igain     =  (p8 == 0 ? 1 : p8)
; CALCULATE THE COEFFICIENTS FOR BAND-BASS FILTER FROM cf AND bw IN p5, p6:
  i2pi      =  6.2831853
  icf       =  p5
  ibw       =  p6
  ib2       =  exp(-i2pi*ibw/sr)
  ib1       =  -4*ib2/(1 + ib2) * cos(i2pi * icf/sr)
  ib1sqrd   =  ib1*ib1
  ib2sqrd   =  (1+ib2)*(1+ib2)
  iscl1     =  (1 - ib2)*sqrt(1-ib1sqrd/(4*ib2))
  iscl2     =  sqrt((ib2sqrd-ib1sqrd) * ((1 - ib2)/(1 + ib2)))
  iscl      =  (p7 == 1 ? iscl1 : iscl2)          ; 1 = PITCH, 2 = NOISE
  kgate     expseg    igain,p3*.9,igain,p3*.1,.001
  aprev1    init      0                           ; init y(n-1) to 0
  aprev2    init      0                           ; init y(n-2) to 0
  ainput    soundin   p4                          ; x(n)
                                                                        ; y(n) = a0x(n) - b1y(n-1) - b2y(n-2)
  aoutput   =  iscl*ainput - ib1*aprev1 - ib2*aprev2
  aprev2    =  aprev1
  aprev1    =  aoutput
            out       aoutput*kgate
endin

