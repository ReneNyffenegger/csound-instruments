  sr        =  48000
  ksmps     =  1
  nchnls    =  1

#include "base_macros.h.orc"

            seed      0
  ga0x      init      0

instr 1

            kgoto     start01

/*-------------------------------------------------------------------------- */

  ivol      table     0, 64    /* volume                                       */
  ibpm      table     1, 64    /* tempo                                        */
  irel      table     2, 64    /* release time (sec.)                          */
  if01      table     3, 64    /* oscillator start frequency (rel.)            */
  ifd1      table     4, 64    /* frequency envelope decay speed               */
  idec      table     5, 64    /* amp. decay speed                             */

/*-------------------------------------------------------------------------- */

  i001      =  1/65536
  i002      =  1/1024

  imkey     =  p4                           /* MIDI key number              */
  imvel     =  p5                           /* MIDI velocity                */
  ivel      =  $VELOC2AMP(imvel)            /* convert velocity             */
  ibtime    =  60/ibpm                      /* beat time                    */
  ivol      =  ivel*ivol

  icps      =  $MIDI2CPS(imkey)             /* base freq.   */
  ifmax     =  sr*0.48                      /* max. allowed freq.   */

  ixtime    =  irel + (16/kr)

  p3        =  p3 + ixtime                  /* increase note length */

start01:

  kamp1     expseg    1, p3-ixtime, 1, ixtime, i002            /* envelopes */
  kamp2     expseg    1, ibtime/idec, 0.5
  kfrq1     expseg    1, ibtime/ifd1, 0.5
  kfrq      =  icps*(1+kfrq1*(if01-1))      /* kfrq  = osc. frequency */

  a1        oscil3    16384.0, kfrq, 256       /* oscillator */
  a1_       unirand   2.0
  a1_       butterbp  a1_-1.0, kfrq, kfrq
  a1_       butterbp  a1_, kfrq, kfrq*2.0
  a1        =  a1 + a1_*32768.0*(100.0/kfrq)
  a2        =  a1                           /* a1 = a2 = osc. signal */

  a0y       =  a1*ivol*kamp1*kamp2

  ga0x      =  ga0x + a0y

endin

instr 90

  a_        =  ga0x

  a_        limit     a_, -300, 300

  a_1       tone      a_, 120
  a_        =  a_ - a_1*2.0
  a_1       tone      a_, 120
  a_        =  a_ - a_1*2.0

  a_1       butterhp  a_, 1000
  a_        =  a_ - a_1*3.0

  a_        pareq     a_, 150, 3.0, 0.7, 1

            out       a_*20.0

  ga0x      =  0

endin


