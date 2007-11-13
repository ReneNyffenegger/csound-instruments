;===========================================================================
; A Multi-Effects System
;===========================================================================
; This orchestra is designed as a multi effects unit and mixer.
; It can be used as a guitar simulator using the pluck algorithm or to
; process existing digital audio files.

;  1. Simple Sine Wave
;  2. Pluck
;  4. Noise
;  5. Monosampler
;  6. Soundin
;  7. LFO
;  8. Distortion 2
;  9. Enhancer
; 10. Noise Gate
; 11. Compressor/Limiter/Expander
; 12. De-esser
; 13. Tube Amp Distortion
; 14. Feedback Generator
; 15. Low Pass Resonant Filter
; 16. Wah-Wah
; 17. Talk-Box
; 18. 3 Band Equalizer
; 19. Resonator
; 20. Vibrato
; 21. Tremelo
; 22. Pitch Shifter
; 23. Panner
; 24. Ring Modulator
; 30. Flanger
; 35. Chorus
; 37. Phasor
; 40. Stereo Delay
; 45. Reverb
; 46. Lyon's Reverb 1
;100. Mixer
;110. Clear channels

sr=44100
kr=22050
ksmps=2
nchnls=2
zakinit 30, 30

; These are for Lyon's reverb
gifeed init .5
gilp1  init 1/10
gilp2  init 1/23
gilp3  init 1/41
giroll init 3000

;===========================================================================
; Sound Sources
;===========================================================================
; Simple Sin Wave Generator
;---------------------------------------------------------------------------
instr 1

  iamp  init p4
  ifqc  init p5
  izout init p6
  kamp linseg 0, .002, p4, p3-.004, p4, .002, 0 ;Declick

  asin1 oscil kamp, ifqc, 1                     ;Sine oscillator
        zawm   asin1, izout                     ;Mix to zak channel

endin

;---------------------------------------------------------------------------
; Pluck Physical Model
;---------------------------------------------------------------------------
       instr  2

iamp   =      p4          ; Amplitude
ifqc  =       cpspch(p5)  ; Convert to frequency
itab1  =      p6          ; Initial table
imeth  =      p7          ; Decay method
ioutch =      p8          ; Output channel

kamp   linseg 0, .002, iamp, p3-.004, iamp, .002, 0  ; Declick

aplk   pluck  kamp, ifqc, ifqc, itab1, imeth       ; Pluck waveguide model
       zawm   aplk, ioutch                           ; Write to output
gifqc  =      ifqc
       endin

;---------------------------------------------------------------------------
; Noise
;---------------------------------------------------------------------------
instr 4

  iamp  init p4
  izout init p5
  kamp  linseg 0, .002, p4, p3-.004, p4, .002, 0

  arnd1  rand  kamp                              ;Random generator
  afilt  tone  arnd1, 1000                       ;Low pass filter
         zawm  afilt, izout                      ;Mix to zak channel

endin

;---------------------------------------------------------------------------
; Sampler Mono
;---------------------------------------------------------------------------
         instr   5

  izout  init    p9
  asamp  loscil  p4, p5, p6, 440, 1, p7, p8
         zawm    asamp, izout

         endin

;---------------------------------------------------------------------------
; Sound In
;---------------------------------------------------------------------------



;===========================================================================
; Effects Section
;===========================================================================
; LFO
;---------------------------------------------------------------------------
          instr   7
iamp      init    p4
ifqc      init    p5
itab1     init    p6
ioffset   init    p7
iout      init    p8

koscil    oscil   iamp, ifqc, itab1  ;Table oscillator
kout      =       koscil+ioffset

          zkw     kout, iout           ;Send to output channel

          endin

;---------------------------------------------------------------------------
; Distortion 2
;---------------------------------------------------------------------------
         instr   8

igaini   =       p4          ; Pre gain
igainf   =       p5          ; Post gain
iduty    =       p6          ; Duty cycle offset
islope   =       p7          ; Slope offset
izin     =       p8          ; Input channel
izout    =       p9          ; Output channel
asign    init    0           ; Delayed signal

kamp     linseg  0, .002, 1, p3-.004, 1, .002, 0   ; Declick

