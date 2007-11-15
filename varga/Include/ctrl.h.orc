
/* ctrl.h.orc - macros for MIDI control */
/* Written by Istvan Varga, May 2002    */

; M_CTRLINIT - initialize MIDI controller
;
; MCTLI_zofs: zak offset (2048 locations are used to store controllers)
; MCTLI_chn:  channel (1 - 16)
; MCTLI_ctrl: controller number (1 - 127)
; MCTLI_val:  controller value (0 - 127)
;
; all parameters must be integers, and only MCTLI_val is allowed to be
; an expression

#define M_CTRLINIT(MCTLI_zofs'MCTLI_chn'MCTLI_ctrl'MCTLI_val) #

            ctrlinit  $MCTLI_chn, $MCTLI_ctrl, $MCTLI_val
            ziw       $MCTLI_val, int($MCTLI_zofs + $MCTLI_chn * 128 + $MCTLI_ctrl - 127.5)

#

; M_CTRL - read the value of a MIDI controller, and store in zak space
;
; MCTL_zofs: zak offset (2048 locations are used to store controllers)
; MCTL_chn:  channel (1 - 16)
; MCTL_ctrl: controller number (1 - 127)
;
; all parameters must be integers, and expressions are not allowed
; k_ is used as temporary variable

#define M_CTRL(MCTL_zofs'MCTL_chn'MCTL_ctrl) #

  k_        ctrl7     $MCTL_chn, $MCTL_ctrl, 0, 127
            zkw       int(k_ + 0.5), int($MCTL_zofs + $MCTL_chn * 128 + $MCTL_ctrl - 127.5)

#

; M_CTRL0 - read the value of a MIDI controller, and if it is non-zero,
;           store in zak space
;
; MCTL0_zofs: zak offset (2048 locations are used to store controllers)
; MCTL0_chn:  channel (1 - 16)
; MCTL0_ctrl: controller number (1 - 127)
;
; all parameters must be integers, and expressions are not allowed
; k_ and k__ are used as temporary variables

#define M_CTRL0(MCTL0_zofs'MCTL0_chn'MCTL0_ctrl) #

  k_        ctrl7     $MCTL0_chn, $MCTL0_ctrl, 0, 127
  k__       zkr       int($MCTL0_zofs + $MCTL0_chn * 128 + $MCTL0_ctrl - 127.5)
  k_        =  (k_ < 0.5 ? k__ : int(k_ + 0.5))
            zkw       k_, int($MCTL0_zofs + $MCTL0_chn * 128 + $MCTL0_ctrl - 127.5)

#

; INTERP_K - interpolate k-rate variable
;
; INTK_kr:   variable to be interpolated (k-rate)
; INTK_itim: time over which output values are interpolated
;
; k_ is used as temporary variable

#define INTERP_K(INTK_kr'INTK_itim) #

  k_        phasor    1 / ($INTK_itim)
  k_        trigger   1 - k_, 0.5, 0
$INTK_kr        tlineto $INTK_kr, $INTK_itim, k_

#

; Z_CTRL - read controller from zak space
;
; ZCTL_kr:   output variable (k-rate)
; ZCTL_zofs: zak offset (2048 locations are used to store controllers)
; ZCTL_chn:  channel (1 - 16)
; ZCTL_ctrl: controller number (1 - 127)
;
; all input parameters must be integers, and expressions are not allowed

#define Z_CTRL(ZCTL_kr'ZCTL_zofs'ZCTL_chn'ZCTL_ctrl) #

$ZCTL_kr        zkr int($ZCTL_zofs + $ZCTL_chn * 128 + $ZCTL_ctrl - 127.5)

#

; Z_CTRLI - read controller from zak space with interpolation
;
; ZCTLI_kr:   output variable (k-rate)
; ZCTLI_zofs: zak offset (2048 locations are used to store controllers)
; ZCTLI_chn:  channel (1 - 16)
; ZCTLI_ctrl: controller number (1 - 127)
; ZCTLI_itim: time over which output values are interpolated
;
; ZCTLI_zofs, ZCTLI_chn, and ZCTLI_ctrl must be integers, and expressions
; are not allowed
; k_ is used as temporary variable

#define Z_CTRLI(ZCTLI_kr'ZCTLI_zofs'ZCTLI_chn'ZCTLI_ctrl'ZCTLI_itim) #

$ZCTLI_kr       zkr int($ZCTLI_zofs + $ZCTLI_chn * 128 + $ZCTLI_ctrl - 127.5)
$INTERP_K($ZCTLI_kr'$ZCTLI_itim)

#

; PITCHBEND - get note frequency with pitch bend (interpolated)
;
; PBEND_kr:    output variable (k-rate)
; PBEND_range: bend range in semitones
; PBEND_itim:  time over which output values are interpolated

#define PITCHBEND(PBEND_kr'PBEND_range'PBEND_itim) #

$PBEND_kr       cpsmidib $PBEND_range
$INTERP_K($PBEND_kr'$PBEND_itim)

#

; POLYAFT - get (polyphonic) aftertouch with interpolation
;
; POLYAFT_kr:   output variable (k-rate)
; POLYAFT_note: note number (0 - 127)
; POLYAFT_itim: time over which output values are interpolated

#define POLYAFT(POLYAFT_kr'POLYAFT_note'POLYAFT_itim) #

$POLYAFT_kr     polyaft $POLYAFT_note, 0, 127
$INTERP_K($POLYAFT_kr'$POLYAFT_itim)

#

