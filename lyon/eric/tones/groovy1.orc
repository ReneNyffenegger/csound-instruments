  sr        =  44100
  kr        =  4410
  ksmps     =  10
;cheesy FM

;f1 0 4096 10 1
;i1 0 dur freq amp

instr 1 ; accent
  icar      =  1.0
  imod      =  2.01
  iatk      =  .01
  idk1      =  .01
  idk2      =  p3-(iatk+idk1)
  iamp      =  4000 * p5
  iamp2     =  iamp*.4
  ifreq2    =  p4 
  irvt      =  .2
  ilpt      =  1/cpspch(p4)
  ifrsp     =  4
  ifrseed   =  .1111
  inspee    =  5
  inseed    =  .2343
  ikspeed   =  1.181
  iseed3    =  .45252
  iseed4    =  .16667
  irespeed  =  6
  ksafenv   linseg    0,.05,iamp,p3-.5,iamp,.45,0
  kcps      randi     p4*.2, ifrsp, ifrseed
  kcps      =  kcps + p4        
  kndex     randi     2.0, inspee, inseed
  kndex     =  kndex + 2.1
  kkspeed   randi     ikspeed/2, 1.0, iseed3
  kkspeed   =  ikspeed + kkspeed
  kmod      oscil     1, kkspeed, 2
  afm       foscil    ksafenv, kcps, icar, kmod, kndex, 1 ; sine
        ;kres randi kcps*.6, irespeed, iseed4
        ;kbw = kres + (kcps*.7)
        ;ares reson afm, kcps, kbw, 1
  arev      alpass    afm, .5, .02
            out       arev
endin