asig     zar     izin                  ; Read input channel
aold     =       asign                 ; Save the last signal
asign    =       igaini*asig/20000     ; Normalize the signal
aclip    =       (8*asign-4)/(1+exp(30*asign-15))/(1+exp(1-asign))+.8
aclip    =       igainf*aclip*30000    ; Re-amplify the signal

atemp    delayr  .1                    ; Amplitude and slope based delay
aout     deltapi (2-iduty*asign)/1500 + islope*(asign-aold)/300
         delayw  aclip

         zaw     aout, izout           ; Write to output channel

         endin

;---------------------------------------------------------------------------
; Enhancer
;---------------------------------------------------------------------------
         instr   9

ilogain  =       p4       ; Low Gain
imidgain =       p5       ; Midrange Gain
ihigain  =       p6       ; High Gain
ilofco   =       p7       ; Low frequency cut-off
ihifco   =       p8       ; High frequency cut-off
iloshft  =       p9/1000  ; Low phase shift
imidshft =       p10/1000 ; Mid phase shift
ihishft  =       p11/1000 ; High phase shift
izin     =       p12      ; Input channel
izout    =       p13      ; Output channel

asig    zar      izin     ; Read from input channel

alosig  butterlp asig, ilofco+ilofco/4    ; Low pass filter overlap a bit
atmpsig butterhp asig, ilofco-ilofco/4    ; High pass at low frequency cut-off
amidsig butterlp atmpsig, ihifco+ihifco/4 ; then low pass at high frequency cut-off
ahisig  butterhp asig, ihifco-ihifco/4    ; Hi pass filter

alodel  delayr   iloshft                  ; Low frequency delay
        delayw   alosig
amiddel delayr   imidshft                 ; Midrange delay
        delayw   amidsig
ahidel  delayr   ihishft                  ; High frequency delay
        delayw   ahisig

aout    =        ilogain*alodel+imidgain*amiddel+ihigain*ahidel  ; Apply gain and reconstruct signal

        zaw      aout, izout     ; Write to output channel

        endin

;---------------------------------------------------------------------------
; Noise Gate
;---------------------------------------------------------------------------
          instr 10

ifqc      =     1/p4          ; RMS calculation frequency
ideltm    =     p5            ; Delay time to open gate just before signal start
itab      =     p6            ; Noise gate table
ipostgain =     p7            ; Post gain
iinch     =     p8            ; Input channel
ioutch    =     p9            ; Output channel

kenv  linseg    0, .02, 1, p3-.04, 1, .02, 0  ; Declick envelope

asig  zar       iinch                ; Read from input channel

adel1 delayr    ideltm               ; Delay the signal
      delayw    asig

kamp  rms       adel1, ifqc          ; Calculate RMS on the delayed signal
kampn =         kamp/30000           ; Normalize to 0-1
kcomp tablei    kampn,itab,1,0       ; Reference the noise gate table
acomp =         kcomp*asig*ipostgain ; Apply noise gate to original signal
      zaw       acomp*kenv, ioutch   ; Declick and write to the output channel 

      endin

;---------------------------------------------------------------------------
; Compressor/Limiter
;---------------------------------------------------------------------------
          instr  11

ifqc      =      1/p4     ; RMS calculation frequency
ideltm    =      p5       ; Delay time to apply compression to initial dynamics
itab      =      p6       ; Compressor/limiter table
ipostgain =      p7       ; Post gain
iinch     =      p8       ; Input Channel
ioutch    =      p9       ; Output Channel

kenv      linseg 0, .02, 1, p3-.04, 1, .02, 0  ; Amp envelope to declick.

asig  zar        iinch                 ; Read input channel
kamp  rms        asig, ifqc            ; Find rms level
kampn =          kamp/30000            ; Normalize rms level 0-1.
kcomp tablei     kampn,itab,1,0        ; Look up compression value in table

adel1 delayr     ideltm                ; Delay for the input delay time, 1/ifqc/2 is typical
      delayw     asig                  ; Write to delay line

acomp =          kcomp*adel1*ipostgain ; Compress the delayed signal and post gain,
      zaw        acomp*kenv, ioutch    ; declick and write to output channel

      endin

;---------------------------------------------------------------------------
; De-Esser
;---------------------------------------------------------------------------
          instr    12

