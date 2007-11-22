  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 99
                                                  ; DECLARE ALL SIGNALS
  gal1      init      0
  gar1      init      0
  gal2      init      0
  gar2      init      0
  gal3      init      0
  gar3      init      0
  gal4      init      0
  gar4      init      0

  gkg1      init      0
  gkg2      init      0
  gkg3      init      0
  gkg4      init      0

  gkp1      init      0
  gkp2      init      0
  gkp3      init      0
  gkp4      init      0

                                                  ; MASTER GAIN (HOW DO I READ THESE TWO FROM ALL CHANNELS?)
  gkmainl   =  1/127
  gkmainr   =  1/127

                                                  ; COMPUTE ALL THE LEFT-RIGHT GAINS FROM GKP'S
  kg1l      =  gkg1 * gkp1
  kg1r      =  gkg1 * (1 - gkp1)
  kg2l      =  gkg2 * gkp2
  kg2r      =  gkg2 * (1 - gkp2)
  kg3l      =  gkg3 * gkp3
  kg3r      =  gkg3 * (1 - gkp3)
  kg4l      =  gkg4 * gkp4
  kg4r      =  gkg4 * (1 - gkp4)

                                                  ; MIX THE SIGNALS
                                   
  aoutl     =  gal1 * kg1l + gal2 * kg2l + gal3 * kg3l + gal4 * kg4l
  aoutr     =  gar1 * kg1r + gar2 * kg2r + gar3 * kg3r + gar4 * kg4r

                                                  ; OUTPUT
                                   
            outs      aoutl * gkmainl, aoutr * gkmainr

                                                  ; IN CASE AN INSTRUMENT STOPS PLAYING EMPTY IT'S BUFFER
  ga1l      =  0
  ga1r      =  0
  gkg1      =  0
  gkp1      =  0

  ga2l      =  0
  gar2      =  0
  gkg2      =  0
  gkp2      =  0

  gal3      =  0
  gar3      =  0
  gkg3      =  0
  gkp3      =  0

  gal4      =  0
  gar4      =  0
  gkg4      =  0
  gkp4      =  0
endin

instr 1
                                                  ; GET THE CONTROLLERS FOR VOLUME AND PAN
  gkg1      midictrl  1
  gkp1      midictrl  5
                                                  ; SCALE PANNING
  gkp1      =  gkp1/127

                                                  ; MAKE A SOUND
  a1        oscil     32000, 220, 1

                                                  ; SEND SIGNALS
  gal1      =  a1
  gar1      =  a1
endin

instr 2
  gkg2      midictrl  1
  gkp2      midictrl  5
  gkp2      =  gkp1/127

  a1        oscil     32000, 440, 1

  gal2      =  a1
  gar2      =  a1
endin

instr 3
  gkg3      midictrl  1
  gkp3      midictrl  5
  gkp3      =  gkp1/127

  a1        oscil     32000, 660, 1

  gal3      =  a1
  gar3      =  a1
endin

instr 4
  gkg4      midictrl  1
  gkp4      midictrl  5
  gkp4      =  gkp1/127

  a1        oscil     32000, 880, 1

  gal4      =  a1
  gar4      =  a1
endin

