  sr        =  44100
  kr        =  4410
  ksmps     =  10.0
  nchnls    =  1

instr     1
;================================================================;
;        Example Bank o' Filters Instrument                      ;
;                                                                ;  
; This instrument is similar to a 4-band parametric equalizer.   ;
; It uses four pairs of cascaded butterbp filters and allows the ;
; user to specify four center frequencies (in PCH) and four Qs.  ;
; With sufficiently high Q values (20-30), the bands are narrow  ;
; and resonant enough to generate distinct pitches, which can be ;
; tuned to chords. RP                                            ;
;================================================================; 

  igain     =  p4
  isndin    =  p5
  icf1      =  cpspch(p6)                         ;p6, 8, 10, 12 are in PCH
  ibw1      =  icf1/p7                            ;p7, 9, 11, 13 are Qs
  icf2      =  cpspch(p8)
  ibw2      =  icf2/p9
  icf3      =  cpspch(p10)
  ibw3      =  icf3/p11
  icf4      =  cpspch(p12)
  ibw4      =  icf4/p13

  asound    soundin   isndin
  ainput    =  (asound) * (igain)
  asig1     butterbp  ainput,icf1,ibw1
  asig2     butterbp  ainput,icf2,ibw2
  asig3     butterbp  ainput,icf3,ibw3
  asig4     butterbp  ainput,icf4,ibw4
  aout1     butterbp  asig1,icf1,ibw1
  aout2     butterbp  asig2,icf2,ibw2
  aout3     butterbp  asig3,icf3,ibw3
  aout4     butterbp  asig4,icf4,ibw4
  asum2     =  (aout3) + (aout4)
  asum1     =  (aout1) + (aout2)
  asum      =  (asum1) + (asum2)
  aoutput   balance   asum,ainput
            out       aoutput
endin