ifqc      =        1/p4     ; RMS calculation frequency
ideltm    =        p5       ; Delay time is usually 1/fqc/2
itab      =        p6       ; De-Ess table
ifco      =        p7       ; Cut off frequency
ipostgain =        p8       ; Post gain
iinch     =        p9       ; Input channel
ioutch    =        p10      ; Output channel

kenv      linseg   0, .02, 1, p3-.04, 1, .02, 0  ; Declick envelope

asig      zar      iinch           ; Read input channel
afilt     butterhp asig, ifco      ; High pass filter the signal
kamp      rms      afilt, ifqc     ; Calculate rms on the high pass signal
kampn     =        kamp/30000      ; Normalize rms 0-1
kcomp     tablei   kampn,itab,1,0  ; Look up de-esser value in table

adel1     delayr   ideltm          ; Delay signal for delay time
          delayw   asig

acomp     =        kcomp*adel1*ipostgain ; Apply de-ess and post gain
          zaw      acomp*kenv, ioutch    ; Declick and write to output channel

          endin

;---------------------------------------------------------------------------
; Distortion
;---------------------------------------------------------------------------
         instr   13

igaini   =       p4          ; Pre gain
igainf   =       p5          ; Post gain
iduty    =       p6          ; Duty cycle offset
islope   =       p7          ; Slope offset
izin     =       p8          ; Input channel
izout    =       p9          ; Output channel
asign    init    0           ; Delayed signal

kamp     linseg  0, .002, 1, p3-.004, 1, .002, 0   ; Declick

asig     zar     izin                  ; Read input channel
aold     =       asign                 ; Save the last signal
asign    =       igaini*asig/60000     ; Normalize the signal
aclip    tablei  asign,5,1,.5          ; Read the waveshaping table
aclip    =       igainf*aclip*15000    ; Re-amplify the signal

atemp    delayr  .1                    ; Amplitude and slope based delay
aout     deltapi (2-iduty*asign)/1500 + islope*(asign-aold)/300
         delayw  aclip

         zaw     aout, izout           ; Write to output channel

         endin

;---------------------------------------------------------------------------
; Distortion Feedback Generator
;---------------------------------------------------------------------------
         instr   14

igaini   =       p4         ; Pre Gain
igainf   =       p5         ; Post Gain
iduty    =       p6         ; Duty cycle shift
itabd    =       p7         ; Distortion table
iresfqc  =       p8         ; Resonance frequency
ideltim  =       p9         ; Feedback delay time
ifeedbk  =       p10        ; Feedback gain
itabc    =       p11        ; Limiter table
izin     =       p12        ; Input channel
izout    =       p13        ; Output channel

asign    init    0          ; Initialize last value

kdclick  linseg   0, .1, 1, p3-.3, 1, .2, 0        ; Ramp feedback in and out
kamp     linseg   0, .002, 1, p3-.004, 1, .002, 0  ; Declick

asig     zar      izin                             ; Read input channel

afdbk    =        asig/100                         ; Reduce original signal
adel1    delayr   ideltim                          ; Feed back delay
afilt    butterbp adel1, iresfqc, iresfqc/4        ; Filter the delayed signal
kamprms  rms      afilt                 ; Find rms level
kampn    =        kamprms/30000         ; Normalize rms level 0-1.
kcomp    tablei   kampn,itabc,1,0        ; Look up compression value in table
         delayw   afdbk+kcomp*ifeedbk*afilt        ; Add limited feedback

aold     =        asign                            ; Save the old value
asign    =        (afilt*kdclick)/60000            ; Normalize
aclip    tablei   asign,itabd,1,.5                 ; Waveshape with distortion table
aclip    =        igainf*aclip*15000               ; Rescale

atemp    delayr  .1                            ; Amplitude based delays
aout     deltapi (2-iduty*asign)/1500 + iduty*(asign-aold)/300
         delayw  aclip

         zaw     aout, izout                   ; Write to the output channels

         endin

;---------------------------------------------------------------------------
; Low Pass Resonant Filter
;---------------------------------------------------------------------------
        instr   15

idur    =       p3
itab1   =       p4   ; Cut-Off Frequency
itab2   =       p5   ; Resonance
ilpmix  =       p6   ; Low-Pass signal multiplier
irzmix  =       p7   ; Resonance signal multiplier
izin    =       p8   ; Input channel
izout   =       p9   ; Output channel

