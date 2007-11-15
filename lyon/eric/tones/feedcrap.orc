  sr        =  44100
  kr        =  882
  ksmps     =  50

instr 2
  gax0      =  20000.0
  gax1      =  0.0
  gax2      =  0.0
  gay1      =  0.0
  gay2      =  0.0
endin

instr 1
;ispeed1 = 911.35 good noise settings
;ispeed2 = 512.135
;ispeed3 = 407.535
;ispeed4 = 331.3545
;ispeed5 = 17.3275
  ispeed1   =  1.35
  ispeed2   =  1.135
  ispeed3   =  0.535
  ispeed4   =  3.3545
  ispeed5   =  7.3275

  iseed1    =  .9135
  iseed2    =  .4935
  iseed3    =  .7325
  iseed4    =  .8135
  iseed5    =  .69935

  kx0       randh     .5, ispeed1, iseed1
  kx1       randh     .5, ispeed2, iseed2
  kx2       randh     .5, ispeed3, iseed3
  ky1       randh     .5, ispeed4, iseed4
  ky2       randh     .5, ispeed5, iseed5

  asum1     =  (kx0*gax0)+(kx1*gax1)+(kx2*gax2)
  asum2     =  (ky1*gay1)+(ky2*gay2)
  gay0      =  asum1-asum2
swap:
  gax2      =  gax1
  gax1      =  gax0
  gay2      =  gay1
  gay1      =  gay0
  aout      atone     gay0, 500
            out       aout
endin

instr 3
  ispeed1   =  10.35
  ispeed2   =  30.135
  ispeed3   =  0.535
  ispeed4   =  10.3545
  ispeed5   =  13.3275

  iseed1    =  .09135
  iseed2    =  .04935
  iseed3    =  .07325
  iseed4    =  .8135
  iseed5    =  .069935
  iamp      =  10000.
  izero     =  0.
  ifeed     =  .75

  ax0       init      iamp
  ay0       init      izero
  kx0       randh     .7, ispeed1, iseed1
  kx1       randh     .6, ispeed2, iseed2
  kx2       randh     .5, ispeed3, iseed3
  ky1       randh     .4, ispeed4, iseed4
  ky2       randh     .3, ispeed5, iseed5
  ax1       delay1    ax0
  ax2       delay1    ax1
  ay1       delay1    ay0
  ay2       delay1    ay1
  asum1     =  (kx0*ax0)+(kx1*ax1)+(kx2*ax2)
  asum2     =  (ky1*ay1)+(ky2*ay2)
  ay0       =  asum1-asum2
  aout      atone     ay0, 500
            out       aout
endin