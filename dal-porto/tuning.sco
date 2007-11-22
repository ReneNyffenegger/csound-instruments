; TUNING.SCO (TUNING SCORE) BY MARK DAL PORTO

;=======================================================================;
; THE CHROMATIC SCALE USED IN THIS SCORE FOR THE (1) MEANTONE (QUARTER- ;
; COMMA), (2) JUST, AND (3) PYTHAGORAN TUNING SYSTEM IS SPELLED C,DB    ;
; (NOT C#),D,EB(NOT D#),E,F,F#(NOT GB),G,AB(NOT G#),A,BB(NOT A#),B.     ;
; IN THESE TUNING SYSTEMS, DB AND C# WOULD NOT BE IDENTICAL PITCHES OR  ;
; FREQUENCIES; THE SAME IS TRUE OF EB AND D#, ETC.  HOWEVER, IN THE     ;
; EQUAL TEMPERAMENT SYSTEM, C# IS THE SAME PITCH OR FREQUENCY AS DB,    ;
; D# THE SAME AS EB, ETC.  (IN CSOUND, OCTAVE.PITCH NUMBERS CAN BE      ;
; USED TO CORRESPOND TO THE NOTES ON A TRADITIONALLY-TUNED PIANO, I.E.  ;
; 8.00 = C4 OR MIDDLE C, 6.08 = AB2, ETC.).  THIS SCORE SIMULATES AN    ;
; ACTUAL KEYBOARD TUNED TO ONE OF THE ABOVE 3 TEMPERAMENTS OR TUNING    ;
; SYSTEMS.  ITS PERFORMANCE SHOWS THE INTONATION PROBLEMS THAT WILL     ;
; RESULT WHEN MODULATING INTO DISTANT KEYS USING THE MEANTONE, JUST,    ;
; AND PYTHAGORAN TEMPERAMENTS WHEN PLAYED ON A TRADITIONAL (12-KEY PER  ;
; OCTAVE) KEYBOARD.                                                     ;
;=======================================================================;

