  sr        =  48000
  ksmps     =  2
  nchnls    =  1

#include "base_macros.h.orc"

            seed      0

instr 1

/* ------------------------------------------------------------------------- */

  ivol      =  2.0          /* volume                                       */
  ibpm      =  216          /* tempo                                        */

  irel      =  0.02         /* release time                                 */

  istrtf1   =  4.0000       /* start frequency 1                            */
  ifdec1    =  20           /* freq. decay speed 1                          */
  istrtf2   =  0.5          /* start frequency 2                            */
  ifdec2    =  256          /* freq. decay speed 2                          */

  insmix    =  1.0          /* noise mix                                    */

  iLPf      =  2.0          /* LP filter start frequency / osc. freq.       */
  iLPd      =  4.0          /* LP filter freq. decay speed                  */

  iAM1s     =  3.0          /* amp. envelope 1 start value                  */
  iAM1d     =  1024         /* amp. envelope 1 decay speed                  */
  iAM2s     =  2.0          /* amp. envelope 2 start value                  */
  iAM2d     =  1.0          /* amp. envelope 2 decay speed                  */

/* ------------------------------------------------------------------------- */

  ibtime    =  60/ibpm

  p3        =  p3+irel+0.05

  imkey     =  p4
  imvel     =  p5

  icps      =  $MIDI2CPS(imkey)
  iamp      =  (0.0039+imvel*imvel/16192)*ivol*16384
  kamp      linseg    1,p3-(irel+0.05),1,irel,0,0.05,0

  k_        port      1,ibtime/ifdec1,istrtf1            /* calculate base frequency */
  k__       port      1,ibtime/ifdec2,istrtf2
  kcps      =  icps*k_*k__

  kfnum     =  $CPS2MIDI(kcps)
  a_        phasor    kcps
  a1        tableikt  a_, int(kfnum + 256.5), 1, 0.0, 1
  a2        tableikt  a_, int(kfnum + 256.5), 1, 0.5, 1
  a0        =  a1 - a2                              /* a0 = osc. signal */

  a_        unirand   2                               /* noise generator */
  a_        tone      a_-1,kcps
  a0        =  a0+a_*insmix

  k_        expseg    1,ibtime/iAM1d,0.5                       /* amp. envelopes */
  k__       expseg    1,ibtime/iAM2d,0.5
  k_        =  (1-k_)*(1-iAM1s)+iAM1s
  k__       =  (1-k__)*(1-iAM2s)+iAM2s
  a0        =  a0*k_*k__

  a1        =  a0

  k_        port      0,ibtime/iLPd,iLPf                 /* LP filter */
  a0        butterlp  a0,kcps*k_

  a_        butterhp  a1,kcps*1
  a_        butterlp  a_,kcps*8
  k_        expseg    1,0.005,0.5
  a0        =  a0+1.5*a_*k_

  a0        butterlp  a0*iamp*kamp,sr*0.48
  a0        limit     a0 * 2.0, -4000, 5000

  a_        tone      a0, icps
  a0        =  a0 - a_
  a_        tone      a0, icps
  a0        =  a0 - a_
  a0        pareq     a0, icps, 4.0, 1.0, 0

  a0        pareq     a0, kcps * 2.0, 0.25, 2.0, 0
  a0        pareq     a0, icps * 16.0, 2.0, 1.0, 2
  a0        pareq     a0, icps * 128.0, 0.0, 0.7071, 2

  a0        limit     a0 * 1.5, -24000, 24000

            out       a0 * 1.25

endin

instr 90
endin


