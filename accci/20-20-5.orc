; ************************************************************************
; ACCCI:     20-20-5.ORC
; synthesis: FM(20),
;            double-carrier FM, dynamic spectral evolution (20)
;            trumpet (5)
; source:    Morrill(1977)
; coded:     jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4/1.2
  ifq1      =  p5
  imax1     =  p6
  ifq2      =  p7
  imax2     =  p8
  ifqm      =  ifq1
  iratio    =  imax2/imax1

  ivibwidth =  .007                               ; vibrato generator
  irandev   =  .007
  ifqr      =  125
  ivibrate  =  7
  iportdev  =  .03

; vibrato signal

  kwidth    linseg    0, .6, ivibwidth, idur - .6 - .2, ivibwidth, .2, 0
  kv1       randi     irandev, ifqr
  kv2       oscili    kwidth, ivibrate, 1
  kv3       oscili    iportdev, 1/idur, 31
  kv        =  (1+kv1)*(1+kv2)*(1+kv3)

; double-carrier, single modulator instrument

  kdyn      linseg    0, .03, 1, idur - .03 - .01, .9, .01, 0
  amod      oscili    kdyn*ifqm*imax1, ifqm*kv, 1

  kamp1     linseg    0, .03, 1, idur - .03 - .15, .9, .15, 0
  a1        oscili    kamp1*iamp, amod+(ifq1*kv), 1

  kamp2     linseg    0, .03, 1, idur - .03 - .3, .9, .3, 0
  a2        oscili    kamp2*iamp*.2, (amod*iratio)+(ifq2*kv), 1

            out       a1+a2
endin
