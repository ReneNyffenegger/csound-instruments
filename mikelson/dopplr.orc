  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;-------------------------------------------------------------
; Some noise based doppler effect sounds.
;-------------------------------------------------------------
instr 1
; Initializations
;-------------------------------------------------------------
  idlen     init      .2                          ;Length of the delay line.
  iphaz     init      .01                         ;Phase difference between right and left ears.
  ifqc      =  cpspch(p5)                         ;Convert Pitch to frequency.

; Envelopes
;-------------------------------------------------------------
  kpanl     linseg    0, p3/3, .1, p3/3, .9, p3/3, 1 ;Pan left
  kpanr     =  1-kpanl                            ;Pan right
  kdopl     expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3 ;Doppler envelope
  kdist     linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1 ;The sound is quieter 
                                                     ;the farther away it is.

; Generate noise bands
;-------------------------------------------------------------
  anoize    rand      p4                          ;Take a noise
  af1       reson     anoize, ifqc, 10            ;and generate some frequency
  af2       reson     anoize, ifqc*2, 20          ;bands to add together
  af3       reson     anoize, ifqc*8, 100         ;for input to the doppler effect.
  asamp     =  af1+af2+af3

; Doppler effects
;-------------------------------------------------------------
  adel1     delayr    idlen                       ;There has to be enough room for
  atap1     deltapi   idlen/2+kdopl               ;an object coming from a long ways
  atap2     deltapi   idlen/2+kdopl+iphaz         ;away.  Take two taps for right and
            delayw    asamp*kdist                 ;left ears.

; Scale and output
;-------------------------------------------------------------
            outs      atap1*kpanl, atap2*kpanr

endin

;-------------------------------------------------------------
; Some noise based doppler effect sounds.
;-------------------------------------------------------------
instr 2
; Initializations
;-------------------------------------------------------------
  idlen     init      .2                          ;Length of the delay line.
  iphaz     init      .01                         ;Phase difference between right and left ears.
  ifqc      =  cpspch(p5)                         ;Convert Pitch to frequency.

; Envelopes
;-------------------------------------------------------------
  kpanl     linseg    0, p3/3, .1, p3/3, .9, p3/3, 1 ;Pan left
  kpanr     =  1-kpanl                            ;Pan right
  kdopl     expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3 ;Doppler envelope
  kdist     linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1 ;The sound is quieter 
                                                     ;the farther away it is.

; Generate noise bands
;-------------------------------------------------------------
  anoize    rand      p4                          ;Take a noise
  af1       reson     anoize, ifqc, 10            ;and generate some frequency
  af2       reson     anoize, ifqc*2, 20          ;bands to add together
  af3       reson     anoize, ifqc*8, 100         ;for input to the doppler effect.
  asamp     =  af1+af2+af3

; Doppler effects
;-------------------------------------------------------------
  adel1     delayr    idlen                       ;There has to be enough room for
  atap1     deltapi   idlen/2+kdopl               ;an object coming from a long ways
  atap2     deltapi   idlen/2+kdopl+iphaz         ;away.  Take two taps for right and
            delayw    asamp*kdist                 ;left ears.

; Scale and output
;-------------------------------------------------------------
            outs      atap2*kpanr, atap1*kpanl

endin


;-------------------------------------------------------------
; Sample based doppler effects.
;-------------------------------------------------------------
instr 3

  idlen     init      .2
  iphaz     init      .01
  ifqc      =  p5

  kpanl     linseg    0, p3/3, .1, p3/3, .9, p3/3, 1
  kpanr     =  1-kpanl
  kdopl     expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3
  kdist     linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1

;Sampler
  asamp     loscil    p4, p5, p6, 440, 1, p7, p8

  adel1     delayr    idlen
  atap1     deltapi   idlen/2+kdopl
  atap2     deltapi   idlen/2+kdopl+iphaz
            delayw    asamp*kdist

            outs      atap1*kpanl, atap2*kpanr

endin

;-------------------------------------------------------------
; Sample based doppler effects.
;-------------------------------------------------------------
instr 4

  idlen     init      .2
  iphaz     init      .01
  ifqc      =  p5

  kpanl     linseg    0, p3/3, .1, p3/3, .9, p3/3, 1
  kpanr     =  1-kpanl
  kdopl     expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3
  kdist     linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1

;Sampler
  asamp     loscil    p4, p5, p6, 440, 1, p7, p8

  adel1     delayr    idlen
  atap1     deltapi   idlen/2+kdopl
  atap2     deltapi   idlen/2+kdopl+iphaz
            delayw    asamp*kdist

            outs      atap2*kpanr, atap1*kpanl

endin


