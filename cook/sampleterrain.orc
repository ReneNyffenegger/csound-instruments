  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; 3D Sample Wave Terrain

  ilevl     =  p4*32767                           ; Output level
  ipitch    =  (p5 < 10 ? cpspch(p5) : p5)        ; Pitch in cpspch or Hz
  iposx1    =  p6                                 ; X position start
  iposx2    =  p7                                 ; X position finish
  iposy1    =  p8                                 ; Y position start
  iposy2    =  p9                                 ; Y position finish
  iradi1    =  p10/1000                           ; Radius start (scaled)
  iradi2    =  p11/1000                           ; Radius end (scaled)
  iratex    =  p12                                ; X random rate
  iratey    =  p13                                ; Y random rate
  idpth     =  p14/1000                           ; Random depth (scaled)

  kx        line      iposx1, p3, iposx2          ; X position
  ky        line      iposy1, p3, iposy2          ; Y position
  krad      line      iradi1, p3, iradi2          ; Radius
  krndx     randi     idpth, iratex               ; X random position modulation
  krndy     randi     idpth, iratey               ; Y random position modulation
  ksin      oscili    krad, ipitch, 3             ; X indexing osc (sine)
  kcos      oscili    krad, ipitch, 3, .25        ; Y indexing osc (cosine)
  kindx     =  kx + ksin + krndx                  ; Add X indexes together
  kindy     =  ky + kcos + krndy                  ; Add Y indexes together
  ax        tablei    kindx, 1, 1, 0, 1           ; X indexing
  ay        tablei    kindy, 2, 1, 0, 1           ; Y indexing
            out       ax*ay*ilevl                 ; Output

endin