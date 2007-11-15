
#include "base_macros.h.orc"
$ORCHDR(48000'2'2)

#include "spat.h.orc"

/* mono output file name (file format: raw float samples) */

#define OUTFLNAME # "_tmp.pcm" #

/* spatializer macro */

#define SPATMACRO # $PhseStereo #

/* ------------------------------------------------------------------------- */

            seed      0
  gax0      init      0

instr 1

  imkey     =  p4           /* get note parameters from score file */
  imvel     =  p5

  imkey     limit     imkey,0,127
  imvel     limit     imvel,0,127

  icps      =  $MIDI2CPS(imkey)
  iamp      =  $VELOC2AMP(imvel)

/* ------------------------------------------------------------------------- */

  ivol      table     0,     64      /* output volume                        */
  ibpm      table     1,     64      /* tempo                                */

  ifrqs1    table     2,     64      /* oscillator start freq. 1 / note frq. */
  ifrqd1    table     3,     64      /* osc. frq. 1 decay speed at max. vel. */
  ifrqdx1   table     4,     64      /* osc. freq. 1 max. decay speed        */
  ifrqdxv   table     5,     64      /* note velocity for max. decay speed   */
  ifrqs2    table     6,     64      /* oscillator start freq. 2 / note frq. */
  ifrqd2    table     7,     64      /* osc. freq. 2 decay speed             */
  ifrqs3    table     8,     64      /* oscillator start freq. 3 / note frq. */
  ifrqd3    table     9,     64      /* osc. freq. 3 decay speed             */
  ifrqs4    table     10,     64      /* oscillator start freq. 4 / note frq. */
  ifrqd4    table     11,     64      /* osc. freq. 4 decay speed             */

  iffr1s    table     12,     64      /* lowpass filter start freq. 1 (Hz)    */
  iffr1d    table     13,     64      /* lowpass filter freq. 1 decay speed   */
  iffr2s    table     14,     64      /* lowpass filter start freq. 2 (Hz)    */
  iffr2d    table     15,     64      /* lowpass filter freq. 2 decay speed   */
  iffr3s    table     16,     64      /* LP filter start freq. 3 / note frq.  */
  iffr3d    table     17,     64      /* lowpass filter freq. 3 decay speed   */
  iffr4s    table     18,     64      /* LP filter start freq. 4 / note frq.  */
  iffr4d    table     19,     64      /* lowpass filter freq. 4 decay speed   */

  iEQ1fo    table     20,     64      /* EQ 1 frequency / osc. frequency      */
  iEQ1fn    table     21,     64      /* EQ 1 frequency / note frequency      */
  iEQ1fa    table     22,     64      /* EQ 1 frequency (Hz)                  */
  iEQ1l     table     23,     64      /* EQ 1 level                           */
  iEQ1q     table     24,     64      /* EQ 1 Q                               */
  iEQ1m     table     25,     64      /* EQ 1 mode (0:peak,1:low,2:high)      */
  iEQ0x     table     26,     64      /* EQ input mix to EQ output            */
  iEQ1x     table     27,     64      /* EQ 1 mix to EQ output                */

  iEQ2fo    table     28,     64      /* EQ 2 frequency / osc. frequency      */
  iEQ2fn    table     29,     64      /* EQ 2 frequency / note frequency      */
  iEQ2fa    table     30,     64      /* EQ 2 frequency (Hz)                  */
  iEQ2l     table     31,     64      /* EQ 2 level                           */
  iEQ2q     table     32,     64      /* EQ 2 Q                               */
  iEQ2m     table     33,     64      /* EQ 2 mode (0:peak,1:low,2:high)      */
  iEQ2i     table     34,     64      /* EQ 2 input (0: EQ 1, 1: EQ input)    */
  iEQ2x     table     35,     64      /* EQ 2 mix to EQ output                */

  iEQ3fo    table     36,     64      /* EQ 3 frequency / osc. frequency      */
  iEQ3fn    table     37,     64      /* EQ 3 frequency / note frequency      */
  iEQ3fa    table     38,     64      /* EQ 3 frequency (Hz)                  */
  iEQ3l     table     39,     64      /* EQ 3 level                           */
  iEQ3q     table     40,     64      /* EQ 3 Q                               */
  iEQ3m     table     41,     64      /* EQ 3 mode (0:peak,1:low,2:high)      */
  iEQ3i     table     42,     64      /* EQ 3 input (0: EQ 2, 1: EQ input)    */
  iEQ3x     table     43,     64      /* EQ 3 mix to EQ output                */

  iEQ4fo    table     44,     64      /* EQ 4 frequency / osc. frequency      */
  iEQ4fn    table     45,     64      /* EQ 4 frequency / note frequency      */
  iEQ4fa    table     46,     64      /* EQ 4 frequency (Hz)                  */
  iEQ4l     table     47,     64      /* EQ 4 level                           */
  iEQ4q     table     48,     64      /* EQ 4 Q                               */
  iEQ4m     table     49,     64      /* EQ 4 mode (0:peak,1:low,2:high)      */
  iEQ4i     table     50,     64      /* EQ 4 input (0: EQ 3, 1: EQ input)    */
  iEQ4x     table     51,     64      /* EQ 4 mix to EQ output                */

  insmix    table     52,     64      /* noise mix                            */

  iEQn1fo   table     53,     64      /* noise EQ 1 frequency / osc. freq.    */
  iEQn1fn   table     54,     64      /* noise EQ 1 frequency / note freq.    */
  iEQn1fa   table     55,     64      /* noise EQ 1 frequency (Hz)            */
  iEQn1l    table     56,     64      /* noise EQ 1 level                     */
  iEQn1q    table     57,     64      /* noise EQ 1 Q                         */
  iEQn1m    table     58,     64      /* noise EQ 1 mode (0:peak,1:lo,2:hi)   */

  iEQn2fo   table     59,     64      /* noise EQ 2 frequency / osc. freq.    */
  iEQn2fn   table     60,     64      /* noise EQ 2 frequency / note freq.    */
  iEQn2fa   table     61,     64      /* noise EQ 2 frequency (Hz)            */
  iEQn2l    table     62,     64      /* noise EQ 2 level                     */
  iEQn2q    table     63,     64      /* noise EQ 2 Q                         */
  iEQn2m    table     64,     64      /* noise EQ 2 mode (0:peak,1:lo,2:hi)   */

  imkmin    table     65,     64      /* MIDI key range for panning           */
  imkmax    table     66,     64

  iazim0    table     67,     64      /* azimuth range                        */
  iazim1    table     68,     64
  ielev0    table     69,     64      /* elevation range                      */
  ielev1    table     70,     64
  idist0    table     71,     64      /* distance range                       */
  idist1    table     72,     64

