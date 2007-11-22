;
;-------------------------------------------------------------------------
; TB Wannabe
;-------------------------------------------------------------------------

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

;-------------------------------------------------------------------------

instr 15   ; Table Based Rezzy Synth with Enveloped Resonance
;-------------------------------------------------------------------------
; A whole bunch of initializations.
;-------------------------------------------------------------------------

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez      =  p7
  itabl1    =  p8
  kvalley   init      0
  kpeak     init      0
  knewval   init      1
  knewpk    init      1
  ksaveval  init      0
  ksavepk   init      0
  kynm1     init      0
  kynm2     init      0
  ktynm1    init      0
  ktynm2    init      0
  kfrangenm1   init   0
  kfrangenm2   init   0
  knewrez   init      0
  kfsweep   init      30
  kstep     init      0
  knxtstp   init      1

; LFO Frequency Sweep
;-------------------------------------------------------------------------
  kfsweep   expseg    30, .5*p3, p6, .5*p3, 30

; Sequencer Section
;-------------------------------------------------------------------------
loop1:
;     Read the duration for the current step of the sequence.
  kdur      table     kstep, 21
  kdur1     =  kdur/8                             ; Make the step smaller.

;     Frequency Envelope
  kfco      expseg    20, .1, i(kfsweep), i(kdur1)-.1, 20

;     Amplitude envelope
  kaenv     linseg    0, .01, 1, i(kdur1)-.02, 1, .01, 0

;     Panning
  kpanleft  table     kstep, 22
  kpanright table     kstep, 23

;     Pitch for the step of the sequence.
  kpch1     table     kstep, 20
  kfqc1     =  cpspch(kpch1)

;     Pitch for the next step need for sliding to the next step.
  kpch2     table     knxtstp, 20
  kfqc2     =  cpspch(kpch2)

;     If the slide is turned on then slide up to the next step otherwise 
;don't.
if (p9 = 0) goto skipslide
  kfqc      linseg    i(kfqc1), i(kdur1)-.04, i(kfqc1), .04, i(kfqc2)
            goto      nxtslide
skipslide:
  kfqc      =  kfqc1
nxtslide:

;     When the time runs out go to the next step of the sequence and 
;reinitialize the envelopes.
            timout    0, i(kdur1), cont1
  kstep     =  frac((kstep + 1)/8)*8
  knxtstp   =  frac((kstep + 1)/8)*8

            reinit    loop1
cont1:

; Start with my low pass resonant filter.

; This relationship attempts to separate Freq. from Res.
  ka1       =  100/irez/sqrt(kfco)-1
  kta1      =  100/sqrt(kfco)-1
  ka2       =  1000/kfco

; Oscillator
  kxn       oscil     iamp, kfqc, itabl1

; Replace the differential eq. with a difference eq.
  kyn       =  ((ka1+2*ka2)*kynm1-ka2*kynm2+kxn)/(1+ka1+ka2)
  ktyn      =  ((kta1+2*ka2)*ktynm1-ka2*ktynm2+kxn)/(1+kta1+ka2)

; Extract the resonance from the filtered signal.
  koldrez   =  knewrez
  knewrez   =  kyn-ktyn

; This section determines current peak and valley values and the range.
; As long as the signal rises it tracks peak.  When it falls it updates
; peak and tracks valley.

if (koldrez>=knewrez) goto next1
if (knewval != 1) goto next2
  knewval   =  0
  knewpk    =  1
  kvalley   =  ksaveval
next2:
  ksavepk   =  knewrez

next1:
if (koldrez<=knewrez) goto next 3
if (knewpk != 1) goto next4
  knewpk    =  0
  knewval   =  1
  kpeak     =  ksavepk
next4:
  ksaveval  =  knewrez

next3:
; The current range is calculated and low pass filtered.
  krangen   =  abs(kpeak-kvalley)
  kfrangen  =  ((kta1+2*ka2)*kfrangenm1-ka2*kfrangenm2+krangen)/(1+kta1+ka2)

; The filtered range is used to envelope the resonance then distortion is 
;added.
  kclip1    =  knewrez*kfrangen/irez/120000000
  kclip     tablei    kclip1, 7, 1, .5
  kout      =  ktyn + kclip*40000

; Update everything for the next pass.
  kynm2     =  kynm1
  kynm1     =  kyn
  ktynm2    =  ktynm1
  ktynm1    =  ktyn
  kfrangenm2   =      kfrangenm1
  kfrangenm1   =      kfrangen

; Convert to Audio Rates
  aout      =  kout

; Amp envelope, Pan and Output
            outs      kaenv*kpanleft*aout, kaenv*kpanright*aout

endin
