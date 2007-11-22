  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;--------------------------------------------------
instr   23                                      ;Convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"highpass300hz.con"      ;use cvanal to make
            out       a2*p4
endin

instr   24                                      ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"highpass300hz.con"      ;use cvanal to make
            out       a2*p4
endin

instr   25                                      ;convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"highpass1khz.con"       ;use cvanal to make
            out       a2*p4
endin

instr   26                                      ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"highpass1khz.con"       ;use cvanal to make
            out       a2*p4
endin

instr   27                                      ;convolution test
  a1        soundin   "hello.aif"
  a2        convolve  a1,"highpass3khz.con"       ;use cvanal to make
            out       a2*p4
endin

instr   28                                      ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"highpass3khz.con"       ;use cvanal to make
            out       a2*p4
endin

instr   29                                      ;convolution test
  a1        soundin   "cymbal.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr   30                                      ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"cymbal.con"             ;use cvanal to make
            out       a2*p4
endin
