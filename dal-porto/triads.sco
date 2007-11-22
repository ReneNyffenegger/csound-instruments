; TRIADS.SCO BY MARK DAL PORTO

; TRIAD COMPARISON SCORE USING DIFFERENT TUNINGS

; SCALE USED FOR MEANTONE (QUARTER-COMMA), JUST, AND PYTHAGORAN TUNINGS:  
; C,DB,EB,E,F#,G,A,BB

; WAVEFORM USED FOR TRIADS:  A SAWTOOTH WITH 16 HARMONICS
f1  0 512   10
      1     .5    .333  .25   .2    .167  .143  .125  .111  .1    .09   .083  .077  .07   .066  .062

; THE FOLLOWING SCORE COMPARES C AND F# MAJOR AND MINOR TRIADS 
; USING THE EQUAL, MEANTONE, JUST, AND PYTHAGORAN TUNING SYSTEMS
;============================================================================
; SECTION 1 - COMPARISON OF C MAJOR TRIADS
; EQUAL TEMPERAMENT
i1  0  2.5    392.00                    ; P4=FREQUENCY; NOTE IS G4
i1  0  2.5    329.63                    ; E4 
i1  0  2.5    261.63                    ; C4
; MEANTONE TEMPERAMENT
i1  3  2.5    391.21                    ; G4
i1  3  2.5    327.03                    ; E4
i1  3  2.5    261.63                    ; C4
; JUST TEMPERAMENT
i1  6  2.5    392.44                    ; G4
i1  6  2.5    327.03                    ; E4
i1  6  2.5    261.63                    ; C4
; PYTHAGORAN TEMPERAMENT
i1  9  2.5    392.44                    ; G4
i1  9  2.5    331.11                    ; E4
i1  9  2.5    261.63                    ; C4
;---------------------------------------------------------------------------
; COMPARISON OF C MINOR TRIADS
; EQUAL TEMPERAMENT
i1  12 2.5    392.00                    ; NOTE IS G4
i1  12 2.5    311.13                    ; Eb4 
i1  12 2.5    261.63                    ; C4
; MEANTONE TEMPERAMENT
i1  15 2.5    391.21                    ; G4
i1  15 2.5    312.98                    ; Eb4
i1  15 2.5    261.63                    ; C4
; JUST TEMPERAMENT
i1  18 2.5    392.44                    ; G4
i1  18 2.5    313.96                    ; Eb4
i1  18 2.5    261.63                    ; C4
; PYTHAGORAN TEMPERAMENT
i1  21 3.0    392.44                    ; G4
i1  21 3.0    310.08                    ; Eb4
i1  21 3.0    261.63                    ; C4
f0  27                                  ; CREATES 3 SECONDS OF SILENCE
s                                       ; END OF SECTION 1 - BEGINS NEW STARTING TIME OF "0"
;============================================================================
; SECTION 2 - COMPARISON OF F# MAJOR TRIADS
; EQUAL TEMPERAMENT
i1  0  2.5    554.37                    ; P4=FREQUENCY; NOTE IS C#5
i1  0  2.5    466.16                    ; A#4 
i1  0  2.5    369.99                    ; F#4 
; MEANTONE TEMPERAMENT
i1  3  2.5    559.88                    ; Db5
i1  3  2.5    468.02                    ; Bb4
i1  3  2.5    365.62                    ; F#4
; JUST TEMPERAMENT
i1  6  2.5    558.14                    ; Db5
i1  6  2.5    470.93                    ; Bb4
i1  6  2.5    367.92                    ; F#4
; PYTHAGORAN TEMPERAMENT
i1  9  2.5    551.24                    ; Db5
i1  9  2.5    465.12                    ; Bb4
i1  9  2.5    372.50                    ; F#4
;---------------------------------------------------------------------------
; COMPARISON OF F# MINOR TRIADS
; EQUAL TEMPERAMENT
i1  12 2.5    554.37                    ; note is C#5
i1  12 2.5    440.00                    ; A4 
i1  12 2.5    369.99                    ; F#4 
; MEANTONE TEMPERAMENT
i1  15 2.5    559.88                    ; Db5
i1  15 2.5    437.41                    ; A4
i1  15 2.5    365.62                    ; F#4
; JUST TEMPERAMENT
i1  18 2.5    558.14                    ; Db5
i1  18 2.5    436.05                    ; A4
i1  18 2.5    367.92                    ; F#4
; PYTHAGORAN TEMPERAMENT
i1  21 3.0    551.24                    ; Db5
i1  21 3.0    441.49                    ; A4
i1  21 3.0    372.50                    ; F#4

e                       ; END OF SECTION 2 AND SCORE
