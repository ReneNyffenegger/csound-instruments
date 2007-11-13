;*********************************************
; Physical Models 1                          *
; coded:        1/22/97 Hans Mikelson        *
;*********************************************

sr = 44100
kr = 4410
ksmps =  10
nchnls = 1

;Bass Physical Model
instr 2

; Initializations
  ifqc  = cpspch(p5)
  ipluck  =    1/ifqc*p6
  kcount  init 0
  adline  init 0
  ablock2 init 0
  ablock3 init 0
  afiltr  init 0
  afeedbk init 0

  koutenv linseg 0,.01,1,p3-.11,1,.1,0 ;Output envelope
  kfltenv linseg 0, 1.5, 1, 1.5, 0 

; This envelope loads the string with a triangle wave.
  kenvstr linseg 0,ipluck/4,-p4/2,ipluck/2,p4/2,ipluck/4,0,p3-ipluck,0

  aenvstr =     kenvstr
  ainput  tone  aenvstr,200

; DC Blocker
  ablock2 =     afeedbk-ablock3+.99*ablock2
  ablock3 =     afeedbk
  ablock  =     ablock2

; Delay line with filtered feedback
  adline  delay ablock+ainput,1/ifqc-15/sr
  afiltr  tone  adline,400

; Resonance of the body 
  abody1 reson afiltr, 110, 40
  abody1 =     abody1/5000
  abody2 reson afiltr, 70, 20
  abody2 =     abody2/50000

  afeedbk =     afiltr

  aout    =     afeedbk
          out 50*koutenv*(aout + kfltenv*(abody1 + abody2))

          endin

;Flute Instrument based on Perry Cook's Slide Flute

instr 3

  aflute1 init 0
  ifqc    = cpspch(p5)
  ipress  = p6
  ibreath = p7
  ifeedbk1= p8
  ifeedbk2= p9

; Flow setup
  kenv1   linseg 0, .06, 1.1*ipress, .2, ipress, p3-.16, ipress, .02, 0 
  kenv2   linseg 0, .01, 1, p3-.02, 1, .01, 0
  kenvibr linseg 0, .5, 0, .5, 1, p3-1, 1  ; Vibrato envelope

; The values must be approximately -1 to 1 or the cubic will blow up.
  aflow1 rand kenv1
  kvibr oscil .1*kenvibr, 5, 3

; ibreath can be used to adjust the noise level.
  asum1 = ibreath*aflow1 + kenv1 + kvibr
  asum2 = asum1 + aflute1*ifeedbk1

  afqc  = 1/ifqc - asum1/20000 -9/sr + ifqc/12000000

; Embouchure delay should be 1/2 the bore delay
;  ax delay asum2, (1/ifqc-10/sr)/2
  atemp1 delayr 1/ifqc/2
  ax     deltapi afqc/2 ; - asum1/ifqc/10 + 1/1000
         delayw asum2

  apoly = ax - ax*ax*ax
  asum3 = apoly + aflute1*ifeedbk2

  avalue tone asum3, 2000

; Bore, the bore length determines pitch.  Shorter is higher pitch.
   atemp2   delayr 1/ifqc
   aflute1 deltapi afqc
           delayw avalue

  out avalue*p4*kenv2

endin

; Clarinet Instrument based on Perry Cook's Clarinet

instr 4
  areedbell init 0
  ifqc  = cpspch(p5)
  ifco  = p7
  ibore = 1/ifqc-15/sr

; I got the envelope from Perry Cooke's Clarinet.
  kenv1   linseg 0, .005, .55 + .3*p6, p3 - .015, .55 + .3*p6, .01, 0
  kenvibr linseg 0, .1, 0, .9, 1, p3-1, 1  ; Vibrato envelope

; Supposedly has something to do with reed stiffness?
  kemboff = p8

; Breath Pressure
  avibr oscil .1*kenvibr, 5, 3
  apressm = kenv1 + avibr

; Reflection filter from the bell is lowpass.
  arefilt tone areedbell, ifco

; The delay from bell to reed.
  abellreed delay arefilt, ibore

; Back pressure and reed table look up.
  asum2 = - apressm -.95*arefilt - kemboff
  areedtab tablei asum2/4+.34, p9, 1, .5
  amult1 = asum2 * areedtab

; Forward Pressure
  asum1 = apressm + amult1

  areedbell delay asum1, ibore

  aofilt atone areedbell, ifco

  out aofilt*p4

endin

instr 8  ; Drum Stick 1

  gadrum init 0

; Frequency
  ifqc  = cpspch(p5)

; Initialize the delay line with noise
  ashape linseg 0, 1/ifqc/8, -1/2, 1/ifqc/4, 1/2, 1/ifqc/8, 0, p3-1/ifqc, 0
  gadrum tone ashape, p6

endin

instr 9  ; A square drum

  irt2     init sqrt(2)
  itube    init p7
  ifdbck1  init p8
  ifdbck2  init p9
  anodea   init 0
  anodeb   init 0
  anodec   init 0
  anoded   init 0
  afiltr   init 0
  ablocka2 init 0
  ablocka3 init 0
  ablockb2 init 0
  ablockb3 init 0
  ablockc2 init 0
  ablockc3 init 0
  ablockd2 init 0
  ablockd3 init 0

; Frequency
  ifqc  = cpspch(p5)
  ipfilt = p6

