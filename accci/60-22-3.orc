; ************************************************************************
; ACCCI:      60-22-3.ORC
; synthesis:  phase vocoder(60)
;             ktimpnt variable(22)
;             pointer control by LFO, santur1.pvx(3)
; coded:      jpg 12/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  ifildur   =  5                                  ; original audio file length

  ktimpnt   oscil     ifildur/20, .25, 1, .75
  ktimpnt   =  ktimpnt + ifildur/2
  aout      pvoc      ktimpnt, 1.0, "santur1.pvx"
            out       aout
endin

