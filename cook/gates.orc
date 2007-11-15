  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Gate - passes signal over threshold

  ilevl     =  p4                                 ; Level
  ithresh   =  p5*32768                           ; Threshold

  ain       soundin   "sample1.wav"

  kin       downsamp  ain
  kpos      limit     kin, 0, 32768
  kneg      limit     kin,-32768, 0
  kgate1    =  (kpos > ithresh ? kpos : 0)
  kgate2    =  (kneg <-ithresh ? kneg : 0)
  kgate     =  kgate1 + kgate2
  agate     upsamp    kgate
            out       agate*ilevl

endin

instr    2 ; Gate - passes signal under threshold

  ilevl     =  p4/p5                              ; Level scaled to compensate for clipping
  ithresh   =  p5*32768                           ; Threshold

  ain       soundin   "sample1.wav"

  kin       downsamp  ain
  kpos      limit     kin, 0, 32768
  kneg      limit     kin,-32768, 0
  kgate1    =  (kpos < ithresh ? kpos : 0)
  kgate2    =  (kneg >-ithresh ? kneg : 0)
  kgate     =  kgate1 + kgate2
  agate     upsamp    kgate
            out       agate*ilevl

endin

instr    3 ; Gate - passes loudest input

  ilevl     =  p4                                 ; Output level

  ain1      soundin   "sample1.wav"
  ain2      soundin   "sample2.wav"

  kin1      downsamp  ain1
  kin2      downsamp  ain2
  kpos1     limit     kin1, 0, 32768
  kneg1     limit     kin1,-32768, 0
  kpos2     limit     kin2, 0, 32768
  kneg2     limit     kin2,-32768, 0
  kgate1    =  (kpos1 > kpos2 ? kpos1 : kpos2)
  kgate2    =  (kneg1 < kneg2 ? kneg1 : kneg2)
  kgate     =  kgate1 + kgate2
  agate     upsamp    kgate
            out       agate*ilevl

endin

instr    4 ; Gate - passes quietest input

  ilevl     =  p4                                 ; Output level

  ain1      soundin   "sample1.wav"
  ain2      soundin   "sample2.wav"

  kin1      downsamp  ain1
  kin2      downsamp  ain2
  kpos1     limit     kin1, 0, 32768
  kneg1     limit     kin1,-32768, 0
  kpos2     limit     kin2, 0, 32768
  kneg2     limit     kin2,-32768, 0
  kgate1    =  (kpos1 < kpos2 ? kpos1 : kpos2)
  kgate2    =  (kneg1 > kneg2 ? kneg1 : kneg2)
  kgate     =  kgate1 + kgate2
  agate     upsamp    kgate
            out       agate*ilevl

endin