kfco    oscil   1,1/idur,itab1      ; Cut-off Frequency envelope from table
kfcort  =       sqrt(kfco)          ; Needed for the filter
krezo   oscil   1,1/idur,itab2      ; Resonance envelope from table
krez    =       krezo*kfco/500      ; Add more resonance at high Fco
kamp    linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick


axn     zar     izin                ; Read input channel

ka1     =       1000/krez/kfco-1    ; Compute filter coeff. a1
ka2     =       100000/kfco/kfco    ; Compute filter coeff. a2
kb      =       1+ka1+ka2           ; Compute filter coeff. b
ay1     nlfilt  axn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1  ; Use the non-linear filter
ay      nlfilt  ay1/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1  ; as an ordinary filter.

ka1lp   =       1000/kfco-1         ; Resonance of 1 is a low pass filter
ka2lp   =       100000/kfco/kfco
kblp    =       1+ka1lp+ka2lp
ay1lp   nlfilt  axn/kblp, (ka1lp+2*ka2lp)/kblp, -ka2lp/kblp, 0, 0, 1   ; Low-pass filter
aylp    nlfilt  ay1lp/kblp, (ka1lp+2*ka2lp)/kblp, -ka2lp/kblp, 0, 0, 1

ayrez   =       ay - aylp    ; Extract the resonance part.
ayrz    =       ayrez/kfco   ; Use lower amplitudes at higher Fco

ay2     =       aylp*6*ilpmix + ayrz*300*irzmix  ; Scale the low pass and resonance separately

       zaw      ay2, izout   ; Write to the output channel

       endin

;---------------------------------------------------------------------------
; Wah-Wah
;---------------------------------------------------------------------------
         instr   16

irate    =       p4                ; Auto Wah Rate
idepth   =       p5                ; Low Pass Depth
ilow     =       p6                ; Minimum Frequency
ifmix    =       p7/1000           ; Formant Mix
itab1    =       p8                ; Wave form table
izin     =       p9                ; Input Channel
izout    =       p10               ; Output Channel

kosc1    oscil   .5, irate, itab1, .25        ; Oscilator
kosc2    =       kosc1 + .5                   ; Rescale for 0-1
kosc3    =       kosc2                        ; Formant Depth 0-1

klopass  =       idepth*kosc2+ilow            ; Low pass filter range
kform1   =       430*kosc2 + 300              ; Formant 1 range
kamp1    =       ampdb(-2*kosc3 + 59)*ifmix   ; Formant 1 level
kform2   =       220*kosc2 + 870              ; Formant 2 range
kamp2    =       ampdb(-14*kosc3 + 55)*ifmix  ; Formant 2 level
kform3   =       200*kosc2 + 2240             ; Formant 3 range
kamp3    =       ampdb(-15*kosc3 + 32)*ifmix  ; Formant 3 level

asig     zar       izin                       ; Read input channel

afilt    butterlp asig, klopass               ; Low pass filter

ares1    reson    afilt, kform1, kform1/8     ; Compute some formants
ares2    reson    afilt, kform2, kform1/8     ; to add character to the
ares3    reson    afilt, kform3, kform1/8     ; sound

aresbal1 balance  ares1, afilt                ; Adjust formant levels
aresbal2 balance  ares2, afilt
aresbal3 balance  ares3, afilt

         zaw      afilt+kamp1*aresbal1+kamp2*aresbal2+kamp3*aresbal3, izout

         endin

;---------------------------------------------------------------------------
; Talk-Box
;---------------------------------------------------------------------------
         instr   17

idur     =       p3          ; Duration
ixtab    =       p4          ; Index table
ifrmtab  =       p5          ; Formant table
iamptab  =       p6          ; Formant amplitude table
izin     =       p7          ; Input channel
izout    =       p8          ; Output channel

iptime   =       idur/128    ; Time to slide half way to next formant set

kdeclick linseg  1, p3-.002, 1, .002, 0  ; Declick
kformi   oscil   1, 1/idur, ixtab        ; Read the formant index table

