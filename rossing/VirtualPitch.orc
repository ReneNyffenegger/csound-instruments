
;*****************************************   VIRTUAL PITCH   ****************************************

;  One of the most remarkable properties of the auditory system is its ability to extract pitch from
; complex tones. When the complex tone consists of a given number of harmonically related partials, 
; the pitch corresponds to the 'missing fundamental'. This pitch is often referred to as "pitch of 
; the missing fundamental", "virtual pitch", or "musical pitch".
; A complex tone consisting of 10 harmonics of 200Hz having equal amplitude will be presented to the l
; listener(s), first with all harmonics, then without the fundamental, then without the two lowest 
; harmonics,etc. Does the pitch of the complex tone change?


;******************************************   HEADER   *********************************************
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr         1

  iamp      =  ampdb(p4)               
  ifunc     =  p6
 
  k1        linen     iamp,.02,p3,.02         
  a1        oscili    k1,p5,ifunc             
            out       a1
endin  
