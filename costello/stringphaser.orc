; stringphaser.orc
;
; by Sean Costello, August 23-26, 1999
;
; This orchestra is a digital recreation of the old analog "string
; ensemble." A string ensemble was an attempt to create a reasonably
; full string section sound, with full polyphony, using the limited
; technology available in the early 1970's. In this orchestra,
; the string ensemble section is followed by a 6-stage phase shifter
; (a digital recreation of a common 1970's analog effect), and is
; sent into a FDN (Feedback Delay Network) reverb, based upon the
; work of Stautner and Puckette.

  sr        =  44100
  kr        =  44100                              ; kr MUST equal sr for phase shifting to work in this version.
  ksmps     =  1
  nchnls    =  2

; global variables initialization

  gasig2    init      0                           ; global variable to send pulse waves to ensemble section
  ga2       init      0                           ; global variable to send output of ensemble to reverb


instr 19        ; Used to generate simple sawtooth-like waveforms, with
                ; AR-type envelopes. These are sent to the ensemble
                ; section to produce the string animation. As the
                ; ensemble/phaser/reverb section has a fixed level of
                ; computational overhead (since these are global
                ; processors), the polyphony can be raised to large
                ; numbers of simultaneous notes without significantly
                ; increasing the computational load.

  idur      =  p3
  iamp      =  p4
  ifreq     =  cpspch(p5)
  iharms    =  (sr*.4) / ifreq                    ; Limits number of harmonics in bandlimited
                        ; pulse waveform

; asig is a simple sawtooth-like waveform, similar to the waveforms
; that would have been created by the divide-down circuitry &
; waveshapers in the old string ensembles.
  asig      gbuzz     1, ifreq, iharms, 1, .9, 2

; The amplitude envelope is a simulation of a simple AR envelope, to
; fade the note in and out. Not "realistic" from the standpoint of
; an acoustic instrument, but very close to the simple envelopes
; of the Solina/ARP String Ensemble/etc.
  kenv      linseg    0, 1, iamp, idur - 2, iamp, 1, 0

; The output is scaled somewhat. Note that mixing multiple notes does
; not result in a linear increase of amplitude. The gbuzz waveform
; must have a very large peak per period, with the majority of
; the period being fairly low level.
  aout      =  kenv * asig * .45

; The output of instr 19 is sent to the "ensemble" chorusing
; section. None of the dry signal will be heard in the output.
  gasig2    =  gasig2 + aout

; If you want to hear the straight waveform being used, comment 
; out the line above for gasig2, and uncomment the following line.
;outs   aout, aout

endin



instr 22        ; Ensemble section. Takes static sawtooth waves,
                ; and produces an animated flanged/chorused/vibratoed
                ; output. The phase shifter follows the output
                ; of the ensemble.

; Initialization of feedback variables for allpass filters.
  ay1       init      0
  ay2       init      0 
  ay3       init      0
  ay4       init      0
  ay5       init      0
  ay6       init      0

; Initialization of variable for phaser feedback.
  afeed     init      0

  idur      =  p3
  ivib      =  p4 * .00025                        ; Determines amount of pitch change/vibrato/
                        ; chorusing. A value of 1 gives moderately thick 
                        ; chorusing, without excessive vibrato. Vary this 
                        ; according to taste.


; Simulates the first of two 3-phase LFOs that were used
; in the ensemble sections. Each LFO had three outputs,
; seperated by 120 degrees. This first LFO provides a
; slow flanging component to the sound, and helps to 
; prevent unpleasant phase cancellations of the faster vibrato
; component provided by the second LFO.
  ktimea    oscili    4, 0.33, 1
  ktimeb    oscili    4, 0.33, 1, .333
  ktimec    oscili    4, 0.33, 1, .667

; Simulates the second 3-phase LFO. This LFO provides
; a vibrato component to the sound. Note that the amplitude
; of this LFO is 1/4th the amplitude of the slower LFO.
  ktimed    oscili    1, 5.5, 1
  ktimee    oscili    1, 5.5, 1, .333
  ktimef    oscili    1, 5.5, 1, .667

; The outputs of the 2 LFOs are combines, so that the 0
; degree component of the slow LFO is combined with the 
; 0 degree component of the fast LFO, the 120 degree 
; component of the slow LFO is combined with the 120
; degree component of the fast LFO, and the 240 degree
; component of the slow LFO is combined with the 240
; degree component of the fast LFO. Each of the summed
; LFO signals is scaled by ivib.
  ktime1    =  (ktimea + ktimed) * ivib
  ktime2    =  (ktimeb + ktimee) * ivib
  ktime3    =  (ktimec + ktimef) * ivib

; Each of the summed & scaled LFO signals is used to 
; modulate a deltapi delay line. This results in 
; three parallel signals, each with a small amount of
; vibrato and pitch warble.
  adummy    delayr    .030
  asig1     deltap3   ktime1 + .012
  asig2     deltap3   ktime2 + .012
  asig3     deltap3   ktime3 + .012
            delayw    gasig2

; The delay line outputs are mixed together, resulting
; in a signal with complex phase, timbral and pitch 
; shifts. Unlike most flangers or chorus generators, the
; dry input signal is NOT mixed in with the outputs of 
; the delay lines. This results in a more animated signal,
; with multiple layers of "through-zero" flanging, and
; less of the characteristic comb-filter sound of normal
; flangers and choruses.
  aout      =  (asig1 + asig2 + asig3) * .33

; kphs and kcoeff make up the modulation signal for the 
; phaser. The phaser coefficient must be in the range of
; -1 < kcoeff < 1. For phase shifting purposes, the more
; interesting effects occur in the range -1 < kcoeff < 0.
; The modulating waveform uses an inverted half-sine
; (ranging from -1 to 0) as a table, which results in 
; a nice phasing sweep.
  kphs      oscili    .69, .1, 3, .25
  kcoeff    =  kphs - .3

; Input to the phaser is the output of the delay lines,
; plus feedback from the output of the phaser. Feedback
; results in increased depth of the notch frequencies, 
; making a more pronounced "sweeping" sound.
  ain       =  aout + afeed

; Each allpass stage takes the form
;
; Output = (coeff * Input) + PreviousInput - (coeff * PreviousOutput)
; 
; The allpass section consists of 6 of these stages in series,
; with each stage sharing the same coefficient. You can easily
; extend these by cutting and pasting. In my original orchestra,
; I used a unit generator of my own construction, allpassn, for 
; the phase shifting. allpassn includes n stages of allpass filters
; in series, all sharing the same coefficient, with feedback amount
; variable. I will soon send this ugen to John ffitch, as it is
; nice to have this in a ugen so that the kr can be at a value different
; from sr.
  ax1       delay1    ain
  ay1       =  kcoeff * ain + ax1 - kcoeff * ay1
  ax2       delay1    ay1
  ay2       =  kcoeff * ay1 + ax2 - kcoeff * ay2
  ax3       delay1    ay2
  ay3       =  kcoeff * ay2 + ax3 - kcoeff * ay3
  ax4       delay1    ay3
  ay4       =  kcoeff * ay3 + ax4 - kcoeff * ay4
  ax5       delay1    ay4
  ay5       =  kcoeff * ay4 + ax5 - kcoeff * ay5
  ax6       delay1    ay5
  ay6       =  kcoeff * ay5 + ax6 - kcoeff * ay6

; Feedback to phaser. Increase the constant for a more
; pronounced effect. Feedback gain values outside of
; the range -1 < g < 1 may result in oscillation, overflow,
; and other nasty things.
  afeed     =  .5 * ay6

; The output of the allpass filter series is summed with
; the input to the allpass filter series, to produce an
; output signal with 3 notches in it. As kcoeff is swept,
; the notches move in frequency, producing the classic 
; "phaser" effect. The output is also scaled by 1/2 to
; keep the output level roughly the same as the input level.
  aout2     =  (aout + ay6) * .5

; The output of the phase shifting section is sent via
; a global variable to instr 99 (reverberation).
;ga2 = ga2 + .37 * aout2

; Phaser output sent to main outputs. If you want to 
; use the straight ensemble output (with no allpass
; phase shifting), replace aout2 with aout in the line
; below, as well as in the ga2... line above.
            outs      aout, aout

  gasig2    =  0

endin


instr 99        ; Simple implementation of Feedback Delay Network (FDN)
                ; reverb, as described by John Stautner and Miller 
                ; Puckette, "Designing Multi-Channel Reverberators," 
                ; Computer Music Journal, Vol. 6, No. 1, Spring 1982,
                ; p.52-65. This version sticks to implementing the 
                ; basic FDN structure, and leaves out most of the
                ; FIR multitap delay lines and filtering used for
                ; the early reflections. For sounds with non-percussive
                ; attacks, this simple implementation works great.

  afilt1    init      0
  afilt2    init      0
  afilt3    init      0
  afilt4    init      0

  igain     =  p4 * 0.70710678117                 ; gain of reverb
  ipitchmod =  p5                                 ; amount of random pitch mod, between 0 and 1
  idelaytime   =      p6                          ; controls overall length of delay lines
  ifilt     =  p7                                 ; controls cutoff of lowpass filters at 
                                ; outputs of delay lines
  ifreq     =  p8                                 ; controls frequency of random noise

  kgain     linseg    .94, 66, .94, 2, 1, p3 - 68, 1
  k1        randi     .001, 3.1 * ifreq, .06
  k2        randi     .0011, 3.5 * ifreq, .9
  k3        randi     .0017, 1.11 * ifreq, .7
  k4        randi     .0006, 3.973 * ifreq, .3

  atap      multitap  ga2, 0.00043, 0.0215, 0.00268, 0.0298, 0.00485, 0.0572, 0.00595, 0.0708, 0.00741, 0.0797, 0.0142, 0.134, 0.0217, 0.181, 0.0272, 0.192, 0.0379, 0.346, 0.0841, 0.504

  adum1     delayr    0.072 
  adel1     deltapi   0.0663 * idelaytime + k1 * ipitchmod
            delayw    ga2 + afilt2 + afilt3

  adum2     delayr    0.082 
  adel2     deltapi   0.0753 * idelaytime + k2 * ipitchmod
            delayw    ga2 - afilt1 - afilt4

  adum3     delayr    0.095
  adel3     deltapi   0.0882 * idelaytime + k3 * ipitchmod
            delayw    ga2 + afilt1 - afilt4

  adum4     delayr    0.11
  adel4     deltapi   0.0971 * idelaytime + k4 * ipitchmod
            delayw    ga2 + afilt2 - afilt3

  afilt1    tone      adel1 * igain, ifilt
  afilt2    tone      adel2 * igain, ifilt
  afilt3    tone      adel3 * igain, ifilt
  afilt4    tone      adel4 * igain, ifilt

            outs      afilt1 + afilt2 + atap, afilt4 + afilt3 + atap

  ga2       =  0

endin