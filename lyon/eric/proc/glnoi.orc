  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
  gipo      =  1.570796
  gigain    =  2.5


instr 1
  gasrc     soundin   p4,p5
endin
; MONO SOURCE:
;i1 0 dur file skip
;i2 0 dur res1 res2 amp bfac loc fmult
; STEREO SOURCE:
;i3 0 dur file skip
;i4 0 dur res1 res2 res3 res4 amp bfac loc
; res1 -> res2 and res3 -> res4 : gliss
;note: res2mult scales res1 to generate res2
instr 2
  iatk      =  p3 * .2
  idk       =  p3 * .8
  ires1     =  p4
  ires2     =  p5
  ires3     =  p6
  ires4     =  p7
  iamp      =  p8 * gigain
  ibw1      =  p9*ires1
  ibw2      =  p9*ires2
  ibw3      =  p9*ires3
  ibw4      =  p9*ires4
  iloc1     =  p10
  iloc2     =  1.0 - p10
  ileft1    =  cos(gipo*iloc1)
  iright1   =  sin(gipo*iloc1)
  ileft2    =  cos(gipo*iloc2)
  iright2   =  sin(gipo*iloc2)


  kenv      linseg    0,iatk,iamp,idk,0
  kfr1      line      ires1,p3,ires2
  kfr2      line      ires3,p3,ires4
  kbw1      line      ibw1,p3,ibw2
  kbw2      line      ibw3,p3,ibw4
  ares1a    reson     gasrc,kfr1,kbw1,1
  ares1     reson     ares1a,kfr1,kbw1,1
  ares2a    reson     gasrc,kfr2,kbw2,1
  ares2     reson     ares2a,kfr2,kbw2,1
  aout1     =  (ares1*ileft1)+(ares2*ileft2)
  aout2     =  (ares1*iright2)+(ares2*iright2)
            outs      aout1*kenv, aout2*kenv 
endin
instr 3
  gasrc1, gasrc2      soundin                     p4,p5
endin
instr 4
  iatk      =  p3 * .2
  idk       =  p3 * .8
  ires1     =  p4
  ires2     =  p5
  ires3     =  p6
  ires4     =  p7
  iamp      =  p8 * gigain
  ibw1      =  p9*ires1
  ibw2      =  p9*ires2
  ibw3      =  p9*ires3
  ibw4      =  p9*ires4
  iloc1     =  p10
  iloc2     =  1.0 - p10
  ileft1    =  cos(gipo*iloc1)
  iright1   =  sin(gipo*iloc1)
  ileft2    =  cos(gipo*iloc2)
  iright2   =  sin(gipo*iloc2)


  kenv      linseg    0,iatk,iamp,idk,0
  kfr1      line      ires1,p3,ires2
  kfr2      line      ires3,p3,ires4
  kbw1      line      ibw1,p3,ibw2
  kbw2      line      ibw3,p3,ibw4
  ares1a    reson     gasrc1,kfr1,kbw1,1
  ares1     reson     ares1a,kfr1,kbw1,1
  ares2a    reson     gasrc2,kfr2,kbw2,1
  ares2     reson     ares2a,kfr2,kbw2,1
  aout1     =  (ares1*ileft1)+(ares2*ileft2)
  aout2     =  (ares1*iright2)+(ares2*iright2)
            outs      aout1*kenv, aout2*kenv 
 
endin
