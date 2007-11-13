sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     2207                ; PITCH SHIFTER
igain     =         p4                  ; OVERALL GAIN
idelay    =         p5                  ; N SECONDS DELAY
insemis   =         p6                  ; N SEMITONES TO SHIFT
ifract    =         insemis/12          ; FRACTION OF AN OCTAVE
ibasehz   =         cpsoct(8)           ; USE MIDDLE C AS BASIS
inewhz    =         cpsoct(8+ifract)    ; REL FREQ OF NEW PITCH
iratio    =         inewhz/ibasehz      ; RATIO NEW HZ TO OLD
irate     =         (iratio-1)/idelay   ; SUBTRACT 1/1 SPEED
kenv      linen     igain, .01, p3, .05 ; OVERALL ENV CONTROL
ainput    soundin   p7                  ; P7 IS SOUNDIN.NNN
actl1     phasor    -irate              ; MOVING PHASE 1-0
agate1    tablei    actl1, 1, 1, 0, 1   ; WINDOW FUNC =TRIANGLE
actl2     phasor    -irate, .5          ; PHASE OFFSET OF .5
agate2    tablei    actl2, 1, 1, 0, 1   ; TRIANGLE WINDOW FUNC
ajunk     delayr    idelay              ; ALLOC DELAY LINE
asig1     deltapi   actl1*idelay        ; 2 VARIABLE TAPS
asig2     deltapi   actl2*idelay        ; OFFSET 1/2 BUFFER LEN
          delayw    ainput
asig1     =         asig1*agate1        ; GATE TAP OUTPUTS
asig2     =         asig2*agate2        ; SEPARATELY
asum      =         asig1+asig2         ; AND SUM
          out       asum*kenv           ; OVERALL ENVELOPE
          endin
