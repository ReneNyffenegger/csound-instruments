; ************************************************************************
; ACCCI:     01-01-2B.ORC
; timbre:    plucked instrument
; synthesis: simple(01),
;            basic instrument(01)
; source:    #250 Reedy and Plucked Tones, Choral Effect, Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  idec      =  p6
;                       ;xamp, irise,idur,idec,   ifn,   iatss,iatdec
  a1        envlpx    iamp,  .01,idur,idec,    51,     1  ,  .01
  a1        oscili    a1, ifq1, 11
            out       a1
endin



