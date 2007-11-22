
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;--------------------------------------------------
     
instr     12                  ;MIX REVERB DELAY & DARKEN
  idlt      =  2.972789-0.02                      ;REVERB STARTS 20MS AFTER SOUND
  irat      =  0.3                                ; ratio of reverb to direct sound
  a1        soundin   "fox.aif"
  ad        delay     a1,idlt
  a2        convolve  a1,"gaussreverb.con"        ;use cvanal to make
  a3        tone      a2,1000                     ;DARKEN (LPF) REVERB
            out       ad+a3*p4*irat
endin
