; ************************************************************************
; ACCCI:      60-22-1B.ORC
; synthesis:  phase vocoder(60)
;             ktimpnt variable(22)
;             pointer control by LINSEG, speech1.pvx(1B)
; coded:      jpg 12/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  ifmod     =  p4

  ktimpnt   linseg    0,idur/6,1.1,idur/6,1.2,idur/24,1.3,3*idur/24,1.6,idur/2,5

  aout      pvoc      ktimpnt, ifmod, "speech1.pvx", 0
            out       aout
endin
