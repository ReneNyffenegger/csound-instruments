;  Song name:           Grooving Night
;  Tempo:               103 bpm
;  Duration:            8 min 46 s
;  Composer:            Thomas Huber
;  Email:               huber@iamexwi.unibe.ch / thuber@gmx.ch
;  Last changed:        17.5.99

;  CD quality
  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

; Assign MIDI channels to instruments.
; Each instrument has to use its own MIDI channel to use
; its own MIDI controller values. Note that the same instrument
; is included mulptiple times, but is fed with different
; controller values, so it sounds different. Think of an
; instrument as a whole synthesizer, being able to produce
; a whole bunch of different sounds.
            massign   1, 1
            massign   2, 2
            massign   3, 3
            massign   4, 4
            massign   5, 5
            massign   6, 6

; reset global reverb and mixer bus
  gahalll   init      0                           ; left reverb channel
  gahallr   init      0                           ; right reverb channel
  galeft    init      0                           ; left mixer input channel
  garight   init      0                           ; right mixer input channel


instr 1
;       Instrument:             Analog Drum
;       Author:                 Thomas Huber
;       Email:                  huber@iamexwi.unibe.ch /
;                               thuber@gmx.ch
;       Credits:                A significant part of the code is
;                               taken from Josep M Comajuncosas's 'bdrum' code
;       Last changed:           16.5.99
;
;       Description:
;       This instrument is able to produce a variety of Bass drums. It
;       contains two oscillators and a noise source. The initial frequency of 
;       Osc1 is adjustable, the initial frequency of Osc2 is fixed at 4 kHz. 
;       Osc2 also has a fixed envelope decay time. For both oscillators, the 
;       initial frequency can be enveloped to decay with time.
;       Osc1 simulates the low frequency oscillation of the drum, Osc2/Noise
;       simulate the initial noise when the drum is beaten.
;
;       Sound:
;       Produces deep analog bass drums
;
;       Controllers: (Kawai K5000 controller box used)
;       #16:            Osc1 amplitude decay time
;       #18:            Osc1 Base frequency
;       #17:            Frequency decay envelope level
;       #19:            Noise source level
;       #74:            Osci1/Osc2 mix
;       #82:            Reverb amount
;       #83:            Instrument output level (used as mixer)


        ; controllers
  idecay    midictrl  16
  idecay    =  (idecay+1)/90
  ibase     midictrl  18
  ibasefrq  tablei    (ibase/128), 3, 1
  ibasefrq  =  ibasefrq*800 + 25

        ; Oscillator envelopes
  kenv3     mxadsr    0.001, idecay, 0.000001, 0.0001
  kenv4     mxadsr    0.001, 0.01, 0.000001, 0.0001

        ; To prevent too strong reverb caused by sharp attack times
  kreverbenv   madsr  0.15, idecay, 0.0001, 0.01


  ilower    midictrl  17
  ilower    =  ilower/128
  kfreq1    madsr     0.0005, 0.3, 0, 0
  kfreq2    madsr     0.0005, 0.007, 0, 0
  kfreq1    =  (1-ilower)+ilower*kfreq1
  kfreq2    =  (1-ilower)+ilower*kfreq2

            xtratim   0.3

        ; Noise source
  iwheel3   midictrl  19
  arand     randi     (iwheel3/128)*8000,3000
  anoise    =  arand*kenv3

        ; The two oscillators
  aosc1     oscili    20000*kenv3, kfreq1*ibasefrq+25, 1
  aosc2     oscili    10000*kenv4, kfreq2*4000+1000, 1

        ; osci1/osc2 balance
  imix      midictrl  74
  imix      =  imix/128
  aout2     =  imix*aosc1 + (1-imix)*aosc2 + anoise

        ; Sine distorter
  aout3     =  sin(aout2/7000)*32000
  aout      butterlp  aout3, ibasefrq*5
  kwheel1   midictrl  83,0
  kvolume   tablei    (kwheel1/128), 3, 1 

        ; Send to reverb unit
  kwheel2   midictrl  82,0
  kreverb   tablei    (kwheel2/128), 3, 1 
  gahalll   =  gahalll + kreverbenv*kreverb*0.5*aout
  gahallr   =  gahallr + kreverbenv*kreverb*0.5*aout

        ; Output
  adrum     =  0.61*aout*kvolume

        ; Send to mixer bus
  galeft    =  galeft + adrum
  garight   =  garight + adrum
endin


instr 2
;       Instrument:             TB-303
;       Author:                 Thomas Huber
;       Email:                  huber@iamexwi.unibe.ch /
;                               thuber@gmx.ch
;       Credits:                A significant part of the code is
;                               taken from Josep M Comajuncosas's TB-303 code
;       Last changed:           16.5.99
;
;       Description:
;       This instrument is inspired by the famous Roland TB303. It's
;       a Sawtooth filtered through a enveloped, resonant lowpass 
;       filter (moogvcf used). In addition to the cutoff frequency,
;       also the resonance can be enveloped
;
;       Sound:
;       Produces liquid TB303 acid sounds.
;
;       Controllers: (Kawai K5000 controller box used)
;       #74:            Filter cutoff frequency
;       #73:            Filter cutoff envelope attack time
;       #78:            Filter cutoff envelope decay time
;       #72:            Filter cutoff envelope sustain level
;       #81:            Filter cutoff envelope level
;       #77:            Filter resonance
;       #16:            Filter resonance envelope attack time
;       #17:            Filter resonance envelope decay time
;       #71:            Filter resonance envelope sustain level
;       #76:            Filter resonance envelope level
;       #82:            Distorsion level
;       #83:            Instrument output level (used as mixer)



        ; Get frequency from MIDI note numer
  knote     cpsmidib  
        ; Limit for cutoff frequency
  khighest  =  (22050/2.2)/knote
        ; MIDI note velocity is used to modify the filter cutoff
        ; in addition to the controller
  iveloc    ampmidi   1

  iattack   midictrl  73,1,300
  idecay    midictrl  78,10,500
  isustain  midictrl  72,20

  iqattack  midictrl  16,2
  iqdecay   midictrl  17,10
  iqsustain midictrl  71,10

            xtratim   0.01
  kgate     madsr     0.02,0.2,1,0.005
  kdecayraw madsr     iattack/400,idecay/456,isustain/128,0.01
  kqdecayraw   madsr  iqattack/400,iqdecay/456, iqsustain/128,0.02

        ; transpose 1 Octave down
  knote     =  knote/2 

        ; controllers
  kwh1      midictrl  74,34
  kwh2      midictrl  77,24
  kwh4      midictrl  76
  kwh6      midictrl  81
  kwh7      midictrl  82,1
  kwh8      midictrl  83,10
      
        ; controllers only have 7bit resolution. To prevent
        ; stepping, they are integrated. However at the beginning,
        ; the controller must reach its value immediately. So the
        ; integration constant (parameter of portk) is variable.
        ; See Tips & Tricks section in night.txt Text file 
  kstep     linseg    0.00001, 0.075, 0.03
  kwheel1   portk     kwh1, kstep
  kwheel2   portk     kwh2, kstep  
  kwheel4   portk     kwh4, kstep
  kwheel6   portk     kwh6, kstep
  kwheel7   portk     kwh7, kstep
  kwheel8   portk     kwh8, kstep

        ; Filter cutoff
  kcutoff   tablei    (kwheel1/128),3,1           ; logarithmic scale
  kcutoff   =  khighest*kcutoff

  kamount   tablei    (kwheel6/128), 3, 1
  kamount2  tablei    (kwheel4/128), 3, 1
  kdecay    =  (1-kamount)+kamount*kdecayraw
  kqdecay   =  (1-kamount2)+kamount2*kqdecayraw

        ; Limit check
  kfrq      =  knote * kdecay * kcutoff * iveloc + 50
  kfrq      =  (kfrq > 22050/2.2 ? 22050/2.2 : kfrq)
  kres      =  ((kwheel2/128) + kqdecay)/2

        ; Generate Sawtooths (stereo, slightly detuned)
  a1        buzz      1, knote, 44100/(4*knote), 1 ,0 ;bandlimited pulse
  a2        buzz      1, knote*0.99, 44100/(4*knote), 1 ,0
  asawl     filter2   a1, 1, 1, 1, -.99           ;leaky integrator
  asawr     filter2   a2, 1, 1, 1, -.99

        ; pass through moog analog filter
  arawtmpl  moogvcf   0.5*asawl, kfrq, kres
  arawtmpr  moogvcf   0.5*asawr, kfrq, kres

        ; adjust output level (if cutoff is low, the output would
        ; drop)
  arawl     balance   arawtmpl, asawl
  arawr     balance   arawtmpr, asawr

        ; "Sinus-Distorter". The output is fed into a sine function.
        ; The sine is linear for small arguments, and increasingly
        ; nonlinear for higher arguments. Another possibility would
        ; be tanh.
  kdist     tablei    (kwheel7/128), 3, 1
  kdist     =  kdist * 10
  kpostgain =  (kdist > 1 ? 1 : kdist)
  aaudiol   =  sin(kdist*(kwheel8/127)*arawl*kgate)/(kpostgain+0.0001)
  aaudior   =  sin(kdist*(kwheel8/127)*arawr*kgate)/(kpostgain+0.0001)

        ; Filter too low frequencies
  aaudiol   butterhp  aaudiol, 25
  aaudior   butterhp  aaudior, 25

        ; Apply envelope
  aleft     =  0.6*10000*(kwheel8/127)*aaudiol*kgate ;
  aright    =  0.6*10000*(kwheel8/127)*aaudior*kgate ;

        ; Pass to reverb unit
  gahalll   =  gahalll + 0.25*aleft
  gahallr   =  gahallr + 0.25*aright

        ; Add to global Mixer bus
  galeft    =  galeft + aleft
  garight   =  garight + aright
