/* bass_01.orc - filtered and distorted sawtooth/square bass with */
/*               bass drum. Written by Istvan Varga, 2002         */

  sr        =  44100
  ksmps     =  10
  nchnls    =  1

  gibpm     =  137.0                              ; tempo

instr 1

  irel      =  0.02                               ; release time

/* note parameters */

  p3        =  p3 + irel + 0.01                   ; extend note duration

  icps      =  440 * exp(log(2) * (p4 - 69) / 12) ; base frequency
  iamp      =  0.0039 + p5 * p5 / 16192           ; velocity -> amplitude
  iffrq     =  440 * exp(log(2) * (p6 - 69) / 12) ; filter frequency

/* envelopes */

  aamp1     expseg    2, 50 / iffrq, 1, 1, 1      ; decay
  aamp2     linseg    1, p3 - (irel + 0.01), 1, irel, 0, 1, 0 ; release
  aamp      =  aamp1 * aamp2 * aamp2
; oscillator frequency
  kcps      expseg    icps*0.5, 0.01, icps*0.5, 0.01, icps, 1, icps

  kffrqa    port      1, 0.005, 0.5               ; filter frequency attack
  kffrqd    port      0, 30 / gibpm, 1            ; filter frequency decay
  kffrq     =  iffrq * kffrqa * kffrqd

  kffrqx    port      0, 0.05, 24 * (p5 / 127)    ; velocity -> filter
  kffrqx    =  exp(log(2) * kffrqx / 12)

  kffrq1    =  kffrq / kffrqx                     ; filter frequency for positive peak
  kffrq2    =  kffrq * kffrqx                     ; filter frequency for negative peak

/* oscillator */

  a1        phasor    kcps, 0
  a2        phasor    kcps, 0.5
  a1        =  1 - 2 * a1
  a2        =  1 - 2 * a2

/* filters */

  a1        pareq     a1, kffrq1, 0, 2.0, 2       ; resonant lowpass
  a2        pareq     a2, kffrq2, 0, 2.0, 2
  a0        =  a1 - a2

/* distortion */

  atmp      delay1    a0
  a0        =  a0 - atmp
  atmp      =  taninv(a0 * abs(a0) * 400)
  a0        integ     atmp
  a0        pareq     a0, kcps, 0, 2.0, 1         ; resonant highpass

/* output */

  a0        =  a0 * 70 * sqrt(sqrt(iffrq))        ; correct amplitude
  a0        =  a0 * aamp * iamp

            out       a0

endin

instr 2         ; bass drum

; +------------+             +------------+     +------------+
; | oscillator |--->---+-->--| highpass 1 |-->--| bandpass 1 |-->--+
; +------------+       |     +------------+     +------------+     |
;                      |                                           V
;          +-----<-----+                        +-------------+    |
;          |           |              +----<----| "allpass" 1 |----+
;          |           V              |         +-------------+
;          |           |              |
;          |    +------------+      +---+       +-----------------+
;          |    | highpass 2 |      | + |--->---| output highpass |--+
;          |    +------------+      +---+       +-----------------+  |
;          |           |              |                              V
;          |           V              ^         +----------------+   |
;          |           |              |         | output lowpass |-<-+
;          |         +---+     +------------+   +----------------+
;          +---->----| + |-->--| highpass 3 |           |
;                    +---+     +------------+           +---->-----+
;                                                                  |
; +-----------------+   +----------------+   +---------------+   +---+ output
; | noise generator |->-| noise bandpass |->-| noise lowpass |->-| + |-------->
; +-----------------+   +----------------+   +---------------+   +---+

  ifn       =  p4

  iscl      table     0, ifn                      ; volume
  irel      table     1, ifn                      ; release time (sec.)

  ibsfrq    table     2, ifn                      ; base frequency (MIDI note number)
  ifrqs     table     3, ifn                      ; oscillator start frequency / base frequency
  ifrqt     table     4, ifn                      ; oscillator freq. envelope half-time in beats

  ibw01     table     5, ifn                      ; bandpass 1 bandwidth / oscillator frequency
  ihp1      table     6, ifn                      ; highpass 1 freq. / oscillator frequency
  iapf1     table     7, ifn                      ; "allpass" 1 start freq. / oscillator frq.
  iapdx     table     8, ifn                      ; "allpass" 1 envelope half-time in beats
  iapf2     table     9, ifn                      ; "allpass" 1 end frq. / oscillator frequency

  ihp2      table     10, ifn                     ; highpass 2 frequency / base frequency
  imx2      table     11, ifn                     ; highpass 2 output gain
  ihp3      table     12, ifn                     ; highpass 3 freq. / base frequency
  imx3      table     13, ifn                     ; highpass 3 output gain

  ihpx      table     14, ifn                     ; output highpass frequency / base frequency
  iq0x      table     15, ifn                     ; output highpass resonance

  ifr1      table     16, ifn                     ; output lowpass start freq 1 / oscillator frq.
  ifdx1     table     17, ifn                     ; output lowpass frequency 1 half-time in beats
  ifr2      table     18, ifn                     ; output lowpass start freq 2 / oscillator frq.
  ifdx2     table     19, ifn                     ; output lowpass frequency 2 half-time in beats

  insbp1    table     20, ifn                     ; noise bandpass start frequency in Hz
  insbp2    table     21, ifn                     ; noise bandpass end frequency in Hz
  insbw     table     22, ifn                     ; noise bandpass bandwidth / frequency
  inslp1    table     23, ifn                     ; noise lowpass start frequency (Hz)
  inslp2    table     24, ifn                     ; noise lowpass end frequency (Hz)
  insht     table     25, ifn                     ; noise filter envelope half-time in beats
  insatt    table     26, ifn                     ; noise attack time (in seconds)
  insdec    table     27, ifn                     ; noise decay half-time (in beats)
  insmx     table     28, ifn                     ; noise mix

  ixtim     =  irel + 0.01                        ; extend note duration
  p3        =  p3 + ixtim
  iamp      =  0.0039 + p5 * p5 / 16192           ; velocity -> amplitude

