
t       0       138.0                   ; tempo

#include "fgen.h.sco"
;include "room.sco"

f 1 0 65537 -1    "drums/909_crash.wav"   0     0     0   
f 2 0 8193  -1    "drums/909_hhat_2.wav"  0     0     0   
f 3 0 16385 -1    "drums/909_hhat_5.wav"  0     0     0   
f 4 0 32769 -1    "drums/909_hhat_6.wav"  0     0     0   
f 5 0 16385 -1    "drums/909_clap_1.wav"  0     0     0   
f 6 0 16385 -1    "drums/909_kick_6.wav"  0     0     0   
f 7 0 8193  -1    "drums/909_snar_1.wav"  0     0     0   
f 8 0 8193  -1    "drums/909_snar_2.wav"  0     0     0   
f 9 0 8193  -1    "drums/909_snar_7.wav"  0     0     0   

/* crash cymbal */

f 101 0     32    -2    1     0.25  0.05 ; input table, volume, delay
      -30   0.6                         ; azimuth, distance
      5                                 ; transpose (in semitones)
      0.000 1.0   1.0                   ; attack, decay, sustain level
      0.05                              ; release time
      12000 2.0   1.5   0               ; EQ1 frequency, level, Q, mode
      1000  1.0   0.7071      0         ; EQ2 frequency, level, Q, mode
      2.0   2.0   0.0   0.0             ; effect 1, 2, 3, 4 send

/* bass drum */

f 102 0     32    -2    6     1.0   0.05 ; input table, volume, delay
      0     0.6                         ; azimuth, distance
      0                                 ; transpose (in semitones)
      0.000 1.0   1.0                   ; attack, decay, sustain level
      0.025                             ; release time
      1000  1.0   0.7071      0         ; EQ1 frequency, level, Q, mode
      1000  1.0   0.7071      0         ; EQ2 frequency, level, Q, mode
      0.0   0.0   0.0   0.0             ; effect 1, 2, 3, 4 send

/* hand clap */

f 103 0     32    -2    5     1.2   0.041 ; input table, volume, delay
      0     0.6                         ; azimuth, distance
      0                                 ; transpose (in semitones)
      0.000 1.0   1.0                   ; attack, decay, sustain level
      0.025                             ; release time
      1000  1.0   0.7071      0         ; EQ1 frequency, level, Q, mode
      1000  1.0   0.7071      0         ; EQ2 frequency, level, Q, mode
      0.0   0.0   0.0   0.0             ; effect 1, 2, 3, 4 send

/* hihat 1 */

f 104 0     32    -2    2     0.7   0.048 ; input table, volume, delay
      80    1.0                         ; azimuth, distance
      0                                 ; transpose (in semitones)
      0.000 0.06  0.125                 ; attack, decay, sustain level
      0.025                             ; release time
      12000 2.0   1.5   0               ; EQ1 frequency, level, Q, mode
      1000  1.0   0.7071      0         ; EQ2 frequency, level, Q, mode
      0.0   0.0   0.0   0.0             ; effect 1, 2, 3, 4 send

/* hihat 2 */

f 105 0     32    -2    3     0.7   0.048 ; input table, volume, delay
      50    1.0                         ; azimuth, distance
      0                                 ; transpose (in semitones)
      0.000 1.0   1.0                   ; attack, decay, sustain level
      0.05                              ; release time
      12000 2.0   1.5   0               ; EQ1 frequency, level, Q, mode
      1000  1.0   0.7071      0         ; EQ2 frequency, level, Q, mode
      1.1   0.0   0.0   0.0             ; effect 1, 2, 3, 4 send

; effects
i 11   0.000  9.000
i 12   0.000  9.000
i 13   0.000  9.000
i 14   0.000  9.000

; output instr
i 90   0.000  9.000

e	; end of score

