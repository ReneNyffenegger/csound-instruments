  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2


instr 99                ; Miller Puckette and John Stautner's 
                        ; Feedback Delay Network Reverb,                
                        ; converted into a gong
  afilt1    init      0
  afilt2    init      0
  afilt3    init      0
  afilt4    init      0
  adel1     init      0
  adel2     init      0
  adel3     init      0
  adel4     init      0
  alimit1   init      0
  alimit2   init      0
  alimit3   init      0
  alimit4   init      0
  alimita   init      0
  alimitb   init      0
  alimitc   init      0
  alimitd   init      0

  anoise    =  0
  ipi       =  3.141592654
  idel1     =  1/p4 
  ilooptime =  idel1 * 3
  idel2     =  1/p4 * 2.25
  idel3     =  1/p4 * 3.616
  idel4     =  1/p4 * 5.06

  iamp      =  p5
  ipitchmod =  p7

; bilinear z-transform, used to convert frequencies in
; the .sco file for the passive nonlinear filter into
; coefficients that the allpass filter can use. The
; frequency corresponds to the 90 degree phase shift
; frequency of the allpass filter.
  ilimit1   =  (1 - ipi * p8 / 44100) / (1 + ipi * p8 / 44100)
  ilimit2   =  (1 - ipi * p9 / 44100) / (1 + ipi * p9 / 44100)

; A single period of a sine wave, with frequency 
; corresponding to the longest delay length in
; the network, is used to "strike" the gong.
  krandenv  linseg    1, ilooptime, 1, 0, 0, p3-ilooptime, 0
  anoise    oscili    krandenv * p11, p4, 1

  igain     =  p6 * 0.70710678117                 ; gain of reverb

; used to add random pitch modulation to the
; delay lines. Useful for reverb, but not as 
; useful in this application.
  k1        randi     .001, 3.1, .06
  k2        randi     .0011, 3.5, .9
  k3        randi     .0017, 1.11, .7
  k4        randi     .0006, 3.973, .3


  adum1     delayr    1
  adel1a    deltapi   idel1 + k1 * ipitchmod
            delayw    anoise + afilt2 + afilt3

; Passive nonlinear filter, a la Scott Van Duyne
; and John Pierce. Essentially a single order
; allpass filter, where the coefficient switches
; between two different values, based upon the 
; state of the delay line it is associated with.
; Produces effects similar to FM. In addition,
; if the allpass filter is tuned to a low frequency
; it will produce a "detuning" of the harmonics in 
; the delay line that adds to the bell-like nature
; of the sound.
  kdel1     downsamp  adel1a
if kdel1 < 0 goto or
  klimit1   =  ilimit1
            goto      next
or:
  klimit1   =  ilimit2
next:
  ax1       delay1    adel1a
  adel1     =  klimit1 * (adel1a + adel1) - ax1

; Repeat the above for the next 3 delay lines.

  adum2     delayr    1
  adel2a    deltapi   idel2 + k2 * ipitchmod
            delayw    anoise - afilt1 - afilt4

  kdel2     downsamp  adel2a
if kdel2 < 0 goto or2
  klimit2   =  ilimit1
            goto      next2
or2:
  klimit2   =  ilimit2
next2:
  ax2       delay1    adel2a
  adel2     =  klimit2 * (adel2a + adel2) - ax2

  adum3     delayr    1
  adel3a    deltapi   idel3 + k3 * ipitchmod
            delayw    anoise + afilt1 - afilt4

  kdel3     downsamp  adel3a
if kdel3 < 0 goto or3
  klimit3   =  ilimit1
            goto      next3
or3:
  klimit3   =  ilimit2
next3:
  ax3       delay1    adel3a
  adel3     =  klimit3 * (adel3a + adel3) - ax3

  adum4     delayr    1
  adel4a    deltapi   idel4 + k4 * ipitchmod
            delayw    anoise + afilt2 - afilt3

  kdel4     downsamp  adel4a
if kdel4 < 0 goto or4
  klimit4   =  ilimit1
            goto      next4
or4:
  klimit4   =  ilimit2
next4:
  ax4       delay1    adel4a
  adel4     =  klimit4 * (adel4a + adel4) - ax4


  afilt1    tone      adel1 * igain, p10
  afilt2    tone      adel2 * igain, p10
  afilt3    tone      adel3 * igain, p10
  afilt4    tone      adel4 * igain, p10

            outs      (afilt1 + afilt3) * iamp, (afilt2 + afilt4) * iamp

  ga1       =  0

endin