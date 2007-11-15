  sr        =  48000
  ksmps     =  2
  nchnls    =  2

#include "spat.h.orc"

            seed      0
  ga0       init      0

instr 1

  ibpfrq    =  1046.5                               /* bandpass filter frequency */
  kbpbwd    port      ibpfrq*0.25, 0.03, ibpfrq*4.0      /* bandpass filter bandwidth */
  idec      =  0.5                                  /* decay time                */

  a1        =  1.0
  a1_       delay1    a1
  a1        =  a1 - a1_
  a2        delay     a1, 0.011
  a3        delay     a1, 0.023
  a4        delay     a1, 0.031

  a1        tone      a1, 60.0
  a2        tone      a2, 60.0
  a3        tone      a3, 60.0
  a4        tone      a4, 1.0 / idec

  aenv1     =  a1 + a2 + a3 + a4*60.0*idec

  a_        unirand   2.0
  a_        =  aenv1 * (a_ - 1.0)
  a_        butterbp  a_, ibpfrq, kbpbwd

            vincr     ga0, a_*12000000

endin

instr 99

            tableiw   6, 0, 225                   ; spat3di recursion depth

  a_        =  ga0
            clear     ga0

  i_az_     =  10
  i_el_     =  0
  i_d_      =  2
$PhseStereo

            outs      a_L_, a_R_

endin

