  sr        =  44100
  kr        =  100
  ksmps     =  441


; MULTI BAND FILTER INSTRUMENT original version
; new version of d2
instr 1
  ibw       =  .07
  iatk      =  .03
  idk       =  .03
  iamp      =  1.0
  isust     =  p3-(iatk+idk)
  inote     =  1./p3
  igain     =  3.
;       araw soundin 1,0
  araw      randi     20000,10000,.666
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  kamp1     oscil     igain, inote, 1
  kamp2     oscil     igain, inote, 2
  kamp3     oscil     igain, inote, 3
  kamp4     oscil     igain, inote, 4
  kamp5     oscil     igain, inote, 5
  kamp6     oscil     igain, inote, 6
  kamp7     oscil     igain, inote, 7

  kres1     oscil     1.0, inote, 8
  kres2     =  kres1 * 2.
  kres3     =  kres1 * 4.
  kres4     =  kres1 * 8.
  kres5     =  kres1 * 16.
  kres6     =  kres1 * 32.
  kres7     =  kres1 * 64.
  kbw1      =  kres1 * ibw 
  kbw2      =  kres2 * ibw 
  kbw3      =  kres3 * ibw 
  kbw4      =  kres4 * ibw 
  kbw5      =  kres5 * ibw 
  kbw6      =  kres6 * ibw 
  kbw7      =  kres7 * ibw 

  ares1     reson     araw,kres1,kbw1,1
  ares2     reson     araw,kres2,kbw2,1
  ares3     reson     araw,kres3,kbw3,1
  ares4     reson     araw,kres4,kbw4,1
  ares5     reson     araw,kres5,kbw5,1
  ares6     reson     araw,kres6,kbw6,1
  ares7     reson     araw,kres7,kbw7,1
  ares1     =  ares1 * kamp1
  ares2     =  ares2 * kamp2
  ares3     =  ares3 * kamp3
  ares4     =  ares4 * kamp4
  ares5     =  ares5 * kamp5
  ares6     =  ares6 * kamp6
  ares7     =  ares7 * kamp7
  asum      =  ares1+ares2+ares3+ares4+ares5+ares6+ares7
  aout      =  asum * kenv
            out       aout

endin