endin


instr 3
;       Instrument:             TB-303
;       Author:                 Thomas Huber
;       Email:                  huber@iamexwi.unibe.ch /
;                               thuber@gmx.ch
;       Credits:                A significant part of the code is
;                               taken from Josep M Comajuncosas's TB-303 code
;       Last changed:           16.5.99
;
;       Description:
;       This instrument is inspired by the famous Roland TB303. It's
;       a Sawtooth filtered through a enveloped, resonant lowpass 
;       filter (moogvcf used). In addition to the cutoff frequency,
;       also the resonance can be enveloped
;
;       Sound:
;       Produces liquid TB303 acid sounds.
;
;       Controllers: (Kawai K5000 controller box used)
;       #74:            Filter cutoff frequency
;       #73:            Filter cutoff envelope attack time
;       #78:            Filter cutoff envelope decay time
;       #72:            Filter cutoff envelope sustain level
;       #81:            Filter cutoff envelope level
;       #77:            Filter resonance
;       #16:            Filter resonance envelope attack time
;       #17:            Filter resonance envelope decay time
;       #71:            Filter resonance envelope sustain level
;       #76:            Filter resonance envelope level
;       #82:            Distorsion level
;       #83:            Instrument output level (used as mixer)



        ; Get frequency from MIDI note numer
  knote     cpsmidib  
        ; Limit for cutoff frequency
  khighest  =  (22050/2.2)/knote
        ; MIDI note velocity is used to modify the filter cutoff
        ; in addition to the controller
  iveloc    ampmidi   1

  iattack   midictrl  73,1,300
  idecay    midictrl  78,10,500
  isustain  midictrl  72,20

  iqattack  midictrl  16,2
  iqdecay   midictrl  17,10
  iqsustain midictrl  71,10

            xtratim   0.01

  kgate     madsr     0.02,0.2,1,0.005
  kdecayraw madsr     iattack/400,idecay/456,isustain/128,0.01
  kqdecayraw   madsr  iqattack/400,iqdecay/456, iqsustain/128,0.02

        ; transpose 1 Octave down
  knote     =  knote/2 

        ; controllers
  kwh1      midictrl  74,34
  kwh2      midictrl  77,24
  kwh4      midictrl  76
  kwh6      midictrl  81
  kwh7      midictrl  82,1
  kwh8      midictrl  83,10
      
        ; controllers only have 7bit resolution. To prevent
        ; stepping, they are integrated. However at the beginning,
        ; the controller must reach its value immediately. So the
        ; integration constant (parameter of portk) is variable.
        ; See Tips & Tricks section in night.txt Text file 
  kstep     linseg    0.00001, 0.075, 0.03
  kwheel1   portk     kwh1, kstep
  kwheel2   portk     kwh2, kstep  
  kwheel4   portk     kwh4, kstep
  kwheel6   portk     kwh6, kstep
  kwheel7   portk     kwh7, kstep
  kwheel8   portk     kwh8, kstep

        ; Filter cutoff
  kcutoff   tablei    (kwheel1/128),3,1           ; logarithmic scale
  kcutoff   =  khighest*kcutoff

  kamount   tablei    (kwheel6/128), 3, 1
  kamount2  tablei    (kwheel4/128), 3, 1
  kdecay    =  (1-kamount)+kamount*kdecayraw
  kqdecay   =  (1-kamount2)+kamount2*kqdecayraw

        ; Limit check
  kfrq      =  knote * kdecay * kcutoff * iveloc + 50
  kfrq      =  (kfrq > 22050/2.2 ? 22050/2.2 : kfrq)
  kres      =  ((kwheel2/128) + kqdecay)/2

        ; Generate Sawtooths (stereo, slightly detuned)
  a1        buzz      1, knote, 44100/(4*knote), 1 ,0 ;bandlimited pulse
  a2        buzz      1, knote*0.99, 44100/(4*knote), 1 ,0
  asawl     filter2   a1, 1, 1, 1, -.99           ;leaky integrator
  asawr     filter2   a2, 1, 1, 1, -.99

        ; pass through moog analog filter
  arawtmpl  moogvcf   0.5*asawl, kfrq, kres
  arawtmpr  moogvcf   0.5*asawr, kfrq, kres

        ; adjust output level (if cutoff is low, the output would
        ; drop)
  arawl     balance   arawtmpl, asawl
  arawr     balance   arawtmpr, asawr

        ; "Sinus-Distorter". The output is fed into a sine function.
        ; The sine is linear for small arguments, and increasingly
        ; nonlinear for higher arguments. Another possibility would
        ; be tanh.
  kdist     tablei    (kwheel7/128), 3, 1
  kdist     =  kdist * 10
  kpostgain =  (kdist > 1 ? 1 : kdist)
  aaudiol   =  sin(kdist*(kwheel8/127)*arawl*kgate)/(kpostgain+0.0001)
  aaudior   =  sin(kdist*(kwheel8/127)*arawr*kgate)/(kpostgain+0.0001)

        ; Filter too low frequencies
  aaudiol   butterhp  aaudiol, 25
  aaudior   butterhp  aaudior, 25

        ; Apply envelope
  aleft     =  0.6*10000*(kwheel8/127)*aaudiol*kgate ;
  aright    =  0.6*10000*(kwheel8/127)*aaudior*kgate ;

        ; Pass to reverb unit
  gahalll   =  gahalll + 0.25*aleft
  gahallr   =  gahallr + 0.25*aright

        ; Add to global Mixer bus
  galeft    =  galeft + aleft
  garight   =  garight + aright
