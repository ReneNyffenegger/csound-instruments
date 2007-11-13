  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

  ga1       init      0
  ga2       init      0
  ga3       init      0
  ga4       init      0
  ga5       init      0
  ga6       init      0
  ga7       init      0

instr 1 ; used to playback the first fragment of 
  ; Beethoven's 9th that is used. Part of the output
  ; is sent to the global reverberators of instr 96 
  ; and instr 97, to create the sustained reverberation
  ; at the beginning of the piece.

  idur      =  p3
  irevamount   =      p4

  ain       soundin   "b9n2pt1.wav"

; used to avoid clicking in output.
  kenv      linseg    1, 4, 1, .1, 0
  ain       =  ain * kenv

; used to control reverberation amount. Only the 
; last few notes of the phrase are reverberated.
  krevamount   linseg   0, 2, 0, .5, .9
  ga1       =  ga1 + krevamount * ain
  ga2       =  ga1

            outs      ain * .8, ain * .8

endin

instr 2

  afeed     init      0

  idur      =  p3
  ibegshift =  p4
  iendshift =  p5

; Source wave is second fragment of Beethoven's 9th.
  ain       soundin   "b9n2pt2.wav"

; Used to control levels of the recording, and to avoid
; clicking at beginning and end of sample.
  kenv      linseg    0, 5, 2.3, idur - 5.2, 2.3, .1, 0
  ain       =  ain * kenv

; controls amount of frequency shift. For first part of piece,
; the frequencies are shifted downwards. In the middle part of 
; the piece, a slight amount of frequency shifting is used, with 
; feedback routed through a 12-stage phaser, to produce a 
; "barberpole phasing" effect. The end of the piece uses
; frequency shifting to transpose the frequencies upwards.
  kfreq     linseg    0, 24, -500, 18, -5, .5, .4, 10, .5, idur - 52.5, 200 

; Controls the amount of feedback for the frequency shifter/phaser
; combo. For most of the piece, the feedback is at zero, and the output
; is straight frequency shifting. When the feedback is high, the result
; is a "barberpole" phasing effect, consisting of notches that constantly
; sweep through the frequency spectrum. Inspired by a Harald Bode patent.
  kfeed     linseg    0, 41, 0, 1.5, .99, 10, .99, 3, 0, idur - 55.5, 0

; I don't think this envelope is used in the output.
  kamp      linseg    1, idur * .8, 1, idur * .2, 0

; envelope controlling amount of reverberation.
  krev      linseg    0, 52, 0, 1, .13, 2, .13, .5, 0, 13.5, 0, .37, .4, idur - 69.37, .4

; controls amount of upshift in signal versus amount of downshift.
; Used to create a stereo effect during "barberpole phasing" section.
; Normally, only the upshift is present in the output. During the 
; "barberpole" section, the upshift output is in the left channel,
; while the downshift output is in the right channel.
  kbal      linseg    1, 41, 1, 1.5, 0, 10, 0, 3, 1, idur - 55.5, 1 

; frequency shifter section, consisting of hilbert
; transformer, quadrature oscillator, multiplication
; of outputs of hilbert transformer with outputs of
; quadrature oscillator, and summing of products of
; multiplication to produce frequency shifted signal
; See hilbert in Csound manual for further details.
  areal, aimag hilbert  ain + afeed

  asin      oscili    1, kfreq, 1
  acos      oscili    1, kfreq, 1, .25
  amod1     =  areal * acos
  amod2     =  aimag * asin
  aupshift  =  (amod1 + amod2) * 0.707   
  adownshift   =      (amod1 - amod2) * 0.707
  afeed     =  aupshift * kfeed 

; used to create a 12-stage phaser, which creates
; additional notches in the frequency shifter
; output when feedback is used. allpassn is a ugen
; I created for this purpose. If you wish to reproduce this
; effect, stringphaser.orc has a 6-stage phaser construted
; using currently available Csound ugens; this could be the 
; basis for a 12-stage phaser. I am currently
; working on several improved allpass/phaser ugens.
  afeed     allpassn  afeed, 12, 0, 0

; outputs are the upshift and/or downshift from frequency 
; shifter.
            outs      aupshift, aupshift * kbal + adownshift * (1 - kbal)  

; used to send part of signal to a global reverberator.
  ga7       =  ga7 + (aupshift * krev)

endin


