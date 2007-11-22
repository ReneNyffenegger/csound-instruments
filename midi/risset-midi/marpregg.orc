;================ARPEGGIO.O=================
;THIS INSTRUMENT, DESIGNED BY RISSET, PRODUCES AN ARPEGGIATION IN THE
;HARMONIC SERIES.  ONE CAN HEAR VERY CLEARLY THE INDIVIDUAL HARMONICS
;COME INTO PHASE.  THE PHENOMENON OF BEATING IS AGAIN THE MEANS FOR
;DOING THIS.  SEE THE RELAVENT PASSAGE IN CHAPTER 3 (PP. 101-102) DODGE.

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01

;P4 = FREQ OF FUNDAMENTAL (HZ)
;P5 = AMP
;P6 = INITIAL OFFSET OF FREQ - .03 HZ

;INIT VALUES CORRESPOND TO FREQ. OFFSETS FOR OSCILLATORS BASED ON ORIGINAL p6

;i1 = p6
  i1        =  .09
;i2 = 2*p6
  i2        =  2*.09
;i3 = 3*p6
  i3        =  3*.09
;i4 = 4*p6
  i4        =  4*.09

;ampenv        linen          p5,.01,p3,.02       ;A SIMPLE ENVELOPE TO PREVENT CLICKING.
  ampenv    linen     2500,.01,10,.02

;a1            oscili         ampenv,p4,1         ;NINE OSCILLATORS WITH THE SAME AMPLITUDE ENV
  a1        oscili    ampenv,knote,1
;a2            oscili         ampenv,p4+i1,1      ;AND WAVEFORM, BUT SLIGHTLY DIFFERENT
  a2        oscili    ampenv,knote+i1,1
;a3            oscili         ampenv,p4+i2,1      ;FREQUENCIES TO CREATE THE BEATING EFFECT
  a3        oscili    ampenv,knote+i2,1
;a4            oscili         ampenv,p4+i3,1
  a4        oscili    ampenv,knote+i3,1
;a5            oscili         ampenv,p4+i4,1
  a5        oscili    ampenv,knote+i4,1
;a6            oscili         ampenv,p4-i1,1
  a6        oscili    ampenv,knote-i1,1
;a7            oscili         ampenv,p4-i2,1
  a7        oscili    ampenv,knote-i2,1
;a8            oscili         ampenv,p4-i3,1
  a8        oscili    ampenv,knote-i3,1
;a9            oscili         ampenv,p4-i4,1
  a9        oscili    ampenv,knote-i4,1

            out       (a1+a2+a3+a4+a5+a6+a7+a8+a9)*kgate
endin