kform1   table   3*kformi,   ifrmtab     ; Read the first formant frequency
kdb1     table   3*kformi, ifrmtab       ; Read the first formant dB's
kamp1    =       dbamp(60+kdb1)/200      ; Convert from decibels to amplitude
kform2   table   3*kformi+1, ifrmtab     ; Read the second formant frequency
kdb2     table   3*kformi+1, ifrmtab     ; Read the second formant dB's
kamp2    =       dbamp(60+kdb2)/200      ; Convert dB to amp
kform3   table   3*kformi+2, ifrmtab     ; Read the third formant frequency
kdb3     table   3*kformi+2, ifrmtab     ; Read the third formnat dB's
kamp3    =       dbamp(60+kdb3)/200      ; Convert dB to amp

kfrm1p   port    kform1, iptime, 300     ; Portamento to the next formant
kamp1p   port    kamp1,  iptime, .15     ; Portamento to the next amplitude
kfrm2p   port    kform2, iptime, 2000    ; Repeat for second
kamp2p   port    kamp2,  iptime, .15
kfrm3p   port    kform3, iptime, 4000    ; and again for the third
kamp3p   port    kamp3,  iptime, .15

asig     zar     izin                    ; Output channel

aform1   reson   asig, kfrm1p, kfrm1p/8  ; Compute the three resonances
aform2   reson   asig, kfrm2p, kfrm2p/8
aform3   reson   asig, kfrm3p, kfrm3p/8

abal1    balance aform1, asig            ; Adjust the levels
abal2    balance aform2, asig
abal3    balance aform3, asig

aout     =       abal1*kamp1p+abal2*kamp2p+abal3*kamp3p  ; Scale and sum

         zaw     aout*kdeclick, izout    ; Write to the output channel


         endin

;---------------------------------------------------------------------------
; 3 Band Equalizer
;---------------------------------------------------------------------------
         instr   18

ilogain  =       p4     ; Low Gain
imidgain =       p5     ; Midrange Gain
ihigain  =       p6     ; High Gain
ilofco   =       p7     ; Low frequency cut-off
ihifco   =       p8     ; High frequency cut-off
izin     =       p9     ; Input channel
izout    =       p10    ; Output channel

asig    zar      izin   ; Read from input channel

alosig  butterlp asig, ilofco             ; Low pass filter
atmpsig butterhp asig, ilofco-ilofco/4    ; High pass at low frequency cut-off
amidsig butterlp atmpsig, ihifco+ihifco/4 ; then low pass at high frequency cut-off
ahisig  butterhp asig, ihifco             ; Hi pass filter

aout    =        asig+ilogain*alosig+imidgain*amidsig+ihigain*ahisig  ; Apply gain and reconstruct signal

        zaw      aout, izout     ; Write to output channel

        endin

;---------------------------------------------------------------------------
; Resonator
;---------------------------------------------------------------------------
        instr   19

itabres =       p4     ; Resonance table
itabdb  =       p5     ; Amplitude table
izin     =      p6     ; Input channel
izout    =      p7     ; Output channel

ires1   table   1, itabres   ; Read the four resonance frequencies
ires2   table   2, itabres   ; from the table.
ires3   table   3, itabres
ires4   table   4, itabres

idb1    table   1, itabdb    ; Read the amplitudes from the table
idb2    table   2, itabdb
idb3    table   3, itabdb
idb4    table   4, itabdb

iamp1   =       dbamp(idb1)/300  ; Convert dB to amplitude
iamp2   =       dbamp(idb2)/300
iamp3   =       dbamp(idb3)/300
iamp4   =       dbamp(idb4)/300

asig    zar     izin   ; Read from input channel

ares1   reson   asig, ires1, ires1/8  ; Filter the resonances
ares2   reson   asig, ires2, ires2/8
ares3   reson   asig, ires3, ires3/8
ares4   reson   asig, ires4, ires4/8

abal1   balance ares1, asig           ; Balance the resonances
abal2   balance ares2, asig           ; Scale each and output
abal3   balance ares3, asig
abal4   balance ares4, asig

        zaw     iamp1*abal1+iamp2*abal2+iamp3*abal3+iamp4*abal4, izout

        endin

;---------------------------------------------------------------------------
; Vibrato
;---------------------------------------------------------------------------
        instr 20

