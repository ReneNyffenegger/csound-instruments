  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  2

  gamod     init      0                           ; global FM variable

instr 11

  ilength   =  p3
  iamp      =  p4

  a1, a2    soundin   "grantest3.aiff"
 
  kenv      linen     p4, .01, p3, .01

            outs      a1, a2

endin

instr 15 ; a sine wave windowed by a Hanning window.  Can't get much simpler.
         ; I use it for the granular textures.  Inefficient, yes, but
         ; I like working with CM to generate the granular textures, just to
         ; get a feel of how granular synthesis really works.

  idur      =  p3
  ifreq     =  p4
  iamp      =  p5
  ichan1    =  sqrt(p6)
  ichan2    =  sqrt(1-p6)

  kenv      oscil1    0, iamp, idur, 2
  aosc      oscili    kenv, ifreq, 1

  asig1     =  aosc * ichan1
  asig2     =  aosc * ichan2

            outs      asig1, asig2

endin


instr 7 ; The Simple FM instrument from class.  It does good "mouse drums."

  icarfreq  =  p6
  iratio    =  p7
  imodfreq  =  icarfreq * iratio
  index     =  p8
  idev      =  imodfreq*index
  iamp      =  p4 * 5000
  iampfunc  =  p5
;iglobalmodamount = p9
  ichan1    =  sqrt(p9)
  ichan2    =  sqrt(1-p9)

  kenv      oscil1i   0, 1, p3, iampfunc

  amod      oscili    idev * kenv,  imodfreq,  1
  aosc      oscili    kenv,  icarfreq + amod,  1

  asig1     =  aosc * ichan1 * iamp
  asig2     =  aosc * ichan2 * iamp

            outs      asig1, asig2

;gamod = acar * iglobalmodamount

endin

instr 8 ; my first FM instrument - not very scientific, but
        ; it has a nice sound.  Modified to have more control.
        ; Used for some background drones.  Sounds kinda analog,
        ; in a good way (although it can come precariously close
        ; to sounding like Peter Gabriel [gagging sound]).

        ; Sunday, December 5 - experimenting with having
        ; a global variable modulating the signal.  This should
        ; create a similar effect to what Risset used in one 
        ; of his compositions, although I have to admit
        ; that my idea is more strongly influenced by Aphex
        ; Twin's "Ventolin," as well as a Moog technique
        ; I picked up from watching Jessamine perform several times.
        ; Not used in composition as of December 6.

  aosc1     init      0
  aosc2     init      0
  aosc3     init      0

  idur1     =  p3
  ifreq1    =  p4
  iamp      =  p5 * 3000
  iattack1  =  p6
  index     =  p7
  idev      =  index * ifreq1
  kamp1     linseg    .0001, iattack1, 1, (idur1 - iattack1), .0001

  amod      =  gamod * kamp1 * ifreq1

  aosc1     oscili    idev * kamp1, ifreq1, 1
  aosc2     oscili    kamp1 * iamp, (ifreq1 * .998) + aosc1 + amod, 1
  aosc3     oscili    kamp1 * iamp, (ifreq1 * 1.5007) + aosc1 + amod, 1
  aosc4     oscili    kamp1 * iamp, .1 + aosc1 + amod, 1
  aout1     =  (aosc2 + aosc3 + aosc4) * .5

  aosc5     oscili    idev * kamp1, ifreq1 * .99, 1
  aosc6     oscili    kamp1 * iamp, (ifreq1 * .987) + aosc5 + amod, 1
  aosc7     oscili    kamp1 * iamp, (ifreq1 * 1.498) + aosc5 + amod, 1
  aosc8     oscili    kamp1 * iamp, .13 + aosc5 + amod, 1
  aout2     =  (aosc6 + aosc7 + aosc8) * .5

            outs      aout1, aout2

  gamod     =  0

endin

; noisebell.orc by Sean Costello
;
; This is a modification of the Risset Additive Bell 
; instrument, where each partial of the bell is 
; ring modulated by noise.  The bandwidth of the 
; noise is controlled by a linseg generator, with
; the starting and ending bandwidth frequencies 
; specified in the score.


; Risset Additive Bell Instrument with 11 big fat partials

instr 5