/* ------------------------------------------------------------------------- */

  p3        =  p3+0.40      /* increase note length */

  ibtime    =  60/ibpm

  kamp      linseg    1,p3-0.40,1,0.05,0,0.1,0         /* amp. envelope */
  kamp      =  kamp*iamp*ivol

  i_        limit     (imvel-ifrqdxv),0,127     /* calculate freq. 1 dec. speed */
  i_        =  i_/(127-ifrqdxv)
  ifrqd1    =  ifrqdx1-i_*(ifrqdx1-ifrqd1)

  kfrq1     expseg    1,ibtime/ifrqd1,0.5      /* osc. frq. envelopes */
  kfrq2     expseg    1,ibtime/ifrqd2,0.5
  kfrq3     expseg    1,ibtime/ifrqd3,0.5
  kfrq4     expseg    1,ibtime/ifrqd4,0.5

  kfrq1     =  kfrq1*ifrqs1*icps
  kfrq2     =  kfrq2*ifrqs2*icps
  kfrq3     =  kfrq3*ifrqs3*icps
  kfrq4     =  kfrq4*ifrqs4*icps

  kcps      =  kfrq1+kfrq2+kfrq3+kfrq4      /* kcps = osc. frequency */

  kmkey     =  ((log(kcps/440.0)/log(2.0))*12.0)+69.0
  kmkey     limit     kmkey,0,127
  kfnum     =  int(256.5+kmkey)             /* kfnum = ftable number */

  a_        phasor    kcps,0                   /* square oscillator */

  a__       tableikt  a_,kfnum,1,0.5,1
  a_        tableikt  a_,kfnum,1,0,1

  a0        =  a_-a__

  a_        unirand   2                       /* noise generator */
  a_        =  a_-1

  a_        pareq     a_,iEQn1fa+icps*iEQn1fn+kcps*iEQn1fo,iEQn1l,iEQn1q,iEQn1m
  a_        pareq     a_,iEQn2fa+icps*iEQn2fn+kcps*iEQn2fo,iEQn2l,iEQn2q,iEQn2m

  a0        =  a0+insmix*a_

/* EQ */

  kEQ1f     =  iEQ1fa+icps*iEQ1fn+kcps*iEQ1fo
  kEQ2f     =  iEQ2fa+icps*iEQ2fn+kcps*iEQ2fo
  kEQ3f     =  iEQ3fa+icps*iEQ3fn+kcps*iEQ3fo
  kEQ4f     =  iEQ4fa+icps*iEQ4fn+kcps*iEQ4fo

  a1        pareq     a0,                       kEQ1f,  iEQ1l,  iEQ1q,  iEQ1m
  a2        pareq     (iEQ2i<0.5 ? a1:a0),      kEQ2f,  iEQ2l,  iEQ2q,  iEQ2m
  a3        pareq     (iEQ3i<0.5 ? a2:a0),      kEQ3f,  iEQ3l,  iEQ3q,  iEQ3m
  a4        pareq     (iEQ4i<0.5 ? a3:a0),      kEQ4f,  iEQ4l,  iEQ4q,  iEQ4m

  a0        =  iEQ0x*a0+iEQ1x*a1+iEQ2x*a2+iEQ3x*a3+iEQ4x*a4

  kffr1     expseg    1,ibtime/iffr1d,0.5      /* LP filter freq. envelopes */
  kffr2     expseg    1,ibtime/iffr2d,0.5
  kffr3     expseg    1,ibtime/iffr3d,0.5
  kffr4     expseg    1,ibtime/iffr4d,0.5

  kffr1     =  kffr1*iffr1s
  kffr2     =  kffr2*iffr2s
  kffr3     =  kffr3*iffr3s*icps
  kffr4     =  kffr4*iffr4s*icps

  kffrq     =  kffr1+kffr2+kffr3+kffr4      /* kffrq = LP filter frequency */

  a0        butterlp  a0,kffrq               /* LP filter */

  a_        =  a0*kamp                      /* apply envelope */

  gax0      =  gax0+a_                      /* send to global output */

  ispt1     limit     imkey,imkmin,imkmax               /* calculate azimuth, */
  ispt1     =  (ispt1-imkmin)/(imkmax-imkmin)       /* elevation and distance */

  i_az_     =  iazim0+(iazim1-iazim0)*ispt1
  i_el_     =  ielev0+(ielev1-ielev0)*ispt1
  i_d_      =  idist0+(idist1-idist0)*ispt1

$SPATMACRO

            outs      a_L_,a_R_          /* output spatialized sound */

endin

/* ------------------------------------------------------------------------- */

instr 90

;       soundout gax0,$OUTFLNAME,6      /* mono output file */
  gax0      =  0

endin

