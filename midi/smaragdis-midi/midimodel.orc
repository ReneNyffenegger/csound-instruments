  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1
; A SEMITONE 2^(1/12)
  isem      =  .059463094

; GET MIDI NOTE
  inote     cpsmidi   

; GET PITCH BEND AND FIND THE 2 SEMITONE BEND CPS
  kpbend    pchbend   2 * isem * inote

; MOD WHEEL
  kmodw     midictrl  1

; CTL 6 FOR PAN SCALED TO 1
  kctl6     midictrl  6
  kctl6     =  kctl6 / 127

; CTL 4 FOR VIBRATO SPEED
  kctl4     midictrl  4
  kctl4     =  kctl4 / 127

; CTL 5 FOR MOD INDEX
  kctl5     midictrl  5
  kctl5     =  kctl5 / 127

; AFTER TOUCH SCALED TO 1
  kafter    aftouch   1

; Velocity
  ivel      veloc     

; Keyboard gate
  kgate     linenr    ivel / 127, 0, .5, .01

; LFO OSCILATOR
  klfo      oscil     kmodw * inote / 2400, 10 * kctl4, 1

; AUDIO OSCILATOR
  aoscm     oscil     1000 * kctl5, inote + kpbend, 1
  aosc      oscil     20000, inote + kpbend + klfo + aoscm, 1

; SET UP AND EXECUTE A LOWPASS FILTER
  ilofr     =  100
  ihifr     =  sr/2 - ilofr
  kafter    port      kafter, 2/kr
  afilt     tone      aosc, (kafter * ihifr) + ilofr
  aq        reson     aosc, (kafter * ihifr) + ilofr, 100

; MIXER AND OUTPUT
  aout      =  (afilt + aq/10)/10
            outs      aout * kgate * kctl6, aout * kgate * (1 - kctl6)
endin
