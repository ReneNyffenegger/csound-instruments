; ************************************************************************
; ACCCI:      60-23-1.ORC
; synthesis:  phase vocoder(60)
;             kfmod variable(23)
;             transposition control by EXPON, santur1.pvx(1)
; coded:      jpg 12/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  itarget   =  p4
  ioct      =  octpch(p5)

  ktimpnt   line      0, idur, 5
  kfmod     expon     .1, idur, .1+itarget
  aout      pvoc      ktimpnt, cpsoct(ioct-.3*kfmod)/440, "santur1.pvx"
            out       aout/3
endin

