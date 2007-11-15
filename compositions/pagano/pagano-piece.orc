  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  garvbsig  init      0
  gaol      init      0
  gaor      init      0
instr    1 ; Random 64Hz to 1024Hz step generator:-)
  idur      =  p3
  ilevl     =  p4                                 ; Output level
  irate     =  p5                                 ; Rate
  iseed     =  p6                                 ; Seed
  itabl     =  p7                                 ; Table for volume envelope
  ilowest   =  p8                                 ; lowest frequency
  inumber   =  p9                                 ; max number of steps
  istep     =  p10                                ; steps in freq

  k0        linseg    0, .1, 1, p3-.2, 1, .1, 0   ; Overall env
  k1        randh     inumber/2, irate, iseed     ; 'Sample and hold'
  k2        =  int(k1 + inumber/2+1)              ; Convert to whole numbers
  a3        oscil     1, irate, itabl             ; Read table for volume envelope
  a4        oscil     a3, ilowest+istep*k2, 1     ; Generate random notes 128Hz apart
  kpan      line      0,idur*.7,1
  aol       =  a4*k0*ilevl*kpan
  aor       =  a4*k0*ilevl*(1-kpan)
            outs      aol*k0, aor*k0              ; Output and envelope
  asoundz   =  aol*k0+aor*k0
  garvbsig  =  garvbsig+asoundz
endin

instr    2 ; Random 64Hz to 1024Hz step generator:-)
  idur      =  p3
  ilevl     =  p4                                 ; Output level
  irate     =  p5                                 ; Rate
  iseed     =  p6                                 ; Seed
  itabl     =  p7                                 ; Table for volume envelope
  ilowest   =  p8                                 ; lowest frequency
  inumber   =  p9                                 ; max number of steps
  istep     =  p10                                ; steps in freq

  k0        linseg    0, .2, 1, p3-.2, 1, .2, 0   ; Overall env
  k1        randh     inumber/2, irate, iseed     ; 'Sample and hold'
  k2        =  int(k1 + inumber/2+1)              ; Convert to whole numbers
  a3        oscil     1, irate, itabl             ; Read table for volume envelope
  a4        oscil     a3, ilowest+istep*k2/2, 1   ; Generate random notes 64Hz apart
  kpan      line      0,idur*.8,1
  aol       =  a4*k0*ilevl*kpan
  aor       =  a4*k0*ilevl*(1-kpan)
            outs      aol*k0, aor*k0              ; Output and envelope
  astuff    =  aol*k0+aor*k0
  garvbsig  =  garvbsig+astuff
endin

instr 3;Begin: Untitled1
  kpan      =  p8
  aamp      expseg    .5,p3-.01,1,.01,.1
  kenv1     linseg    500, p5, 495, p3, 475, p6, 500
  asig1     oscili    kenv1, p7, p4
  krtl      =  sqrt(2)/2*cos(kpan)+sin(kpan)
  krtr      =  sqrt(2)/2*cos(kpan)-sin(kpan)
  aol       =  (asig1*aamp)*krtl
  aor       =  (asig1*aamp)*krtr
  gaol      =  gaol+aol
  gaor      =  gaor+aor
            outs      aol*aamp,aor*aamp
endin    ;
instr    4; Random 64Hz to 1024Hz step generator:-)
  idur      =  p3
  ilevl     =  p4                                 ; Output level
  irate     =  p5                                 ; Rate
  iseed     =  p6                                 ; Seed
  itabl     =  p7                                 ; Table for volume envelope
  ilowest   =  p8                                 ; lowest frequency
  inumber   =  p9                                 ; max number of steps
  istep     =  p10                                ; steps in freq

  k0        linseg    0, .1, 1, p3-.2, 1, .1, 0   ; Overall env
  k1        randh     inumber/2, irate, iseed     ; 'Sample and hold'
  k2        =  int(k1 + inumber/2+1)              ; Convert to whole numbers
  a3        oscil     1, irate, itabl             ; Read table for volume envelope
  a4        oscil     a3, ilowest+istep*k2, 1     ; Generate random notes 128Hz apart
  kpan      line      0,idur*.7,1
  aol       =  a4*k0*ilevl*kpan
  aor       =  a4*k0*ilevl*(1-kpan)
            outs      aol*k0, aor*k0              ; Output and envelope
  asoundz   =  aol*k0+aor*k0
  garvbsig  =  garvbsig+asoundz
endin



instr  50
  idur      =  p3
  igainl    =  p4
  itiml     =  p5

  igainr    =  p6
  itimr     =  p7


  afltl     init      0
  afltr     init      0
  aamp      linseg    0,.005,1,idur-.01,1,.005,0
  adell     delay     (gaol+afltl)*igainl,itiml*2
  adelr     delay     (gaor+afltr)*igainr,itimr*2
  gaol      =  0
  gaor      =  0
            outs      adell*aamp,adelr*aamp
endin


instr 98

  a1        reverb2   garvbsig, p4, p5
            outs      a1,a1

  garvbsig  =  0

endin