; Amplitude Envelope
  kampenv   linseg 0, .01, p4, p3-.02, p4, .01, 0

; Delay Lines
  alineab delay anodea+gadrum+afiltr, 1/ifqc
  alineba delay anodeb+gadrum+afiltr, 1/ifqc
  alinebc delay anodeb+gadrum+afiltr, 1/ifqc
  alinecb delay anodec+gadrum+afiltr, 1/ifqc
  alinecd delay anodec+gadrum+afiltr, 1/ifqc
  alinedc delay anoded+gadrum+afiltr, 1/ifqc
  alinead delay anodea+gadrum+afiltr, 1/ifqc
  alineda delay anoded+gadrum+afiltr, 1/ifqc
  alineac delay anodea+gadrum+afiltr, 1/ifqc*irt2
  alineca delay anodec+gadrum+afiltr, 1/ifqc*irt2
  alinebd delay anodeb+gadrum+afiltr, 1/ifqc*irt2
  alinedb delay anoded+gadrum+afiltr, 1/ifqc*irt2

; Filter the delayed signal and feedback into the delay.
; Implements DC blocking.
  ablocka1 = -(alineba + alineca + alineda)/ifdbck1
  ablocka2 = ablocka1 - ablocka3 + .99*ablocka2
  ablocka3 = ablocka1
  anodea   = ablocka2

; Node B
  ablockb1 = -(alineba + alineca + alineda)/ifdbck1
  ablockb2 = ablockb1 - ablockb3 + .99*ablockb2
  ablockb3 = ablockb1
  anodeb   = ablockb2

; Node C
  ablockc1 = -(alineba + alineca + alineda)/ifdbck1
  ablockc2 = ablockc1 - ablockc3 + .99*ablockc2
  ablockc3 = ablockc1
  anodec   = ablockc2

; Node D
  ablockd1 = -(alineba + alineca + alineda)/ifdbck1
  ablockd2 = ablockd1 - ablockd3 + .99*ablockd2
  ablockd3 = ablockd1
  anoded   = ablockd2

; Body resonance
  atube  delay anodea, itube/ifqc
  afiltr tone  atube, 1000
  afiltr = afiltr/ifdbck2

; Scale and output
  out anodea*kampenv*1000

endin

instr 10 ; Drum Stick 2

  gadrum2 init 0

; Frequency
  ifqc  = cpspch(p5)

; Initialize the delay line with noise
  ashape linseg 0, 1/ifqc/8, -1/2, 1/ifqc/4, 1/2, 1/ifqc/8, 0, p3-1/ifqc, 0
  gadrum2 tone ashape, p6

endin

instr 11 ; A square drum

  irt2     init sqrt(2)
  itube    init p7
  ifdbck1  init p8
  ifdbck2  init p9
  anodea   init 0
  anodeb   init 0
  anodec   init 0
  anoded   init 0
  afiltr   init 0
  ablocka2 init 0
  ablocka3 init 0
  ablockb2 init 0
  ablockb3 init 0
  ablockc2 init 0
  ablockc3 init 0
  ablockd2 init 0
  ablockd3 init 0

; Frequency
  ifqc  = cpspch(p5)
  ipfilt = p6

; Amplitude Envelope
  kampenv   linseg 0, .01, p4, p3-.02, p4, .01, 0

; Delay Lines
  alineab delay anodea+gadrum2+afiltr, 1/ifqc
  alineba delay anodeb+gadrum2+afiltr, 1/ifqc
  alinebc delay anodeb+gadrum2+afiltr, 1/ifqc
  alinecb delay anodec+gadrum2+afiltr, 1/ifqc
  alinecd delay anodec+gadrum2+afiltr, 1/ifqc
  alinedc delay anoded+gadrum2+afiltr, 1/ifqc
  alinead delay anodea+gadrum2+afiltr, 1/ifqc
  alineda delay anoded+gadrum2+afiltr, 1/ifqc
  alineac delay anodea+gadrum2+afiltr, 1/ifqc*irt2
  alineca delay anodec+gadrum2+afiltr, 1/ifqc*irt2
  alinebd delay anodeb+gadrum2+afiltr, 1/ifqc*irt2
  alinedb delay anoded+gadrum2+afiltr, 1/ifqc*irt2

; Filter the delayed signal and feedback into the delay.
; Implements DC blocking.
  ablocka1 = -(alineba + alineca + alineda)/ifdbck1
  ablocka2 = ablocka1 - ablocka3 + .99*ablocka2
  ablocka3 = ablocka1
  anodea   = ablocka2

; Node B
  ablockb1 = -(alineba + alineca + alineda)/ifdbck1
  ablockb2 = ablockb1 - ablockb3 + .99*ablockb2
  ablockb3 = ablockb1
  anodeb   = ablockb2

; Node C
  ablockc1 = -(alineba + alineca + alineda)/ifdbck1
  ablockc2 = ablockc1 - ablockc3 + .99*ablockc2
  ablockc3 = ablockc1
  anodec   = ablockc2

; Node D
  ablockd1 = -(alineba + alineca + alineda)/ifdbck1
  ablockd2 = ablockd1 - ablockd3 + .99*ablockd2
  ablockd3 = ablockd1
  anoded   = ablockd2

; Body resonance
  atube  delay anodea, itube/ifqc
  afiltr tone  atube, 1500
  afiltr = afiltr/ifdbck2

; Scale and output
  out anodea*kampenv*1000

endin
