  sr        =  44100
  kr        =  22050
  ksmps     =  2
  nchnls    =  2

instr 1

  iamdepth  =  .3
  iag1      =  iamdepth/2.
  iag2      =  (1.-iamdepth)+iag1
  imaxdel   =  .025 
  imaxdel2  =  .08                                ; delay for stereo copies
  imax1     =  imaxdel * .49
  imax2     =  imaxdel * .5
  imax3     =  imaxdel2 * .49
  imax4     =  imaxdel2 * .5
  imax      =  imaxdel * 2.01
  imaxx     =  imaxdel2 * 2.01
  iseed1    =  .33
  iseed2    =  .133
  iseed3    =  .7533
  iseed4    =  .66
  iseed5    =  .2133
  iseed6    =  .394
  iseed7    =  .867
  iseed8    =  .567
  iseed9    =  .467
  iseed10   =  .337
  iseed11   =  .217
  iseed12   =  .35867

  irsp1     =  1.37                               ; speed of random vib
  irsp2     =  1.17                               ; speed of random vib
  irsp3     =  1.86                               ; speed of random vib
  irsp4     =  1.55                               ; speed of random vib
  irsp5     =  1.62                               ; speed of random vib
  irsp6     =  1.55                               ; speed of random vib
  irsp7     =  .75                                ; speed of random vib
  irsp8     =  .83                                ; speed of random vib
  irsp9     =  .36                                ; speed of random vib
  irsp10    =  .95                                ; speed of random vib
  irsp11    =  1.07                               ; speed of random vib
  irsp12    =  .46                                ; speed of random vib

  itsp1     =  2.5                                ; speed of random tremolo
  itsp2     =  2.75                               ; speed of random tremolo
  itsp3     =  2.63                               ; speed of random tremolo
  itsp4     =  2.15                               ; speed of random tremolo
  itsp5     =  3.21                               ; speed of random tremolo
  itsp6     =  2.65                               ; speed of random tremolo

  ifile     =  p4
  iskip     =  p5
  igain     =  4.0/7.0

  a1        soundin   ifile, iskip
  a1        =  a1 * igain

  kfr1      randi     imax1, irsp1, iseed1
  kfr2      randi     imax1, irsp2, iseed2
  kfr3      randi     imax1, irsp3, iseed3
  kfr4      randi     imax1, irsp4, iseed4
  kfr5      randi     imax1, irsp5, iseed5
  kfr6      randi     imax1, irsp6, iseed6
  kfr1      =  kfr1 + imax2
  kfr2      =  kfr2 + imax2
  kfr3      =  kfr3 + imax2
  kfr4      =  kfr4 + imax2
  kfr5      =  kfr5 + imax2
  kfr6      =  kfr6 + imax2
  
  kfr1a     randi     imax3, irsp7, iseed7
  kfr2a     randi     imax3, irsp8, iseed8
  kfr3a     randi     imax3, irsp9, iseed9
  kfr4a     randi     imax3, irsp10, iseed10
  kfr5a     randi     imax3, irsp11, iseed11
  kfr6a     randi     imax3, irsp12, iseed12
  kfr1a     =  kfr1a + imax4
  kfr2a     =  kfr2a + imax4
  kfr3a     =  kfr3a + imax4
  kfr4a     =  kfr4a + imax4
  kfr5a     =  kfr5a + imax4
  kfr6a     =  kfr6a + imax4

  ktrem1    randi     iag1, itsp1, iseed1
  ktrem2    randi     iag1, itsp2, iseed2
  ktrem3    randi     iag1, itsp3, iseed3
  ktrem4    randi     iag1, itsp4, iseed4
  ktrem5    randi     iag1, itsp5, iseed5
  ktrem6    randi     iag1, itsp6, iseed6

  ktrem1    =  ktrem1 + iag2
  addl1     delayr    imax
  atap1     deltapi   kfr1
  atap2     deltapi   kfr2
  atap3     deltapi   kfr3
  atap4     deltapi   kfr4
  atap5     deltapi   kfr5
  atap6     deltapi   kfr6
            delayw    a1

  atap1     =  atap1 * ktrem1
  atap2     =  atap2 * ktrem2
  atap3     =  atap3 * ktrem3
  atap4     =  atap4 * ktrem4
  atap5     =  atap5 * ktrem5
  atap6     =  atap6 * ktrem6

  adt1      delayr    imaxx
  atap1a    deltapi   kfr1a
            delayw    atap1
  adt2      delayr    imaxx
  atap2a    deltapi   kfr2a
            delayw    atap2
  adt3      delayr    imaxx
  atap3a    deltapi   kfr3a
            delayw    atap3
  adt4      delayr    imaxx
  atap4a    deltapi   kfr4a
            delayw    atap4
  adt5      delayr    imaxx
  atap5a    deltapi   kfr5a
            delayw    atap5
  adt6      delayr    imaxx
  atap6a    deltapi   kfr6a
            delayw    atap6
  aleft     =  atap1+atap2a+atap3+atap4a+atap5+atap6a+a1
  aright    =  atap1a+atap2+atap3a+atap4+atap5a+atap6+a1
            outs      aleft, aright
