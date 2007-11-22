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
;isndin    =         p5
  ipitch    =  cpspch(p5)
;inharms   =         int((sr/2)/ipitch)
  inharms   =  16
  iQ        =  25                                 ;experiment with this
  icf1      =  p6
  ibw1      =  icf1/iQ
  ifac1     =  10^(p7/20)
  icf2      =  p8
  ibw2      =  icf2/iQ
  ifac2     =  10^(p9/20)
  icf3      =  p10
  ibw3      =  icf3/iQ
  ifac3     =  10^(p11/20)
  icf4      =  p12
  ibw4      =  icf4/iQ
  ifac4     =  10^(p13/20)
  icf5      =  p14
  ibw5      =  icf5/iQ
  ifac5     =  10^(p15/20)
  isinefn   =  1                                  ;fn1 has sine wave in 8192 locs
  icutoff   =  ipitch                             ;experiment with this
;asound    soundin   isndin
  ivibwth   =  .02
  ivibhz    =  5
  kvib      oscili    ivibwth,ivibhz,1
  kpitch    =  ipitch*(1+kvib)
  asound    buzz      igain,kpitch,inharms,isinefn
  ainput    butlp     asound,icutoff              ;12 dB/Octave rolloff
  ainput    butlp     ainput,icutoff
;bank of 5 bandpass filters
  asig1     butterbp  ainput,icf1,ibw1
  asig2     butterbp  ainput,icf2,ibw2
  asig3     butterbp  ainput,icf3,ibw3
  asig4     butterbp  ainput,icf4,ibw4
  asig5     butterbp  ainput,icf5,ibw5
  aout1     butterbp  asig1,icf1,ibw1
  aout2     butterbp  asig2,icf2,ibw2
  aout3     butterbp  asig3,icf3,ibw3
  aout4     butterbp  asig4,icf4,ibw4
  aout5     butterbp  asig5,icf5,ibw5
            print     ifac1,ifac2,ifac3,ifac4,ifac5
  asum      =  aout1*ifac1+aout2*ifac2+aout3*ifac3+aout4*ifac4+aout5*ifac5
  aoutput   balance   asum,asound
  aoutput   linen     aoutput,.5,p3,.5
            out       aoutput
endin