; duration of decay of the 11 partials

  idur1     =  p3
  idur2     =  p3 * .9
  idur3     =  p3 * .65
  idur4     =  p3 * .55
  idur5     =  p3 * .325
  idur6     =  p3 * .35
  idur7     =  p3 * .25
  idur8     =  p3 * .2
  idur9     =  p3 * .15
  idur10    =  p3 * .1
  idur11    =  p3 * .075

; frequency of the 11 partials

  ifreq1    =  p4 * .56
  ifreq2    =  (p4 * .56) + 1
  ifreq3    =  p4 * .92
  ifreq4    =  (p4 * .92) + 1.7
  ifreq5    =  p4 * 1.19
  ifreq6    =  p4 * 1.7
  ifreq7    =  p4 * 2
  ifreq8    =  p4 * 2.74
  ifreq9    =  p4 * 3
  ifreq10   =  p4 * 3.75
  ifreq11   =  p4 * 4.07

; amplitudes of the 11 partials

  iamp1     =  p5 * 1500
  iamp2     =  iamp1 * 0.67
  iamp3     =  iamp1 * 1.35
  iamp4     =  iamp1 * 1.80
  iamp5     =  iamp1 * 2.67
  iamp6     =  iamp1 * 1.67
  iamp7     =  iamp1 * 1.46
  iamp8     =  iamp1 * 1.33
  iamp9     =  iamp1 * 1.33
  iamp10    =  iamp1 * 0.75
  iamp11    =  iamp1 * 1.33

; itable specifies the table used for the overall
; amplitude envelope of the note.  This is specified
; by p6 in the score, and MUST be either 2, 3, or 4.
; 2 specifies the normal exponential decay bell envelope.
; 3 specifies an exponential rise (reverse bell).
; 4 exponentially rises, then decays.

  itable    =  p6

; inoisea (inoise1a, inoise2a..,) serves the purpose of
; defining the starting pitch of the RANDI generator
; for each of the 11 partials.  The pitch of each
; partial's RANDI generator is scaled so that
; the bandwitdh of each note's noise spectrum is 
; proportional to all of the other partials.
; Also, it should prevent a "tremolo" effect for the
; overall sound with low frequency noise modulation,
; as each partial's noise generator will start at
; a different frequency.

  inoise1a  =  p7 * .56
  inoise2a  =  (p7 * .56) + 1
  inoise3a  =  p7 * .92
  inoise4a  =  (p7 * .92) + 1.7
  inoise5a  =  p7 * 1.19
  inoise6a  =  p7 * 1.7
  inoise7a  =  p7 * 2
  inoise8a  =  p7 * 2.74
  inoise9a  =  p7 * 3
  inoise10a =  p7 * 3.75
  inoise11a =  p4 * 4.07

  inoise1b  =  p8 * .56
  inoise2b  =  (p8 * .56) + 1
  inoise3b  =  p8 * .92
  inoise4b  =  (p8 * .92) + 1.7
  inoise5b  =  p8 * 1.19
  inoise6b  =  p8 * 1.7
  inoise7b  =  p8 * 2
  inoise8b  =  p8 * 2.74
  inoise9b  =  p8 * 3
  inoise10b =  p8 * 3.75
  inoise11b =  p8 * 4.07

  kenv1     oscil1    0, iamp1, idur1, itable
  kfrq1     linseg    inoise1a, idur1, inoise1b
  amod1     randi     kenv1, kfrq1
  aosc1     oscili    amod1, ifreq1, 1

  kenv2     oscil1    0, iamp2, idur2, itable
  kfrq2     linseg    inoise2a, idur2, inoise2b
  amod2     randi     kenv2, kfrq2
  aosc2     oscili    amod2, ifreq2, 1

  kenv3     oscil1    0, iamp3, idur3, itable
  kfrq3     linseg    inoise3a, idur3, inoise3b
  amod3     randi     kenv3, kfrq3
  aosc3     oscili    amod3, ifreq3, 1

  kenv4     oscil1    0, iamp4, idur4, itable
  kfrq4     linseg    inoise4a, idur4, inoise4b
  amod4     randi     kenv4, kfrq4
  aosc4     oscili    amod4, ifreq4, 1

  kenv5     oscil1    0, iamp5, idur5, itable
  kfrq5     linseg    inoise5a, idur5, inoise5b
  amod5     randi     kenv5, kfrq5
  aosc5     oscili    amod5, ifreq5, 1
 
  kenv6     oscil1    0, iamp6, idur6, itable
  kfrq6     linseg    inoise6a, idur6, inoise6b
  amod6     randi     kenv6, kfrq6
  aosc6     oscili    amod6, ifreq6, 1

  kenv7     oscil1    0, iamp7, idur7, itable
  kfrq7     linseg    inoise7a, idur7, inoise7b
  amod7     randi     kenv7, kfrq7
  aosc7     oscili    amod7, ifreq7, 1

  kenv8     oscil1    0, iamp8, idur8, itable
  kfrq8     linseg    inoise8a, idur8, inoise8b
  amod8     randi     kenv8, kfrq8
  aosc8     oscili    amod8, ifreq8, 1

  kenv9     oscil1    0, iamp9, idur9, itable
  kfrq9     linseg    inoise9a, idur9, inoise9b
  amod9     randi     kenv9, kfrq9
  aosc9     oscili    amod9, ifreq9, 1

  kenv10    oscil1    0, iamp10, idur10, itable
  kfrq10    linseg    inoise10a, idur10, inoise10b
  amod10    randi     kenv10, kfrq10
  aosc10    oscili    amod10, ifreq10, 1

  kenv11    oscil1    0, iamp11, idur11, itable
  kfrq11    linseg    inoise11a, idur11, inoise11b
  amod11    randi     kenv11, kfrq11
  aosc11    oscili    amod11, ifreq11, 1

  asum1     =  aosc1 + aosc3 + aosc5 + aosc7 + aosc9 + aosc11
  asum2     =  aosc2 + aosc4 + aosc6 + aosc8 + aosc10


            outs      asum1, asum2


