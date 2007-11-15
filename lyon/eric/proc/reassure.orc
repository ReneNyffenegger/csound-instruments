  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr 1
  ifile     =  p4
  iskip     =  p5
  iamp      =  p6
  irnddev   =  p7
  irndspeed =  p8/p3
  irndamp   =  p9
  irseed1   =  p10
  irseed2   =  p11
  ibw       =  p12
  afil1,afil2  soundin  ifile, iskip
  aamp      oscili    iamp, 1/p3, 2
  kfre1     randi     irnddev, irndspeed, irseed1
  kfre1     =  (kfre1 + 1) * irndamp
        
  kfre2     randi     irnddev, irndspeed, irseed2
  kfre2     =  (kfre2 + 1) * irndamp
  ares1     reson     afil1, kfre1, ibw, 1
  ares2     reson     afil2, kfre2, ibw, 1


            outs      ares1, ares2
endin

instr 2
  ifile     =  p4
  iskip     =  p5
  iamp      =  p6
  irnddev   =  p7
  irndspeed =  p8/p3
  irndamp   =  p9
  irseed1   =  p10
  irseed2   =  p11
  ibw       =  p12
  afil1     soundin   ifile, iskip
  aamp      oscili    iamp, 1/p3, 2
  kfre1     randi     irnddev, irndspeed, irseed1
  kfre1     =  (kfre1 + 1) * irndamp
        
  kfre2     randi     irnddev, irndspeed, irseed2
  kfre2     =  (kfre2 + 1) * irndamp
  ares1     reson     afil1, kfre1, ibw, 1
  ares2     reson     afil1, kfre2, ibw, 1


            outs      ares1, ares2
endin