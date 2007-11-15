  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gipo      =  1.570796
; mono in -> stereo out
instr 1
  ga1       soundin   p4,p5
endin
;i1 0 dur file skip
;i2 0 dur res amp bandfac pos
instr 2
  ires      =  p4
  iamp      =  p6 * 2
  ibf       =  .05
  ipos      =  p7
  ileft     =  (cos(gipo*ipos))*iamp
  iright    =  (sin(gipo*ipos))*iamp
  ibw       =  ires*ibf 

  kenv      linseg    0,p3/2,iamp,p3/2,0
  ares      reson     ga1, ires, ibw, 1
  ares      =  ares * kenv
            outs      ares*ileft,ares*iright
endin
