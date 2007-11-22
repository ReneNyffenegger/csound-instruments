  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr 1
  kn        cpsmidib  2
  ka        midictrl  1, 0, 32000
  a1        oscil     ka, kn, 1
            out       a1
endin

instr 2
  kn        cpsmidib  2
  ka        midictrl  1, 0, 32000
  a1        oscil     ka, kn, 2
            out       a1
endin

instr 3
  a1        oscil     32000, 200, 1
            out       a1
endin
