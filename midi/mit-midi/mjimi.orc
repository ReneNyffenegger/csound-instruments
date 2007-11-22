;=======================================================================;
; JIMI            WAVESHAPING ELECTRIC GUITAR INSTRUMENT                ;
;                 CODED BY AN ANONYMOUS MIT GRADUATE STUDENT            ;
;                 MUSIC AND COGNITION GROUP, MIT MEDIA LAB              ;
;=======================================================================;
instr               1
            massign   1,1
  knote     cpsmidib  
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  k1        envlpx    .45,.01,5,.03,1,-.2,.01
  a1        oscil     k1,knote,2
  a2        tablei    a1,3,1,.5
            out       a2*kgate
endin
