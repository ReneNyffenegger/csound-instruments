;    1IN1OUT.ORC
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gasig     init      0

instr          1
;  INSTRUMENT SETUPS
;         DURATION TABLES
;  TABLE FOR SOUNDIN.# IN ATTACK MODULE
  i1        table     p4, 50

;  INITIALIZE THE AUDIO SIGNALS
  asig1     init      0

; RESET VALUE OF P3 HERE
; MAKE P60 THE SWITCH.  IF ANYTHING IS THERE, THEN DON'T CHANGE P3.
; OTHERWISE, CHOOSE THE LONGEST OF THE SOUNDFILES TO REPRESENT P3.
if             p60 > 0   igoto nochange
  p3        =  (i1 > p3? i1 : p3)
nochange:

; ATTACK MODULE - p4:soundfile, p5:ampfac, p6:attack, p7:decay, p8:skip
;  p9:delay (not implemented yet)
;  SWITCH TO SKIP THIS MODULE: (p10)
if             p10 == 1  goto skipatt
;
;  ENVELOPE
  k1        envlpx    p5,p6,(p60 == 1? p3: i1),p7,1,.9,.01

;  AUDIO SIGNAL - READ IN SOUNDFILE
  asig1     soundin   p4,p8

;  FILTER SIGNAL? (0? SKIP FILTER)
if             p11 == 0  goto nofilter

;  USE TABLES? (2? YES)
if             p11== 2   goto usetables
  i2        =  p12
  i3        =  p13
            print     i2
            print     i3
            goto      dofilter

usetables:
;  TABLE FOR CENTER FREQUENCY FOR BANDPASS FILTER
  i2        table     p4, p12
            print     i2
;
;  TABLE FOR BANDWIDTH OF BANDPASS FILTER
  i3        table     p4, p13
            print     i3

dofilter:
  ares1     reson     asig1,i2, i3, 1
  asig1     balance   ares1, asig1

nofilter:
  asig      =  k1 * asig1

skipatt:

; OUTPUT
;  SWITCH TO PUT OUT SIGNAL OR SEND IT ON FOR PROCESSING
if p61         ==        0 goto sendout
  gasig     =  gasig + asig
            igoto     done
sendout:
            out       asig
done:

endin

