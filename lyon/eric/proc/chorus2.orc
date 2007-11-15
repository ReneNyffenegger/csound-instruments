  sr        =  44100
  kr        =  22050
  ksmps     =  2

instr 1

  iamdepth  =  .3
  iag1      =  iamdepth/2.
  iag2      =  (1.-iamdepth)+iag1
  imaxdel   =  p6 
  imax1     =  imaxdel * .49
  imax2     =  imaxdel * .5
  iseed1    =  p6
  iseed2    =  p7
  iseed3    =  p8
  iseed4    =  p9
  iseed5    =  p10
  iseed6    =  p11
  irsp1     =  1.37                               ; speed of random vib
  irsp2     =  1.17                               ; speed of random vib
  irsp3     =  1.86                               ; speed of random vib
  irsp4     =  1.55                               ; speed of random vib
  irsp5     =  1.62                               ; speed of random vib
  irsp6     =  1.55                               ; speed of random vib
  itsp1     =  2.5                                ; speed of random tremolo
  itsp2     =  2.75                               ; speed of random tremolo
  itsp3     =  2.63                               ; speed of random tremolo
  itsp4     =  2.15                               ; speed of random tremolo
  itsp5     =  3.21                               ; speed of random tremolo
  itsp6     =  2.65                               ; speed of random tremolo

  imax      =  imaxdel * 2.01
  ifile     =  p4
  iskip     =  p5
  igain     =  4.0/7.0

  a1        soundin   ifile, iskip

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

  amono     =  atap1+atap2+atap3+atap4+atap5+atap6+a1
            out       amono * igain
endin
