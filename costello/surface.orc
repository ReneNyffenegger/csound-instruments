; surface.orc
;
; Sean Costello
; Music 402
; March 11, 1999
; 
; A meditation upon the surface of a sound.
; The sound is frozen in time, and the singularities that make up the sound
; are explored.
; Gabor would be proud.
; Unfortunately, the sound unexpectedly falls (or is pulled?) beneath
; the surface, to a watery grave.
; Was it an accident?
; Or was it the treacherous grip of Architeuthis that interrupted 
; our study of the quantum nature of sound?
;
; OK, I am on sort of a giant squid kick lately.
;
; I ended up changing it so that the sound emerges from the water.  
; "Surfaces" from the water, if I may be so bold.
; Does anyone actually read this?

  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  2

  ga1       init      0                           ; sends output of time stretching instrument to reverb
  ga2       init      0                           ; ditto

instr 1

  iwindfun  =  1                                  ; half-cosine
  isampfun  =  2                                  ; apocalypse.aiff
  ibeg      =  0                                  ; just copied from manual
  iwindsize =  2000                               ; works well with sound in question
  iwindrand =  1500                               ; gives swirly effect, less comb filtering
  ioverlap  =  83                                 ; I like lots of overlaps, for a nice reverberant sound.
  idur      =  p3                                 ; overall duration of note
  ibegtime  =  p4                                 ; where in soundfile sndwarp starts reading
  iendtime  =  p5                                 ; where in soundfile sndwarp stops reading
  iattack   =  p6                                 ; attack of amplitude envelope, as percentage of total dur
  iamp      =  p7                                 ; overall amplitude of note, with 1 being the baseline
  irelease  =  p8                                 ; decay of amp env, as % of total dur.  The % of sustain of the note
                        ; is determined by 1 - (iattack + idecay).  ASR envelope, simple but useful.
  ibegpitch =  p9                                 ; beginning pitch of note, with 1 being pitch of original sample
  iendpitch =  p10                                ; ending pitch of note, with 1 being pitch of orignal sample
  iwetbeg   =  sqrt(p11)                          ; initial ratio of dry (straight sndwarp output) to wet (sndwarp output 
                        ; through my "moisturizer")
  idrybeg   =  sqrt(1-p11)   
  iwetattack   =      p12                         ; determines attack of wet/dry envelope, as per amplitude envelope above
  iwetsus1  =  sqrt(p13)                          ; amount of wetness during initial part of sustain of ASR envelope.
  idrysus1  =  sqrt(1-p13)  
  iwetsus2  =  sqrt(p14)                          ; allows for different wet/dry ratio at end of "sustain" phase. Not really
  idrysus2  =  sqrt(1-p14)                        ; an ASR envelope at all, so much as an envelope that traverses
                        ; between four specified points, with the rate of travel between
                        ; each point controlled.
  iwetrelease  =      p15                         ; determines release of wet/dry envelope.  As in the amplitude envelope,
                        ; the length of the sustain segment is determined by 
                        ; 1 - (iwetattack + iwetdecay)
  iwetend   =  sqrt(p16)                          ; amount of wetness at end of sound.
  idryend   =  sqrt(1-p16)   
  ichan1    =  sqrt(p17)                          ; determines the placement in the stereo field of the dry sound.
  ichan2    =  sqrt(1-p17)
  ispeed    =  p18                                ; determines speed of water noise
  ireverb   =  p19                                ; controls amount of reverb per note

; determines where in the sound to begin and end reading, and how long it takes
; to traverse the two points
  ktimpnt   linseg    ibegtime, idur, iendtime

; determines beginning and ending pitches for sound.
  aresamp   linseg    ibegpitch, idur, iendpitch

; sndwarp section that generates actual notes.  Beautiful voices from a creaky old junkie geezer.
  asig      sndwarp   .1, ktimpnt, aresamp, isampfun, ibeg, iwindsize, iwindrand, ioverlap, iwindfun, 1

; overall amplitude envelope for sound
  kenv      linseg    0, idur * iattack, iamp, idur - (idur * (iattack + irelease)), iamp, idur * irelease, 0

; sndwarp output multiplied by amplitude envelope
  asigb     =  asig * kenv

; amplitude based filtering - opens and closes bandwidth of reson filter
  avoc1     reson     asigb, 0, kenv * 15000 + 500, 1