endin

; noisetimp.orc by Sean Costello
;
; This is a modification of the Risset Additive Bell 
; instrument, where each partial of the bell is 
; ring modulated by noise.  The bandwidth of the 
; noise is controlled by a linseg generator, with
; the starting and ending bandwidth frequencies 
; specified in the score.
;
; Plus, I turned the bell into a timpani, relying
; on Chapter 18 of Fletcher & Rossing, "The Physics
; of Musical Instruments" for the relavant info.

; Timpani!!

instr 14

; duration of decay of the 11 partials

  idur1     =  p3 * .087                          ; mode 01
  idur2     =  p3 * .5                            ; mode 11
  idur3     =  p3 * .804                          ; mode 21
  idur4     =  p3 * .065                          ; mode 02
  idur5     =  p3 * .325                          ; mode 31
  idur6     =  p3 * .54                           ; mode 12
  idur7     =  p3 * 1                             ; mode 41
  idur8     =  p3 * .195                          ; mode 22
  idur9     =  p3 * .108                          ; mode 03
  idur10    =  p3 * .89                           ; mode 51
  idur11    =  p3 * .075                          ; mode 32

; frequency of the 11 partials

  ifreq1    =  p4 * .80                           ; mode 01
  ifreq2    =  p4 * 1.00                          ; mode 11
  ifreq3    =  p4 * 1.50                          ; mode 21
  ifreq4    =  p4 * 1.65                          ; mode 02
  ifreq5    =  p4 * 1.97                          ; mode 31
  ifreq6    =  p4 * 2.00                          ; mode 12
  ifreq7    =  p4 * 2.44                          ; mode 41
  ifreq8    =  p4 * 2.86                          ; mode 22
  ifreq9    =  p4 * 2.71                          ; mode 03
  ifreq10   =  p4 * 2.91                          ; mode 51
  ifreq11   =  p4 * 3.27                          ; mode 32

; amplitudes of the 11 partials

  iamp1     =  p5 * 15000                         ; mode 01
  iamp2     =  iamp1 * 2.52                       ; mode 11
  iamp3     =  iamp1 * 1.83                       ; mode 21
  iamp4     =  iamp1 * 0.55                       ; mode 02
  iamp5     =  iamp1 * 1.47                       ; mode 31
  iamp6     =  iamp1 * 1.67                       ; mode 12
  iamp7     =  iamp1 * 0.62                       ; mode 41
  iamp8     =  iamp1 * 0.50                       ; mode 22
  iamp9     =  iamp1 * 0.52                       ; mode 03
  iamp10    =  iamp1 * 0.55                       ; mode 51
  iamp11    =  iamp1 * 0.33                       ; mode 32

; itable specifies the table used for the overall
; amplitude envelope of the note.  This is specified
; by p6 in the score, and MUST be either 2, 3, or 4.
; 2 specifies the normal exponential decay bell envelope.
; 3 specifies an exponential rise (reverse bell).
; 4 exponentially rises, then decays.

  itable    =  p6

