  sr        =  44100
  kr        =  4410
  ksmps     =  10


;i1 0 dur file skip gain
;i2 0 dur res1 bw
instr 1
  igain     =  p6
  ifile     =  p4
  iskip     =  p5
  kenv      linseg    0, .01 , igain , p3-.05, igain, .04, 0
  araw      soundin   ifile, iskip
  garaw     =  araw * kenv
endin
instr 2
  ires1     =  p4
  ibw       =  ires1 * p5 
  ares      reson     garaw,ires1,ibw,1
            out       ares
endin
instr 3
  ires1     =  p4
  igain     =  p5 * 5
  ibw       =  ires1 * p6 
  ares      reson     garaw,ires1,ibw,1
            out       ares*igain
endin