iamp    =     p4/1000       ; Vibrato amplitude
ifqc    =     p5            ; Vibrato frequency
itab1   =     p6            ; Wave shape
iphase  =     p7            ; Phase shift
idelay  =     p8            ; Delay time before vibrato begins
irmptim =     p9            ; Ramp time for vibrato
izin    =     p10           ; Input channel
izout   =     p11           ; Output channel

asig   zar    izin          ; Read input channel

kramp linseg  0, idelay, 0, irmptim, 1, p3-idelay-irmptim, 1  ; Delay and ramp vibrato
kosc  oscil   kramp*iamp, ifqc, itab1   ; Low frequency oscillator
atmp  delayr  3*iamp                    ; Delay the signal
aout  deltapi kosc+1.5*iamp             ; Variable delay tap
      delayw  asig

      zaw     aout,izout                ; Write to the output channel

      endin

;---------------------------------------------------------------------------
; Tremelo
;---------------------------------------------------------------------------
          instr 21

  iamp    =     p4           ; Amplitude
  ifqc    =     p5           ; Frequency
  itab1   =     p6           ; Waveform
  iphase  =     p7           ; Phase offset
  izin    =     p8           ; Input channel
  izout   =     p9           ; Output channel

  asig    zar   izin         ; Read input channel

  kosc    oscil iamp, ifqc, itab1, iphase   ; LFO
  aout    =     asig*(kosc+1)/2             ; Adjust to 0-1 range and multiply

          zaw   aout, izout  ; Write to output channel

          endin
   
;---------------------------------------------------------------------------
; Pitch Shifter
;---------------------------------------------------------------------------
        instr 22

ipshift =     (p4<=1 ? p4-1 : p4/2)  ; If shift is <= 1 use shift-1,
itab1   =     p5                     ; otherwise use shift/2 since moving
izin    =     p6                     ; in the opposite direction as sound
izout   =     p7

asig   zar    izin                   ; Read input channel

kosc  oscil   1/gifqc, gifqc*ipshift, itab1  ; Pitch shifting oscillator uses
atmp  delayr  .1                             ; a saw wave with amplitude=wavelength
aout  deltapi kosc+1/gifqc                   ; of the fundamental and base frequency
      delayw  asig                           ; the same as the fundamental.
                                             ; Variable delay time.
      zaw     aout,izout             ; Write to output channel

      endin

;---------------------------------------------------------------------------
; Panner
;---------------------------------------------------------------------------
instr 23

  iamp    =    p4            ; Amplitude
  ifqc    =    p5            ; Frequency
  itab1   =    p6            ; Waveshape
  iphase  =    p7            ; Phase offset
  izin    =    p8            ; Input channel
  izoutl  =    p9            ; Output channel L
  izoutr  =    p10           ; Output channel R

  asig   zar  izin           ; Read input channel

  kosc  oscil iamp, ifqc, itab1, iphase  ; LFO
  kpanl =     (kosc+1)/2     ; Scale sine to 0-1
  kpanr =     1-kpanl        ; Calculate right pan value.

  aoutl  =     asig*kpanl    ; Determine panning
  aoutr  =     asig*kpanr

         zaw   aoutl, izoutl ; Write to left channel
         zaw   aoutr, izoutr ; Write to right channel
endin

;---------------------------------------------------------------------------
; Ring Modulator
;---------------------------------------------------------------------------
         instr  24

izin1    =      p4           ; Input channel 1
izin2    =      p5           ; Input channel 2
izout    =      p6           ; Output channel

asig1    zar    izin1        ; Read input channel 1
asig2    zar    izin2        ; Read input channel 2

armod    =      asig1*asig2  ; Compute ring modulation
aout     balance armod, (asig1+asig2)/2  ; Rescale to match average input levels

         zaw    aout, izout  ; Write to output

         endin

;---------------------------------------------------------------------------
; Flanger
;---------------------------------------------------------------------------
instr 30

irate    =       p4          ; Flanger rate
idepth   =       p5/1000     ; Flanger depth time converted to msec.
iwave    =       p6          ; Waveshape
ifdbk    =       p7          ; Amount of feedback
imixfl   =       p8          ; Mix of flanged signal
imix     =       1-imixfl    ; Mix of direct signal
ideloff  =       p9/1000     ; Delay offset
iphase   =       p10         ; Phase shift
izin     =       p11         ; Input channel
izout    =       p12         ; Output channel
adel1    init    0           ; Must be initialized to zero for feedback

