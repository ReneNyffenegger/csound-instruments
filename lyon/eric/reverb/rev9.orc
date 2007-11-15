
  sr        =  44100
  kr        =  8820
  ksmps     =  5

instr 1
  idev1     =  .02
  imax1     =  idev1 * 2.1
  ifile     =  p4
  iskip     =  p5
  iorig     =  p6
  irev      =  1.-p6
  iegain    =  .2
  icgain    =  .05
  iagain    =  iorig/2

  ihpf      =  50
  icmblpf   =  2700
  ieclp1    =  .1
  ieclp2    =  .1327
  ieclp3    =  .0639
  ieclp4    =  .184
  iecrvt    =  1.0
  icombrvt  =  1.8
  ilpt1     =  1/30
  ilpt2     =  1/38
  ilpt3     =  1/43
  ilpt4     =  1/51
  iallrvt   =  .1
  araw      soundin   ifile,iskip
  aec1      comb      araw, iecrvt, ieclp1
  aec2      comb      araw, iecrvt, ieclp2
  aec3      comb      araw, iecrvt, ieclp3
  aec4      comb      araw, iecrvt, ieclp4
  aec       =  aec1+aec2+aec3+aec4
  aecho1    atone     aec, ihpf
        ; func1 is raised amp=1 cosine with small dc (.05 )
  adel1     oscil     idev1, 1.4, 1
  adel2     oscil     idev1, 1.63, 1
  adel3     oscil     idev1, 1.871, 1
  addl1     delayr    imax1
  atap1     deltapi   adel1
  atap2     deltapi   adel2
  atap3     deltapi   adel3
            delayw    aecho1
  aecho     =  (atap1+atap2+atap3) 
        ;acomb1 comb aecho, icombrvt, ilpt1
        ;acomb2 comb aecho, icombrvt, ilpt2
        ;acomb3 comb aecho, icombrvt, ilpt3
        ;acomb4 comb aecho, icombrvt, ilpt4
        ;asum = acomb1 + acomb2 + acomb3
        ;acomb tone asum, icmblpf
        ;acomb = acomb * icgain
  asum2     =  aecho * iegain

        ;asum2 = acomb + aecho
  all1      alpass    asum2, iallrvt, .006
  all2      alpass    asum2, iallrvt, .007
  all3      alpass    araw, 2.0, .03
  all3lp    tone      all3, 2000
  arev      =  all1 + all2 
  aout      =  (irev*arev)+(iorig*araw)+(all3lp*iagain)
            out       aout
endin