;-------------------------------------------------------------
; Some more noise based doppler effect sounds.
;-------------------------------------------------------------
instr 5
; Initializations
;-------------------------------------------------------------
  idlen     init      .5                          ;Length of the delay line.
  iphaz     init      .01                         ;Phase difference between right and left ears.
  ifqc      =  cpspch(p5)                         ;Convert Pitch to frequency.

;Use the Lorenz attractor for the motion of the sound
;--------------------------------------------------------------------
  kx        init      p10
  ky        init      p11
  kz        init      p12
  kh        init      p6
  ks        init      p7
  kr1       init      p8
  kb        init      p9
  kdoplr    init      idlen/2

;--------------------------------------------------------------------
  kdx       =  kh*ks*(ky-kx)
  kdy       =  kh*(-kx*kz+kr1*kx-ky)
  kdz       =  kh*(kx*ky-kb*kz)

;--------------------------------------------------------------------
  kx        =  kx+kdx
  ky        =  ky+kdy
  kz        =  kz+kdz

  kxscale   =  kx
  kyscale   =  ky
  kdxscale  =  kdx
  kdyscale  =  kdy

; Sound modifications.  
; Panning goes to 1,0 at -inf, 0,1 at +inf and 1/2,1/2 at 0
;-------------------------------------------------------------
  kpanl     =  1/(1+exp(kxscale/10))              ;Compute pan left
  kpanr     =  1/(1+exp(-kxscale/10))             ;Compute pan right
  kdist     =  sqrt(kxscale*kxscale+kyscale*kyscale+1) ;Find the distance to the source.
  kddoplr   =  (kxscale*kdxscale+kyscale*kdyscale)*10/kdist ;Doppler effect or Deltap increment.
  kdoplr    =  kdoplr+kddoplr/20000

; Generate noise bands
;-------------------------------------------------------------
;anoize rand   p4                       ;Take a noise
;af1    reson  anoize, ifqc, 10         ;and generate some frequency
;af2    reson  anoize, ifqc*2, 20       ;bands to add together
;af3    reson  anoize, ifqc*8, 100      ;for input to the doppler effect.
;asamp  =      af1+af2+af3
  asamp     buzz      p4, ifqc, 10, 2

; Doppler effects
;-------------------------------------------------------------
  adel1     delayr    idlen                       ;There has to be enough room for
  atap1     deltapi   kdoplr                      ;an object coming from a long ways
  atap2     deltapi   kdoplr+iphaz                ;away.  Take two taps for right and
            delayw    asamp/kdist                 ;left ears.

; Scale and output
;-------------------------------------------------------------
            outs      atap1*kpanl, atap2*kpanr

;ax = kx
;ay = ky

;outs ax*100, ay*100

endin

;-------------------------------------------------------------
; Some more noise based doppler effect sounds.
;-------------------------------------------------------------
instr 6
; Initializations
;-------------------------------------------------------------
  idlen     init      .5                          ;Length of the delay line.
  iphaz     init      .01                         ;Phase difference between right and left ears.
  ifqc      =  cpspch(p5)                         ;Convert Pitch to frequency.

;Initialize x, y, dx, dy
;--------------------------------------------------------------------
  kx        init      p6
  ky        init      p7
  kdx       init      p8
  kdy       init      p9
  kdoplr    init      idlen/2

;--------------------------------------------------------------------
  kx        =  kx+kdx
  ky        =  ky+kdy

; Sound modifications.  
; Panning goes to 1,0 at -inf, 0,1 at +inf and 1/2,1/2 at 0
;-------------------------------------------------------------
  kpanl     =  1/(1+exp(kx/20))                   ;Compute pan left
  kpanr     =  1/(1+exp(-kx/20))                  ;Compute pan right
  kdist     =  sqrt(kx*kx+ky*ky+1)                ;Find the distance to the source.
  kddoplr   =  (kx*kdx+ky*kdy)/kdist              ;Doppler effect or Deltap increment.
  kdoplr    =  kdoplr+kddoplr/4000

; Generate noise bands
;-------------------------------------------------------------
;anoize rand   p4                       ;Take a noise
;af1    reson  anoize, ifqc, 10         ;and generate some frequency
;af2    reson  anoize, ifqc*2, 20       ;bands to add together
;af3    reson  anoize, ifqc*8, 100      ;for input to the doppler effect.
;asamp  =      af1+af2+af3
  asamp     buzz      p4, ifqc, 10, 2

; Doppler effects
;-------------------------------------------------------------
  adel1     delayr    idlen                       ;There has to be enough room for
  atap1     deltapi   kdoplr                      ;an object coming from a long ways
  atap2     deltapi   kdoplr+iphaz                ;away.  Take two taps for right and
            delayw    asamp/kdist                 ;left ears.

; Scale and output
;-------------------------------------------------------------
            outs      atap1*kpanl, atap2*kpanr

endin
