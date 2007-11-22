;------------------------------------------------------------------
; Industry
; by Hans Mikelson April 1998
;------------------------------------------------------------------
; ORCHESTRA

  sr        =  44100
  kr        =  22050
  ksmps     =  2
  nchnls    =  2

;------------------------------------------------------------------
; Industrial Loops
;------------------------------------------------------------------
instr      2

  idur      =  p3
  iamp      =  p4*2
  ifqc      =  cpspch(p5)
  iplstab   =  p6
  irattab   =  p7
  iratrat   =  p8
  ipantab   =  p9
  imixtab   =  p10
  iloop     =  p11
  adel      init      0

  kprate    oscil     1, iratrat, irattab         ; Pulse Rate
  kamp      oscil     iamp, kprate, iplstab       ; Amplitude Pulse
  kloop     linseg    0, .005, 1, iloop-.01, 1, .005,  0, p3-iloop-.01, 0 ; Gate in delay loop
  kpan      oscil     1, 1/idur, ipantab          ; Panning
  kmix      oscil     1, 1/idur, imixtab          ; Fading

  asig      rand      kamp                        ; Noise source
  aflt      butterbp  asig, ifqc, ifqc/4          ; Band Filter
  abal      balance   aflt, asig                  ; Bring level back up

  aout      =  abal*kloop+adel                    ; Gate in with feedback
  adel      delay     aout, iloop                 ; Delay

            outs      aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; Output pan & fade

endin

;------------------------------------------------------------------
; SciFi Loops
;------------------------------------------------------------------
instr      3

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irattab   =  p6
  iratrat   =  p7
  ipantab   =  p8
  imixtab   =  p9
  iloop     =  p10
  imodf     =  p11
  imodl     =  p12
  adel      init      0

  krate     oscil     1, iratrat, irattab         ; Pulse Rate
  kloop     linseg    0, .005, 1, iloop-.01, 1, .005,  0, p3-iloop-.01, 0 ; Gate in delay loop
  kpan      oscil     1, 1/idur, ipantab          ; Panning
  kmix      oscil     1, 1/idur, imixtab          ; Fading

;                Amp   Fqc         Car   Mod    MAmp    Wave
  abal      foscil    iamp, ifqc*krate, 1,    imodf, imodl,  1 ; FM Source

  aout      =  abal*kloop+adel                    ; Gate in with feedback
  adel      delay     aout, iloop                 ; Delay

            outs      aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; Output pan & fade

endin