endin
instr 2

  iamdepth  =  .3
  iag1      =  iamdepth/2.
  iag2      =  (1.-iamdepth)+iag1
  imaxdel   =  .025 
  imaxdel2  =  .08                                ; delay for stereo copies
  imax1     =  imaxdel * .49
  imax2     =  imaxdel * .5
  imax3     =  imaxdel2 * .49
  imax4     =  imaxdel2 * .5
  imax      =  imaxdel * 2.01
  imaxx     =  imaxdel2 * 2.01
  iseed1    =  .33
  iseed2    =  .133
  iseed3    =  .7533
  iseed4    =  .66
  iseed5    =  .2133
  iseed6    =  .394
  iseed7    =  .867
  iseed8    =  .567
  iseed9    =  .467
  iseed10   =  .337
  iseed11   =  .217
  iseed12   =  .35867

  irsp1     =  1.37                               ; speed of random vib
  irsp2     =  1.17                               ; speed of random vib
  irsp3     =  1.86                               ; speed of random vib
  irsp4     =  1.55                               ; speed of random vib
  irsp5     =  1.62                               ; speed of random vib
  irsp6     =  1.55                               ; speed of random vib
  irsp7     =  .75                                ; speed of random vib
  irsp8     =  .83                                ; speed of random vib
  irsp9     =  .36                                ; speed of random vib
  irsp10    =  .95                                ; speed of random vib
  irsp11    =  1.07                               ; speed of random vib
  irsp12    =  .46                                ; speed of random vib

  itsp1     =  2.5                                ; speed of random tremolo
  itsp2     =  2.75                               ; speed of random tremolo
  itsp3     =  2.63                               ; speed of random tremolo
  itsp4     =  2.15                               ; speed of random tremolo
  itsp5     =  3.21                               ; speed of random tremolo
  itsp6     =  2.65                               ; speed of random tremolo

  ifile     =  p4
  iskip     =  p5
  igain     =  4.0/7.0

  a1,a2     soundin   ifile, iskip
  a1        =  a1 * igain
  a2        =  a2 * igain

  kfr1      randi     imax1, irsp1, iseed1
  kfr2      randi     imax1, irsp2, iseed2
  kfr3      randi     imax1, irsp3, iseed3
  kfr4      randi     imax1, irsp4, iseed4
  kfr5      randi     imax1, irsp5, iseed5
  kfr6      randi     imax1, irsp6, iseed6
  kfr1      =  kfr1 + imax2
  kfr2      =  kfr2 + imax2
  kfr3      =  kfr3 + imax2
  kfr4      =  kfr4 + imax2
  kfr5      =  kfr5 + imax2
  kfr6      =  kfr6 + imax2
  
  kfr1a     randi     imax3, irsp7, iseed7
  kfr2a     randi     imax3, irsp8, iseed8
  kfr3a     randi     imax3, irsp9, iseed9
  kfr4a     randi     imax3, irsp10, iseed10
  kfr5a     randi     imax3, irsp11, iseed11
  kfr6a     randi     imax3, irsp12, iseed12
  kfr1a     =  kfr1a + imax4
  kfr2a     =  kfr2a + imax4
  kfr3a     =  kfr3a + imax4
  kfr4a     =  kfr4a + imax4
  kfr5a     =  kfr5a + imax4
  kfr6a     =  kfr6a + imax4

  ktrem1    randi     iag1, itsp1, iseed1
  ktrem2    randi     iag1, itsp2, iseed2
  ktrem3    randi     iag1, itsp3, iseed3
  ktrem4    randi     iag1, itsp4, iseed4
  ktrem5    randi     iag1, itsp5, iseed5
  ktrem6    randi     iag1, itsp6, iseed6

  ktrem1    =  ktrem1 + iag2
  addl1     delayr    imax
  atap1     deltapi   kfr1
  atap3     deltapi   kfr3
  atap5     deltapi   kfr5
            delayw    a1
  addl2     delayr    imax
  atap2     deltapi   kfr2
  atap4     deltapi   kfr4
  atap6     deltapi   kfr6
            delayw    a2

  atap1     =  atap1 * ktrem1
  atap2     =  atap2 * ktrem2
  atap3     =  atap3 * ktrem3
  atap4     =  atap4 * ktrem4
  atap5     =  atap5 * ktrem5
  atap6     =  atap6 * ktrem6

  adt1      delayr    imaxx
  atap1a    deltapi   kfr1a
            delayw    atap1
  adt2      delayr    imaxx
  atap2a    deltapi   kfr2a
            delayw    atap2
  adt3      delayr    imaxx
  atap3a    deltapi   kfr3a
            delayw    atap3
  adt4      delayr    imaxx
  atap4a    deltapi   kfr4a
            delayw    atap4
  adt5      delayr    imaxx
  atap5a    deltapi   kfr5a
            delayw    atap5
  adt6      delayr    imaxx
  atap6a    deltapi   kfr6a
            delayw    atap6
  aleft     =  atap1+atap2a+atap3+atap4a+atap5+atap6a+a1
  aright    =  atap1a+atap2+atap3a+atap4+atap5a+atap6+a1
            outs      aleft, aright
endin
