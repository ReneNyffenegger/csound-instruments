;*********************************************
; Physical Models 1                          *
; coded:        1/22/97 Hans Mikelson        *
;*********************************************

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

; KARPLUS STRONG ALGORITHM

instr 1

; FREQUENCY
  ifqc      =  cpspch(p5)

; AMPLITUDE ENVELOPE
  kampenv   linseg    0, .01, p4, p3-.02, p4, .01, 0

; INITIALIZE THE DELAY LINE WITH NOISE
  kinitenv  linseg    1, 1/ifqc, 1, 0, 0, p3-1/ifqc, 0
  arand     rand      1
  adline    delayr    1/ifqc

; FILTER THE DELAYED SIGNAL AND FEEDBACK INTO THE DELAY.
  afiltr    tone      adline, 2000
            delayw    afiltr+arand*kinitenv

; SCALE AND OUTPUT
            out       afiltr*kampenv

endin

; BASS PHYSICAL MODEL
instr 2

; INITIALIZATIONS
  ifqc      =  cpspch(p5)
  kcount    init      0
  abody1    init      0
  abody2    init      0
  adline    init      0

; ENVELOPES
;**********
; FILTER ENVELOPE
  kenvflt   linseg    0, .01, 1, p3-.11, 1, .1, 0

; THIS ENVELOPE LOADS THE STRING WITH A TRIANGLE WAVE.
  kenvstr   linseg    0, 1/ifqc/8, -p4/2, 1/ifqc/4, p4/2, 1/ifqc/8, 0, p3-1/ifqc, 0

; THIS ENVELOPE IS FOR THE BODY RESONANCE
  kenvres   linseg    0, .1, 1, p3-.1, 1

; DELAY LINE WITH FILTERED FEEDBACK
  afiltr    tone      adline, ifqc*ifqc/10
  adline    delay     afiltr + kenvstr, 1/ifqc

; RESONANCE OF THE BODY 
  abody1    reson     afiltr, 160, 40
  abody2    reson     afiltr, 80, 20

  aout      =  afiltr + .0001*kenvres*abody1 + .00004*kenvres*abody2
            out       aout * kenvflt
endin

; PERRY COOK'S SLIDE FLUTE

instr 3

  aflute1   init      0
  ifqc      =  cpspch(p5)
  ipress    =  p6
  ibreath   =  p7

; FLOW SETUP
  kenv1     linseg    0, .1, ipress, p3-.2, ipress, .1, 0 
  kenv2     linseg    0, .01, 1, p3-.02, 1, .01, 0

; THE VALUES MUST BE AROUND -1 AND 1 OR THE CUBIC WILL BLOW UP.
  aflow1    rand      1
  aflow1    =  aflow1 * kenv1

; .0356 CAN BE USED TO ADJUST THE "BREATH" LEVEL.
  asum1     =  ibreath*aflow1 + kenv1
  asum2     =  asum1 + aflute1*.4

; EMBOUCHURE DELAY SHOULD BE 1/2 THE BORE DELAY

  ax        delay     asum2, 1/ifqc/2 - 15/sr

  apoly     =  ax - ax*ax*ax
  asum3     =  apoly + aflute1*.4

  avalue    tone      asum3, 2000

; BORE THE BORE LENGTH DETERMINES PITCH.  SHORTER IS HIGHER.
  aflute1   delay     avalue, 1/ifqc - 15/sr

            out       avalue*p4*kenv2

endin

; JULIUS SMITH'S SINGLE REED INSTRUMENT

instr 4
  areedbell init      0
  ifqc      =  cpspch(p5)
  ifco      =  p7
                                             
; I GOT THE ENVELOPE FROM PERRY COOKE'S CLARINET.
  kenv1     linseg    0, .005, .55 + .3*p6, p3 - .015, .55 + .3*p6, .01, 0
  kenvibr   linseg    0, .1, 0, .9, 1, p3-1, 1    ; VIBRATO ENVELOPE

; SUPPOSEDLY HAS SOMETHING TO DO WITH REED STIFFNESS?
  kemboff   =  p8

; BREATH PRESSURE
  avibr     oscil     .1*kenvibr, 5, 3
  apressm   =  kenv1 + avibr

; REFLECTION FILTER FROM THE BELL IS LOWPASS.
  arefilt   tone      areedbell, ifco

; THE DELAY FROM BELL TO REED.
  abellreed delay     arefilt, 1/ifqc-15/sr

; BACK PRESSURE AND REED TABLE LOOK UP.
  asum2     =  - apressm -.95*arefilt - kemboff
  areedtab  tablei    asum2/4+.34, p9, 1, .5
  amult1    =  asum2 * areedtab

; FORWARD PRESSURE
  asum1     =  apressm + amult1

  areedbell delay     asum1, 1/ifqc-14/sr

  aofilt    atone     areedbell, ifco

            out       aofilt*p4

endin

instr 5             ; PERRY COOK'S CLARINET
  asum2     init      0
  abellreed init      0
  aout      init      0
  kenv1     linseg    0, .005, .55 + .3*p4, p3 - .015, .55 + .3*p4, .01, 0 

; REED SECTION
  apressm   =  kenv1
  arefilt   tone      abellreed, 1500
  asum2     =  (-.95)*arefilt - apressm 
  areedtab  tablei    asum2/4+.34, 1, 1, .5

  abellreed delayr    1/p5/2
            delayw    aout
  aout      delayr    1/p5/2
            delayw    apressm + areedtab*asum2

            out       aout*10000
endin