; function 1 is the (quarter-comma) Meantone scale
; (C,Db,D,Eb,E,F,F#,G,Ab,A,Bb,B)
f1  0 16    -2 
      0     .0963 .1609 .2582 .3219 .4190 .4834 .5811 .6781 .7416 .8392 .9030

; FUNCTION 2 IS THE JUST SCALE (C,Db,D,Eb,E,F,F#,G,Ab,A,Bb,B)
f2  0 16    -2 
      0     .0931 .1695 .263  .3219 .415  .4918 .585  .6781 .737  .848  .9069

; FUNCTION 3 IS THE PYTHAGORAN SCALE (C,Db,D,Eb,E,F,F#,G,Ab,A,Bb,B)
f3  0 16    -2 
      0     .0752 .1699 .2451 .3398 .415  .5097 .585  .6602 .7549 .8301 .9248

; FUNCTION 4 IS THE EQUAL TEMPERAMENT SCALE
; (C,C#/Db,E,F,F#/Gb,G,G#/Ab,A,A#/Bb,B)
f4  0 16    -2 
      0     .0833 .1667 .25   .3333 .4167 .5    .5833 .6667 .75   .8333 .9167

; FUNCTION 5 IS THE WAVEFORM GENERATOR WHICH CREATES A SAWTOOTH
; WITH 13 HARMONICS
f5  0 512   10  
      1     .5    .333  .25   .2    .167  .143  .125  .111  .1    .09   .083  .077

;========================================================================;
; THE FOLLOWING SCORE USES THE SIMPLE HARMONIC CHORD PROGRESSION OF      ;
; I - II6 - I6/4 - V7 - I IN THE KEY OF C FOR ALL 4 TUNING SYSTEMS,      ;
; THEN IN THE KEY OF F, AND, FINALLY, IN F#.  THE SCORE BEGINS WITH      ;
; THE MOST "CURRENT" TUNING SYSTEM (EQUAL TEMPERAMENT) AND THEN          ;
; PROGRESSES "BACKWARD" IN TIME TO THE MEANTONE (IN COMMON USE DURING    ;
; THE BAROQUE ERA), THE JUST (COMMON DURING THE RENAISSANCE), AND        ;
; FINALLY THE PYTHAGORAN (THE MOST "ANCIENT" OF THESE 4 TUNING SYSTEMS). ;
;========================================================================;

; SECTION 1 - IN THE KEY OF C
; EQUAL TEMPERAMENT

i1  0  1.1    9.04                      ; P4=OCTAVE.PITCH CONVERSION TO CPS; NOTE IS E5 (659.26 HZ)
i1  0  1.1    9.00                      ; C5 (523.25 Hz)
i1  0  1.1    8.07                      ; G4 (392.00 Hz)
i1  0  1.1    8.00                      ; C4 (261.63 Hz)

i1  1  1.1    9.05                      ; F5 (698.46 Hz)
i1  1  1.1    9.02                      ; D5 (587.33 Hz)
i1  1  1.1    8.09                      ; A4 (440.00 Hz)
i1  1  1.1    7.05                      ; F3 (174.61 Hz)

i1  2  1.1    9.04                      ; E5 (659.26 Hz)
i1  2  1.1    9.00                      ; C5 (523.25 Hz)
i1  2  1.1    8.07                      ; G4 (392.00 Hz)
i1  2  1.1    7.07                      ; G3 (196.00 Hz)

i1  3  1.1    9.02                      ; D5 (587.33 Hz)
i1  3  1.1    8.11                      ; B4 (493.88 Hz)
i1  3  1.1    8.05                      ; F4 (349.23 Hz)
i1  3  1.1    6.07                      ; G2 (98.00 Hz)

i1  4  3.5    9.00                      ; C5 (523.25 Hz)
i1  4  3.5    8.07                      ; G4 (392.00 Hz)
i1  4  3.5    8.04                      ; E4 (329.63 Hz)
i1  4  3.5    7.00                      ; C3 (130.81 Hz)
;---------------------------------------------------------------------------
; MEANTONE TEMPERAMENT

i2  8  1.1    9.3219                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS E5 (654.06 HZ)
i2  8  1.1    9.0000                    ; C5 (523.25 Hz)
i2  8  1.1    8.5811                    ; G4 (391.21 Hz)
i2  8  1.1    8.0000                    ; C4 (261.63 Hz)

i2  9  1.1    9.4190                    ; F5 (699.84 Hz)
i2  9  1.1    9.1609                    ; D5 (585.00 Hz)
i2  9  1.1    8.7416                    ; A4 (437.41 Hz)
i2  9  1.1    7.4190                    ; F3 (174.96 Hz)

i2  10 1.1    9.3219                    ; E5 (654.06 Hz)
i2  10 1.1    9.0000                    ; C5 (523.25 Hz)
i2  10 1.1    8.5811                    ; G4 (391.21 Hz)
i2  10 1.1    7.5811                    ; G3 (195.60 Hz)

i2  11 1.1    9.1609                    ; D5 (585.00 Hz)
i2  11 1.1    8.9030                    ; B4 (489.03 Hz)
i2  11 1.1    8.4190                    ; F4 (349.92 Hz)
i2  11 1.1    6.5811                    ; G2 (97.80 Hz)

i2  12 3.5    9.0000                    ; C5 (523.25 Hz)
i2  12 3.5    8.5811                    ; G4 (391.21 Hz)
i2  12 3.5    8.3219                    ; E4 (327.03 Hz)
i2  12 3.5    7.0000                    ; C3 (130.81 Hz)
;---------------------------------------------------------------------------
; JUST TEMPERAMENT

i2  16 1.1    9.3219                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS E5 (654.06 HZ)
i2  16 1.1    9.0000                    ; C5 (523.25 Hz)
i2  16 1.1    8.5850                    ; G4 (392.44 Hz)
i2  16 1.1    8.0000                    ; C4 (261.63 Hz)

i2  17 1.1    9.4150                    ; F5 (697.66 Hz)
i2  17 1.1    9.1695                    ; D5 (588.66 Hz)
i2  17 1.1    8.7370                    ; A4 (436.05 Hz)
i2  17 1.1    7.4150                    ; F3 (174.41 Hz)

i2  18 1.1    9.3219                    ; E5 (654.06 Hz)
i2  18 1.1    9.0000                    ; C5 (523.25 Hz)
i2  18 1.1    8.5850                    ; G4 (392.44 Hz)
i2  18 1.1    7.5850                    ; G3 (196.22 Hz)

i2  19 1.1    9.1695                    ; D5 (588.66 Hz)
i2  19 1.1    8.9069                    ; B4 (490.55 Hz)
i2  19 1.1    8.4150                    ; F4 (348.83 Hz)
i2  19 1.1    6.5850                    ; G2 (98.11 Hz)

i2  20 3.5    9.0000                    ; C5 (523.25 Hz)
i2  20 3.5    8.5850                    ; G4 (392.44 Hz)
i2  20 3.5    8.3219                    ; E4 (327.03 Hz)
i2  20 3.5    7.0000                    ; C3 (130.81 Hz)
;---------------------------------------------------------------------------
; PYTHAGORAN TEMPERAMENT

i2  24 1.1    9.3398                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS E5 (662.22 HZ)
i2  24 1.1    9.0000                    ; C5 (523.25 Hz)
i2  24 1.1    8.5850                    ; G4 (392.42 Hz)
i2  24 1.1    8.0000                    ; C4 (261.63 Hz)

i2  25 1.1    9.4150                    ; F5 (697.66 Hz)
i2  25 1.1    9.1699                    ; D5 (588.66 Hz)
i2  25 1.1    8.7549                    ; A4 (441.49 Hz)
i2  25 1.1    7.4150                    ; F3 (174.41 Hz)

i2  26 1.1    9.3398                    ; E5 (662.22 Hz)
i2  26 1.1    9.0000                    ; C5 (523.25 Hz)
i2  26 1.1    8.5850                    ; G4 (392.42 Hz)
i2  26 1.1    7.5850                    ; G3 (196.22 Hz)

i2  27 1.1    9.1699                    ; D5 (588.66 Hz)
i2  27 1.1    8.9248                    ; B4 (496.67 Hz)
i2  27 1.1    8.4150                    ; F4 (348.83 Hz)
i2  27 1.1    6.5850                    ; G2 (98.11 Hz)

i2  28 4.0    9.0000                    ; C5 (523.25 Hz)
i2  28 4.0    8.5850                    ; G4 (392.42 Hz)
i2  28 4.0    8.3398                    ; E4 (331.11 Hz)
i2  28 4.0    7.0000                    ; C3 (130.81 Hz)
f0  36                                  ; CREATES 4 SECONDS OF SILENCE
s                                       ; END OF SECTION 1 - BEGINS NEW STARTING TIME OF "0"
;======================================================================
; SECTION 2 - IN THE KEY OF F
; EQUAL TEMPERAMENT

i1  0  1.1    8.09                      ; P4=OCTAVE.PITCH CONVERSION TO CPS; NOTE IS A4 (440.00 HZ)
i1  0  1.1    8.05                      ; F4 (349.23 Hz)
i1  0  1.1    8.00                      ; C4 (261.63 Hz)
i1  0  1.1    7.05                      ; F3 (174.61 Hz)

i1  1  1.1    8.10                      ; Bb4 (466.16 Hz)
i1  1  1.1    8.07                      ; G4 (392.00 Hz)
i1  1  1.1    8.02                      ; D4 (293.66 Hz)
i1  1  1.1    6.10                      ; Bb2 (116.54 Hz)

i1  2  1.1    8.09                      ; A4 (440.00 Hz)
i1  2  1.1    8.05                      ; F4 (349.23 Hz)
i1  2  1.1    8.00                      ; C4 (261.63 Hz)
i1  2  1.1    7.00                      ; C3 (130.81 Hz)

i1  3  1.1    8.07                      ; G4 (392.00 Hz)
i1  3  1.1    8.04                      ; E4 (329.63 Hz)
i1  3  1.1    7.10                      ; Bb3 (233.08 Hz)
i1  3  1.1    6.00                      ; C2 (65.41 Hz)

i1  4  3.5    8.05                      ; F4 (349.23 Hz)
i1  4  3.5    8.00                      ; C4 (261.63 Hz)
i1  4  3.5    7.09                      ; A3 (220.00 Hz)
i1  4  3.5    6.05                      ; F2 (87.31 Hz)
;---------------------------------------------------------------------------
; MEANTONE TEMPERAMENT

i2  8  1.1    8.7416                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS A4 (437.41 HZ)
i2  8  1.1    8.4190                    ; F4 (349.92 Hz)
i2  8  1.1    8.0000                    ; C4 (261.63 Hz)
i2  8  1.1    7.4190                    ; F3 (174.96 Hz)

i2  9  1.1    8.8392                    ; Bb4 (468.02 Hz)
i2  9  1.1    8.5811                    ; G4 (391.21 Hz)
i2  9  1.1    8.1609                    ; D4 (292.50 Hz)
i2  9  1.1    6.8392                    ; Bb2 (117.00 Hz)

i2  10 1.1    8.7416                    ; A4 (437.41 Hz)
i2  10 1.1    8.4190                    ; F4 (349.92 Hz)
i2  10 1.1    8.0000                    ; C4 (261.63 Hz)
i2  10 1.1    7.0000                    ; C3 (130.81 Hz)

i2  11 1.1    8.5811                    ; G4 (391.21 Hz)
i2  11 1.1    8.3219                    ; E4 (327.03 Hz)
i2  11 1.1    7.8392                    ; Bb3 (234.01 Hz)
i2  11 1.1    6.0000                    ; C2 (65.41 Hz)

i2  12 3.5    8.4190                    ; F4 (349.92 Hz)
i2  12 3.5    8.0000                    ; C4 (261.63 Hz)
i2  12 3.5    7.7416                    ; A3 (218.70 Hz)
i2  12 3.5    6.4190                    ; F2 (87.48 Hz)
;---------------------------------------------------------------------------
; JUST TEMPERAMENT

i2  16 1.1    8.7370                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS A4 (436.05 HZ)
i2  16 1.1    8.4150                    ; F4 (348.83 Hz)
i2  16 1.1    8.0000                    ; C4 (261.63 Hz)
i2  16 1.1    7.4150                    ; F3 (174.41 Hz)

i2  17 1.1    8.8480                    ; Bb4 (470.93 Hz)
i2  17 1.1    8.5850                    ; G4 (392.44 Hz)
i2  17 1.1    8.1695                    ; D4 (294.33 Hz)
i2  17 1.1    6.8480                    ; Bb2 (117.73 Hz)

i2  18 1.1    8.7370                    ; A4 (436.05 Hz)
i2  18 1.1    8.4150                    ; F4 (348.83 Hz)
i2  18 1.1    8.0000                    ; C4 (261.63 Hz)
i2  18 1.1    7.0000                    ; C3 (130.81 Hz)

i2  19 1.1    8.5850                    ; G4 (392.44 Hz)
i2  19 1.1    8.3219                    ; E4 (327.03 Hz)
i2  19 1.1    7.8480                    ; Bb3 (235.46 Hz)
i2  19 1.1    6.0000                    ; C2 (65.41 Hz)

i2  20 3.5    8.4150                    ; F4 (348.83 Hz)
i2  20 3.5    8.0000                    ; C4 (261.63 Hz)
i2  20 3.5    7.7370                    ; A3 (218.02 Hz)
i2  20 3.5    6.4150                    ; F2 (87.21 Hz)
;---------------------------------------------------------------------------
; PYTHAGORAN TEMPERAMENT

i2  24 1.1    8.7549                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS A4 (441.49 HZ)
i2  24 1.1    8.4150                    ; F4 (348.83 Hz)
i2  24 1.1    8.0000                    ; C4 (261.63 Hz)
i2  24 1.1    7.4150                    ; F3 (174.41 Hz)

i2  25 1.1    8.8301                    ; Bb4 (465.12 Hz)
i2  25 1.1    8.5850                    ; G4 (392.44 Hz)
i2  25 1.1    8.1699                    ; D4 (294.33 Hz)
i2  25 1.1    6.8301                    ; Bb2 (116.28 Hz)

i2  26 1.1    8.7549                    ; A4 (441.49 Hz)
i2  26 1.1    8.4150                    ; F4 (348.83 Hz)
i2  26 1.1    8.0000                    ; C4 (261.63 Hz)
i2  26 1.1    7.0000                    ; C3 (130.81 Hz)

i2  27 1.1    8.5850                    ; G4 (392.44 Hz)
i2  27 1.1    8.3398                    ; E4 (331.11 Hz)
i2  27 1.1    7.8301                    ; Bb3 (232.56 Hz)
i2  27 1.1    6.0000                    ; C2 (65.41 Hz)

i2  28 4.0    8.4150                    ; F4 (348.83 Hz)
i2  28 4.0    8.0000                    ; C4 (261.63 Hz)
i2  28 4.0    7.7549                    ; A3 (220.74 Hz)
i2  28 4.0    6.4150                    ; F2 (87.21 Hz)
f0  36                                  ; CREATES 4 SECONDS OF SILENCE
s                                       ; END OF SECTION 2 - BEGINS NEW STARTING TIME OF "0"
;======================================================================
; SECTION 3 - IN THE KEY OF F#
; EQUAL TEMPERAMENT

i1  0  1.1    8.10                      ; P4=OCTAVE.PITCH CONVERSION TO CPS; NOTE IS A#4 (466.16 HZ)
i1  0  1.1    8.06                      ; F#4 (369.99 Hz)
i1  0  1.1    8.01                      ; C#4 (277.18 Hz)
i1  0  1.1    7.06                      ; F#3 (185.00 Hz)

i1  1  1.1    8.11                      ; B4 (493.88 Hz)
i1  1  1.1    8.08                      ; G#4 (415.30 Hz)
i1  1  1.1    8.03                      ; D#4 (311.13 Hz)
i1  1  1.1    6.11                      ; B2 (123.47 Hz)

i1  2  1.1    8.10                      ; A#4 (466.16 Hz)
i1  2  1.1    8.06                      ; F#4 (369.99 Hz)
i1  2  1.1    8.01                      ; C#4 (277.18 Hz)
i1  2  1.1    7.01                      ; C#3 (138.59 Hz)

i1  3  1.1    8.08                      ; G#4 (415.30 Hz)
i1  3  1.1    8.05                      ; E#4 (349.23 Hz)
i1  3  1.1    7.11                      ; B3 (246.94 Hz)
i1  3  1.1    6.01                      ; F#2 (92.50 Hz)

i1  4  3.5    8.06                      ; F#4 (369.99 Hz)
i1  4  3.5    8.01                      ; C#4 (277.18 Hz)
i1  4  3.5    7.10                      ; A#3 (233.08 Hz)
i1  4  3.5    6.06                      ; F#2 (92.50 Hz)
;---------------------------------------------------------------------------
; MEANTONE TEMPERAMENT

i2  8  1.1    8.8392                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS BB4 (468.02 HZ)
i2  8  1.1    8.4834                    ; F#4 (365.62 Hz)
i2  8  1.1    8.0963                    ; Db4 (279.94 Hz)
i2  8  1.1    7.4834                    ; F#3 (182.81 Hz)

i2  9  1.1    8.9030                    ; B4 (489.03 Hz)
i2  9  1.1    8.6781                    ; Ab4 (418.60 Hz)
i2  9  1.1    8.2582                    ; Eb4 (312.98 Hz)
i2  9  1.1    6.9030                    ; B2 (122.26 Hz)

i2  10 1.1    8.8392                    ; Bb4 (468.02 Hz)
i2  10 1.1    8.4834                    ; F#4 (365.62 Hz)
i2  10 1.1    8.0963                    ; Db4 (279.94 Hz)
i2  10 1.1    7.0963                    ; Db3 (139.97 Hz)

i2  11 1.1    8.6781                    ; Ab4 (418.60 Hz)
i2  11 1.1    8.4190                    ; F4 (349.92 Hz)
i2  11 1.1    7.9030                    ; B3 (244.51 Hz)
i2  11 1.1    6.0963                    ; Db2 (69.98 Hz)

i2  12 3.5    8.4834                    ; F#4 (365.62 Hz)
i2  12 3.5    8.0963                    ; Db4 (279.94 Hz)
i2  12 3.5    7.8392                    ; Bb3 (234.01 Hz)
i2  12 3.5    6.4834                    ; F#2 (91.40 Hz)
;---------------------------------------------------------------------------
; JUST TEMPERAMENT

i2  16 1.1    8.8480                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS BB4 (470.93 HZ)
i2  16 1.1    8.4918                    ; F#4 (367.92 Hz)
i2  16 1.1    8.0931                    ; Db4 (279.07 Hz)
i2  16 1.1    7.4918                    ; F#3 (183.96 Hz)

i2  17 1.1    8.9069                    ; B4 (490.55 Hz)
i2  17 1.1    8.6781                    ; Ab4 (418.60 Hz)
i2  17 1.1    8.2630                    ; Eb4 (313.96 Hz)
i2  17 1.1    6.9069                    ; B2 (122.64 Hz)

i2  18 1.1    8.8480                    ; Bb4 (470.93 Hz)
i2  18 1.1    8.4918                    ; F#4 (367.92 Hz)
i2  18 1.1    8.0931                    ; Db4 (279.07 Hz)
i2  18 1.1    7.0931                    ; Db3 (139.53 Hz)

i2  19 1.1    8.6781                    ; Ab4 (418.60 Hz)
i2  19 1.1    8.4150                    ; F4 (348.83 Hz)
i2  19 1.1    7.9069                    ; B3 (245.27 Hz)
i2  19 1.1    6.0931                    ; Db2 (69.77 Hz)

i2  20 3.5    8.4918                    ; F#4 (367.92 Hz)
i2  20 3.5    8.0931                    ; Db4 (279.07 Hz)
i2  20 3.5    7.8480                    ; Bb3 (235.46 Hz)
i2  20 3.5    6.4918                    ; F#2 (91.98 Hz)
;---------------------------------------------------------------------------
; PYTHAGORAN TEMPERAMENT

i2  24 1.1    8.8301                    ; P4=OCTAVE.% CONVERSION TO CPS; NOTE IS Bb4 (465.12 HZ)
i2  24 1.1    8.5097                    ; F#4 (372.50 Hz)
i2  24 1.1    8.0752                    ; Db4 (275.62 Hz)
i2  24 1.1    7.5097                    ; F#3 (186.25 Hz)

i2  25 1.1    8.9248                    ; B4 (496.67 Hz)
i2  25 1.1    8.6602                    ; Ab4 (413.42 Hz)
i2  25 1.1    8.2451                    ; Eb4 (310.08 Hz)
i2  25 1.1    6.9248                    ; B2 (124.17 Hz)

i2  26 1.1    8.8301                    ; Bb4 (465.12 Hz)
i2  26 1.1    8.5097                    ; F#4 (372.50 Hz)
i2  26 1.1    8.0752                    ; Db4 (275.62 Hz)
i2  26 1.1    7.0752                    ; Db3 (137.81 Hz)

i2  27 1.1    8.6602                    ; Ab4 (413.42 Hz)
i2  27 1.1    8.4150                    ; F4 (348.83 Hz)
i2  27 1.1    7.9248                    ; B3 (248.33 Hz)
i2  27 1.1    6.0752                    ; Db2 (68.90 Hz)

i2  28 4.0    8.5097                    ; F#4 (372.50 Hz)
i2  28 4.0    8.0752                    ; Db4 (275.62 Hz)
i2  28 4.0    7.8301                    ; Bb3 (232.56 Hz)
i2  28 4.0    6.5097                    ; F#2 (93.12 Hz)

e                    ; END OF SECTION 3 AND SCORE