; inoisea (inoise1a, inoise2a..,) serves the purpose of
; defining the starting pitch of the RANDI generator
; for each of the 11 partials.  The pitch of each
; partial's RANDI generator is scaled so that
; the bandwitdh of each note's noise spectrum is 
; proportional to all of the other partials.
; Also, it should prevent a "tremolo" effect for the
; overall sound with low frequency noise modulation,
; as each partial's noise generator will start at
; a different frequency.

  inoise1a  =  p7 * .56
  inoise2a  =  (p7 * .56) + 1
  inoise3a  =  p7 * .92
  inoise4a  =  (p7 * .92) + 1.7
  inoise5a  =  p7 * 1.19
  inoise6a  =  p7 * 1.7
  inoise7a  =  p7 * 2
  inoise8a  =  p7 * 2.74
  inoise9a  =  p7 * 3
  inoise10a =  p7 * 3.75
  inoise11a =  p4 * 4.07

  inoise1b  =  p8 * .56
  inoise2b  =  (p8 * .56) + 1
  inoise3b  =  p8 * .92
  inoise4b  =  (p8 * .92) + 1.7
  inoise5b  =  p8 * 1.19
  inoise6b  =  p8 * 1.7
  inoise7b  =  p8 * 2
  inoise8b  =  p8 * 2.74
  inoise9b  =  p8 * 3
  inoise10b =  p8 * 3.75
  inoise11b =  p8 * 4.07

  kenv1     oscil1    0, iamp1, idur1, itable
  kfrq1     linseg    inoise1a, idur1, inoise1b
  amod1     randi     kenv1, kfrq1
  aosc1     oscili    amod1, ifreq1, 1

  kenv2     oscil1    0, iamp2, idur2, itable
  kfrq2     linseg    inoise2a, idur2, inoise2b
  amod2     randi     kenv2, kfrq2
  aosc2     oscili    amod2, ifreq2, 1

  kenv3     oscil1    0, iamp3, idur3, itable
  kfrq3     linseg    inoise3a, idur3, inoise3b
  amod3     randi     kenv3, kfrq3
  aosc3     oscili    amod3, ifreq3, 1

  kenv4     oscil1    0, iamp4, idur4, itable
  kfrq4     linseg    inoise4a, idur4, inoise4b
  amod4     randi     kenv4, kfrq4
  aosc4     oscili    amod4, ifreq4, 1

  kenv5     oscil1    0, iamp5, idur5, itable
  kfrq5     linseg    inoise5a, idur5, inoise5b
  amod5     randi     kenv5, kfrq5
  aosc5     oscili    amod5, ifreq5, 1
 
  kenv6     oscil1    0, iamp6, idur6, itable
  kfrq6     linseg    inoise6a, idur6, inoise6b
  amod6     randi     kenv6, kfrq6
  aosc6     oscili    amod6, ifreq6, 1

  kenv7     oscil1    0, iamp7, idur7, itable
  kfrq7     linseg    inoise7a, idur7, inoise7b
  amod7     randi     kenv7, kfrq7
  aosc7     oscili    amod7, ifreq7, 1

  kenv8     oscil1    0, iamp8, idur8, itable
  kfrq8     linseg    inoise8a, idur8, inoise8b
  amod8     randi     kenv8, kfrq8
  aosc8     oscili    amod8, ifreq8, 1

  kenv9     oscil1    0, iamp9, idur9, itable
  kfrq9     linseg    inoise9a, idur9, inoise9b
  amod9     randi     kenv9, kfrq9
  aosc9     oscili    amod9, ifreq9, 1

  kenv10    oscil1    0, iamp10, idur10, itable
  kfrq10    linseg    inoise10a, idur10, inoise10b
  amod10    randi     kenv10, kfrq10
  aosc10    oscili    amod10, ifreq10, 1

  kenv11    oscil1    0, iamp11, idur11, itable
  kfrq11    linseg    inoise11a, idur11, inoise11b
  amod11    randi     kenv11, kfrq11
  aosc11    oscili    amod11, ifreq11, 1

  asum1     =  aosc1 + aosc2 + aosc3 + aosc4 + aosc5 + aosc6 + aosc7 + aosc8 + aosc9 + aosc10 + aosc11


            outs      asum1, asum1


endin