endin



instr 4
;       Instrument:     MS404
;       Author:         Thomas Huber
;       Email:          huber@iamexwi.unibe.ch / thuber@gmx.ch
;       Last change:    16.5.99
;
;       Principle:
;       This instrument was originally inspired by the MS404
;       Analog Synthesizer. It contains 4 stereo VCO's that
;       are PWM modulated by LFO's. The output is filtered
;       through a MOOG VCF filter with adjustable enveloped and/or
;       modulated cutoff. The cutoff is also modulateable by a
;       chaotic source (lorenz opcode).
;
;       Sound:
;       This instrument produces a very warm, analog-like
;       sound. If the filter envelope decay time is set short,
;       also very sharp, percussive sounds can be produced
;
;       Controllers: (controlled by a Kawai K5000 controller box)
;       #73:            Filter envelope attack time
;       #78:            Filter envelope decay time
;       #72:            Filter envelope sustain level
;       #74;            Filter cutoff frequency
;       #77;            Filter resonance
;       #71:            Filter envelope level
;       #16;            LFO frequency
;       #17:            LFO amplitude
;       #75:            Chaotic source amplitude (modulates filter cutoff)
;       #80:            PWM LFO frequency
;       #81:            PWM LFO amplitude
;       #82:            Distorsion amount
;       #83:            Overall instrument level (used as mixer)



        ; Convert MIDI notenumber to frequency
  inote     cpsmidib  
        ; Limit for filter cutoff
  ihighest  =  (sr/2)/inote*1.5
        ; final step size for portk to integrate controller values
  istepsize =  0.03

        ; Instrument envelope
  kgate     madsr     0.003,0.2,0.9,0.12

        ; Filter envelope
  iattack   midictrl  73,1
  idecay    midictrl  78,10,500
  isustain  midictrl  72,10
  kdecayraw madsr     iattack/400,(idecay+1)/456,(isustain+8)/128,0.1

        ; controllers
  kwh1      midictrl  74,14
  kwh2      midictrl  77,14
  kwh3      midictrl  16,1
  kwh4      midictrl  17,1
  kwh5      midictrl  80,14
  kwh6      midictrl  81
  iwheel7   midictrl  82,1
  kwh8      midictrl  83,5
  kwh10     midictrl  75
  kwh11     midictrl  71


        ; Controllers only have 7bit resolution. To prevent
        ; stepping, they are integrated. However at the beginning,
        ; the controller must reach its value immediately. So the
        ; integration constant (parameter of portk) is variable and
        ; very small at the beginning, reaching it's final value
        ; after 75 ms.
        ; See Tips & Tricks section in night.txt Text file 
  kstep     linseg    0.00001, 0.075, istepsize
  kwheel1   portk     kwh1, kstep
  kwheel2   portk     kwh2, kstep
  kwheel3   portk     kwh3, kstep
  kwheel4   portk     kwh4, kstep
  kwheel5   portk     kwh5, kstep
  kwheel6   portk     kwh6, kstep
  kwheel8   portk     kwh8, kstep
  kwheel10  portk     kwh10, kstep
  kwheel11  portk     kwh11, kstep

  kamount   tablei    (kwheel11/128), 3, 1
  kdecay    =  (1-kamount)+kamount*kdecayraw
  kcutoff   tablei    (kwheel1/128),3,1           ; logarithmic scale
  kcutoff   =  ihighest*kcutoff/2

        ; range checks. The low boundary check is used because
        ; for low krates, madsr can produce negative values
  kfrq2     =  (inote * kdecay * kcutoff * 1.8) + 100
  kfrq3     =  (kfrq2 > sr/3 ? sr/3 : kfrq2)
  kfrq      =  (kfrq3 <= 100 ? 101 : kfrq3)
  kres      =  (kwheel2/128)

        ; LFO's for FM and cutoff-modulation. The trinagle is
        ; used for FM modulation of the sound frequency, the other 
        ; is a chaotic source used to modulate the cutoff of the
        ; filter
  klfofreq  tablei    (kwheel3/128), 3, 1
  klfofreq  =  klfofreq*40+0.00001
  klfo      lfo       0.5, klfofreq, 1

        ; Lorenz chaotic source
  achaos,ay,az lorenz   10, 28, 8/3, 0.005, 0.6, 0.6, 0.6, 1
  kchaos    downsamp  achaos
  kchaos    =  (kchaos > 3 ? 3 : kchaos)
  kchaos    =  (kchaos < -3 ? -3 : kchaos)

  klfo1     =  1+(kwheel4/128)*klfo*0.02
  klfo2     =  1+(kwheel10/128)*kchaos*0.1
  kpwfrq    tablei    (kwheel5/128),3,1

        ; LFO's for the pulse width modulation. Amount of
        ; modulation controllable
  kpwamp    tablei    (kwheel6/128), 3, 1
  kpw       lfo       0.30*kpwamp, kpwfrq*27, 0
  kpw2      lfo       0.30*kpwamp, kpwfrq*20, 0
  kpw3      lfo       0.30*kpwamp, kpwfrq*18, 0
  kpw4      lfo       0.30*kpwamp, kpwfrq*23, 0
  kpw       =  kpw + 0.5
  kpw2      =  kpw2 + 0.5
  kpw3      =  kpw3 + 0.5
  kpw4      =  kpw4 + 0.5

        ; PWM modulated Sawtooth. If you think pulse width and
        ; sawtooth are incompatible, think of a saw/ramp-ratio
        ; modulated sawtooth. But it all the same sounds PWM-ish
        ; Per channel, 4 vco's that are slightly detuned in the
        ; percent range are mixed. All vco's on the left channel
        ; are tuned lower, all vco's on the right channel are
        ; tuned higher. Two different PWM frequency are used
        ; per stereo channel. These two produce a nice stereo effect
  asaw1l    vco       0.25, klfo1*inote*0.99951, 2, kpw,  1, 1/inote
  asaw2l    vco       0.25, klfo1*inote*0.98209, 2, kpw,  1, 1/inote
  asaw3l    vco       0.25, klfo1*inote*0.99121, 2, kpw2, 1, 1/inote
  asaw4l    vco       0.25, klfo1*inote*0.99344, 2, kpw2, 1, 1/inote
  ainputleft   =      0.26*(asaw1l+asaw2l+asaw3l+asaw4l)

  asaw1r    vco       0.25, klfo1*inote*1.00259, 2, kpw3,  1, 1/inote
  asaw2r    vco       0.25, klfo1*inote*1.02109, 2, kpw3,  1, 1/inote
  asaw3r    vco       0.25, klfo1*inote*1.01221, 2, kpw4, 1, 1/inote
  asaw4r    vco       0.25, klfo1*inote*1.00744, 2, kpw4, 1, 1/inote
  ainputright  =      0.26*(asaw1r+asaw2r+asaw3r+asaw4r)

        ; Now the stuff is filtered. The LFO is used for a stereo
        ; panning effect
  kpan      lfo       0.25, 0.3, 1
  kpan      =  kpan + 0.5
        ; MOOG analog filter
  aoutleft  moogvcf   0.4*(kpan)*ainputleft,  kfrq*klfo2, kres
  aoutright moogvcf   0.4*(1-kpan)*ainputright, kfrq*klfo2, kres

        ; Apply envelope
  atmpr     =  32000*(kwheel8/127)*aoutleft*kgate ;
  atmpl     =  32000*(kwheel8/127)*aoutright*kgate ;

        ; Distorter
        ; The distort1 opcode is used, but I'm not too happy
        ; with it. I'll have to learn about Chebychef Polynomials
        ; for a good distorter.
  idist     tablei    (iwheel7/128), 3, 1         ; amount of distorsion
  idist     =  idist*100
  aaudiol   distort1  atmpl, idist, 1/sqrt(idist), 0.5, 0.5
  aaudior   distort1  atmpr, idist, 1/sqrt(idist), 0.5, 0.5

        ; Send to Reverb Unit
  gahalll   =  gahalll + 0.2*aaudiol
  gahallr   =  gahallr + 0.2*aaudior

        ; Add to global Audio Bus
  galeft    =  galeft + aaudiol
  garight   =  garight + aaudior
