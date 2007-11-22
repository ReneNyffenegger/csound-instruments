  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr 1
                    ;SORT OF KARPLUS-STRONG STRING

  idamp     =  5000
  ipitch    =  440
  iperiod   =  1000/ipitch
  isc       =  100
  afeed     init      0

  aimpl     oscilx    10000, ipitch, 1, 1
     
  arefl     tone      aimpl + afeed, idamp
  aout      atone     arefl, idamp
  afeed     vdelay    arefl, iperiod, 1000
            outs      aout*isc, aout*isc
endin

instr 2
                    ;WAVEGUIDE PLUCKED STRING

  idamp     =  4000
  ipitch    =  440
  isc       =  50
  aright    init      0
  aleft     init      0

;SIMPLE WAVEGUIDE PLUCKED STRING MODEL.  NOT WORTH LOOKING OVER!

  aimpl     oscilx    10000, ipitch/2, 1, 1       ;INITIAL STATE OF STRING 
  aimpr     oscilx    10000, ipitch/2, 2, 1

;kpitch   oscil     ipitch, 1/p3, 3
  kpitch    =  ipitch

  anrefl    tone      aimpl - aright, idamp       ;REFLECT ON NUT
  aoutn     atone     anrefl, idamp               ;PICK SOUND FROM NUT
  aleft     vdelay    anrefl, 500/kpitch, 1000    ;GO TO BRIDGE
  abrefl    tone      aimpr - aleft, idamp        ;REFLECT ON BRIDGE
  aoutb     atone     abrefl, idamp               ;PICK SOUND FROM BRIDGE
  aright    vdelay    abrefl, 500/kpitch, 1000    ;GO BACK TO THE NUT
            outs      aoutn*isc, aoutb*isc
endin

instr 3
                    ;WAVEGUIDE CLARINET 

; INTERESTING POINTS IN THE EXTENDED CSOUND IMPLEMENTATION:
; THE "AM" FACTOR FOR IPMAX = 10 TAKES SMALL VALUES LIKE .005 - .02.
; IF THE VALUE IS SMALL (.005) THEN THE REED TAKES MORE TIME TO RESPOND
; TO THE MOUTH PRESSURE.  FOR VALUES BIGGER THAN .03 STRANGE THINGS HAPPEN.
; I WILL ASSUME THAT THEY ARE MULTIPHONICS OR SOME OVERFLOW OF AIR.
; IF "IPMAX" IS LOWERED THEN THESE NUMBERS CHANGE.  "IPMAX" DOES NOT NEED 
; VALUES MUCH BIGGER THAN 10 SINCE OVERFLOW AND FEEDBACK SHOW UP.
; "AM" AND" "IPMAX" DETERMINE REED STIFFNESS AND EMBROCHURE  ( HOW TIGHT
; THE REED IS PRESSED BY THE PLAYER).
; "IDAMP" ACCORDING TO MY ACOUSTICS BOOK SHOULD BE BETWEEN 1400HZ TO 2000HZ.
; 1000HZ SOUNDS FINE TO ME!
; FOR SOME REASON PITCH IS IN THE WRONG OCTAVE.  I TRY TO BRING IT UP BY
; MULTIPLYING IT BY 2 BUT I THING IT'S STILL OFF.
; "A GROWL" IS A SIMPLE SIMULATION OF THE GROWLING SAX PLAYERS DO TO GET
; MULTIPHONICS.  IF "AGROWL" IS USED WITH "AM" EQUAL TO .03 AND A LOW 
; CUTTOF FREQUENCY FOR THE BELL I GET A HARMONIC.
; IN MIT'S CSOUND IMPLEMENTATION THE INSTRUMENT BEHAVES AND SOUNDS MUCH DIFFERENT.
; THE HARMONIC TRICK DOES NOT WORK AND THE CUTOFF FREQUENCY SOUNDS GOOD AT 1800HZ.


;         INIT SECTION

  idamp     =  1200                               ;DETERMINES BRIGHTNESS OF CLARINET
  ipitch    =  4*cpspch( p4)                      ;PITCH (SOMETHING'S WRONG HERE! BUT IT WORKS)
  ipmax     =  10                                 ;MAX MOUTH PRESSURE
  ivol      =  1000                               ;BRING TO AUDIBLE LEVEL FACTOR
  apbp      init      0                           ;INIT THE RETURNING PRESSURE WAVE

;         CONTROL SECTION
  apm       linseg    0, p3/2, ipmax, p3/8, 0, 3*p3/8, 0 ;MOUTH PRESSURE

;apm      linseg    0, .2, ipmax, .5, ipmax/2, p3-.7, 0

  am        =  .01                                ;EMBROCHURE/REED STIFFNESS FACTOR
;am       linseg    .05, .02,.02, p3-.02, .02 

  krand     rand      1                           ;RANDOM ELEMENT
  krand     port      krand, 1/kr
  apm       =  apm - (krand * ipmax)/10

  kvs       line      0, p3, 1                    ;SIMPLE TIME VARYING VIBRATO
  kpitch    oscil     kvs*p6, kvs*5, 4
;kbend    oscil     1000, 1/p3, p5
  kbend     =  0
  kpitch    =  ipitch - kpitch + kbend + krand * 50
;agrowl   oscil     apm, .5, 5                         ;GROWLING
;apm      =         agrowl

;         WAVEGUIDE STARTS HERE
;
; THE UGLY VARIABLE NAMES MEAN:
;
; apdp:             Closed reed pressure drop
; apbp, apbm:  Traveling pressure waves
; atr:              Reed responce to pressure
; abell:       Pressure wave at bell
; arefl:       Reflected pressure wave at bell
; aout:             Output from bell

  apdp      =  2*apbp - apm
  atr       =  1 - am*(apdp - ipmax)
;atr      reed      apdp, ipmax, am          ;MY REED OPCODE (NOT USED NOW)
  apbm      =  apm/2 + atr * apdp/2               ;START FROM REED

  abell     vdelay    apbm, 500/kpitch, 1000      ;GO TO BELL
  arefl     tone      -abell, idamp               ;DAMP/REFLECT ON BELL
  aout      atone     abell, idamp                ;GET OUT OF BELL
  apbp      vdelay    arefl, 500/kpitch, 1000     ;GO BACK TO REED

            outs      aout*ivol, aout*ivol        ;GIVE IT TO ME!
endin
