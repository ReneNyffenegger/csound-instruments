sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     2208                ; SOUNDIN INSTRUMENT
gasend    init      0                   ; INIT THE GLOBAL VAR
idry      =         p4                  ; AMT OF SIGNAL TO OUT
iwet      =         p5                  ; AMT OF SIGNAL TO EFFECT
ainput    soundin   p6
          out       ainput*idry
gasend    =         gasend+ainput*iwet
          endin

          instr     2209                ; HARMONIZER WITH FEEDBACK
igain     =         p4                  ; OVERALL GAIN
idelay    =         p5                  ; N SECONDS DELAY
insemis   =         p6                  ; N SEMITONES TO SHIFT
ifeed     =         p7                  ; FEEDBACK FACTOR
ilfohz    =         p8                  ; LFO FREQ
ifract    =         insemis/12          ; FRACTION OF AN OCT
ibasehz   =         cpsoct(8)           ; MIDDLE C AS BASIS
inewhz    =         cpsoct(8+ifract)    ; DESIRED REL PITCH
iratio    =         inewhz/ibasehz      ; RATIO NEW HZ TO OLD
irate     =         (iratio-1)/idelay   ; SUBTRACT 1/1 SPEED
krate     init      irate               ; COPY TO KVAR
          if        (ilfohz==0) goto continue
krate     oscili    irate, ilfohz, 2    ; LFO SINE FN
continue:
kenv      linen     igain, .01, p3, .05 ; OVERALL ENV CONTROL
actl1     phasor    -irate              ; MOVING PHASE 1-0
agate1    tablei    actl1, 1, 1, 0, 1   ; TRIANGLE WINDOW FUNC
actl2     phasor    -irate, .5          ; PHASE OFFSET OF .5
agate2    tablei    actl2, 1, 1, 0, 1   ; TRIANGLE WINDOW FUNC
ajunk     delayr    idelay              ; ALLOC DELAY LINE
asig1     deltapi   actl1*idelay        ; 2 VARIABLE TAPS
asig2     deltapi   actl2*idelay        ; OFFSET 1/2 BUFF LEN
asig1     =         asig1*agate1        ; GATE TAP OUTPUTS
asig2     =         asig2*agate2        ; SEPARATELY
asum      =         asig1+asig2         ; AND SUM
ainput    =         gasend+asum*ifeed
          delayw    ainput
          out       asum*kenv           ; OVERALL ENVELOPE
gasend    =         0                   ; ZERO GLOBAL VARIABLE
          endin
