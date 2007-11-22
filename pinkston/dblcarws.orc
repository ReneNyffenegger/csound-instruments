  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;=========================================================================;
;                                                                         ;
;               Multi-carrier Waveshaping Instruments                     ;
;                                                                         ;
;=========================================================================;
;                Coded by Russell Pinkston - Univ. of Texas               ;
;=========================================================================;

instr   10

  ihertz    =  cpspch(p4)
  ipkamp    =  p5
  iwsfn     =  p6                                 ;waveshaping function
  inmfn     =  p7                                 ;normalization function
  ixris     =  p8                                 ;index rise time
  ixdec     =  p9                                 ;index decay time
  ihertz1   =  p10*ihertz
  ihertz2   =  p11*ihertz
  icarfn    =  p12
  kgate     linen     1,.01,p3,.1                 ;overall amp envelope
  kctrl     linen     .999,ixris,p3,ixdec         ;waveshaping index control
  kamp1     linseg    1,p3/2,0,p3/2,1             ;crossfade control
  kamp2     =  1-kamp1
  acar1     oscili    kamp1,ihertz1,icarfn        ;carrier1
  acar2     oscili    kamp2,ihertz2,icarfn        ;carrier2
  aindex    =  kctrl/2*(acar1+acar2)
  asignal   tablei    .5+aindex,iwsfn,1           ;waveshaping
  knormal   tablei    kctrl,inmfn,1               ;amplitude normalization
            out       asignal*knormal*ipkamp*kgate
endin

;==================================================================;
;Variation of instr 10 with randomized LFO gating. It also uses    ;
;balance instead of a normalization table. Note that results sound ;
;the same as with normalization, but balance removes DC Bias.      ;
;==================================================================;

instr   11

  ihertz    =  cpspch(p4)
  ipkamp    =  p5
  iwsfn     =  p6                                 ;waveshaping function
  inmfn     =  p7                                 ;normalization function
  ixris     =  p8                                 ;index rise time
  ixdec     =  p9                                 ;index decay time
  ihertz1   =  p10*ihertz
  ihertz2   =  p11*ihertz
  icarfn    =  p12
  ilfohz    =  p13
  idepth    =  p14
  ibase     =  1-idepth
  ilfofn    =  p15
  irhz      =  p16
  irfac     =  p17                                ;amount of random deviation
  irbase    =  1-irfac                            ;unvaried part
  iseed     =  p18                                ;seed for randi
  krval     randi     irfac/2,irhz,iseed
  krval     =  irbase+krval                       ;offset 0-1
  kdepth    =  idepth*krval                       ;randomize the lfo amplitude
  klfohz    =  ilfohz*krval                       ;randomize the lfo frequency
  klfo      oscili    kdepth,klfohz,ilfofn        ;AM (tremolo)
  klfo      =  ibase+klfo                         ;base amt plus random
  kgate     linen     klfo,.01,p3,.1              ;overall amp envelope
  kctrl     linen     .999*klfo,ixris,p3,ixdec    ;waveshaping index control
  kamp1     linseg    1,p3/2,0,p3/2,1             ;crossfade control
  kamp2     =  1-kamp1
  acar1     oscili    kamp1,ihertz1,icarfn        ;carrier1
  acar2     oscili    kamp2,ihertz2,icarfn        ;carrier2
  aindex    =  kctrl*(acar1+acar2)
  asignal   tablei    .5+.5*aindex,iwsfn,1        ;waveshaping
  asignal   balance   asignal,aindex
            out       asignal*ipkamp*kgate
endin