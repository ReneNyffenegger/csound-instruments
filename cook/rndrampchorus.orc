  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2
            seed      0

instr    1 ; Chorus with random direction ramp LFO

  ilevl     =  p4                                 ; Output level
  idelay    =  p5/1000                            ; Delay in ms
  idepth    =  p6/1000                            ; LFO depth in ms
  irate     =  p7/kr/.25                          ; LFO rate
  irev      =  p8                                 ; LFO reversing rate
  imix      =  p9                                 ; Mix: 0=Input 1=Chorus
  imax      =  idelay + idepth + .1
  kramp     init      .5

  ain       soundin   "sample1.wav"

  iseed     =  rnd(1)
  krnd      randi     1, irev
if       krnd > 0 goto up
  kramp     =  kramp + irate
            goto      lfo
up:
  kramp     =  kramp - irate
lfo:
  klfo      mirror    kramp, 0, 1
  alfo1     upsamp    klfo
  alfo2     =  1 - alfo1
  achorus1  flanger   ain, alfo1*idepth + idelay, 0, imax
  achorus2  flanger   ain, alfo2*idepth + idelay, 0, imax
            outs1     (ain*imix + achorus1*(1 - imix))*ilevl
            outs2     (ain*imix + achorus2*(1 - imix))*ilevl

endin

