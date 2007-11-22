
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


;--------------------------------------------------
instr     3              ;convolution test
  a1        soundin   "oneecho.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr     4              ;convolution test
  a1        soundin   "twoechos.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr     5              ;convolution test
  a1        soundin   "fiveechos.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin
     
instr     6              ;convolution test
  a1        soundin   "gaussreverb.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr     7              ;convolution test
  a1        soundin   "gaussreverb.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
            out       a2*p4
endin

instr     8              ;convolution test
  a1        soundin   "uniformreverb.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr     9              ;convolution test
  a1        soundin   "uniformreverb.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
            out       a2*p4
endin

instr     10             ;convolution test
  a1        soundin   "whitenoise.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr     11             ;convolution test
  a1        soundin   "whitenoise.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
            out       a2*p4
endin
