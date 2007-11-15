
#include "base_macros.h.orc"
$ORCHDR(48000'64'2)

#include "spat.h.orc"

            seed      0
  ga0       init      0

instr 1

$NOTEPARAMS(0.2)

  ifrqs     =  icps * 16                          ; start frequency
  ifrqe     =  icps                               ; end frequency
  ifrqd     =  80                                 ; freq. decay speed

  acps      line      0, 1, ifrqd
  acps      =  acps * acps
  acps      =  (ifrqe * acps + ifrqs) / (acps + 1)
  aamp      =  sin($TWOPI * sqrt(ifrqe / acps))

  a0        oscili    aamp, acps, 1

  a0        pareq     a0, icps * 8, 0, 0.7071, 2
  a0        =  taninv(a0 * 1.5)

  aenv      linseg    1, ilnth, 1, 0.05, 0, 1, 0
  aenv      =  aenv * aenv

  ga0       =  ga0 + a0 * aenv * iamp * 17000

endin

instr 90                /* output instrument */

  a_        =  ga0
  ga0       =  0

  i_az_     =  0                                  ; azimuth
  i_el_     =  0                                  ; elevation
  i_d_      =  0.6                                ; distance

$UHJ_Stereo

            outs      a_L_, a_R_

endin