; release envelope
  aenv1     linseg    1, p3 - ixtim, 1, irel, 0, 1, 0
  aenv1     =  aenv1 * aenv1

; output amplitude
  iamp      =  iamp * iscl

; beat time
  ibtime    =  60 / gibpm

; ---- noise generator ----

  a_ns      rnd31     32768 * insmx, 0, 0
  k_nsf     expon     1, ibtime * insht, 0.5
  k_nsbp    =  insbp2 + (insbp1 - insbp2) * k_nsf
  k_nslp    =  inslp2 + (inslp1 - inslp2) * k_nsf
; noise bandpass
  a_ns      butterbp  a_ns, k_nsbp, k_nsbp * insbw
; noise lowpass
  a_ns      pareq     a_ns, k_nslp, 0, 0.7071, 2
; noise amp. envelope
  a_nse1    linseg    0, insatt, 1, 1, 1
  a_nse2    expon     1, ibtime * insdec, 0.5
  a_ns      =  a_ns * a_nse1 * a_nse2

; ---- oscillator ----

; base frequency
  icps      =  440 * exp(log(2) * (ibsfrq - 69) / 12)
; oscillator frequency
  kfrq      expon     1, ibtime * ifrqt, 0.5
  kfrq      =  icps * (1 + (ifrqs - 1) * kfrq)
  a1        phasor    kfrq
  a2        phasor    kfrq, 0.5
  a1        =  32768 * (a2 - a1)
  a2        =  a1                                 ; a1 = a2 = osc. signal

; ---- filters ----

; highpass 1
  a1        butterhp  a1, ihp1 * kfrq
; bandpass 1
  a1        butterbp  a1, kfrq, ibw01 * kfrq
; "allpass" 1
  k_apf     expon     1, ibtime * iapdx, 0.5
  k_apf     =  (iapf2 + (iapf1 - iapf2) * k_apf) * kfrq
  atmp      tone      a1, k_apf
  a1        =  2 * atmp - a1
; highpass 2
  a3        butterhp  a2, ihp2 * icps
; highpass 3
  a2        butterhp  a2 + a3 * imx2, ihp3 * icps
  a1        =  a1 + a2 * imx3
; output highpass
  a1        pareq     a1, ihpx * icps, 0, iq0x, 1
; output lowpass
  k1        expon     1, ibtime * ifdx1, 0.5
  k2        expon     1, ibtime * ifdx2, 0.5
  kfrx      limit     (k1 * ifr1 + k2 * ifr2) * kfrq, 10, sr * 0.48
  a1        pareq     a1, kfrx, 0, 0.7071, 2

            out       (a1 + a_ns) * iamp * aenv1

endin