kamp     linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick

asig     zar     izin        ; Read input channel

asig1    =       asig+ifdbk*adel1       ; Add feedback to signal
aosc1    oscil   idepth, irate, iwave, iphase  ; Flanger LFO
aosc2    =       aosc1+ideloff          ; Add LFO to offset

atemp    delayr  idepth+ideloff         ; Total delay time
adel1    deltapi aosc2                  ; Variable delay tap
         delayw  asig1                  ; Write to delay line

aout     =       imixfl*adel1+imix*asig ; Mix direct and flanged signals
         zaw     aout, izout            ; Write to output channel

         endin

;---------------------------------------------------------------------------
; Chorus
;---------------------------------------------------------------------------
         instr   35

irate    =       p4             ; Chorus rate
idepth   =       p5/1000        ; Chorus depth converted to msec.
iwave    =       p6             ; Waveshape
imixch   =       p7             ; Mix of chorused signal
imix     =       1-imixch       ; Mix of direct signal
ideloff  =       p8/1000        ; Delay offset converted to msec.
iphase   =       p9             ; Phase offset
izin     =       p10            ; Input channel
izout    =       p11            ; Output channel

kamp     linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick

asig     zar     izin           ; Read input channel

aosc1    oscil   idepth, irate, iwave, iphase  ; LFO for chorus
aosc2    =       aosc1+ideloff                 ; Add delay offset

atemp    delayr  idepth+ideloff
adel1    deltapi aosc2                         ; Variable delay tap
         delayw  asig

aout     =       (adel1*imixch+asig*imix)*kamp ; Mix direct and chorused signals

         zaw     aout, izout                   ; Write to output channel

         endin

;---------------------------------------------------------------------------
; Phasor
;---------------------------------------------------------------------------
         instr   37

irate    =       p4              ; Phasor rate
idepth   =       p5/1000         ; Phasor depth
iwave    =       p6              ; Waveshape
ifdbk    =       p7              ; Feedback amount
imixph   =       p8              ; Mix of phased signal
imix     =       1-imixph        ; Mix of direct signal
ideloff  =       p9/1000         ; Phasor delay offset
iphase   =       p10             ; Waveform phase offset
izin     =       p11             ; Input channel
izout    =       p12             ; Output channel
aphs     init    0               ; Initialize for feedback

kamp     linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick

asig     zar     izin                          ; Read the input channel

asig1    =       asig+ifdbk*aphs               ; Compute feedback
kosc1    oscil   idepth, irate, iwave, iphase  ; LFO for phasor
kosc2    =       kosc1+ideloff                 ; Delay offset

atemp    delayr  idepth+ideloff                ; Delay signal
adel1    deltapi kosc2                         ; Variable delay tap
         delayw  asig1                         ; Write to delay line

aphs     =       adel1-ifdbk*asig              ; Subtract feedback

aout     =       aphs*imixph/2+asig*imix
         zaw     aout, izout                   ; Scale and write to output channel

         endin

;---------------------------------------------------------------------------
; Delay
;---------------------------------------------------------------------------
instr 40

  itim1   =    p4                ; Delay time 1
  ifdbk1  =    p5                ; Feedback amount 1
  ixfdbk1 =    p6                ; Cross feedback amount 1
  itim2   =    p7                ; Delay time 2
  ifdbk2  =    p8                ; Feedback amount 2
  ixfdbk2 =    p9                ; Cross feedback amount 2
  izinl   =    p10               ; Left input channel
  izinr   =    p11               ; Right input channel
  izoutl  =    p12               ; Left output channel
  izoutr  =    p13               ; Right output channel

  aoutl   init 0                 ; Initialize feedback to zero
  aoutr   init 0

  asigl  zar  izinl              ; Read input channels
  asigr  zar  izinr

  aoutl  delayr itim1
         delayw asigl+ifdbk1*aoutl+ixfdbk1*aoutr  ; Sum delayed signal with
                                                  ; with original and add 
  aoutr  delayr itim2                             ; cross-feedback signal.
         delayw asigr+ifdbk2*aoutr+ixfdbk2*aoutl

         zaw   aoutl, izoutl     ; Write to output channels
         zaw   aoutr, izoutr
