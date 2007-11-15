  sr        =  48000
  ksmps     =  2
  nchnls    =  1

  ga0x      init      0

instr 1

/* ----------------------------------------------------------------------------------------- */
  ibpm      =  140.000                            ; tempo
  ivol      =  0.5                                ; volume
  irel      =  0.05                               ; release time
  ifmax     =  5.3333                             ; max. frequency / note frq.
  ifdec     =  12                                 ; frequency decay speed
  ifmax2    =  4                                  ; max. frequency 2 / note frq.
  ifdec2    =  1024                               ; frequency 2 decay speed
  iamax     =  0.5                                ; start amplitude
  iadec     =  16                                 ; amplitude -> 1.0 speed
  iamax2    =  -4                                 ; start amp. 2
  iadec2    =  1024                               ; amp2 -> 1.0 speed
  iLP1f     =  2                                  ; lowpass filter 1 start freq. / oscillator freq.
  iLP1fd    =  6                                  ; LP filter 1 freq. decay speed
  iHPxf     =  1.5                                ; output resonant HP filter freq. / note frq.
  iHPxq     =  1.5                                ; output resonant HP filter Q

/* ----------------------------------------------------------------------------------------- */

  icps      =  440.0*exp(log(2.0)*(p4-69.0)/12.0)   /* read input parameters from score */
  iamp      =  0.0039+p5*p5/16192
  p3        =  p3+irel+0.05

  ibtime    =  60/ibpm                              /* convert parameters */
  iHPxf     =  iHPxf*icps

  iSCALE0   =  sr/(10*3.141593)                     /* scale for BUZZ oscillators*/

/* -------- ENVELOPES -------- */

  kfrq      port      1,ibtime/ifdec,ifmax               /* base freq. envelope */
  kfrq_     port      1,ibtime/ifdec2,ifmax2
  kfrq      =  kfrq*kfrq_*icps
  kamp1     linseg    1,p3-(irel+0.05),1,irel,0,1,0    /* amp. envelope 1 (avoid clicks at note end) */
  kamp      expon     1,ibtime/iadec,0.5                /* amp. envelopes */
  kamp2     expon     1,ibtime/iadec2,0.5
  kamp      =  iamp*kamp1*(kamp*(iamax-1)+1)*(kamp2*(iamax2-1)+1)

  kffrq1    port      0,ibtime/iLP1fd,iLP1f              /* lowpass 1 freq. envelope */
  kffrq1    =  kffrq1*kfrq

/* -------- OSCILLATOR -------- */

  k_nh_     =  int(sr/(2*kfrq))
  a_1_      buzz      iSCALE0,kfrq,k_nh_,1,0
  a_2_      buzz      iSCALE0,kfrq,k_nh_,1,0.5
  aosc0     tone      a_1_-a_2_,10

/* -------- FILTERS -------- */

  a1        butterlp  aosc0,kffrq1           /* lowpass 1 */

  a1        pareq     a1,iHPxf,iHPxq*2,iHPxq,0  /* resonant HP */
  a_        tone      a1,iHPxf
  a1        =  a1-a_
  a_        tone      a1,iHPxf
  a1        =  a1-a_

/* -------- OUTPUT -------- */

  ga0x      =  ga0x+(kamp*ivol*(1.0*a1))

endin

instr 90

  a0x       table3    ga0x/2.80,100,1,0.5,0    /* distortion table */
  ga0x      =  0

            out       a0x*30000

endin


