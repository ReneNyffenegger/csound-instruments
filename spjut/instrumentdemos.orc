  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;--------------------------------------------------
instr     41                  ;Convolution test
  a1        soundin   "marimba.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr     42                  ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"marimba.con"            ;use cvanal to make
            out       a2*p4
endin

instr     43                  ;convolution test
  a1        soundin   "pluckbass.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin
     
instr     44                  ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"pluckbass.con"          ;use cvanal to make
            out       a2*p4
endin

instr     45                  ;convolution test
  a1        soundin   "piano.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin
          
instr     46                  ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"piano.con"              ;use cvanal to make
            out       a2*p4
endin

instr  47                     ;convolution test
  a1        soundin   "brass.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr  48                     ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"brass.con"              ;use cvanal to make
            out       a2*p4
endin

instr  49                     ;convolution test
  a1        soundin   "altosax.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr  50                     ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"altosax.con"            ;use cvanal to make
            out       a2*p4
endin

instr  51                     ;convolution test
  a1        soundin   "violin.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr  52                     ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"violin.con"             ;use cvanal to make
            out       a2*p4
endin
