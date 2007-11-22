;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; COPYRIGHT 1998 PAUL M. WINKLER, ZARMZARM@EROLS.COM
; LAST MODIFIED: MON DEC 14 03:52:13 1998
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gkLFO     init      0
  gkamp     init      0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; WE SIMULATE A SQUARE WAVE BY OVERDRIVING A TABLE INDEX, 
; AND SIMULATE PWM BY VARYING AN OFFSET TO THE INDEX.
; ALIASING IS REDUCED BY MAKING THE AMOUNT OF OVERDRIVE 
; INVERSELY PROPORTIONAL TO PITCH.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 5
  ipitch    =  cpspch(p4)
  ianti_alias  =      10                          ; RECOMMENDED RANGE IS 4 TO ABOUT 30
  isquareness  =      sr/(ipitch * ianti_alias) 

; INFINITE isquareness YIELDS A SQUARE WAVE 
; isquareness < 1  YIELDS A SINE

  knarrowness  =      gkLFO * isquareness
  aindex    oscil     isquareness, ipitch, 1      ; SINE WAVE INDEX
  aindex    =  aindex + knarrowness
  aout      table     aindex, 5, 1, 0             ; f5 SHOULD BE STRAIGHT LINE +- 1
  aout      dcblock   aout
  kamp      adsr      .01, .02, .5, .2
  kamp      =  kamp*32000*gkamp
            out       aout*kamp
endin

instr 98                                ; GLOBAL FADES - P4 IS RISE AND DECAY TIME
  gkamp     expseg    0.005, p4, 1, (p3 - (p4 * 2)), 1, p4, 0.005
endin

instr 99                                ; GLOBAL LFO
  klfo      linseg    p4, p3, p5                  ; RAMP FROM P4 TO P5
  gkLFO     oscil     0.5, klfo, 1                ; USE F1
  gkLFO     =  gkLFO + 0.5                        ; RANGE FROM 0 TO 1
endin