endin




instr 5
;       Instrument:     MS404
;       Author:         Thomas Huber
;       Email:          huber@iamexwi.unibe.ch / thuber@gmx.ch
;       Last change:    16.5.99
;
;       Principle:
;       This instrument was originally inspired by the MS404
;       Analog Synthesizer. It contains 4 stereo VCO's that
;       are PWM modulated by LFO's. The output is filtered
;       through a MOOG VCF filter with adjustable enveloped and/or
;       modulated cutoff. The cutoff is also modulateable by a
;       chaotic source (lorenz opcode).
;
;       Sound:
;       This instrument produces a very warm, analog-like
;       sound. If the filter envelope decay time is set short,
;       also very sharp, percussive sounds can be produced
;
;       Controllers: (controlled by a Kawai K5000 controller box)
;       #73:            Filter envelope attack time
;       #78:            Filter envelope decay time
;       #72:            Filter envelope sustain level
;       #74;            Filter cutoff frequency
;       #77;            Filter resonance
;       #71:            Filter envelope level
;       #16;            LFO frequency
;       #17:            LFO amplitude
;       #75:            Chaotic source amplitude (modulates filter cutoff)
;       #80:            PWM LFO frequency
;       #81:            PWM LFO amplitude
;       #82:            Distorsion amount
;       #83:            Overall instrument level (used as mixer)



        ; Convert MIDI notenumber to frequency
  inote     cpsmidib  
        ; Limit for filter cutoff
  ihighest  =  (sr/2)/inote*1.5
        ; final step size for portk to integrate controller values
  istepsize =  0.03

        ; Instrument envelope
  kgate     madsr     0.003,0.2,0.9,0.12

        ; Filter envelope
  iattack   midictrl  73,1
  idecay    midictrl  78,10,500
  isustain  midictrl  72,10
  kdecayraw madsr     iattack/400,(idecay+1)/456,(isustain+8)/128,0.1

        ; controllers
  kwh1      midictrl  74,14
  kwh2      midictrl  77,14
  kwh3      midictrl  16,1
  kwh4      midictrl  17,1
  kwh5      midictrl  80,14
  kwh6      midictrl  81
  iwheel7   midictrl  82,1
  kwh8      midictrl  83,5
  kwh10     midictrl  75
  kwh11     midictrl  71


        ; Controllers only have 7bit resolution. To prevent
        ; stepping, they are integrated. However at the beginning,
        ; the controller must reach its value immediately. So the
        ; integration constant (parameter of portk) is variable and
        ; very small at the beginning, reaching it's final value
        ; after 75 ms.
        ; See Tips & Tricks section in night.txt Text file 
  kstep     linseg    0.00001, 0.075, istepsize
  kwheel1   portk     kwh1, kstep
  kwheel2   portk     kwh2, kstep
  kwheel3   portk     kwh3, kstep
  kwheel4   portk     kwh4, kstep
  kwheel5   portk     kwh5, kstep
  kwheel6   portk     kwh6, kstep
  kwheel8   portk     kwh8, kstep
  kwheel10  portk     kwh10, kstep
  kwheel11  portk     kwh11, kstep

  kamount   tablei    (kwheel11/128), 3, 1
  kdecay    =  (1-kamount)+kamount*kdecayraw
  kcutoff   tablei    (kwheel1/128),3,1           ; logarithmic scale
  kcutoff   =  ihighest*kcutoff/2

        ; range checks. The low boundary check is used because
        ; for low krates, madsr can produce negative values
  kfrq2     =  (inote * kdecay * kcutoff * 1.8) + 100
  kfrq3     =  (kfrq2 > sr/3 ? sr/3 : kfrq2)
  kfrq      =  (kfrq3 <= 100 ? 101 : kfrq3)
  kres      =  (kwheel2/128)

        ; LFO's for FM and cutoff-modulation. The trinagle is
        ; used for FM modulation of the sound frequency, the other 
        ; is a chaotic source used to modulate the cutoff of the
        ; filter
  klfofreq  tablei    (kwheel3/128), 3, 1
  klfofreq  =  klfofreq*40+0.00001
  klfo      lfo       0.5, klfofreq, 1

        ; Lorenz chaotic source
  achaos,ay,az lorenz   10, 28, 8/3, 0.005, 0.6, 0.6, 0.6, 1
  kchaos    downsamp  achaos
  kchaos    =  (kchaos > 3 ? 3 : kchaos)
  kchaos    =  (kchaos < -3 ? -3 : kchaos)

  klfo1     =  1+(kwheel4/128)*klfo*0.02
  klfo2     =  1+(kwheel10/128)*kchaos*0.1
  kpwfrq    tablei    (kwheel5/128),3,1

        ; LFO's for the pulse width modulation. Amount of
        ; modulation controllable
  kpwamp    tablei    (kwheel6/128), 3, 1
  kpw       lfo       0.30*kpwamp, kpwfrq*27, 0
  kpw2      lfo       0.30*kpwamp, kpwfrq*20, 0
  kpw3      lfo       0.30*kpwamp, kpwfrq*18, 0
  kpw4      lfo       0.30*kpwamp, kpwfrq*23, 0
  kpw       =  kpw + 0.5
  kpw2      =  kpw2 + 0.5
  kpw3      =  kpw3 + 0.5
  kpw4      =  kpw4 + 0.5

        ; PWM modulated Sawtooth. If you think pulse width and
        ; sawtooth are incompatible, think of a saw/ramp-ratio
        ; modulated sawtooth. But it all the same sounds PWM-ish
        ; Per channel, 4 vco's that are slightly detuned in the
        ; percent range are mixed. All vco's on the left channel
        ; are tuned lower, all vco's on the right channel are
        ; tuned higher. Two different PWM frequency are used
        ; per stereo channel. These two produce a nice stereo effect
  asaw1l    vco       0.25, klfo1*inote*0.99951, 2, kpw,  1, 1/inote
  asaw2l    vco       0.25, klfo1*inote*0.98209, 2, kpw,  1, 1/inote
  asaw3l    vco       0.25, klfo1*inote*0.99121, 2, kpw2, 1, 1/inote
  asaw4l    vco       0.25, klfo1*inote*0.99344, 2, kpw2, 1, 1/inote
  ainputleft   =      0.26*(asaw1l+asaw2l+asaw3l+asaw4l)

  asaw1r    vco       0.25, klfo1*inote*1.00259, 2, kpw3,  1, 1/inote
  asaw2r    vco       0.25, klfo1*inote*1.02109, 2, kpw3,  1, 1/inote
  asaw3r    vco       0.25, klfo1*inote*1.01221, 2, kpw4, 1, 1/inote
  asaw4r    vco       0.25, klfo1*inote*1.00744, 2, kpw4, 1, 1/inote
  ainputright  =      0.26*(asaw1r+asaw2r+asaw3r+asaw4r)

        ; Now the stuff is filtered. The LFO is used for a stereo
        ; panning effect
  kpan      lfo       0.25, 0.3, 1
  kpan      =  kpan + 0.5
        ; MOOG analog filter
  aoutleft  moogvcf   0.4*(kpan)*ainputleft,  kfrq*klfo2, kres
  aoutright moogvcf   0.4*(1-kpan)*ainputright, kfrq*klfo2, kres

        ; Apply envelope
  atmpr     =  32000*(kwheel8/127)*aoutleft*kgate ;
  atmpl     =  32000*(kwheel8/127)*aoutright*kgate ;

        ; Distorter
        ; The distort1 opcode is used, but I'm not too happy
        ; with it. I'll have to learn about Chebychef Polynomials
        ; for a good distorter.
  idist     tablei    (iwheel7/128), 3, 1         ; amount of distorsion
  idist     =  idist*100
  aaudiol   distort1  atmpl, idist, 1/sqrt(idist), 0.5, 0.5
  aaudior   distort1  atmpr, idist, 1/sqrt(idist), 0.5, 0.5

        ; Send to Reverb Unit
  gahalll   =  gahalll + 0.2*aaudiol
  gahallr   =  gahallr + 0.2*aaudior

        ; Add to global Audio Bus
  galeft    =  galeft + aaudiol
  garight   =  garight + aaudior
