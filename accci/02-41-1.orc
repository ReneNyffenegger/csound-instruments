; ************************************************************************
; ACCCI:     02-41-1.ORC
; timbre:    brass
; synthesis: additive, same building blocks units(02)
;            basic instrument with added random frequency variation(41)
; source:    #200 Brass-like Sounds through Independent Control of
;            Harmonics, Risset(1969) /i1 and 17/
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  irise     =  p6                                 ; steep rise  (.5 to 3 ms)
  idec      =  p7                                 ; steep decay (4 to 11 ms)
  ifundr    =  p8 * .06                           ; 6% of fundamental

  afqr      randi     ifundr, 10
  aenv      linen     iamp, irise, idur, idec
  a1        oscili    aenv, ifq1 + afqr, 1
            out       a1 * 8
endin
