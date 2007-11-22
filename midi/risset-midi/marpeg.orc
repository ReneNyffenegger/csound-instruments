;================ARPEGGIO.O=================
;THIS INSTRUMENT, DESIGNED BY RISSET, PRODUCES AN ARPEGGIATION IN THE
;HARMONIC SERIES.  ONE CAN HEAR VERY CLEARLY THE INDIVIDUAL HARMONICS
;COME INTO PHASE.  THE PHENOMENON OF BEATING IS AGAIN THE MEANS FOR
;DOING THIS.  SEE THE RELAVENT PASSAGE IN CHAPTER 3 (PP. 101-102) DODGE.

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

            massign   1,1

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,1,2,.01

;p4 = FREQ OF FUNDAMENTAL (HZ)
;p5 = AMP
;p6 = INITIAL OFFSET OF FREQ - .03 HZ

;INIT VALUES CORRESPOND TO FREQ. OFFSETS FOR OSCILLATORS BASED ON ORIGINAL P6

  i1        =  .03
  i2        =  2*.03
  i3        =  3*.03
  i4        =  4*.03

  ampenv    linenr    2500,.01,1,.01              ;A SIMPLE ENVELOPE TO PREVENT CLICKING.

  a1        oscili    ampenv,knote,1              ;NINE OSCILLATORS WITH THE SAME AMPLITUDE ENV
  a2        oscili    ampenv,knote+i1,1           ;AND WAVEFORM, BUT SLIGHTLY DIFFERENT
  a3        oscili    ampenv,knote+i2,1           ;FREQUENCIES TO CREATE THE BEATING EFFECT
  a4        oscili    ampenv,knote+i3,1
  a5        oscili    ampenv,knote+i4,1
  a6        oscili    ampenv,knote-i1,1
  a7        oscili    ampenv,knote-i2,1
  a8        oscili    ampenv,knote-i3,1
  a9        oscili    ampenv,knote-i4,1

            outs      (a1+a2+a3+a4+a5+a6+a7+a8+a9)*kgate,(a1+a2+a3+a4+a5+a6+a7+a8+a9)*kgate
  ga1       =  a1+a2+a3+a4+a5+a6+a7+a8+a9*kgate
endin