endin



instr 6
;       Instrument:     MS404
;       Author:         Thomas Huber
;       Email:          huber@iamexwi.unibe.ch / thuber@gmx.ch
;       Last change:    16.5.99
;
;       Principle:
;       This instrument was originally inspired by the MS404
;       Analog Synthesizer. It contains 4 stereo VCO's that
;       are PWM modulated by LFO's. The output is filtered
;       through a MOOG VCF filter with adjustable enveloped and/or
;       modulated cutoff. The cutoff is also modulateable by a
;       chaotic source (lorenz opcode).
;
;       Sound:
;       This instrument produces a very warm, analog-like
;       sound. If the filter envelope decay time is set short,
;       also very sharp, percussive sounds can be produced
;
;       Controllers: (controlled by a Kawai K5000 controller box)
;       #73:            Filter envelope attack time
;       #78:            Filter envelope decay time
;       #72:            Filter envelope sustain level
;       #74;            Filter cutoff frequency
;       #77;            Filter resonance
;       #71:            Filter envelope level
;       #16;            LFO frequency
;       #17:            LFO amplitude
;       #75:            Chaotic source amplitude (modulates filter cutoff)
;       #80:            PWM LFO frequency
;       #81:            PWM LFO amplitude
;       #82:            Distorsion amount
;       #83:            Overall instrument level (used as mixer)



        ; Convert MIDI notenumber to frequency
  inote     cpsmidib  
        ; Limit for filter cutoff
  ihighest  =  (sr/2)/inote*1.5
        ; final step size for portk to integrate controller values
  istepsize =  0.03

        ; Instrument envelope
  kgate     madsr     0.003,0.2,0.9,0.12

        ; Filter envelope
  iattack   midictrl  73,1
  idecay    midictrl  78,10,500
  isustain  midictrl  72,10
  kdecayraw madsr     iattack/400,(idecay+1)/456,(isustain+8)/128,0.1

        ; controllers
  kwh1      midictrl  74,14
  kwh2      midictrl  77,14
  kwh3      midictrl  16,1
  kwh4      midictrl  17,1
  kwh5      midictrl  80,14
  kwh6      midictrl  81
  iwheel7   midictrl  82,1
  kwh8      midictrl  83,5
  kwh10     midictrl  75
  kwh11     midictrl  71


        ; Controllers only have 7bit resolution. To prevent
        ; stepping, they are integrated. However at the beginning,
        ; the controller must reach its value immediately. So the
        ; integration constant (parameter of portk) is variable and
        ; very small at the beginning, reaching it's final value
        ; after 75 ms.
        ; See Tips & Tricks section in night.txt Text file 
  kstep     linseg    0.00001, 0.075, istepsize
  kwheel1   portk     kwh1, kstep
  kwheel2   portk     kwh2, kstep
  kwheel3   portk     kwh3, kstep
  kwheel4   portk     kwh4, kstep
  kwheel5   portk     kwh5, kstep
  kwheel6   portk     kwh6, kstep
  kwheel8   portk     kwh8, kstep
  kwheel10  portk     kwh10, kstep
  kwheel11  portk     kwh11, kstep

  kamount   tablei    (kwheel11/128), 3, 1
  kdecay    =  (1-kamount)+kamount*kdecayraw
  kcutoff   tablei    (kwheel1/128),3,1           ; logarithmic scale
  kcutoff   =  ihighest*kcutoff/2

        ; range checks. The low boundary check is used because
        ; for low krates, madsr can produce negative values
  kfrq2     =  (inote * kdecay * kcutoff * 1.8) + 100
  kfrq3     =  (kfrq2 > sr/3 ? sr/3 : kfrq2)
  kfrq      =  (kfrq3 <= 100 ? 101 : kfrq3)
  kres      =  (kwheel2/128)

        ; LFO's for FM and cutoff-modulation. The trinagle is
        ; used for FM modulation of the sound frequency, the other 
        ; is a chaotic source used to modulate the cutoff of the
        ; filter
  klfofreq  tablei    (kwheel3/128), 3, 1
  klfofreq  =  klfofreq*40+0.00001
  klfo      lfo       0.5, klfofreq, 1

        ; Lorenz chaotic source
  achaos,ay,az lorenz   10, 28, 8/3, 0.005, 0.6, 0.6, 0.6, 1
  kchaos    downsamp  achaos
  kchaos    =  (kchaos > 3 ? 3 : kchaos)
  kchaos    =  (kchaos < -3 ? -3 : kchaos)

  klfo1     =  1+(kwheel4/128)*klfo*0.02
  klfo2     =  1+(kwheel10/128)*kchaos*0.1
  kpwfrq    tablei    (kwheel5/128),3,1

        ; LFO's for the pulse width modulation. Amount of
        ; modulation controllable
  kpwamp    tablei    (kwheel6/128), 3, 1
  kpw       lfo       0.30*kpwamp, kpwfrq*27, 0
  kpw2      lfo       0.30*kpwamp, kpwfrq*20, 0
  kpw3      lfo       0.30*kpwamp, kpwfrq*18, 0
  kpw4      lfo       0.30*kpwamp, kpwfrq*23, 0
  kpw       =  kpw + 0.5
  kpw2      =  kpw2 + 0.5
  kpw3      =  kpw3 + 0.5
  kpw4      =  kpw4 + 0.5

        ; PWM modulated Sawtooth. If you think pulse width and
        ; sawtooth are incompatible, think of a saw/ramp-ratio
        ; modulated sawtooth. But it all the same sounds PWM-ish
        ; Per channel, 4 vco's that are slightly detuned in the
        ; percent range are mixed. All vco's on the left channel
        ; are tuned lower, all vco's on the right channel are
        ; tuned higher. Two different PWM frequency are used
        ; per stereo channel. These two produce a nice stereo effect
  asaw1l    vco       0.25, klfo1*inote*0.99951, 2, kpw,  1, 1/inote
  asaw2l    vco       0.25, klfo1*inote*0.98209, 2, kpw,  1, 1/inote
  asaw3l    vco       0.25, klfo1*inote*0.99121, 2, kpw2, 1, 1/inote
  asaw4l    vco       0.25, klfo1*inote*0.99344, 2, kpw2, 1, 1/inote
  ainputleft   =      0.26*(asaw1l+asaw2l+asaw3l+asaw4l)

  asaw1r    vco       0.25, klfo1*inote*1.00259, 2, kpw3,  1, 1/inote
  asaw2r    vco       0.25, klfo1*inote*1.02109, 2, kpw3,  1, 1/inote
  asaw3r    vco       0.25, klfo1*inote*1.01221, 2, kpw4, 1, 1/inote
  asaw4r    vco       0.25, klfo1*inote*1.00744, 2, kpw4, 1, 1/inote
  ainputright  =      0.26*(asaw1r+asaw2r+asaw3r+asaw4r)

        ; Now the stuff is filtered. The LFO is used for a stereo
        ; panning effect
  kpan      lfo       0.25, 0.3, 1
  kpan      =  kpan + 0.5
        ; MOOG analog filter
  aoutleft  moogvcf   0.4*(kpan)*ainputleft,  kfrq*klfo2, kres
  aoutright moogvcf   0.4*(1-kpan)*ainputright, kfrq*klfo2, kres


        ; Apply envelope
  atmpr     =  32000*(kwheel8/127)*aoutleft*kgate ;
  atmpl     =  32000*(kwheel8/127)*aoutright*kgate ;

        ; Distorter
        ; The distort1 opcode is used, but I'm not too happy
        ; with it. I'll have to learn about Chebychef Polynomials
        ; for a good distorter.
  idist     tablei    (iwheel7/128), 3, 1         ; amount of distorsion
  idist     =  idist*100
  aaudiol   distort1  atmpl, idist, 1/sqrt(idist), 0.5, 0.5
  aaudior   distort1  atmpr, idist, 1/sqrt(idist), 0.5, 0.5

        ; Send to Reverb Unit
  gahalll   =  gahalll + 0.2*aaudiol
  gahallr   =  gahallr + 0.2*aaudior

        ; Add to global Audio Bus
  galeft    =  galeft + aaudiol
  garight   =  garight + aaudior
