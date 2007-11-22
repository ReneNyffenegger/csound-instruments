  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;--------------------------------------------------
instr  53 ;Convolution test
  a1        soundin   "5th.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr  54 ;convolution test
  a1        soundin   "5th.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
            out       a2*p4
endin

instr  55 ;convolution test
  a1        soundin   "tulip.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr  56 ;convolution test
  a1        soundin   "tulip.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
            out       a2*p4
endin

instr  57 ;convolution test
  a1        soundin   "time.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr  58 ;convolution test
  a1        soundin   "time.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
            out       a2*p4
endin

instr  59 ;convolution test
  a1        soundin   "boy.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr  60 ;convolution test
  a1        soundin   "boy.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
            out       a2*p4
endin

instr  61 ;convolution test
  a1        soundin   "wmtell.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
            out       a2*p4
endin

instr  62 ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"wmtell.con"             ;use cvanal to make
            out       a2*p4
endin
