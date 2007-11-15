  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  2

  ga1       init      0
  ga2       init      0


instr 1         ; sndwarp-based instrument
                ; used to play the "spaces" between the syllables
                ; in the original "apocalypse.aiff" sample.

  iwindfun  =  1
  isampfun  =  2
  ibeg      =  0
  iwindsize =  2000
  iwindrand =  1500
  ioverlap  =  83
  idur      =  p3
  ibegtime  =  p4
  iendtime  =  p5
  iamp      =  p6
  ibegpitch =  p7
  iendpitch =  p8
  ichan1    =  sqrt(p9)
  ichan2    =  sqrt(1-p9)
  ienv      =  p10

  ktimpnt   linseg    ibegtime, idur, iendtime
  aresamp   linseg    ibegpitch, idur, iendpitch

  asig      sndwarp   .1, ktimpnt, aresamp, isampfun, ibeg, iwindsize, iwindrand, ioverlap, iwindfun, 1

  kenv      linseg    0, idur * ienv, iamp, idur - (idur * 2 * ienv), iamp, idur * ienv, 0

  aout      =  asig * kenv
  achan1    =  ichan1 * aout
  achan2    =  ichan2 * aout

            outs      achan1, achan2

endin


instr 2         ; implements PSOLA (Pitch Synchronous Overlap and Add)
                ; timestretching of the apocalypse sound sample.
                ; This process involves chopping up the input sample into
                ; grains that are exactly 1 or 2 times the size of the
                ; period of the waveform at that particular point, and
                ; playing those grains back at a certain rate, repeating
                ; grains as necessary. The rate of grains per second 
                ; determines the pitch of the sound. The playback rate
                ; of the individual grains (i.e. the pitch of each grain)
                ; determines whether formants are preserved, or shifted
                ; up or down. As the grains can be picked from various parts
                ; of the input sample and repeated, this allows for time-
                ; stretching with independent control over pitch, duration,
                ; and timbre.

  idur      =  p3
  ifreq     =  p4
  iamp      =  p5

; iwherebeg and iwhereend control the portions of the original
; sample from which fog derives its grains.
  iwherebeg =  0
  iwhereend =  .55
  aspeed    linseg    iwherebeg, idur, iwhereend

; controls the amount of octavization of the signal. As koct 
; changes from 0 to 0.5, the volume of every other grain
; that is repeated drops. This produces a suboctave component
; in the sound, similar to a secondary voice an octave lower
; being slowly faded in.
  koct      linseg    0, idur, 0.5

; Used to control relationship between distance and pitch, 
; in conjunction with locsig/locsend generators. Creates
; Doppler effect.
  kdistance linseg    1, idur * .4, 3, idur * .3, 1, idur * .3, 2
  kfreq     =  (ifreq * 340) / (340 + 3 * kdistance)

; The main instrument is made up of 4 fog generators. The
; window size of each fog generator is set to be 2 times the 
; period of the source sample, or pretty close (the pitch of the
; sample changes, but the window size seems to be a good fit for
; the entire sample). Each fog generator is slighly detuned, with
; random detuning (which controls the playback rate of the grains)
; and some randomness of the window size (which helps reduce the
; "comb filter" sound that can result from this technique). Each
; fog generator also has an independent LFO, using oscili, to
; impart a vocal-style vibrato on the sound. The result is a 
; thick sound, reminiscent of a choir.
  krnd      randi     2, 15
  krndw     randi     .008, 20
  kosc      oscili    3, 5, 4
  asig1     fog       .25, ifreq + krnd + kosc, 1, aspeed, koct, 10, .005, .028 + krndw, .005, 300, 2, 3, p3

  krnd2     randi     1.7, 13
  kosc2     oscili    3.2, 5.7, 4
  krndw2    randi     .01, 15 
  asig2     fog       .25, ifreq + krnd2 + kosc2 +2, 1, aspeed + .011, koct, 10, .005, .028 + krndw2, .005, 300, 2, 3, p3

  krnd3     randi     1.6, 17
  kosc3     oscili    3.4, 4.3, 4
  krndw3    randi     .007, 13        
  asig3     fog       .25, ifreq + krnd3 + kosc3 - 1.7, 1, aspeed + .019, koct, 10, .005, .028 + krndw3, .005, 300, 2, 3, p3

  krnd4     randi     1.8, 11
  kosc4     oscili    3.1, 4.83, 4
  krndw4    randi     .009, 14        
  asig4     fog       .25, ifreq + krnd4 + kosc4 + 0.8, 1, aspeed + .0273, koct, 10, .005, .028 + krndw4, .005, 300, 2, 3, p3

  kenv      linseg    0, 2, iamp, idur - 5, iamp, 3, 0

