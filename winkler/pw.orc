;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;copyright 1998 Paul M. Winkler, zarmzarm@erols.com
;****++++
;**** Last modified: Wed Dec    9 20:32:30 1998
;****----
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
;SIMULATED PULSE WIDTH MODULATION

;THIS WORKS! BUT P5 SHOULD BE HANDLED BETTER.
  ipitch    =  cpspch (p4)
  aindex    phasor    ipitch

; MAKE THE WIDTH (P5) 'FEEL' A LITTLE NICER -- AN EXPONENTIAL CURVE FROM 
; FTLEN/2 TO FTLEN, CONTROLLED BY A LINEAR PERCENTAGE (0 TO 100).
; THIS IS NOT GREAT: P5 LESS THAN ABOUT 10 IS TOO SMALL!

  ilength   =  ftlen(1) 
  inum      =  p5 * p5 * .0001                    ; normalize it to 0 - 1

; POW WOULD BE A BETTER SOLUTION, BUT IT'S BROKEN IN MY CSOUND VERSION?

  irange    =  ( ilength + ( inum * ilength )) * .5
  aindex    =  aindex * irange
            print     irange
; DISPLAY         AINDEX, .1                                        
  aout      table     aindex, 1                   ;  use f1
            out       aout 
endin 

instr 2
; Same thing, only pulse width is controlled by an envelope.
  ipitch    =  cpspch (p4)
  aindex    phasor    ipitch
  ilength   =  ftlen(1) 
  krange    expseg    ilength * .5, p3 * .5, ilength, p3 * .5, ilength * .5
  aindex    =  aindex * krange
  aout      table     aindex, 1                   ;  table 1
            out       aout 
endin
