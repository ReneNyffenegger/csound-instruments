  sr        =  48000
  ksmps     =  8
  nchnls    =  2

#include "spat.h.orc"

/* simple FM-based rimshot instrument */
/* coded by Istvan Varga, Mar 3 2002  */

            seed      0
  ga0       init      0

instr 1

  p3        =  p3 + 0.1

/* base frequency */

  icps      =  440.0*exp(log(2.0)*(57.0-69.0)/12.0)
  acps      expon     icps, 0.0025, icps * 0.5
  acps      =  acps + icps

  iamp      =  0.0039 + p4*p4/16192.0       /* velocity */

  a1a       phasor    acps, 0.0        /* square wave */
  a1b       phasor    acps, 0.5

  afmenv    expon     1.0, 0.02, 0.5    /* FM envelope */

  a1        =  (a1a-a1b)*6.0*afmenv
  acps      =  acps*(1.0+a1)

  a0        oscil3    1.0, acps, 1     /* sine oscillator */

  a1        unirand   2.0             /* add some noise */
  a1        tone      a1-1.0, 2000
  a0        =  a0 + a1*0.1

  aenv      expon     1.0, 0.005, 0.5   /* amp. envelope */

/* distortion */

  a0        limit     4.0*iamp*a0*aenv, -1.0, 1.0
  a0        table3    a0*4096.0, 1, 0, 0, 1

/* lowpass filter freq. envelope */

  kffrq     expseg    20000, 0.07, 100, 1, 100

  a0x       tone      a0, 4000
  a0y       =  a0 - a0x
  a0x       delay     a0y, 0.0002
  a0        =  a0 - a0x*4.0
  a0        pareq     a0, kffrq, 0, 0.7071, 2

/* de-click envelope */

  a_        linseg    1, p3-0.1, 1, 0.025, 0, 1, 0
  a0        =  a0*a_

            vincr     ga0, a0*15000

endin

instr 99

            tableiw   8, 0, 225                   ; spat3di recursion depth

  a_        =  ga0
            clear     ga0

  i_az_     =  80
  i_el_     =  0
  i_d_      =  2
$PhseStereo

            outs      a_L_, a_R_

endin

