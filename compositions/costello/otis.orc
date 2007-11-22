  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gamod     init      0                           ; GLOBAL FM VARIABLE

instr          11

  ilength   =  p3
  iamp      =  p4

  a1, a2    soundin   "grantest3.aiff"
 
  kenv      linen     p4, .01, p3, .01

            outs      a1, a2

endin

instr          15   ; A SINE WAVE WINDOWED BY A HANNING WINDOW.  CAN'T GET MUCH SIMPLER.
                    ; I USE IT FOR THE GRANULAR TEXTURES.   INEFFICIENT, YES, BUT
                    ; I LIKE WORKING WITH CM TO GENERATE THE GRANULAR TEXTURES, JUST TO
                    ; GET A FEEL OF HOW GRANULAR SYNTHESIS REALLY WORKS.

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


instr          7    ; THE SIMPLE FM INSTRUMENT FROM CLASS.  IT DOES GOOD "MOUSE DRUMS."

  icarfreq  =  p6
  iratio    =  p7
  imodfreq  =  icarfreq * iratio
  index     =  p8
  idev      =  imodfreq*index
  iamp      =  p4 * 5000
  iampfunc  =  p5
;iglobalmodamount =      p9
  ichan1    =  sqrt(p9)
  ichan2    =  sqrt(1-p9)

  kenv      oscil1i   0, 1, p3, iampfunc

  amod      oscili    idev * kenv,   imodfreq,  1
  aosc      oscili    kenv,  icarfreq + amod,   1

  asig1     =  aosc * ichan1 * iamp
  asig2     =  aosc * ichan2 * iamp

            outs      asig1, asig2

;gamod         =         acar * iglobalmodamount

endin

instr          8         ; MY FIRST FM INSTRUMENT - NOT VERY SCIENTIFIC, BUT
                         ; IT HAS A NICE SOUND.  MODIFIED TO HAVE MORE CONTROL.
                         ; USED FOR SOME BACKGROUND DRONES.  SOUNDS KINDA ANALOG,
                         ; IN A GOOD WAY (ALTHOUGH IT CAN COME PRECARIOUSLY CLOSE
                         ; TO SOUNDING LIKE PETER GABRIEL [GAGGING SOUND]).

                         ; SUNDAY, DECEMBER 5 - EXPERIMENTING WITH HAVING
                         ; A GLOBAL VARIABLE MODULATING THE SIGNAL.  THIS SHOULD
                         ; CREATE A SIMILAR EFFECT TO WHAT RISSET USED IN ONE 
                         ; OF HIS COMPOSITIONS, ALTHOUGH I HAVE TO ADMIT
                         ; THAT MY IDEA IS MORE STRONGLY INFLUENCED BY APHEX
                         ; TWIN'S "VENTOLIN," AS WELL AS A MOOG TECHNIQUE
                         ; I PICKED UP FROM WATCHING JESSAMINE PERFORM SEVERAL TIMES.
                         ; NOT USED IN COMPOSITION AS OF DECEMBER 6.

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

; NOISEBELL.ORC BY SEAN COSTELLO
;
; THIS IS A MODIFICATION OF THE RISSET ADDITIVE BELL 
; INSTRUMENT, WHERE EACH PARTIAL OF THE BELL IS 
; RING MODULATED BY NOISE.  THE BANDWIDTH OF THE 
; NOISE IS CONTROLLED BY A LINSEG GENERATOR, WITH
; THE STARTING AND ENDING BANDWIDTH FREQUENCIES 
; SPECIFIED IN THE SCORE.


; RISSET ADDITIVE BELL INSTRUMENT WITH 11 BIG FAT PARTIALS

instr          5

; DURATION OF DECAY OF THE 11 PARTIALS

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

; FREQUENCY OF THE 11 PARTIALS

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

; AMPLITUDES OF THE 11 PARTIALS

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

; ITABLE SPECIFIES THE TABLE USED FOR THE OVERALL
; AMPLITUDE ENVELOPE OF THE NOTE.  THIS IS SPECIFIED
; BY P6 IN THE SCORE, AND MUST BE EITHER 2, 3, OR 4.
; 2 SPECIFIES THE NORMAL EXPONENTIAL DECAY BELL ENVELOPE.
; 3 SPECIFIES AN EXPONENTIAL RISE (REVERSE BELL).
; 4 EXPONENTIALLY RISES, THEN DECAYS.

  itable    =  p6

; INOISEA (INOISE1A, INOISE2A..,) SERVES THE PURPOSE OF
; DEFINING THE STARTING PITCH OF THE RANDI GENERATOR
; FOR EACH OF THE 11 PARTIALS.  THE PITCH OF EACH
; PARTIAL'S RANDI GENERATOR IS SCALED SO THAT
; THE BANDWITDH OF EACH NOTE'S NOISE SPECTRUM IS 
; PROPORTIONAL TO ALL OF THE OTHER PARTIALS.
; ALSO, IT SHOULD PREVENT A "TREMOLO" EFFECT FOR THE
; OVERALL SOUND WITH LOW FREQUENCY NOISE MODULATION,
; AS EACH PARTIAL'S NOISE GENERATOR WILL START AT
; A DIFFERENT FREQUENCY.

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

