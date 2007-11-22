  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;--------------------------------------------------
instr     31 ;CONVOLUTION TEST
  a1        soundin   "hello.aif"
  a2        convolve  a1,"onecyclemidc.con"       ;use cvanal to make
            out       a2*p4
endin

instr     32 ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"onecyclemidc.con"       ;use cvanal to make
            out       a2*p4
endin

instr     33 ;convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"fivecyclesmidc.con"     ;use cvanal to make
            out       a2*p4
endin

instr     34 ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"fivecyclesmidc.con"     ;use cvanal to make
            out       a2*p4
endin

instr     35 ;convolution test
  a1        soundin   "388cyclesmidc.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr     36 ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"388cyclesmidc.con"      ;use cvanal to make
            out       a2*p4
endin

instr     37 ;convolution test
  a1        soundin   "middlec.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin
     
instr     38 ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"middlec.con"            ;use cvanal to make
            out       a2*p4
endin
     
instr     39 ;convolution test
  a1        soundin   "a440.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin
     
instr     40 ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"a440.con"               ;use cvanal to make
            out       a2*p4
endin
