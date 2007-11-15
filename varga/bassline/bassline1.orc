  sr        =  48000
  ksmps     =  32
  nchnls    =  1

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"
#include "ctrl.h.orc"

            zakinit   1, 2048

  gibpm     =  140                                ; tempo
  gibrng    =  12                                 ; bend range

  itmp      ftgen     257, 0, 16384, 7, 1, 16384, -1 ; sawtooth wave
$FGEN_128(l1'256'4096'257'1'sr/2)

; ctrl  7: volume
; ctrl 10: azimuth
; ctrl 24: filter freq. (in 0.5 semitones, 55 to 118.5)
; ctrl 25: filter bend up/down (in 0.5 semitones / beat, -32 to 31.5)
; ctrl 26: filter min frequency (0 to 127)
; ctrl 27: filter max frequency (0 to 127)
; ctrl 28: filter bend 2 end frequency (in 0.5 semitones, -32 to 31.5)
; ctrl 29: filter bend 2 half-time (in 1/64 beats, 0 to 1.984375)
; ctrl 30: filter bandwidth / oscillator frequency (0 to 3.96875)
; ctrl 31: distortion

  ichn      =  1
l2:
            massign   ichn, ichn + 1              ; assign all channels to chn+1

; initialize controllers

$M_CTRLINIT(0'ichn' 7'127)
$M_CTRLINIT(0'ichn'10' 64)
$M_CTRLINIT(0'ichn'24' 34)
$M_CTRLINIT(0'ichn'25' 40)
$M_CTRLINIT(0'ichn'26'  0)
$M_CTRLINIT(0'ichn'27'127)
$M_CTRLINIT(0'ichn'28' 64)
$M_CTRLINIT(0'ichn'29' 32)
$M_CTRLINIT(0'ichn'30' 32)
$M_CTRLINIT(0'ichn'31' 64)

  ichn      =  ichn + 1
if (ichn < 4.5) igoto l2

instr 1

$M_CTRL(0'1' 7)                 ; read controllers and store in zak space
$M_CTRL(0'1'10)
$M_CTRL0(0'1'24)
$M_CTRL0(0'1'25)
$M_CTRL0(0'1'26)
$M_CTRL0(0'1'27)
$M_CTRL0(0'1'28)
$M_CTRL0(0'1'29)
$M_CTRL0(0'1'30)
$M_CTRL0(0'1'31)

$M_CTRL(0'2' 7)                 ; channel 2
$M_CTRL(0'2'10)
$M_CTRL0(0'2'24)
$M_CTRL0(0'2'25)
$M_CTRL0(0'2'26)
$M_CTRL0(0'2'27)
$M_CTRL0(0'2'28)
$M_CTRL0(0'2'29)
$M_CTRL0(0'2'30)
$M_CTRL0(0'2'31)

$M_CTRL(0'3' 7)                 ; channel 3
$M_CTRL(0'3'10)
$M_CTRL0(0'3'24)
$M_CTRL0(0'3'25)
$M_CTRL0(0'3'26)
$M_CTRL0(0'3'27)
$M_CTRL0(0'3'28)
$M_CTRL0(0'3'29)
$M_CTRL0(0'3'30)
$M_CTRL0(0'3'31)

$M_CTRL(0'4' 7)                 ; channel 4
$M_CTRL(0'4'10)
$M_CTRL0(0'4'24)
$M_CTRL0(0'4'25)
$M_CTRL0(0'4'26)
$M_CTRL0(0'4'27)
$M_CTRL0(0'4'28)
$M_CTRL0(0'4'29)
$M_CTRL0(0'4'30)
$M_CTRL0(0'4'31)

endin

#define INSTR2(insno) #

instr $insno

  ichn      =  $insno - 1                         ; MIDI channel

$M_NOTEPARM(0.03'0.02)          ; note parameters
$PITCHBEND(kcps'gibrng'0.01)    ; pitch

$Z_CTRLI(kvol'0'ichn'7'0.02)    ; volume
$Z_CTRLI(kpan'0'ichn'10'0.02)   ; azimuth
$Z_CTRLI(kffrq1'0'ichn'24'0.05) ; filter freq. (in 0.5 semitones, 55 to 118.5)
$Z_CTRL(kbnd1'0'ichn'25)        ; filter bend up/down (-32 to 31.5)
$Z_CTRL(kfmin'0'ichn'26)        ; filter min frequency (0 to 127)
$Z_CTRL(kfmax'0'ichn'27)        ; filter max frequency (0 to 127)
$Z_CTRL(kbnd2f'0'ichn'28)       ; filter bend 2 end frequency (-32 to 31.5)
$Z_CTRL(kbnd2t'0'ichn'29)       ; filter bend 2 half-time (0 to 1.984375)
$Z_CTRL(kbwd'0'ichn'30)         ; filter bandwidth / osc freq. (0 to 3.96875)
$Z_CTRL(kdstrt'0'ichn'31)       ; distortion
; convert params
  kvol      =  $VELOC2AMP(kvol)
  kpan      =  (kpan - 64) * 180 / 64
  kffrq1    =  $MIDI2CPS(kffrq1 * 0.5 + 55)
  kfmin     =  $MIDI2CPS(kfmin)
  kfmax     =  $MIDI2CPS(kfmax)
  kbnd2f    =  $NOTE2FRQ(kbnd2f * 0.5 - 32)
  kbnd2t    =  kbnd2t / 64
  kbwd      =  kbwd / 32
  kdstrt    limit     kdstrt / 16, 0.1, 4
; ftable number
$CPS2FNUM(kfn'kcps'256)

; oscillator
  a1        phasor    kcps
  a2        tablexkt  a1 + 0.5, kfn, 0, 2, 1, 0, 1
  a1        tablexkt  a1, kfn, 0, 2, 1, 0, 1
; channel 1, 3: sawtooth wave
; channel 2, 4: square
  a2        =  a2 * ((ichn == 2) || (ichn == 4) ? -1 : 0)
            vincr     a1, a2

; filter envelopes
  kf1       line      0, 1, 1
  kf1       =  kf1 * (kbnd1 * 0.5 - 32) * gibpm / 60
  kf1       =  kffrq1 * $NOTE2FRQ(kf1)
  kf2       portk     kbnd2f, kbnd2t * 60 / gibpm, 1
  kf1       =  kf1 * kf2
  kf1       =  (kf1 < kfmin ? kfmin : kf1)
  kf1       =  (kf1 > kfmax ? kfmax : kf1)
  kffrq     =  kf1
  kbwd      =  kcps * kbwd

; filters

;a2     tone a1, 10000
;a1     =  a1 - a2
;a2     butterbp a1, kffrq, kbwd
;a2     pareq a2, kffrq, 0, 0.7071, 2
;a2     =  kdstrt * 30000 * a2 / kbwd
;a1     =  taninv(a2) / kdstrt

  a1x       butterbp  a1, kffrq, kbwd             ; filters
  a1x       =  a1x * (2 + kffrq / kcps)           ; correct amplitude
  a1        =  a1x + a1 * 0.25
  a1        pareq     a1 * kcps / kbwd, kffrq, 0, 0.7071, 2

  a1        =  taninv(a1 * kdstrt) / kdstrt       ; distortion

  a1        =  a1 * iamp * kvol * (aenv * aenv) * 26000

            out       a1

endin

#

$INSTR2(2)
$INSTR2(3)
$INSTR2(4)
$INSTR2(5)