instr 95    ; Miller Puckette and John Stautner's
      ; Feedback Delay Network Reverb. Used for the 
    ; reverberation of the frequency-shifted signal
    ; of instr 2.

  afilt1    init      0
  afilt2    init      0
  afilt3    init      0
  afilt4    init      0

  igain     =  p4 * 0.70710678117                 ; gain of reverb
  ipitchmod =  p5                                 ; amount of random pitch mod, between 0 and 1
  idelaytime   =      p6                          ; controls overall length of delay lines
  ifilt     =  p7                                 ; controls cutoff of lowpass filters at outputs of delay lines
  ifreq     =  p8                                 ; controls frequency of random noise

  kgain     linseg    .94, 66, .94, 2, 1, p3 - 68, 1
  k1        randi     .001, 3.1 * ifreq, .06
  k2        randi     .0011, 3.5 * ifreq, .9
  k3        randi     .0017, 1.11 * ifreq, .7
  k4        randi     .0006, 3.973 * ifreq, .3

  atap      multitap  ga1, 0.00043, 0.0215, 0.00268, 0.0298, 0.00485, 0.0572, 0.00595, 0.0708, 0.00741, 0.0797, 0.0142, 0.134, 0.0217, 0.181, 0.0272, 0.192, 0.0379, 0.346, 0.0841, 0.504

  adum1     delayr    0.072 
  adel1     deltapi   0.0663 * idelaytime + k1 * ipitchmod
            delayw    ga7 + afilt2 + afilt3

  adum2     delayr    0.082 
  adel2     deltapi   0.0753 * idelaytime + k2 * ipitchmod
            delayw    ga7 - afilt1 - afilt4

  adum3     delayr    0.095
  adel3     deltapi   0.0882 * idelaytime + k3 * ipitchmod
            delayw    ga7 + afilt1 - afilt4

  adum4     delayr    0.11
  adel4     deltapi   0.0971 * idelaytime + k4 * ipitchmod
            delayw    ga7 + afilt2 - afilt3

  afilt1    tone      adel1 * igain, ifilt
  afilt2    tone      adel2 * igain, ifilt
  afilt3    tone      adel3 * igain, ifilt
  afilt4    tone      adel4 * igain, ifilt

            outs      afilt1 + afilt3 + atap, afilt2 + afilt4 + atap

  ga7       =  0

endin

instr 96    ; Miller Puckette and John Stautner's
      ; Feedback Delay Network Reverb. Used
    ; in conjunction with instr 97 to produce
    ; the dramatic reverberation sound heard
    ; at the beginning of the piece.

  afilt1    init      0
  afilt2    init      0
  afilt3    init      0
  afilt4    init      0

  igain     =  p4 * 0.70710678117                 ; gain of reverb
  ipitchmod =  p5                                 ; amount of random pitch mod, between 0 and 1
  idelaytime   =      p6                          ; controls overall length of delay lines
  ifilt     =  p7                                 ; controls cutoff of lowpass filters at outputs of delay lines

  k1        randi     .001, 3.1, .06
  k2        randi     .0011, 3.5, .9
  k3        randi     .0017, 1.11, .7
  k4        randi     .0006, 3.973, .3

  atap      multitap  ga1, 0.00043, 0.0215, 0.00268, 0.0298, 0.00485, 0.0572, 0.00595, 0.0708, 0.00741, 0.0797, 0.0142, 0.134, 0.0217, 0.181, 0.0272, 0.192, 0.0379, 0.346, 0.0841, 0.504

  adum1     delayr    0.072 
  adel1     deltapi   0.0663 * idelaytime + k1 * ipitchmod
            delayw    ga1 + afilt2 + afilt3

  adum2     delayr    0.082 
  adel2     deltapi   0.0753 * idelaytime + k2 * ipitchmod
            delayw    ga1 - afilt1 - afilt4

  adum3     delayr    0.095
  adel3     deltapi   0.0882 * idelaytime + k3 * ipitchmod
            delayw    ga1 + afilt1 - afilt4

  adum4     delayr    0.11
  adel4     deltapi   0.0971 * idelaytime + k4 * ipitchmod
            delayw    ga1 + afilt2 - afilt3

  afilt1    tone      adel1 * igain, ifilt
  afilt2    tone      adel2 * igain, ifilt
  afilt3    tone      adel3 * igain, ifilt
  afilt4    tone      adel4 * igain, ifilt

;outs afilt1 + afilt3 + atap, afilt2 + afilt4 + atap

  ga3       =  ga3 + afilt1 + afilt3 + atap
  ga4       =  ga4 + afilt2 + afilt4 + atap

  ga1       =  0

endin

