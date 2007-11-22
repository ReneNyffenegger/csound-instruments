  sr        =  44100
  kr        =  44100
  ksmps     =  1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Analog Drum Set inspired in some classical drum machines
;coded by Josep M Comajuncosas / Jul-Aug´2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 1; HANDCLAP

  iamp      =  10000
  iband     =  1000

  kamp1     expon     1.25, .03,  .00001
  kamp2     expseg    .00001,.0005,1,.35,.00001

  anoize    rand      1

  adel1     =  anoize*kamp1
  adel2     delay     anoize*kamp1, .01
  adel3     delay     anoize*kamp1, .022
  adel4     delay     anoize*kamp2, .03

  abp1      resonz    adel1,  iband*.9,  1500,1
  abp2      resonz    adel2,  iband*.8,  1500,1
  abp3      resonz    adel3,  iband,     1500,1
  abp4      resonz    adel4,  iband*1.1, 1500,1



            out       iamp*2*(abp1+abp2+abp3+abp4)

endin