endin

;---------------------------------------------------------------------------
; Simple Reverb
;---------------------------------------------------------------------------
        instr   45

irvtime =       p4                     ; Reverb time
irvfqc  =       p5                     ; Reverb frequency
izin    =       p6                     ; Input channel
izout   =       p7                     ; Output channel

asig    zar     izin                   ; Read input channel
aout    reverb2 asig, irvtime, irvfqc  ; Reverberate
        zaw     aout/5, izout          ; Write to output channel

        endin


;---------------------------------------------------------------------------
; Advanced Reverb by Eric Lyon
;i1 0 dur file skip gain %orig inputdur atk
;---------------------------------------------------------------------------
         instr  46
inputdur =      p6
iatk     =      p7
idk      =      .01
idecay   =      .01

;data for output envelope
ioutsust =      p3-idecay
idur     =      inputdur-(iatk+idk)
isust    =      p3-(iatk+idur+idk)
iorig    =      p5
irev     =      1.0-p5
izin1    init   p8
izin2    init   p9
izoutl   init   p10
izoutr   init   p11

igain    =      p6
kclean   linseg  0,iatk,igain,idur,igain,idk,0,isust,0
kout     linseg  1,ioutsust,1,idecay,0
ain1     zar     izin1
ain2     zar     izin2
ain1     =       ain1*kclean
ain2     =       ain2*kclean
ajunk    alpass  ain1,1.7,.1
aleft    alpass  ajunk,1.01,.07
ajunk    alpass  ain2,1.5,.2
aright   alpass  ajunk,1.33,.05
kdel1    randi   .01,1,.666
kdel1    =       kdel1 + .1
addl1    delayr  .3
afeed1   deltapi kdel1
afeed1   =       afeed1 + gifeed*aleft
         delayw  aleft

kdel2    randi   .01,.95,.777
kdel2    =       kdel2 + .1
addl2    delayr  .3
afeed2   deltapi kdel2
afeed2   =       afeed2 + gifeed*aright
         delayw  aright

;GLOBAL REVERB

        aglobin = (afeed1+afeed2)*.05
        atap1 comb aglobin,3.3,gilp1
        atap2 comb aglobin,3.3,gilp2
        atap3 comb aglobin,3.3,gilp3
        aglobrev alpass atap1+atap2+atap3,2.6,.085
        aglobrev tone aglobrev,giroll

        kdel3 randi .003,1,.888
        kdel3 =kdel3 + .05
        addl3 delayr .2
        agr1 deltapi kdel3
                delayw aglobrev

        kdel4 randi .003,1,.999
        kdel4 =kdel4 + .05
        addl4 delayr .2
        agr2 deltapi kdel4
                delayw aglobrev

        arevl = agr1+afeed1
        arevr = agr2+afeed2
        aoutl = (ain1*iorig)+(arevl*irev)
        aoutr = (ain2*iorig)+(arevr*irev)

              zaw     aoutl*kout, izoutl
              zaw     aoutr*kout, izoutr
              
endin

;---------------------------------------------------------------------------
; Mixer Section
;---------------------------------------------------------------------------
          instr 100

asig1     zar   p4             ; Read input channel 1
igl1      init  p5*p6          ; Left gain
igr1      init  p5*(1-p6)      ; Right gain

asig2     zar   p7             ; Read input channel 2
igl2      init  p8*p9          ; Left gain
igr2      init  p8*(1-p9)      ; Right gain

kdclick   linseg  0, .001, 1, p3-.002, 1, .001, 0  ; Declick

asigl     =     asig1*igl1 + asig2*igl2  ; Scale and sum
asigr     =     asig1*igr1 + asig2*igr2

          outs  kdclick*asigl, kdclick*asigr   ; Output stereo pair

          endin

;---------------------------------------------------------------------------
; Clear audio & control channels
;---------------------------------------------------------------------------
          instr 110

          zacl  0, 30          ; Clear audio channels 0 to 30
          zkcl  0, 30          ; Clear control channels 0 to 30

          endin
