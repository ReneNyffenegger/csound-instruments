
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;--------------------------------------------------
 
instr     63             ;convolution test
  a1        soundin   "5th.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     64             ;convolution test
  a1        soundin   "5th.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     65             ;convolution test
  a1        soundin   "tulip.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     66             ;convolution test
  a1        soundin   "tulip.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     67             ;convolution test
  a1        soundin   "time.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     68             ;convolution test
  a1        soundin   "time.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     69             ;convolution test
  a1        soundin   "boy.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     70             ;convolution test
  a1        soundin   "boy.aif"
  a2        convolve  a1,"fox.con"                ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     71             ;convolution test
  a1        soundin   "wmtell.aif"
  a2        convolve  a1,"hello.con"              ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin

instr     72             ;convolution test
  a1        soundin   "fox.aif"
  a2        convolve  a1,"wmtell.con"             ;use cvanal to make
  a3        diff      a2
            out       a3*p4
endin
