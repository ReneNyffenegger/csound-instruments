instr   118         

  k1        oscil     p4, 1/p3, p7

  k2        expseg    p5, p3/3, p8, p3/3, p9, p3/3, p5

  a1        loscil    k1, k2, p6

            out       a1

endin

