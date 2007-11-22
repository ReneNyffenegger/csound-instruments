; ************************************************************************
; ACCCI:     02-41-2.ORC
; timbre:    brass
; synthesis: additive, with equivalent parallel units(02)
;            basic instrument with added random frequency variation(41)
; source:    #200 Brass-like Sounds through Independent Control of
;            Harmonics, Risset(1969) /instr 1 and instr2-6/
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  if2       =  p6                                 ; function number for envelope
  ifundr    =  p7 * .04                           ; 4% of fundamental

  afqr      randi     ifundr, 20                  ;random frequency fluctuations
  aenv      oscili    iamp, 1/idur, if2           ;envelope
  a1        oscili    aenv, ifq1 + afqr, 1        ;carrier
            out       a1
endin
