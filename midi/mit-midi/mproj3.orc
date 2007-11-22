;BETH LEIBOWITZ MID-TERM PROJECT
; AN FM INSTRUMENT WITH TIME DEPENDENT INDEX OF MODULATION
; AND SCORE CONTROLLED FC/FM RATIO

  nchnls    =  2

            massign   1,1

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     inenr     iveloc, 0, .2, .01

;ifc           =         p6*cpspch(p5)                           ; CARRIER FREQUENCY
  ifc       =  2*cpspch(7.07)
;ifm           =         p7*cpspch(p5)                           ; MODULATION FREQUENCY
  ifm       =  5*cpspch(7.07)
;kndx                    envlpx 11, p3/2, p3, p3/2, 2, 1, .01    ; F2 IS STRAIGHT LINE
  kndx      envlpx    11, 7/2, 7, 7/2, 2, 1, .01
;kamp          envlpx    6000, .1*p3, p3, .2*p3, 2, .8, .01
  kamp      envlpx    6000, .1*7, 7, .2*7, 2, .8, .01
;amod          oscil     kndx*ifm, ifm, 1                        ; F1 IS SIMPLE SINE WAVE
  amod      oscil     ifm*iveloc, knote*5, 1
;asig          oscil     kamp, ifc+amod, 1
  asig      oscil     6000, (knote*2)+amod, 1
  asigo     tone      asig, 9000                  ; I DON'T WANT FOLDOVER AS AN ADDED FACTOR.
            outs      asigo*kgate,asigo*kgate
endin
