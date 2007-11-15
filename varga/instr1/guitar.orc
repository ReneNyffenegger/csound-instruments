  sr        =  48000
  ksmps     =  16
  nchnls    =  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"

instr 1

$M_NOTEPARM(0.05'0.15)

  ictim     =  1 / icps                           ; cycle time
  idec      =  0.3                                ; decay half-time
; note number -> azimuth
  iazim     wrap      inote * 10 + 0.5, -80, 20
  idist     =  1.0                                ; distance

  a1        rnd31     1, 0, 62                    ; some recommended seed values: 3, 62, 73, 95
  a2        expseg    1, ictim * 15, 0.000001, 1, 0.000001
  a1        =  a1 * a2

  idec      =  exp(log(0.5) * (ictim / idec))     ; feedback level

  atmp      delayr    0.1                         ; feedback delay with lowpass filter
; tuning at various note frequencies with sr = 48000 (based on measurements):
;    220.0: 1.0021
;    440.0: 1.0021
;    880.0: 1.0025
;   1046.5: 1.0029
  itune     limit     0.0008 * ((icps / 523.25) - 1), 0, 0.01
  itune     =  itune + 1.0021
  adel      =  ictim * (2 - itune)                ; delay time = cycle time with tuning
  a2        deltapx   adel, 32
  a2        butterlp  a2, sr * 0.47               ; lowpass to remove high freq. ripple
  a3        tone      a2, icps * 20               ; high frequency decay
  a2        =  a2 * 0.7 + a3 * 0.3
  a2        =  a1 + a2 * idec                     ; feedback
            delayw    a2

  a2        pareq     a2, $MIDI2CPS(48), 2, 1, 0
  a2        tone      a2, 10000                   ; output lowpass
; amplitude scale and release envelope
  a2        =  a2 * iamp * (aenv * aenv) * 26000

; spatialize and send to output

$SPAT2(a2'iazim'idist)

endin

$OUT3CH(90'"guitar.pcm")