; OK, the sound is a little too dull, so I am including a second reson filter
; to try and brighten things up.  
  avoc2     reson     asigb, 5200, kenv * 500 + 100, 1
  avoc3     reson     asigb, 7500, kenv * 500 + 200, 1

  avoc      =  (avoc1 + avoc2 + avoc3) * .333

; for dry sound, avoc is multiplied by dry ratio envelope.
  kdry      linseg    idrybeg, idur *iwetattack, idrysus1, idur - (idur * (iwetattack + iwetrelease)), idrysus2, idur * iwetrelease, idryend
  adryout   =  avoc * kdry

  achan1    =  ichan1 * adryout
  achan2    =  ichan2 * adryout


; creates pitch vibrato for "moisturizer"
  kvib      linseg    1.5, idur, 3                ; controls amount of pitch vibrato during underwater section
  ktime1    oscili    .0012 * kvib, 4, 1          ; used to create pitch vibrato
  ktime2    oscili    .0009 * kvib, 5, 1          ; different vibrato rate
  ktime3    oscili    .00087 * kvib, 6.3, 1       ; different vibrato rate
  ktime4    oscili    .0011 * kvib, 4.4, 1        ; ditto

; Four interpolating delay taps, each modulated by different oscillator
  adummy    delayr    .030
  asig1     deltapi   ktime1 + .015
  asig2     deltapi   ktime2 + .015
  asig3     deltapi   ktime3 + .015
  asig4     deltapi   ktime4 + .015
            delayw    avoc

; The outputs of the four delay taps are summed together.  The original signal is not
; added in with the modulated delay outputs.  I prefer this sound - more through-zero
; flanging, less obvious metallic resonances.  Copped the idea from the old ARP String
; Ensemble chorus units (think "Dream Weaver" by Gary Wright)
  avib      =  (asig1 + asig2 + asig3 + asig4)

  kfenv1    linseg    300, idur * .5, 500, idur * .5, 100
;kfenv1 = 500
;kq1    linseg  100, idur * .5, 10, idur * .5, 30
  kq1       =  15 + (200 * kdry)
  krandamp1 linseg    300, idur, 200
  kspeed    linseg    1, p3 * .4, 3, p3 * .6, 7
  krand1    randi     krandamp1, kspeed * 7.31 * ispeed
  krand2    randi     krandamp1, kspeed * 3.2 * ispeed
  krand3    randi     krandamp1, kspeed * 4.7 * ispeed
  krand4    randi     krandamp1, kspeed * 9 * ispeed


; Sum of filter envelope output and outputs of low frequency noise generators.
  kfiltfreq1   =      kfenv1 + krand1
  kfiltfreq2   =      kfenv1 + krand2
  kfiltfreq3   =      kfenv1 + krand3
  kfiltfreq4   =      kfenv1 + krand4

; Four reson filters, with cutoff freq modulated by envelope generators and
; lowpass noise.  Sounds nice and watery, if done properly.
  afilt1    reson     avib, kfiltfreq1, kq1, 1
  afilt2    reson     avib, kfiltfreq2, kq1, 1
  afilt3    reson     avib, kfiltfreq3, kq1, 1
  afilt4    reson     avib, kfiltfreq4, kq1, 1

; Outputs of filters are summed together.  Each filter is panned across stereo 
; field by a different amount, which vastly improves the sound.
  aout1     =  (.9 * afilt1) + (.67 * afilt2) + (.33 * afilt3) + (.1 * afilt4)
  aout2     =  (.1 * afilt1) + (.33 * afilt2) + (.67 * afilt3) + (.9 * afilt4)

; Filter sums are multiplied by wet ratio envelope.
  kwet      linseg    iwetbeg, idur * iwetattack, iwetsus1, idur - (idur * (iwetattack + iwetrelease)), iwetsus2, idur * iwetrelease, iwetend
  awet1     =  aout1 * kwet
  awet2     =  aout2 * kwet

; Amount of sound sent to global reverb.  Have made this constant.  Too many damn 
; parameters to worry about at this point.
; OK, made it per note.  Add another 1/2 hour onto my morning
  ga1       =  ga1 + .1 * (achan1 + awet1) * ireverb
  ga2       =  ga2 + .11 *(achan2 + awet2) * ireverb

; Outputs consist of wet and dry outputs summed together.
            outs      awet1 + achan1, awet2 + achan2


endin




instr 99 ; reverb instrument.  Pretty standard.

  idur      =  p3

  a1        reverb2   ga1, 3.2, .5
  a2        reverb2   ga2, 3.33, .5
        
            outs      a1, a2

  ga1       =  0
  ga2       =  0

endin


