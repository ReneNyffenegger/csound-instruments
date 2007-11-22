
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
                    ;SORT OF KARPLUS-STRONG STRING

  idamp     =  5000
  ipitch    cpsmidib  
  iperiod   =  1000.0/ipitch
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

     ;Simple waveguide plucked string model.  Not worth looking over!

  aimpl     oscilx    10000, ipitch/2, 1, 1       ;Initial state of string 
  aimpr     oscilx    10000, ipitch/2, 2, 1

;kpitch   oscil     ipitch, 1/p3, 3
  kpitch    =  ipitch

  anrefl    tone      aimpl - aright, idamp       ;Reflect on nut
  aoutn     atone     anrefl, idamp               ;Pick sound from nut
  aleft     vdelay    anrefl, 500/kpitch, 1000    ;Go to bridge
  abrefl    tone      aimpr - aleft, idamp        ;Reflect on bridge
  aoutb     atone     abrefl, idamp               ;Pick sound from bridge
  aright    vdelay    abrefl, 500/kpitch, 1000    ;Go back to the nut
            outs      aoutn*isc, aoutb*isc
endin

instr 3
                    ;WAVEGUIDE CLARINET 

     ; Interesting points in the extended Csound implementation:
     ; The "am" factor for ipmax = 10 takes small values like .005 - .02.
     ; If the value is small (.005) then the reed takes more time to respond
     ; to the mouth pressure.  For values bigger than .03 strange things happen.
     ; I will assume that they are multiphonics or some overflow of air.
     ; If "ipmax" is lowered then these numbers change.  "ipmax" does not need 
     ; values much bigger than 10 since overflow and feedback show up.
     ; "am" and" "ipmax" determine reed stiffness and embrochure  ( how tight
     ; the reed is pressed by the player).
     ; "idamp" according to my acoustics book should be between 1400Hz to 2000Hz.
     ; 1000Hz sounds fine to me!
     ; For some reason pitch is in the wrong octave.  I try to bring it up by
     ; multiplying it by 2 but I thing it's still off.
     ; "a growl" is a simple simulation of the growling sax players do to get
     ; multiphonics.  If "agrowl" is used with "am" equal to .03 and a low 
     ; cuttof frequency for the bell I get a harmonic.
     ; In MIT's Csound implementation the instrument behaves and sounds much different.
     ; The harmonic trick does not work and the cutoff frequency sounds good at 1800Hz.


     ;    INIT SECTION

  idamp     =  1500                               ;Determines brightness of clarinet
  ipmax     =  10                                 ;Max mouth pressure
  ivol      =  1000                               ;Bring to audible level factor
  apbp      init      0                           ;Init the returning pressure wave

     ;    CONTROL SECTION
  ipitch    cpsmidi   

  kpm       midictrl  10, 0, ipmax
  kpm       =  ipmax
  apm       =  kpm
  apm       tone      apm, 2

  am        =  .01                                ;Embrochure/reed stiffness factor
  km        midictrl  8, 0.005, .03
  am        =  km

  krand     rand      1                           ;Random element
  krand     port      krand, 1/kr
  apm       =  apm - (krand * ipmax)/10

  kvs       midictrl  1, 0, 1                     ;Simple time varying vibrato
  kpitch    oscil     kvs*3, kvs*7, 4
  kbend     =  0
  kpitch    =  ipitch - kpitch                    ; + kbend + krand * 50

  kgr       midictrl  11, 0, 1
  agrowl    oscil     apm * kgr, 20, 5            ;Growling
  apm       =  apm * (1 - kgr) + agrowl

     ;         WAVEGUIDE STARTS HERE
     ;
     ; The ugly variable names mean:
     ;
     ; apdp:             Closed reed pressure drop
     ; apbp, apbm:       Traveling pressure waves
     ; atr:              Reed responce to pressure
     ; abell:            Pressure wave at bell
     ; arefl:            Reflected pressure wave at bell
     ; aout:             Output from bell

  apdp      =  2*apbp - apm
  atr       =  1 - am*(apdp - ipmax)
  apbm      =  apm/2 + atr * apdp/2               ;Start from reed
     
  abell     vdelay    apbm, 500/kpitch, 1000      ;Go to bell
  arefl     tone      -abell, idamp               ;Damp/reflect on bell
  aout      atone     abell, idamp                ;Get out of bell
  apbp      vdelay    arefl, 500/kpitch, 1000     ;Go back to reed

            outs      aout*ivol, aout*ivol        ;Give it to me!
endin
