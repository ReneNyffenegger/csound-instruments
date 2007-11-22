  ga1       init      0

; ========================================== ;
; ============ FLUTE-LIKE #100 ============= ;
; ========================================== ;

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     inenr     iveloc/2,0,.2,.01

  i1        =  .74

  k1        randi     (800*.01),5
  k1        =  k1 + 800
  k2        oscil     k1,1/.24,12
  k2        =  k2 + i1
  k3        oscil     k2,1/.12,5
  a1        oscili    k3,knote,2
  a2        =  a1*10
  ga1       =  ga1+(.5*a2)                        ;p13 = rvb send level
            out       a2*kgate
endin


instr          2
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2,0,.2,.01

  k1        oscil     1200,1/.15,p7
  k2        oscil     p5,1/.15,9
  a1        oscili    k1,knote,1
  a2        =  a1*10
  ga1       =  ga1+(.5*a2)                        ;p9 = rvb send level
            out       a2*kgate
endin

; ========================================== ;
; =======  GLOBAL REVERB INSTRUMENT  ======= ;
; ========================================== ;

instr         6
  ga1       init      0
  a1        reverb    ga1,1.3                     ;p4=reverb time in seconds
  a2        =  a1*.5                              ;p5=reverb return level
            out       a2
  ga1       =  0
endin
