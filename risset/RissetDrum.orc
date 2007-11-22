; drum.o
; This is the Csound code for the Drum Instrument based on
; Risset's Introductory Catalog of Computer Synthesized Sounds
; see pp.93-94 and figure 3.26 in "Computer Music" - Dodge

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
                                             ; INITIALIZATION
  i1        =  1/p3                               ; ONCE PER DURATION - FOR ENVELOPES
  i2        =  cpspch(p4)                         ; CONVERT OCT. POINT PCH-CLASS NOTATION TO Hz
  i3        =  p5/2                               ; THESE THREE ASSIGNMENTS BALANCE THE THREE
  i4        =  p5/6                               ; BRANCHES OF THE DRUM INSTRUMENT
  i5        =  p5/2.5

                                             ; BRANCH 1 - NOISE
  a1        oscili    i3,i1,2                     ; GENERATE STEEP EXPONENTIAL ENVELOPE
  a1        randi     a1,p6                       ; GENERATE BAND OF NOISE WITH FREQ. GIVEN BY p6
  a1        oscili    a1,500,4                    ; USE NOISE BAND FOR AMP INPUT - RING MOD.

                                             ; BRANCH 2 - INHARM
  a2        oscili    i4,i1,2                     ; STEEP ENVELOPE WITH LOWER AMPLITUDE THAN a1
  a2        oscili    a2,i2*.1,3                  ; GENERATE INHARMONIC PARTIALS - 1,1.6,2.2,2.3

                                             ; BRANCH 3 - FUND
  a3        oscili    i5,i1,1                     ; DECAY OF f1 IS LESS STEEP THAN f2
  a3        oscili    a3,i2,4                     ; GENERATES FUNDAMENTAL TONE

                                             ; GLOBAL ENVELOPE TO PREVENT CLICKING
  a4        linseg    1,p3-.05,1,.05,0,.01,0
            out       a4*(a1+a2+a3)
endin
