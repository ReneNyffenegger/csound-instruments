  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; Mono flanger With 'Sample & Hold' LFO

  ilevl     =  p4                                 ; Output level
  idelay    =  p5/1000                            ; Delay in ms
  idepth    =  p6/2000                            ; LFO depth in ms
  irate     =  p7                                 ; LFO rate in Hz
  ifeed     =  p8                                 ; Feedback (+/-)
  idry      =  p9                                 ; Dry signal level
  imax      =  idelay + idepth + .1

  ain       soundin   "sample1.wav"

  iseed     =  rnd(1)
  alfo      randh     idepth, irate, iseed
  alfo      =  alfo + idepth
  aflange   flanger   ain, alfo + idelay, ifeed, imax
            out       (ain*idry + aflange)*ilevl

endin

