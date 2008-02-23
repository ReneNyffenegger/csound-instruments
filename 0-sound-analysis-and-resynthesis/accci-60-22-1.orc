; ************************************************************************
; ACCCI:      60-22-1.ORC
; synthesis:  phase vocoder(60)
;             ktimpnt variable(22)
;             pointer control by LINE, santur1.pvx(1)
; coded:      jpg 12/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3

  ktimpnt   line      0, idur, 5                  ; original file is 5 seconds

  aout      pvoc      ktimpnt, 1.0, "santur1.pvx"
            out       aout
endin

instr 2; *****************************************************************
  idur      =  p3

  ktimpnt   line      5, idur, 0                  ; play it backwards

  aout      pvoc      ktimpnt, 1.0, "santur1.pvx"
            out       aout
endin