; The outputs of all 4 fog generators are summed, and multiplied
; by an amplitude envelope.
  asum      =  (asig1 + asig2 + asig3 + asig4) * kenv

; krndist implements a degree of randomness to the
; spatial distribution implemented by locsig/locsend.
  krndist   randi     40, ifreq * .0019 

; Used to control a motion trajectory for the signal, as
; implemented by locsig/locsend
  kdegree   linseg    0, idur * .6, 90, idur * .4, 22

; locsig and locsend are used to add a sense of spatial motion
; to the signal. 
  a2, a1    locsig    asum, kdegree + krndist, kdistance, .1
  ar2, ar1  locsend   

; global variables for the reverb sends.
  ga1       =  ga1 + ar1
  ga2       =  ga2 + ar2

            outs      a1, a2

endin


instr 3         ; Similar to above instrument, but uses
                ; fog-derived waveforms as raw material for
                ; a subtractive-synthesis instrument. See
                ; instr 2 for further details on how fog
                ; is used.

  idur      =  p3
  ifreq     =  p4
  iamp      =  p5
  ivibbeg   =  p6
  ivibend   =  p7
  iwherebeg =  .16
  iwhereend =  .223
  ibegdist  =  p8
  imiddist1 =  p9
  imiddist2 =  p10
  ienddist  =  p11

; determines where in sample grains are derived from.
  aspeed    linseg    iwherebeg, idur, iwhereend

; octavization, as in instr 2.
  koct      linseg    0, idur, 0.5

; determines frequency and depth of gated vibrato.
  kfreq     linseg    ivibbeg, idur, ivibend
  kdepth    linseg    25, idur, 100

; kosc1 and kosc2 produce a gated vibrato effect. kosc1
; generates a rapid vibrato, which is modulated in amplitude
; by kosc2. Jean-Claude Risset used this in a composition. 
; The band Jessamine used to use this technique live, by
; rapidly "stabbing" the modulation wheel on a Micromoog
; on and off.
  kosc1     oscili    kdepth, kfreq, 5
  kosc2     oscili    kosc1, 15, 4

  kdistance linseg    ibegdist, idur * .4, imiddist1, idur * .3, imiddist2, idur * .3, ienddist
  kfreq     =  (ifreq * 340) / (340 +  kdistance)

; 3 fog generators are used to produce the raw waveform for the 
; subtractive instrument. Unlike instr 2, no attempt is being
; made to preserve the characteristics of the source signal. 
; Instead, it is being treated as a wavetable, used as a source
; for a buzzy waveform that can be filtered as needed.
; The 3 fog ugens are detuned, to produce an animated waveform
; (similar to the 3 oscillators on a Minimoog).
  asig1     fog       .25, kfreq + kosc2, 1, aspeed, koct, 10, .005, .028, .005, 300, 2, 3, p3

  asig2     fog       .25, kfreq + 1.7 + kosc2, 1, aspeed, koct, 10, .005, .028, .005, 300, 2, 3, p3

  asig3     fog       .25, kfreq - 1.3 + kosc2, 1, aspeed, koct, 10, .005, .028, .005, 300, 2, 3, p3
 
  kenv      linseg    0, idur * .1, iamp, idur - (idur * .4), iamp, idur * .3, 0

  asum      =  (asig1 + asig2 + asig3) * kenv * .8

; Envelopes for center frequncy and bandwidth of reson filters.
  kfc1      linseg    ifreq, idur * .5, 3500 * iamp, idur * .5, ifreq
  kfq1      expseg    100, idur * .3, 1000, idur * .7, 5000
  kfq2      expseg    50, idur * .6, 10000, idur * .4, 2000

; afilt1 is used to obtain the "filter sweep" common
; to subtractive synthesizers, while afilt2 contributes
; more "body" to the fundamental of the sound.
  afilt1    reson     asum, kfc1, kfq1, 1
  afilt2    reson     asum, ifreq, kfq2, 1

; The outputs of the two filters are summed.
  asum2     =  afilt1 + afilt2

; Randomness added to spatial distribution of sound.
  krndist   randi     25, ifreq * .0007

; Envelope for spatial distribution. Direction and
; depth of sweep determined by score parameters.
  kline     linseg    p12, idur * .6, p13, idur * .4, p14
  kdegree   =  krndist + kline

; Spatial distribution, as in instr 2.
  a1, a2    locsig    asum2, kdegree, kdistance, .1
  ar1, ar2  locsend   

  ga1       =  ga1 + ar1
  ga2       =  ga2 + ar2

            outs      a1, a2

endin



instr 99 ; reverb instrument

  a1        reverb2   ga1, 3.2, .5
  a2        reverb2   ga2, 3.33, .5
        
            outs      a1, a2

  ga1       =  0
  ga2       =  0

endin


