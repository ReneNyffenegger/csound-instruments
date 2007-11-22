  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  a1        rand      20000
  a2        butterlp  a1, 500
            out       a2
endin

instr 2
  a1        rand      20000
  a2        tone      a1, 500
            out       a2
endin


instr 3
  a1        rand      20000
  a2        butterhp  a1, 1000
            out       a2
endin

instr 4
  a1        rand      20000
  a2        atone     a1, 1000
            out       a2
endin


instr 5
  a1        rand      20000
  a2        butterbp  a1, 1000, 100
            out       a2
endin

instr 6
  a1        rand      20000
  a2        reson     a1, 1000, 100
  a3        balance   a2, a1
            out       a3/2
endin


instr 7
  a1        rand      20000
  a2        butterbr  a1, 1000, 100
            out       a2
endin

instr 8
  a1        rand      20000
  a2        areson    a1, 1000, 100
  a3        balance   a2, a1
            out       a3/2
                        
endin
