  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;----------------------------------------------------
; Example LPC instruments. These are based partly 
; on one of Richard Karpen's example lpc instruments
; and partly on examples and suggestions posted to
; the Csound list by Eric Spjut. 
; RP
;----------------------------------------------------
instr   1 

; LPC Instrument using GBUZZ as the sound source. It uses the pitch 
; data from the  analysis for the frequecy of the gbuzz.

  ipitscl   =  p4                                 ; pitch scaling factor (1 = no change)
  iampscl   =  p5                                 ; overall amplitude scaling factor
  istart    =  p6                                 ; time in seconds to begin reading lpc file
  iend      =  p7                                 ; time in seconds to end reading lpc file
;iharms         =       int(sr/2/300*ipitscl) ; max n harms (assume 300 hz max)
  iharms    =  int(sr/2/200*ipitscl)              ; max n harms (assume 200 hz max)
  ilpfile   =  p8                                 ; use lpc file lp.p8
  ifadefn   =  p9                                 ; xfade function for voiced/unvoiced transition
  ivoice    =  p10                                ; error threshold for pure voiced sounds
  inoise    =  p11                                ; error threshold for pure unvoiced sounds
  irange    =  inoise - ivoice                    ; range for crossfade   
  inatten   =  1-p12                              ; noise attenuation factor      

  ktime     line      istart, p3, iend            ; time pointer for lpread

;-----------------------------------------------------
  krmsr,krmso,kerr,kcps lpread                    ktime, ilpfile 
;-----------------------------------------------------
; Here we test for the voiced/unvoiced transition:
if      (kerr > ivoice) kgoto next
  kgate     =  1                                  ; pure voiced sound
            kgoto     continue
next:                   
if      (kerr < inoise) kgoto mix
  kgate     =  0                                  ; pure unvoiced sound
            kgoto     continue
mix:
  kgate     tablei    (kerr-ivoice)/irange,ifadefn,1 ; xfade voiced/unvoiced
continue:
  avoice    gbuzz     krmso * kgate, kcps*ipitscl, iharms, 1, .875, 2
  anoise    rand      krmso * (1 - kgate)

;-----------------------------------------------------
  aresynthesis lpreson  avoice+anoise*inatten
;-----------------------------------------------------

  kenv      linen     1, .05, p3, .05

  asig      gain      aresynthesis, krmso*kenv,20     
            out       asig*iampscl
endin   

;============================================================
instr   2 
; LPC Instrument using soundin for the sound source. 
; This is an example of LPC cross synthesis.
; It ignores the pitch data from the analysis

  isound    =  p4                                 ; use soundin.p4
  iampscl   =  p5                                 ; overall amplitude scaling factor
  istart    =  p6                                 ; time in seconds to begin reading lpc file
  iend      =  p7                                 ; time in seconds to end reading lpc file
  ilpfile   =  p8                                 ; use lpc file lp.p8
  ifadefn   =  p9                                 ; xfade function for voiced/unvoiced transition
  ivoice    =  p10                                ; error threshold for pure voiced sounds
  inoise    =  p11                                ; error threshold for pure unvoiced sounds
  irange    =  inoise - ivoice                    ; range for crossfade   

  ktime     line      istart, p3, iend            ; time pointer for lpread

;-----------------------------------------------------
  krmsr,krmso,kerr,kcps lpread                    ktime, ilpfile 
;-----------------------------------------------------
; Here we test for the voiced/unvoiced transition:
if      (kerr > ivoice) kgoto next
  kgate     =  1                                  ; pure voiced sound
            kgoto     continue
next:                   
if      (kerr < inoise) kgoto mix
  kgate     =  0                                  ; pure unvoiced sound
            kgoto     continue
mix:
  kgate     tablei    (kerr-ivoice)/irange,ifadefn,1 ; xfade voiced/unvoiced
continue:
  asound    soundin   isound                      ; input sound for cross synthesis
  avoice    =  krmso * kgate * asound * iampscl
  anoise    rand      krmso * (1 - kgate)

;-----------------------------------------------------
  aresynthesis lpreson  avoice+anoise
;-----------------------------------------------------

  kenv      linen     1, .05, p3, .05

  asig      gain      aresynthesis, krmso*kenv,20     
            out       asig*iampscl
endin
