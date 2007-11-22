; DRUM.O
; THIS IS THE CSOUND CODE FOR THE DRUM INSTRUMENT BASED ON
; RISSET'S INTRODUCTORY CATALOG OF COMPUTER SYNTHESIZED SOUNDS
; SEE PP.93-94 AND FIGURE 3.26 IN "COMPUTER MUSIC" - DODGE

instr 1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01
  p3        =  1                                  ; INITIALIZATION
  i1        =  1/p3                               ; ONCE PER DURATION - FOR ENVELOPES
  i3        =  23000/2                            ; THESE THREE ASSIGNMENTS BALANCE THE THREE
  i4        =  23000/6                            ; BRANCHES OF THE DRUM INSTRUMENT
  i5        =  3000/2.5

                                                            ; BRANCH 1 - NOISE
  a1        oscili    i3,i1,2                     ; GENERATE STEEP EXPONENTIAL ENVELOPE
  a1        randi     a1,400                      ; GENERATE BAND OF NOISE WITH FREQ. GIVEN BY P6
  a1        oscili    a1,500,4                    ; USE NOISE BAND FOR AMP INPUT - RING MOD.

                                                            ; BRANCH 2 - INHARM
  a2        oscili    i4,i1,2                     ; STEEP ENVELOPE WITH LOWER AMPLITUDE THAN A1
  a2        oscili    a2,knote*.1,3               ; GENERATE INHARMONIC PARTIALS - 1,1.6,2.2,2.3

                                                            ; BRANCH 3 - FUND
  a3        oscili    i5,i1,1                     ; DECAY OF F1 IS LESS STEEP THAN F2
  a3        oscili    a3,knote,4                  ; GENERATES FUNDAMENTAL TONE

                                                            ; GLOBAL ENVELOPE TO PREVENT CLICKING
  a4        linseg    1,p3-.05,1,.05,0,.01,0
            out       (a4*(a1+a2+a3))*kgate
endin
