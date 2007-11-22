; ************************************************************************
; ACCCI:     20-10-5.ORC
; synthesis: FM(20),
;            FM with dynamic spectral evolution (10)
;            variable FM instrument(5)
; source:    M.R.Spruit(1993)
; coded:     jpg 1/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  ifqm      =  p6
  imax      =  p7
  ibegae    =  p8                                 ; initial value of EXPSEG amplitude envelope
  ibegkdyn  =  p9                                 ; initial value of LINSEG modulation index
  ibreakp   =  idur/p10                           ; breakpoint time of both envelopes
  imid      =  p11                                ; breakpoint amplitude value
  iend      =  p12                                ; end value of both envelopes
  irtv      =  p13                                ; reverberated / source
  ileft     =  p14                                ; ratio left channel

  ae        expseg    0.0001, ibreakp, imid, idur-ibreakp, 0.0001
  ae        =  ae*iamp

  adyn      linseg    ibegkdyn, ibreakp, 1-imid, idur-ibreakp, 0
  adyn      =  adyn*ifqm*imax

  amod      oscili    adyn, ifqm, 1               ; modulator
  asig      oscili    ae, amod+ifqc, 1            ; carrier

  arev      init      0
  arev      reverb    asig*irtv, idur             ; part reverberated
  adry      =  asig*(1-irtv)                      ; rest unreverberated
  amix      =  arev+adry                          ; mix

  a1        =  amix*ileft                         ; left
  a2        =  amix*(1-ileft)                     ; right

            outs      a1, a2

endin

