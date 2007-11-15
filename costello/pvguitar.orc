  sr        =  44100
  kr        =  2205
  ksmps     =  20 
  nchnls    =  2


instr 15

  ifreq     =  p4

  ktimpnt   linseg    0, 29, 29, 3, 28
  kenv      linseg    1, 30, 1, 3, 0
  aout      pvadd     ktimpnt,  2*ifreq, "fahey2048w8.pv", 1, 1, 3
  aout2     pvadd     ktimpnt,  .25,     "fahey2048w8.pv", 1, 1, 106
  aout3     pvadd     ktimpnt,  .25,     "fahey2048w8.pv", 1, 1, 127
  aout4     pvadd     ktimpnt,  2*ifreq, "fahey2048w8.pv", 1, 1, 8
  aout5     pvadd     ktimpnt,  5*ifreq, "fahey2048w8.pv", 1, 1, 4
  aout6     pvadd     ktimpnt,  .5,      "fahey2048w8.pv", 1, 1, 187
  aout7     pvadd     ktimpnt,  1,       "fahey2048w8.pv", 1, 1, 2

  aout8     =  (aout * .9 + aout2 * .7 + aout3 * .6 + aout4 * .4 + aout5 * .3 + aout6 * .1 + aout7 * .1) * 100
  aout9     =  (aout * .1 + aout2 * .3 + aout3 * .4 + aout4 * .6 + aout5 * .7 + aout6 * .9 + aout7 * .9) * 100

  arev1     reverb    aout5 * 15, 3.8
  arev2     reverb    aout5 * 15, 3.9

            outs      (aout8 + arev1) * kenv, (aout9 + arev2) * kenv


endin