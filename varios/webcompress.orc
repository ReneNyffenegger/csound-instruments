  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

; Written by Erez Webman (C).

;*********************** GLOBAL READER FROM INPUT WAV FILE ********************************** 
instr 2
  gasig     soundin   "speech1.aif"
endin
;********************************************************************************************* 

instr 1
;----- INITIALIZATION -------------------------------------------------------------------------- 
  ihedroom  =  96
  ifreq     =  p4
  ithresh   =  p5
  iratio    =  1/p6
  ireamp    =  ampdb(p7)
  iq        =  2.85
  icfreq    =  p8
  idisp     =  p9
;----------------------------------------------------------------------------------------------- 
;----- INPUT FILE + FILTERING ------------------------------------------------------------------ 
  ain       =  gasig
  ain       butterbp  ain,ifreq,ifreq/iq
  ain       butterbp  ain,ifreq,ifreq/iq
  ain       butterbp  ain,ifreq,ifreq/iq
  ain       butterbp  ain,ifreq,ifreq/iq
;----------------------------------------------------------------------------------------------- 
; ----- ENVELOPE FOLLOWER ---------------------------------------------------------------------- 
  kenv      rms       ain,icfreq
  kenv      =  dbamp(kenv+0.0001)-ihedroom
;----------------------------------------------------------------------------------------------- 
; ----- CALCULATE AMPLITUDE REDUCTION (IN dB) -------------------------------------------------- 
  kreduce   =  (kenv >= ithresh ? (kenv-ithresh)*(iratio-1) : 0)
  areduce   interp    kreduce
  areduce   butterlp  areduce,icfreq
;----------------------------------------------------------------------------------------------- 
; ----- PERFORM THE ACTUAL COMPRESSION ----- 
  aout      =  ain*ampdb(areduce)*ireamp
            out       aout
endin
