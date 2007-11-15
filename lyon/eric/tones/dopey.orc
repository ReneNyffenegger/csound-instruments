  sr        =  44100
  kr        =  8820
  ksmps     =  5

; bonked out tone generator
;min duration .52
;f1 0 2048 10 1 0 .1 .3 .05 .1 0 0 .05
;i1 0 dur freq amp seed1 seed2 atk dk

  giglobgain   =      2000

instr 1
;ifreq = (cpspch( p4 )) * (1.0) 
  ifreq     =  p4
  igain     =  p5 * giglobgain
  iseed1    =  p6 
  iseed2    =  p7 
  iatk      =  p8
  idk       =  p9
  isust     =  p3-(iatk+idk)
  ibdev     =  .02
  idev      =  .01
  imax1     =  1.0 
  icup      =  .01
  icsust    =  p3-(icup)

  aclean    linseg    1, icsust, 1, icup, 0
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
  araw      oscili    aenv, ifreq, 1
  krndenv   linseg    1, .4, .3, p3-.4, .02
  kdel1     randi     idev, 1.0, iseed1
  kdel1     =  ( kdel1 * krndenv ) + ibdev
  kdel2     randi     idev, 3.0, iseed2
  kdel2     =  ( kdel2  * krndenv ) + ibdev
  addl1     delayr    imax1 
  atap1     deltapi   kdel1
  atap2     deltapi   kdel2
  araw      =  araw + .25*(atap1+atap2)
            delayw    araw
  asum1     =  (atap1 + atap2 + araw) 
            out       asum1*aclean
endin


instr 2 ; glissando version
;ifreq = (cpspch( p4 )) * (1.0) 
  ifreq1    =  cpspch( p4 )
  ifreq2    =  cpspch( p5 )
  igain     =  3000
  iseed1    =  p6 
  iseed2    =  p7 
  iatk      =  p8
  idk       =  p9
  isust     =  p3-(iatk+idk)
  ibdev     =  .02
  idev      =  .01
  imax1     =  1.0 
  icup      =  .01
  icsust    =  p3-(icup)

  aclean    linseg    1, icsust, 1, icup, 0
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
  kpch      line      ifreq1, p3, ifreq2
        ;kfreq = cpspch( kpch );
  araw      oscili    aenv, kpch, 1
  krndenv   linseg    1, .4, .3, p3-.4, .02
  kdel1     randi     idev, 1.0, iseed1
  kdel1     =  ( kdel1 * krndenv ) + ibdev
  kdel2     randi     idev, 3.0, iseed2
  kdel2     =  ( kdel2  * krndenv ) + ibdev
  addl1     delayr    imax1 
  atap1     deltapi   kdel1
  atap2     deltapi   kdel2
  araw      =  araw + .25*(atap1+atap2)
            delayw    araw
  asum1     =  (atap1 + atap2 + araw) 
            out       asum1*aclean
endin

