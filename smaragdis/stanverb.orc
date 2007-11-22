  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr 1
  ga2       init      0

  a1        =  ga2
  a2        reverb2   a1, 2.1
            out       a2
  ga2       =  0
endin

instr 2
  ga1       init      0

  ir        =  2.1
  a1        =  ga1

  a2        comb      a1, .822, 1237. / sr
  a3        comb      a1, .802, 1381. / sr
  a4        comb      a1, .773, 1607. / sr
  a5        comb      a1, .753, 1777. / sr
  a6        comb      a1, .753, 1949. / sr
  a7        comb      a1, .753, 2063. / sr
  a8        =  a2 + a3 + a4 + a5 + a6 + a7

  a9        alpass    a8, .7*ir, 307. / sr
  a10       alpass    a9, .7*ir, 97. / sr
  a11       alpass    a10, .7*ir, 71. / sr
  a12       alpass    a11, .7*ir, 53. / sr
  a13       alpass    a12, .7*ir, 37. / sr

            out       a13
  ga1       =  0
endin

instr 3
  a1        soundin   5, 0, 4
  ga1       =  a1 * p4
  ga2       =  a1 * p5
     ;out a1
endin

instr 4
  a1        soundin   5, 0, 4
     ;a2 multitap   a1, .0199, 1.02, .0354, .818, .0389, .0635, .0414, .719, .0699, .267, .0796, .242
  a2        multitap  a1, .0043, .841, .0215, .504, .0225, .491, .0268, .379, .0270, .380, .0298, .346, .0458, .289, .0485, .272, .0572, .192, .0587, .193, .0595, .217, .0612, .181, .0707, .180, .0708, .181, .0726, .176, .0741, .142, .0753, .167, .0797, .134
            out       a2
endin     