; NOISETIMP.ORC BY SEAN COSTELLO
;
; THIS IS A MODIFICATION OF THE RISSET ADDITIVE BELL 
; INSTRUMENT, WHERE EACH PARTIAL OF THE BELL IS 
; RING MODULATED BY NOISE.  THE BANDWIDTH OF THE 
; NOISE IS CONTROLLED BY A LINSEG GENERATOR, WITH
; THE STARTING AND ENDING BANDWIDTH FREQUENCIES 
; SPECIFIED IN THE SCORE.
;
; PLUS, I TURNED THE BELL INTO A TIMPANI, RELYING
; ON CHAPTER 18 OF FLETCHER & ROSSING, "THE PHYSICS
; OF MUSICAL INSTRUMENTS" FOR THE RELAVANT INFO.

; TIMPANI!!

instr          14

; DURATION OF DECAY OF THE 11 PARTIALS

  idur1     =  p3 * .087                          ; MODE 01
  idur2     =  p3 * .5                            ; MODE 11
  idur3     =  p3 * .804                          ; MODE 21
  idur4     =  p3 * .065                          ; MODE 02
  idur5     =  p3 * .325                          ; MODE 31
  idur6     =  p3 * .54                           ; MODE 12
  idur7     =  p3 * 1                             ; MODE 41
  idur8     =  p3 * .195                          ; MODE 22
  idur9     =  p3 * .108                          ; MODE 03
  idur10    =  p3 * .89                           ; MODE 51
  idur11    =  p3 * .075                          ; MODE 32

; FREQUENCY OF THE 11 PARTIALS

  ifreq1    =  p4 * .80                           ; MODE 01
  ifreq2    =  p4 * 1.00                          ; MODE 11
  ifreq3    =  p4 * 1.50                          ; MODE 21
  ifreq4    =  p4 * 1.65                          ; MODE 02
  ifreq5    =  p4 * 1.97                          ; MODE 31
  ifreq6    =  p4 * 2.00                          ; MODE 12
  ifreq7    =  p4 * 2.44                          ; MODE 41
  ifreq8    =  p4 * 2.86                          ; MODE 22
  ifreq9    =  p4 * 2.71                          ; MODE 03
  ifreq10   =  p4 * 2.91                          ; MODE 51
  ifreq11   =  p4 * 3.27                          ; MODE 32

; AMPLITUDES OF THE 11 PARTIALS

  iamp1     =  p5 * 15000                         ; MODE 01
  iamp2     =  iamp1 * 2.52                       ; MODE 11
  iamp3     =  iamp1 * 1.83                       ; MODE 21
  iamp4     =  iamp1 * 0.55                       ; MODE 02
  iamp5     =  iamp1 * 1.47                       ; MODE 31
  iamp6     =  iamp1 * 1.67                       ; MODE 12
  iamp7     =  iamp1 * 0.62                       ; MODE 41
  iamp8     =  iamp1 * 0.50                       ; MODE 22
  iamp9     =  iamp1 * 0.52                       ; MODE 03
  iamp10    =  iamp1 * 0.55                       ; MODE 51
  iamp11    =  iamp1 * 0.33                       ; MODE 32

; ITABLE SPECIFIES THE TABLE USED FOR THE OVERALL
; AMPLITUDE ENVELOPE OF THE NOTE.  THIS IS SPECIFIED
; BY P6 IN THE SCORE, AND MUST BE EITHER 2, 3, OR 4.
; 2 SPECIFIES THE NORMAL EXPONENTIAL DECAY BELL ENVELOPE.
; 3 SPECIFIES AN EXPONENTIAL RISE (REVERSE BELL).
; 4 EXPONENTIALLY RISES, THEN DECAYS.

  itable    =  p6

; INOISEA (INOISE1A, INOISE2A..,) SERVES THE PURPOSE OF
; DEFINING THE STARTING PITCH OF THE RANDI GENERATOR
; FOR EACH OF THE 11 PARTIALS.  THE PITCH OF EACH
; PARTIAL'S RANDI GENERATOR IS SCALED SO THAT
; THE BANDWITDH OF EACH NOTE'S NOISE SPECTRUM IS 
; PROPORTIONAL TO ALL OF THE OTHER PARTIALS.
; ALSO, IT SHOULD PREVENT A "TREMOLO" EFFECT FOR THE
; OVERALL SOUND WITH LOW FREQUENCY NOISE MODULATION,
; AS EACH PARTIAL'S NOISE GENERATOR WILL START AT
; A DIFFERENT FREQUENCY.

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
