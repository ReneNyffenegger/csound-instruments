  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; Dynamic Waveshaper - randomly crossfades between 8 tables

  ilevl     =  p4*32767                           ; Output level
  irate     =  p5                                 ; Rate
  itabl1    =  p6                                 ; 1st table
  itabl2    =  p7                                 ; 2nd table
  itabl3    =  p8                                 ; 3rd table
  itabl4    =  p9                                 ; 4th table
  itabl5    =  p10                                ; 5th table
  itabl6    =  p11                                ; 6th table
  itabl7    =  p12                                ; 7th table
  itabl8    =  p13                                ; 8th table
  iseed     =  rnd(1)

  ain       soundin   "sample1.wav"

  ain       =  ain/65535
  kdclick   linseg    0, .002, 1, p3 - .004, 1, .002, 0
  krnd      randi     .5, irate, iseed
  krnd      =  krnd + .5
  krnd1     tablei    krnd, 100, 1,  0, 1
  krnd2     tablei    krnd, 100, 1, .125, 1
  krnd3     tablei    krnd, 100, 1, .250, 1
  krnd4     tablei    krnd, 100, 1, .375, 1
  krnd5     tablei    krnd, 100, 1, .500, 1
  krnd6     tablei    krnd, 100, 1, .625, 1
  krnd7     tablei    krnd, 100, 1, .750, 1
  krnd8     tablei    krnd, 100, 1, .875, 1
  awav1     tablei    ain, itabl1, 1, .5
  awav2     tablei    ain, itabl2, 1, .5
  awav3     tablei    ain, itabl3, 1, .5
  awav4     tablei    ain, itabl4, 1, .5
  awav5     tablei    ain, itabl5, 1, .5
  awav6     tablei    ain, itabl6, 1, .5
  awav7     tablei    ain, itabl7, 1, .5
  awav8     tablei    ain, itabl8, 1, .5
  asum1     mac       awav1, krnd1, awav2, krnd2, awav3, krnd3, awav4, krnd4
  asum2     mac       awav5, krnd5, awav6, krnd6, awav7, krnd7, awav8, krnd8
  aout      atone     asum1 + asum2, 15
            out       aout*ilevl*kdclick

endin