endin


instr 98
;       Instrument:             Ultra Reverbator
;       Author:                 Thomas Huber
;       Email:                  huber@iamexwi.unibe.ch / thuber@gmx.ch
;       Last changed:           15.5.99
;
;       Principle:
;       Simple stereo reverbator based on a lot of delays (60 per channel)
;       with 9 main delay times. The reverbator is configurable by
;       the following room characteristics: 
;       size:           Room size. Useful values: 0.2...3
;       diffusion:      Diffusion factor. 0...1
;       reflectivity:   Wall reflectivity, feedback value. 0..0.999
;       cutoff:         Room cutoff frequency
;       amount:         damping factor of frequencies below cutoff in dB
;                       -24..0
;       gain:           Overall gain of the reverb unit
;
;       Sound:
;       Well... not bad, but to be optimised, especially for big
;       rooms and high reflectivity factors


  isize     =  p4+0.1                             ; Room size. 1 = normal, >1 bigger, <1 smaller
  idiff     =  p5                                 ; Diffusion factor
  irefl     =  p6                                 ; Reflectivity of walls 0..1
  icutoff   =  p7                                 ; Room cutoff frequency
  iamount   =  p8                                 ; Cut in db per pass
  igain     =  p9                                 ; Reverb gain

        ; 9 main delay times. Direct and a few indirect reflections at
        ; the walls of the oom
  idelay1   =  0.070*isize
  idelay2   =  0.074*isize
  idelay3   =  0.081*isize
  idelay4   =  0.087*isize
  idelay5   =  0.092*isize
  idelay6   =  0.104*isize
  idelay7   =  0.102*isize
  idelay8   =  0.118*isize
  idelay9   =  0.120*isize
  idelay10  =  0.148*isize

        ; clear old reverb out. The old values are used for the feedback
        ; (reflectivity)
  aleftold  init      0
  arightold init      0

        ; Parametric equalizer used to simulate room cutoff frequency
  alastl    pareq     aleftold, icutoff, ampdb(iamount), sqrt(.5), 1

        ; input from left global reverb channel
  ain       =  gahalll+irefl*alastl

        ; A lot of delays... (60)
  adel1     delay     ain, idelay1
  adel2     delay     ain, idelay1*(1-0.21242*idiff)
  adel3     delay     ain, idelay1*(1-0.11273*idiff)
  adel4     delay     ain, idelay1*(1-0.03927*idiff)
  adel5     delay     ain, idelay1+(idelay2-idelay1)*0.11091*idiff
  adel6     delay     ain, idelay1+(idelay2-idelay1)*0.24627*idiff

  adelayed  =  adel1 + 0.9*adel2 + 0.95*adel3 + 0.85*adel4+ 0.85*adel5 + 0.8*adel6
  ifact     =  5.8

  adel7     delay     ain, idelay2
  adel8     delay     ain, idelay2-(idelay2-idelay1)*0.86445*idiff
  adel9     delay     ain, idelay2-(idelay2-idelay1)*0.48500*idiff
  adel10    delay     ain, idelay2+(idelay3-idelay2)*0.10407*idiff
  adel11    delay     ain, idelay2+(idelay3-idelay2)*0.60050*idiff
  adel12    delay     ain, idelay2+(idelay3-idelay2)*0.74800*idiff

  adelayed  =  adelayed + 0.8*adel7 + 0.86*adel8 + 0.82*adel9 + 0.75*adel10 + 0.78*adel11 + 0.73*adel12
  ifact     =  ifact + 4.74


  adel13    delay     ain, idelay3
  adel14    delay     ain, idelay3-(idelay3-idelay2)*0.749063*idiff
  adel15    delay     ain, idelay3-(idelay3-idelay2)*0.566399*idiff
  adel16    delay     ain, idelay3+(idelay4-idelay3)*0.277363*idiff
  adel17    delay     ain, idelay3+(idelay4-idelay3)*0.689000*idiff
  adel18    delay     ain, idelay3+(idelay4-idelay3)*0.895003*idiff

  adelayed  =  adelayed + 0.74*adel13 + 0.66*adel14 + 0.65*adel15 + 0.78*adel16 + 0.67*adel17 + 0.6*adel18
  ifact     =  ifact + 4.10

  adel19    delay     ain, idelay4
  adel20    delay     ain, idelay4-(idelay4-idelay3)*0.391666*idiff
  adel21    delay     ain, idelay4-(idelay4-idelay3)*0.401646*idiff
  adel22    delay     ain, idelay4+(idelay5-idelay4)*0.151369*idiff
  adel23    delay     ain, idelay4+(idelay5-idelay4)*0.691636*idiff
  adel24    delay     ain, idelay4+(idelay5-idelay4)*0.737666*idiff

  adelayed  =  adelayed + 0.64*adel19 + 0.61*adel20 + 0.59*adel21 + 0.55*adel22 + 0.63*adel23 + 0.6*adel24
  ifact     =  ifact + 3.62


  adel25    delay     ain, idelay5
  adel26    delay     ain, idelay5-(idelay5-idelay4)*0.990076*idiff
  adel27    delay     ain, idelay5-(idelay5-idelay4)*0.692245*idiff
  adel28    delay     ain, idelay5-(idelay5-idelay4)*0.492245*idiff
  adel29    delay     ain, idelay5+(idelay6-idelay5)*0.592245*idiff
  adel30    delay     ain, idelay5+(idelay6-idelay5)*0.792245*idiff

  adelayed  =  adelayed + 0.6*adel25 + 0.65*adel26 + 0.57*adel27 + 0.68*adel28 + 0.55*adel29 + 0.53*adel30
  ifact     =  ifact + 3.58


  adel31    delay     ain, idelay6
  adel32    delay     ain, idelay6-(idelay6-idelay5)*0.790076*idiff
  adel33    delay     ain, idelay6-(idelay6-idelay5)*0.592245*idiff
  adel34    delay     ain, idelay6+(idelay7-idelay6)*0.292245*idiff
  adel35    delay     ain, idelay6+(idelay7-idelay6)*0.892245*idiff

  adelayed  =  adelayed + 0.55*adel31 + 0.54*adel32 + 0.48*adel33+ 0.47*adel34 + 0.46*adel35
  ifact     =  ifact + 2.5

  adel36    delay     ain, idelay7
  adel37    delay     ain, idelay7-(idelay7-idelay6)*0.290076*idiff
  adel38    delay     ain, idelay7-(idelay7-idelay6)*0.592245*idiff
  adel39    delay     ain, idelay7+(idelay8-idelay7)*0.592245*idiff
  adel40    delay     ain, idelay7+(idelay8-idelay7)*0.592245*idiff

  adelayed  =  adelayed + 0.5*adel36 + 0.49*adel37 + 0.41*adel38+ 0.43*adel39 + 0.4*adel40
  ifact     =  ifact + 2.23

  adel41    delay     ain, idelay8
  adel42    delay     ain, idelay8-(idelay8-idelay7)*0.290076*idiff
  adel43    delay     ain, idelay8-(idelay8-idelay7)*0.592245*idiff
  adel44    delay     ain, idelay8+(idelay9-idelay8)*0.592245*idiff
  adel45    delay     ain, idelay8+(idelay9-idelay8)*0.592245*idiff
  adel46    delay     ain, idelay8+(idelay9-idelay8)*0.592245*idiff

  adelayed  =  adelayed + 0.4*adel41 + 0.39*adel42 + 0.35*adel43+ 0.38*adel44 + 0.3*adel45 + 0.36*adel46
  ifact     =  ifact + 2.18


  adel47    delay     ain, idelay9
  adel48    delay     ain, idelay9-(idelay9-idelay8)*0.290076*idiff
  adel49    delay     ain, idelay9-(idelay9-idelay8)*0.592245*idiff
  adel50    delay     ain, idelay9-(idelay9-idelay8)*0.592245*idiff
  adel51    delay     ain, idelay9*(1+0.292245*idiff)
  adel52    delay     ain, idelay9*(1+0.592245*idiff)
  adel53    delay     ain, idelay9*(1+0.892245*idiff)
  adel54    delay     ain, idelay9*(1+1.392245*idiff)

  adelayed  =  adelayed + 0.35*adel47 + 0.31*adel48 + 0.3*adel49+ 0.28*adel50 + 0.25*adel51 + 0.21*adel52 + 0.27*adel53+ 0.18*adel54
  ifact     =  ifact + 2.15



        ; scale to have unity gain (is this correct ?)
  areverbleft  =      adelayed/ifact
  aleftold  =  areverbleft


        ; The same procedure for the right channel
        ; Parametric equalizer used to simulate room cutoff
  alastr    pareq     arightold, icutoff, ampdb(iamount), sqrt(.5), 1

        ; input from left global reverb channel
  ain2      =  gahallr+irefl*alastr


  adel1     delay     ain2, idelay1
  adel2     delay     ain2, idelay1*(1-0.31242*idiff)
  adel3     delay     ain2, idelay1*(1-0.21273*idiff)
  adel4     delay     ain2, idelay1*(1-0.11117*idiff)
  adel5     delay     ain2, idelay1+(idelay2-idelay1)*0.11091*idiff
  adel6     delay     ain2, idelay1+(idelay2-idelay1)*0.18627*idiff

  adelayed  =  adel1 + 0.9*adel2 + 0.95*adel3 + 0.8*adel4+ 0.85*adel5 + 0.8*adel6
  ifact     =  5.3


  adel7     delay     ain2, idelay2
  adel8     delay     ain2, idelay2-(idelay2-idelay1)*0.95445*idiff
  adel9     delay     ain2, idelay2-(idelay2-idelay1)*0.57500*idiff
  adel10    delay     ain2, idelay2+(idelay3-idelay2)*0.21407*idiff
  adel11    delay     ain2, idelay2+(idelay3-idelay2)*0.30050*idiff
  adel12    delay     ain2, idelay2+(idelay3-idelay2)*0.54800*idiff

  adelayed  =  adelayed + 0.8*adel7 + 0.86*adel8 + 0.82*adel9 + 0.75*adel10 + 0.78*adel11 + 0.73*adel12
  ifact     =  ifact + 4.74


  adel13    delay     ain2, idelay3
  adel14    delay     ain2, idelay3-(idelay3-idelay2)*0.849063*idiff
  adel15    delay     ain2, idelay3-(idelay3-idelay2)*0.766399*idiff
  adel16    delay     ain2, idelay3+(idelay4-idelay3)*0.377363*idiff
  adel17    delay     ain2, idelay3+(idelay4-idelay3)*0.689000*idiff
  adel18    delay     ain2, idelay3+(idelay4-idelay3)*0.795003*idiff

  adelayed  =  adelayed + 0.8*adel13 + 0.66*adel14 + 0.65*adel15 + 0.78*adel16 + 0.67*adel17 + 0.6*adel18
  ifact     =  ifact + 4.16

  adel19    delay     ain2, idelay4
  adel20    delay     ain2, idelay4-(idelay4-idelay3)*0.891666*idiff
  adel21    delay     ain2, idelay4-(idelay4-idelay3)*0.501646*idiff
  adel22    delay     ain2, idelay4+(idelay5-idelay4)*0.251369*idiff
  adel23    delay     ain2, idelay4+(idelay5-idelay4)*0.491636*idiff
  adel24    delay     ain2, idelay4+(idelay5-idelay4)*0.937666*idiff

  adelayed  =  adelayed + 0.64*adel19 + 0.61*adel20 + 0.59*adel21 + 0.55*adel22 + 0.63*adel23 + 0.6*adel24
  ifact     =  ifact + 3.62


  adel25    delay     ain2, idelay5
  adel26    delay     ain2, idelay5-(idelay5-idelay4)*0.590076*idiff
  adel27    delay     ain2, idelay5-(idelay5-idelay4)*0.292245*idiff
  adel28    delay     ain2, idelay5-(idelay5-idelay4)*0.192245*idiff
  adel29    delay     ain2, idelay5+(idelay6-idelay5)*0.292245*idiff
  adel30    delay     ain2, idelay5+(idelay6-idelay5)*0.892245*idiff

  adelayed  =  adelayed + 0.6*adel25 + 0.65*adel26 + 0.57*adel27 + 0.58*adel28 + 0.65*adel29 + 0.53*adel30
  ifact     =  ifact + 3.58


  adel31    delay     ain2, idelay6
  adel32    delay     ain2, idelay6-(idelay6-idelay5)*0.870076*idiff
  adel33    delay     ain2, idelay6-(idelay6-idelay5)*0.652245*idiff
  adel34    delay     ain2, idelay6+(idelay7-idelay6)*0.132245*idiff
  adel35    delay     ain2, idelay6+(idelay7-idelay6)*0.692245*idiff

  adelayed  =  adelayed + 0.55*adel31 + 0.54*adel32 + 0.48*adel33+ 0.47*adel34 + 0.46*adel35
  ifact     =  ifact + 2.5

  adel36    delay     ain2, idelay7
  adel37    delay     ain2, idelay7-(idelay7-idelay6)*0.880076*idiff
  adel38    delay     ain2, idelay7-(idelay7-idelay6)*0.432245*idiff
  adel39    delay     ain2, idelay7+(idelay8-idelay7)*0.352245*idiff
  adel40    delay     ain2, idelay7+(idelay8-idelay7)*0.452245*idiff

  adelayed  =  adelayed + 0.5*adel36 + 0.49*adel37 + 0.41*adel38+ 0.43*adel39 + 0.4*adel40
  ifact     =  ifact + 2.23

  adel41    delay     ain2, idelay8
  adel42    delay     ain2, idelay8-(idelay8-idelay7)*0.690076*idiff
  adel43    delay     ain2, idelay8-(idelay8-idelay7)*0.392245*idiff
  adel44    delay     ain2, idelay8+(idelay9-idelay8)*0.292245*idiff
  adel45    delay     ain2, idelay8+(idelay9-idelay8)*0.492245*idiff
  adel46    delay     ain2, idelay8+(idelay9-idelay8)*0.992245*idiff

  adelayed  =  adelayed + 0.3*adel41 + 0.31*adel42 + 0.35*adel43+ 0.38*adel44 + 0.3*adel45 + 0.36*adel46
  ifact     =  ifact + 2


  adel47    delay     ain2, idelay9
  adel48    delay     ain2, idelay9-(idelay9-idelay8)*0.490076*idiff
  adel49    delay     ain2, idelay9-(idelay9-idelay8)*0.692245*idiff
  adel50    delay     ain2, idelay9-(idelay9-idelay8)*0.292245*idiff
  adel51    delay     ain2, idelay9*(1+0.192245*idiff)
  adel52    delay     ain2, idelay9*(1+0.392245*idiff)
  adel53    delay     ain2, idelay9*(1+0.802245*idiff)
  adel54    delay     ain2, idelay9*(1+1.192245*idiff)

  adelayed  =  adelayed + 0.35*adel47 + 0.31*adel48 + 0.3*adel49+ 0.28*adel50 + 0.25*adel51 + 0.31*adel52 + 0.27*adel53+ 0.18*adel54
  ifact     =  ifact + 2.25

  areverbright =      adelayed/ifact
  arightold =  areverbright


        ; Add to global Mixer bus
  galeft    =  galeft  + igain*areverbleft
  garight   =  garight + igain*areverbright


        ; reset global hall variable
  gahalll   =  0
  gahallr   =  0
