; ************************************************************************
; ACCCI:      60-22-2.ORC
; synthesis:  phase vocoder(60)
;             ktimpnt variable(22)
;             pointer control by EXPON, santur1.pvx(2)
; coded:      jpg 12/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  ifildur   =  5

  ktimpnt   expon     .1, idur, ifildur
  aout      pvoc      ktimpnt, 1.0, "santur1.pvx"
            out       aout
endin


instr 2; *****************************************************************
  idur      =  p3
  ifildur   =  5

  ktimpnt   expon     ifildur, idur, .1
  aout      pvoc      ktimpnt, 1.0, "santur1.pvx"
            out       aout
endin
