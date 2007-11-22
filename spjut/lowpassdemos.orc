  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;--------------------------------------------------
instr     13                       ;Convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"lowpass3khz.con"        ;use cvanal to make
            out       a2*p4
endin

instr     14                       ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"lowpass3khz.con"        ;use cvanal to make
            out       a2*p4
endin

instr     15                       ;convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"lowpass1khz.con"        ;use cvanal to make
            out       a2*p4
endin

instr     16                       ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"lowpass1khz.con"        ;use cvanal to make
            out       a2*p4
endin

instr     17                       ;convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"lowpass300hz.con"       ;use cvanal to make
            out       a2*p4
endin

instr     18                       ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"lowpass300hz.con"       ;use cvanal to make
            out       a2*p4
endin

instr     19                       ;convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"rimshot.con"            ;use cvanal to make
            out       a2*p4
endin

instr     20                       ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"rimshot.con"            ;use cvanal to make
            out       a2*p4
endin

instr     21                       ;convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"bassdrum.con"           ;use cvanal to make
            out       a2*p4
endin

instr     22                       ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"bassdrum.con"           ;use cvanal to make
            out       a2*p4
endin