endin



instr 99
;       Instrument:             Mixer / Equalizer / Compressor
;       Author:                 Thomas Huber
;       Email:                  huber@iamexwi.unibe.ch / thuber@gmx.ch
;       Last change:            15.5.99
;
;       Principle:
;       Equalize and compress the output from the global mixer bus and 
;       output to disk.
;
;       Sound:
;       Equalizer not used in this song. Compressor is very nice.
;       The attack and decay times of the compressor can be set via 
;       parameters.
;       It might be necessary to use the Equalizer if you burn the
;       song on a CD because of the deemphasis in CD players. The
;       deemphasis attenuates high frequencies, so we should amplify
;       the high frequencies here.


        ; get attack & decay times
  iattack   =  p4                                 ; compressor attack time [s]
  irelease  =  p5                                 ; compressor release time [s]
  iattack   =  (iattack  < 0.001 ? 0.001 : iattack )
  irelease  =  (irelease < 0.001 ? 0.001 : irelease)

        ; reset old audio level. Used to calculate if the
        ; amplitude is rising or falling
  koldlevel init      0


        ; Equalizer
        ; Boost high frequencies above 4 kHz
        ;aoutleft       pareq galeft, 4000, ampdb(+3), sqrt(.5), 2
        ;aoutright      pareq garight, 4000, ampdb(+3), sqrt(.5), 2

        ; Input to compressor unit
  aoutleft  =  galeft 
  aoutright =  garight 

        ; Take the average of the two channels
  amono     =  (aoutleft + aoutright)/2

        ; klevel: 0-32000
  klevel    rms       amono

        ; Different reaction times of the compressor in
        ; rising and in falling amplitude cases
if (klevel < koldlevel) goto down                 ;
        ; compressor attack time
  kstep     =  iattack
            goto      skip
down:
        ; compressor release time
  kstep     =  irelease
skip:
  koldlevel =  klevel
        ; look up gain factor for corresponding amplitude level
        ; The values in the tables are scale by 1/10
  kcomp     tablei    (klevel/10), 10
        ; integrate gain factor
  kcompression portk  kcomp, kstep

        ; Scale output by compression factor and output to speaker
            outs      aoutleft*kcompression, aoutright*kcompression

        ; reset mixer bus
  galeft    =  0
  garight   =  0
endin

