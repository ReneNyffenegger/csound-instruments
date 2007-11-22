  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  a1        oscil     10000, 500, 1               ;
  a2        butterhp  a1, 1000
            out       a2
endin

instr 2
  a1        oscil     10000, 500, 1               ;
  a2        butterlp  a1,     600
            out       a2
endin

instr 3
  a1        oscil     10000, 500, 1               ;
  a2        butterbp  a1, 2000, 500
            out       a2
endin

instr 4
  a1        oscil     10000, 500, 1               ;
  a2        butterbr  a1, 5000, 3000
            out       a2
endin
