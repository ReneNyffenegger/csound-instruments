; RISSET "REEDY/PLUCKED" #250

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2,0,.2,.01

;i1            =         1/p3
  i1        =  1/.5
;k1            oscil     p4, i1, p5
  k1        oscil     6000,i1,6
;a1            oscili    k1, p6, 1
  a1        oscili    k1, knote, 1
            out       a1*kgate
endin



instr          2

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2,0,.2,.01

;i1            =         1/p3
  i1        =  1/.5
;k1            oscil     p4, i1, p5
  k1        oscil     6000,i1,8
;a1            oscili    k1, p6, 1
  a1        oscili    k1, knote, 1
            out       a1*kgate
endin



instr          3

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01

;i1            =         1/p3
  i1        =  1/.5
;k1            oscil     p4, i1, p5
  k1        oscil     1000,i1,7
;a1            oscili    k1, p6, 1
  a1        oscili    k1, knote, 2
            out       a1*kgate
endin
