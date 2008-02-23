; ************************************************************************
; ACCCI:      60-23-2.ORC
; synthesis:  phase vocoder(60)
;             kfmod variable(23)
;             transposition control by LINSEG, speech1.pvx(2)
; coded:      jpg 12/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  ibeg      =  p4
  ifqsc     =  cpspch(p5)/200                     ; scale frequency down, towards unity
  imid      =  p6                                 ; assuming fundamental of 200 Hz...
  iend      =  p7

  ktimpnt   line      0, idur, 5.1
  kfmod     linseg    ibeg, idur/2, imid, idur/2, iend
  aout      pvoc      ktimpnt, ifqsc*kfmod, "speech1.pvx"
            out       aout
endin
