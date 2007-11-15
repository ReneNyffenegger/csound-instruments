  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gatenor   init      0
  gasoprano init      0
  gareverb  init      0

instr 19        ; Pulse wave source for tenor voices.
                ; Octave lower than soprano.

  idur      =  p3
  iamp      =  p4
  ifreq     =  p5 * .5

  iharms    =  (sr*.4) / ifreq

  asig      gbuzz     1, ifreq, iharms, 1, .9, 2
  kenv      linseg    0, .1, iamp, idur -.2, iamp, .1, 0
  aout      =  kenv * asig
  gatenor   =  gatenor + aout

endin

instr 20        ; Pulse wave source for soprano voices.

  idur      =  p3
  iamp      =  p4
  ifreq     =  p5

  iharms    =  (sr*.4) / ifreq

  asig      gbuzz     1, ifreq, iharms, 1, .8, 2
  kenv      linseg    0, .1, iamp, idur -.2, iamp, .1, 0
  aout      =  kenv * asig
  gasoprano =  gasoprano + aout


endin


instr 21        ; Global animator/formants for soprano

  idur      =  p3
  ivib1     =  p4
  ivib2     =  p5
  ivibtime  =  p6

  kvib      linseg    ivib1, ivibtime, ivib1, idur, ivib2
; Four independent LFOs for vibrato, based on ARP Omni 
; phaser section. 
  ktime1    oscili    .0012 * kvib, 4, 1
  ktime2    oscili    .0009 * kvib, 5, 1
  ktime3    oscili    .00087 * kvib, 6.3, 1
  ktime4    oscili    .0011 * kvib, 4.4, 1

; Each LFO modulates a seperate deltapi delay line.
  adummy    delayr    .015
  asig1     deltapi   ktime1 + .009
  asig2     deltapi   ktime2 + .009
  asig3     deltapi   ktime3 + .009
  asig4     deltapi   ktime4 + .009
            delayw    gasoprano

; The four delay lines are summed together.
  aout      =  (asig1 + asig2 + asig3 + asig4) * .25

; Bandpass filters, set to produce formants for
; the soprano "ah" sound.
  afilt1    reson     aout, 800, 80, 1
  afilt2    resonz    aout, 1150, 90, 1
  afilt3    resonz    aout, 2900, 120, 1
  afilt4    resonz    aout, 3900, 130, 1
  afilt5    resonz    aout, 4950, 140, 1

; Outputs of filters scaled to correspond to relative
; amplitudes of formants in vocal sound.
  aout2     =  (afilt1 + .5 * afilt2 + 0.1 * afilt3 + 0.3 * afilt4 + .05 * afilt5)

; Part of output sent to reverb.
  gareverb  =  gareverb + .47 * aout2

            outs      aout2, aout2

  gasoprano =  0

endin

instr 22        ; Global animator/formants for tenor

  idur      =  p3
  ivib1     =  p4
  ivib2     =  p5
  ivibtime  =  p6

  kvib      linseg    ivib1, ivibtime, ivib1, idur, ivib2
; Four independent LFOs for vibrato, based on ARP Omni 
; phaser section. 
  ktime1    oscili    .0012 * kvib, 4.2, 1
  ktime2    oscili    .0009 * kvib, 5.3, 1
  ktime3    oscili    .00087 * kvib, 6.1, 1
  ktime4    oscili    .0011 * kvib, 3.9, 1

; Each LFO modulates a seperate deltapi delay line.
  adummy    delayr    .015
  asig1     deltapi   ktime1 + .009
  asig2     deltapi   ktime2 + .009
  asig3     deltapi   ktime3 + .009
  asig4     deltapi   ktime4 + .009
            delayw    gatenor

; The four delay lines are summed together.
  aout      =  (asig1 + asig2 + asig3 + asig4) * .25

; Bandpass filters, set to produce formants for
; the soprano "ah" sound.
  afilt1    reson     aout, 650, 80, 1
  afilt2    resonz    aout, 1080, 90, 1
  afilt3    resonz    aout, 2650, 120, 1
  afilt4    resonz    aout, 2900, 130, 1
  afilt5    resonz    aout, 3250, 140, 1
  aout2     =  (afilt1 + .5 * afilt2 + 0.44 * afilt3 + 0.4 * afilt4 + 0.1 * afilt5)

; Outputs of filters scaled to correspond to relative
; amplitudes of formants in vocal sound.
  gareverb  =  gareverb + .47 * aout2

; Part of output sent to reverb.
            outs      aout2, aout2

  gatenor   =  0

endin

instr 99        ; Feedback Delay Network reverb, based on work
                ; of Stautner & Puckette.

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

  atap      multitap  gareverb, 0.00043, 0.0215, 0.00268, 0.0298, 0.00485, 0.0572, 0.00595, 0.0708, 0.00741, 0.0797, 0.0142, 0.134, 0.0217, 0.181, 0.0272, 0.192, 0.0379, 0.346, 0.0841, 0.504

  adum1     delayr    0.072 
  adel1     deltapi   0.0663 * idelaytime + k1 * ipitchmod
            delayw    gareverb + afilt2 + afilt3

  adum2     delayr    0.082 
  adel2     deltapi   0.0753 * idelaytime + k2 * ipitchmod
            delayw    gareverb - afilt1 - afilt4

  adum3     delayr    0.095
  adel3     deltapi   0.0882 * idelaytime + k3 * ipitchmod
            delayw    gareverb + afilt1 - afilt4

  adum4     delayr    0.11
  adel4     deltapi   0.0971 * idelaytime + k4 * ipitchmod
            delayw    gareverb + afilt2 - afilt3

  afilt1    tone      adel1 * igain, ifilt
  afilt2    tone      adel2 * igain, ifilt
  afilt3    tone      adel3 * igain, ifilt
  afilt4    tone      adel4 * igain, ifilt

            outs      afilt1 + afilt4 + atap, afilt2 + afilt3 + atap

  gareverb  =  0

endin