instr 97    ; Miller Puckette and John Stautner's
      ; Feedback Delay Network Reverb. Used
    ; in conjunction with instr 96 to create
    ; a very full reverberation sound. The
    ; delay lines of instr 97 are different
    ; lengths than the delay lines of instr 96,
    ; to help smooth out the coloration effects
    ; of a small number of delay lines.

  afilt1    init      0
  afilt2    init      0
  afilt3    init      0
  afilt4    init      0

  igain     =  p4 * 0.70710678117                 ; gain of reverb
  ipitchmod =  p5                                 ; amount of random pitch mod, between 0 and 1
  idelaytime   =      p6                          ; controls overall length of delay lines
  ifilt     =  p7                                 ; controls cutoff of lowpass filters at outputs of delay lines

  k1        randi     .001, 3.1, .06
  k2        randi     .0011, 3.5, .9
  k3        randi     .0017, 1.11, .7
  k4        randi     .0006, 3.973, .3

  atap      multitap  ga1, 0.00043, 0.0215, 0.00268, 0.0298, 0.00485, 0.0572, 0.00595, 0.0708, 0.00741, 0.0797, 0.0142, 0.134, 0.0217, 0.181, 0.0272, 0.192, 0.0379, 0.346, 0.0841, 0.504

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

;outs afilt1 + afilt3 + atap, afilt2 + afilt4 + atap

  ga5       =  ga5 + afilt1 + afilt3 + atap
  ga6       =  ga6 + afilt2 + afilt4 + atap

  ga2       =  0

endin

instr 98  ; frequency shifter for the global reverberator
    ; of instr 96. Transposes the frequencies of
    ; the sustained reverberation downwards, to 
    ; produce a "sinking" effect.


  idur      =  p3
  ibegshift =  p4                                 ; initial amount of frequency shift - can be positive or negative
  iendshift =  p5                                 ; final amount of frequency shift - can be positive or negative

  kfreq     linseg    ibegshift, idur * .25, ibegshift, idur*.75, iendshift
  kamp      linseg    1, idur * .8, 1, idur * .2, 0

; frequency shifter for left channel of instr 96.
  areal, aimag hilbert  ga3

  asin      oscili    1, kfreq, 1
  acos      oscili    1, kfreq, 1, .25
  amod1     =  areal * acos
  amod2     =  aimag * asin
  aupshift  =  (amod1 + amod2) * 0.7   
  adownshift   =      (amod1 - amod2) * 0.7   

; frequency shifter for right channel of instr 96.
  areal2, aimag2      hilbert                     ga4

  asin2     oscili    1, kfreq, 1
  acos2     oscili    1, kfreq, 1, .25

  amod3     =  areal2 * acos2
  amod4     =  aimag2 * asin2

  aupshift2 =  (amod3 + amod4) * 0.7   
  adownshift2  =      (amod3 - amod4) * 0.7 

            outs      aupshift * kamp, aupshift2 * kamp

  ga3       =  0
  ga4       =  0

endin

instr 99  ; frequency shifter for the global reverberator
    ; of instr 97. Transposes the frequencies of
    ; the sustained reverberation downwards, to 
    ; produce a "sinking" effect. In the piece, 
    ; produces a different amount of frequency
    ; shift than instr 99.

  idur      =  p3
  ibegshift =  p4                                 ; initial amount of frequency shift - can be positive or negative
  iendshift =  p5                                 ; final amount of frequency shift - can be positive or negative

  kfreq     linseg    ibegshift, idur * .25, ibegshift, idur*.75, iendshift
  kamp      linseg    1, idur * .8, 1, idur * .2, 0

; frequency shifter for left channel of instr 97.
  areal, aimag hilbert  ga5

  asin      oscili    1, kfreq, 1
  acos      oscili    1, kfreq, 1, .25
  amod1     =  areal * acos
  amod2     =  aimag * asin
  aupshift  =  (amod1 + amod2) * 0.7   
  adownshift   =      (amod1 - amod2) * 0.7   

; frequency shifter for right channel of instr 97. 
  areal2, aimag2      hilbert                     ga6

  asin2     oscili    1, kfreq, 1
  acos2     oscili    1, kfreq, 1, .25

  amod3     =  areal2 * acos2
  amod4     =  aimag2 * asin2

  aupshift2 =  (amod3 + amod4) * 0.7   
  adownshift2  =      (amod3 - amod4) * 0.7 

            outs      aupshift * kamp, aupshift2 * kamp

  ga5       =  0
  ga6       =  0

endin
