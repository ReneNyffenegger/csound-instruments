;;;; *************** DRUMS AND DIFFERENT CANONS *************
;;;;
;;;; ORCHESTRA FILE FOR DISTANT HARMONIES
;;;;

sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2   

gasnd1  init    0
gasnd2  init    0

;;;;    Instrument 1:   BASIC DRUM
;;;;
;;;;  THIS IS A GLISSANDO VERSION OF THE DRUMS

        instr   1,2
i2      =       cpsoct(p4)              ; BASE FREQUENCY    
i3      =       cpsoct(p5)              ; END FREQUENCY
k1      line    i2,p3,i3                ; GLISSANDO FREQUENCY
i1      =       1/p3                    ; ONCE PER DURATION - FOR ENVELOPES
i6      =       (p6)                    ; THESE THREE ASSIGNMENTS BALANCE THE THREE
i4      =       (p6)/3                  ; BRANCHES OF THE DRUM INSTRUMENT
i5      =       (p6)/2.1

                                        ; BRANCH 1 - NOISE
a1      oscili  i6,i1,2                 ; GENERATE STEEP EXPONENTIAL ENVELOPE
a1      randi   a1,i2/2                 ; GENERATE BAND OF NOISE WITH FREQ. GIVEN BY p5
a1      oscili  a1,500,4                ; USE NOISE BAND FOR AMP INPUT - RING MOD.

                                        ; BRANCH 2 - INHARM
a2      oscili  i4,i1,2                 ; STEEP ENVELOPE WITH LOWER AMPLITUDE THAN a1
a2      oscili  a2,i2*.1,3              ; GENERATE INHARMONIC PARTIALS - 1,1.6,2.2,2.3

                                        ; BRANCH 3 - FUND
a3      oscili  i5,i1,1                 ; DECAY OF f1 IS LESS STEEP THAN f2
a3      oscili  a3,k1,4                 ; GENERATES FUNDAMENTAL TONE

                                        ; GLOBAL ENVELOPE TO PREVENT CLICKING
a4      linseg  1,p3-.05,1,.05,0,.01,0
a5      =       a4*(a1+a2+a3)
;;      display a5, p3
a6      =       a5*p7
a7      =       a5*(1-p7)
        outs    a6, a7
gasnd1  =       gasnd1 + a6 * 0.2
gasnd2  =       gasnd2 + a7 * 0.2
        endin

        instr 80
; START DUR START   FINAL   AMP LOC
; p2    p3  p4       p5     p6  p7
i1      =       cpsoct(p4)              ; START FREQUENCY   
i2      =       cpsoct(p5)              ; END FREQUENCY
kglis   line    i1,p3,i2                ; GLISSANDO FREQUENCY
k1      expseg  .0001,4.0,p6,p3-4.0,.001    ; ENV
k25     linseg  1,4.0,1,p3-4.0,3
k1      =       k25*k1
k10     linseg  2.25,4.0,3,p3-4.0,2     ;POWER TO PARTIALS
a1      gbuzz   k1,kglis,k10,0,35,4
a2      reson   a1,500,50,1     ;filt
a3      reson   a2,1500,100,1   ;filt
a4      reson   a3,2500,150,1   ;filt
a5      reson   a4,3500,150,1   ;filt
a6      balance a5,a1
a7      =       a6*p7
a8      =       a6*(1-p7)
        outs    a7,a8
gasnd1  =       gasnd1 + a7 * 0.2
gasnd2  =       gasnd2 + a8 * 0.2

        endin

        instr 4
; START DUR BASE    TENOR   AMP LOC
; p2    p3  p4       p5      p6 p7
i2      =       cpsoct(p4)          ; BASE FREQUENCY    
i3      =       cpsoct(p5)          ; TENOR FREQUENCY
i1      =       1/p3                ; ONCE PER DURATION - FOR ENVELOPES
i6      =       (p6)                ; THESE THREE ASSIGNMENTS BALANCE THE THREE
i4      =       (p6)/3              ; BRANCHES OF THE DRUM INSTRUMENT
i5      =       (p6)/2.1    

                                    ; BRANCH 1 - NOISE
a1      oscili  i6,i1,2             ; GENERATE STEEP EXPONENTIAL ENVELOPE
a1      randi   a1,i2/2             ; GENERATE BAND OF NOISE WITH FREQ. GIVEN BY p5
a1      oscili  a1,500,4            ; USE NOISE BAND FOR AMP INPUT - RING MOD.

                                    ; BRANCH 2 - INHARM
a2      oscili  i4,i1,2             ; STEEP ENVELOPE WITH LOWER AMPLITUDE THAN a1
a2      oscili  a2,i2*.1,3          ; GENERATE INHARMONIC PARTIALS - 1,1.6,2.2,2.3

                                    ; BRANCH 3 - FUND
a3      oscili  i5,i1,1             ; DECAY OF F1 IS LESS STEEP THAN f2
a3      oscili  a3,i3,4             ; GENERATES FUNDAMENTAL TONE

a8      oscili  i5,i1,1             ; DECAY OF F1 IS LESS STEEP THAN f2
a8      oscili  a3,i2,4             ; GENERATES FUNDAMENTAL TONE

                                    ; GLOBAL ENVELOPE TO PREVENT CLICKING
a4      linseg  1,p3-.05,1,.05,0,.01,0
a5      =       a4*(a1+a2+a3)
a6      =       a5*p7
a7      =       a5*(1-p7)
        outs    a6, a7
gasnd1  =       gasnd1 + a6 * 0.125
gasnd2  =       gasnd2 + a7 * 0.125
        endin

        instr   99
asig1   reverb  gasnd1, p4
asig2   reverb  gasnd2, p4
        outs    asig1, asig2
gasnd   =       0
        endin

