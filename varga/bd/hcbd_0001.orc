  sr        =  48000
  ksmps     =  2
  nchnls    =  1

  gaOUT     init      0

/* sawtooth wave generator using buzz opcode            */
/* input parameters:    k_f_    :  frequency,           */
/*                      i_p_    :  phase,               */
/*                      i_t_    :  sine table number    */
/* output:              a_      (amplitude = 1)         */

#define SawToothOscillator #

  a_        buzz      1.2732395*(sr/k_f_),k_f_,sr/(2*k_f_),i_t_,i_p_
  a_        tone      a_,0.25*k_f_

#

instr 1

/* ------------------------------------------------------------------------- */

  ibpm      =  168                          /* tempo */
  ifrq0     =  5.3333                       /* start freq. */
  ivol      =  1.0                          /* volume */
  ifrqenv   =  16.0                         /* freq. envelope speed */
  ifltfrq   =  4.0                          /* filter frq. envelope speed */
  giffrq2   =  1.25                         /* res. HP filter frq. / note frequency */
  giflvl2   =  2.0                          /* res. HP filter resonance */

/* ------------------------------------------------------------------------- */

  iamp      =  ivol*(0.0039+(p5*p5)/16192)          /* velocity */
  icps      =  440.0*exp(log(2.0)*(p4-69.0)/12.0)   /* MIDI key number */
  p3        =  p3+0.05
  ibtime    =  60/ibpm

/* envelopes */

  kamp      linseg    1,p3-0.05,1,0.05,0,1,0
  kamp2     port      1,1/(icps*ifrq0),iamp*16
  kfrq      port      icps,ibtime/ifrqenv,icps*ifrq0
  kfrq2     port      0,ibtime/ifltfrq,icps*ifrq0

  gkFRQ0    =  icps
  gkFRQ1    =  icps*ifrq0
  gkFRQx    port      1,1/(icps*ifrq0),0
  gkFRQx    =  gkFRQx*kfrq

/* generate square wave */

  i_t_      =  1
  i_p_      =  0
  k_f_      =  kfrq
$SawToothOscillator
  a1        =  a_
  i_p_      =  0.5
$SawToothOscillator
  a1        =  a1-a_

/* filters */

  a1        butterlp  a1,kfrq2

  gaOUT     =  gaOUT+a1*8.00*iamp*kamp

endin

instr 80

  a1        =  gaOUT
  gaOUT     =  0

  a1        limit     a1,-1,1

  a2        butterhp  a1,gkFRQx*4
  a1        =  a1+a2
  a2        butterbp  a1,gkFRQx*2,gkFRQx
  a1        =  a1-a2
  a2        butterbp  a1,gkFRQ0*giffrq2,gkFRQ0*giffrq2/(giflvl2-1)
  a1        butterhp  a1+a2*(giflvl2-1),gkFRQ0*giffrq2

  a1        limit     a1*0.5,-1,1

            out       a1*28000

endin

