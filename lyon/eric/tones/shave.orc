  sr        =  44100
  kr        =  8820
  ksmps     =  5
  nchnls    =  2
; glassy tone generator
;min duration = 1.0
;f1 0 2048 10 1 0 .1 .3 .05 .1 0 0 .05
;i1 0 dur freq amp seed1 seed2 atk dk

  giglobgain   =      4000
  gisinefunc   =      1                           ; 1 is a sine wave

instr 1
  ifreq     =  p4
  iamp1     =  p5 * giglobgain
  iamp2     =  iamp1 * ampdb(-20)
  iamp3     =  iamp1 * ampdb(-35)
  iatk      =  p6                                 ; set between .005 .008
  idk1      =  p7                                 ; set to .05 - .08
  idk2      =  p8                                 ; set to .3 - .6
  idk3      =  p3 - (iatk+idk1+idk2)
  ivibdepth1   =      p9 * ifreq                  ; set to .05 - .1 
  ivibdepth2   =      ivibdepth1 * .25
  ivibdepth3   =      ivibdepth1 * .5
  ivibspeed =  p10                                ; set to 5 - 10 Hz
  ivibseg1  =  .3
  ivibseg2  =  p3 - ivibseg1
; FREQUENCY BLOCK
  ifr1      =  ifreq
  ifr2      =  ifreq * p11                        ; set to near 1.04
  ifr3      =  ifreq * p12                        ; set to near 1.015
  ifr4      =  ifreq * p13                        ; set to near .95
  ifrs1     =  p14                                ; set to near .01
  ifrs2     =  p15                                ; set to near .02
  ifrs3     =  p16                                ; set to near .05
  ifrs5     =  p17                                ; set to near .2
  ifrs4     =  p3-(ifrs1+ifrs2+ifrs3+ifrs5)
  itonefunc =  p18                                ; toggle according to frequency
; RESON BLOCK
  iresbw    =  .25
  ires1mult =  1.0
  ires2mult =  2.0
  ires1cf   =  ifreq*ires1mult
  ires2cf   =  ifreq*ires2mult
  ires1bw   =  ires1cf * iresbw
  ires2bw   =  ires2cf * iresbw
  ires1atk  =  p3 * .3
  ires1dk   =  p3 - ires1atk
  ires2atk  =  p3*.7
  ires2dk   =  p3 - ires2atk
  iresgain  =  40.0
;PAN BLOCK
  ipans1    =  p19                                ; set to .4- .7
  ipans2    =  p3-ipans1
  ipanloc   =  p20                                ; random between (say) .25 - .75
  ipanmin   =  -1.0 * ipanloc
  ipanmax   =  1.0 - ipanloc
  ipanamp   =  (ipanmax-ipanmin)/2.0
  iseed     =  p21                                ; random 0.0 - 1.0
  ipanspeed =  p22                                ; set to 5 - 13 Hz
  ipanampadd   =      ipanmin + ipanloc
  ampenv    linseg    0,iatk,iamp1,idk1,iamp2,idk2,iamp3,idk3,0
  kresonamp1   linseg   0, ires1atk, iresgain, ires1dk, 0
  kresonamp2   linseg   0, ires2atk, iresgain, ires2dk, 0
  kpanenv   linseg    0., ipans1, 0., ipans2, 1.0
  apan      randi     .5, ipanspeed, iseed
  apan      =  (apan + .5 + ipanmin)*kpanenv
  apan      =  apan + ipanloc
  apan      =  apan * .25                         ; SCALE FOR USE AS LOOKUP INDEX
  aleft     tablei    apan, gisinefunc, 1         ; SINCOS PAN USING LOOKUP
  apan      =  apan + .25
  aright    tablei    apan, gisinefunc, 1         ;
  kvibenv   linseg    ivibdepth1,ivibseg1,ivibdepth2,ivibseg2,ivibdepth3
  kfreq     linseg    ifr1,ifrs1,ifr2,ifrs2,ifr3,ifrs3,ifr1,ifrs4,ifr1,ifrs5,ifr4
  kvib      oscil     kvibenv, ivibspeed, 1, gisinefunc
  kfreq     =  kfreq + kvib
  audio1    oscili    ampenv, kfreq, itonefunc
  audiores1 reson     audio1, ires1cf, ires1bw, 1
  audiores2 reson     audio1, ires2cf, ires2bw, 1
  audiores1 =  audiores1 * kresonamp1
  audiores2 =  audiores2 * kresonamp2
  audio2    =  audio1+audiores1+audiores2
            outs      audio2*aleft, audio2*aright
endin
