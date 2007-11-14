;;;; *************** DRUMS AND DIFFERENT CANONS *************
;;;;
;;;; ORCHESTRA FILE FOR PRELUDE
;;;;
          
sr        =         44100
kr        =         441
ksmps     =         100
nchnls    =         2

gasnd     init      0

          instr 4,5
; START  DUR     BASEAMP AMPINC  NOISE/CPS       LOC       TIMBRE
;P2     P3      P4      P5      P6              P7        P8
; THE ONLY DIFFERENCE BETWEEN THE TWO DRUMS HERE IS THE BASE FREQUENCY

          if        p1 == 5 igoto high
;; INSTRUMENT 4
i2        =         cpspch(p8) ; 11; 12.5
          igoto     common
high:   ;; INSTRUMENT 5
i2        =         cpspch(20)

common:
i1        =         1/p3             ; ONCE PER DURATION - FOR ENVELOPES
i3        =         (p4+p5)          ; THESE THREE ASSIGNMENTS BALANCE THE THREE
i4        =         (p4+p5)/3        ; BRANCHES OF THE DRUM INSTRUMENT
i5        =         (p4+p5)/2.1           ;

                                     ; BRANCH 1 - NOISE
a1        oscili     i3,i1,2         ; GENERATE STEEP EXPONENTIAL ENVELOPE
a1        randi      a1,p6/2         ; GENERATE BAND OF NOISE WITH FREQ. GIVEN BY P5
a1        oscili     a1,500,4        ; USE NOISE BAND FOR AMP INPUT - RING MOD.

                                     ; BRANCH 2 - INHARM
a2        oscili     i4,i1,2         ; STEEP ENVELOPE WITH LOWER AMPLITUDE THAN A1
a2        oscili     a2,i2*.1,3      ; GENERATE INHARMONIC PARTIALS - 1,1.6,2.2,2.3

                                     ; BRANCH 3 - FUND
a3        oscili     i5,i1,1         ; DECAY OF F1 IS LESS STEEP THAN f2
a3        oscili     a3,i2,4         ; GENERATES FUNDAMENTAL TONE

                                     ; GLOBAL ENVELOPE TO PREVENT CLICKING
a4        linseg     1,p3-.05,1,.05,0,.01,0
a5        =         a4*(a1+a2+a3)
a6        =         a5*p7
a7        =         a5*(1-p7)
          outs      a6, a7
;; DELAY THESE SIGNALS TO PROVIDE A LITTLE OF THE EFFECT
a8        delay1    a7*p7
a9        delay1    a7*(1-p7)
          outs      a8, a9
gasnd     =         gasnd + a5 * 0.25
          endin

          instr 6
;; THE PARAMETER I2 SEEMS TO CONTROL BASIC SOUND TYPE
;;              15.2 HAS A METALIC RING 15.1 IS MORE WOODEN
;;              15.0 IS RATHER LIKE 15.1
i2        =         cpspch(15.1+p5/1000)
i1        =         1/p3                ; ONCE PER DURATION - FOR ENVELOPES
i3        =         p4                  ; THESE THREE ASSIGNMENTS BALANCE THE THREE
i4        =         p4                  ; BRANCHES OF THE DRUM INSTRUMENT
i5        =         p4/6.25
                                        ; BRANCH 1 - NOISE
a1        oscili     i3,i1,2            ; GENERATE STEEP EXPONENTIAL ENVELOPE
a1        randi      a1,p5/2            ; GENERATE BAND OF NOISE WITH FREQ. GIVEN BY P5
a1        oscili     a1,500,4           ; USE NOISE BAND FOR AMP INPUT - RING MOD.

                                        ; BRANCH 2 - INHARM
a2        oscili     i4,i1,2            ; STEEP ENVELOPE WITH LOWER AMPLITUDE THAN A1
a2        oscili     a2,i2*.2,3         ; GENERATE INHARMONIC PARTIALS - 1,1.6,2.2,2.3

                                        ; BRANCH 3 - FUND
a3        oscili     i5,i1,1            ; DECAY OF F1 IS LESS STEEP THAN F2
a3        oscili     a3,i2,4            ; GENERATES FUNDAMENTAL TONE

                                        ; GLOBAL ENVELOPE TO PREVENT CLICKING
a4        linseg     1,p3-.05,1,.05,0,.01,0
a5        =         a4*(a1+a2+a3)
a6        =         a5*p6
a7        =         a5*(1-p6)
          outs a6, a7

;; DELAY THESE SIGNALS TO PROVIDE A LITTLE OF THE EFFECT
a8        delay1    a7*p6
a9        delay1    a7*(1-p6)
          outs      a8, a9
gasnd     =         gasnd + a5 * 0.1
          endin

          instr 10
          
; SIMPLE MARIMBA
; p4=pch p5=amp p6=bias

i5        =         p5+800
i1        =         cpsoct(p4)
i2        =         log(i1)/10.0 - p6
k1        expseg    .0001,.03,i5,p3-.03,.001  ; ENV
k25       linseg     1,.03,1,p3-.03,3
k1        =          k25*k1
k10       linseg     2.25,.03,3,p3-.03,2     ; POWER TO PARTIALS
a1        gbuzz      k1,i1,k10,0,35,4
a2        reson      a1,500,50,1             ; FILT
a3        reson      a2,1500,100,1           ; FILT
a4        reson      a3,2500,150,1           ; FILT
a5        reson      a4,3500,150,1           ; FILT
a6        balance   a5,a1
i6        =         p6
ga7       =         a6*i2
ga8       =         a6*(1-i2)
;;        display   a6, 0.25
          outs      ga7,ga8
gasnd     =         gasnd + a6 * 0.1
;;        out  a6
          endin

          instr   99
asig      reverb    gasnd, p4
          outs      asig, asig
gasnd     =         0
          endin

