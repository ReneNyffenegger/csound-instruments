  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1
  idur      =  .05
  insno     =  3
  ipkamp    =  p4
  ibase     =  octpch(p5)
  irndmax   =  p6
  iseed     =  p7
  kdur      linseg    .25,p3/2,.001,p3/2,.25
  kamp      linseg    ipkamp,p3/2,ipkamp/4,p3/2,ipkamp
  krnd      rand      irndmax/2,iseed
  krnd1     =  int(irndmax/2+krnd+.5)             ;some value in semitones
  koct      =  ibase+krnd1/12                     ;convert to octave
start:
            timout    0,.001+i(kdur),continue
            reinit    start
continue:
            schedule  insno,.001,.1,i(kamp),cpsoct(i(koct))
endin

instr   3
  agate     linen     p4,.001,p3,.02
  asig      oscili    agate,p5,1
            out       asig
endin
