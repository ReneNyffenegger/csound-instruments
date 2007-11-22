
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1                     ;WAVEGUIDE CLARINET 

; INTERESTING POINTS IN THE EXTENDED CSOUND IMPLEMENTATION:
; THE "AM" FACTOR FOR IPMAX = 10 TAKES SMALL VALUES LIKE .005 - .02.
; IF THE VALUE IS SMALL (.005) THEN THE REED TAKES MORE TIME TO RESPOND
; TO THE MOUTH PRESSURE.         FOR VALUES BIGGER THAN .03 STRANGE THINGS HAPPEN.
; I WILL ASSUME THAT THEY ARE MULTIPHONICS OR SOME OVERFLOW OF AIR.
; IF "IPMAX" IS LOWERED THEN THESE NUMBERS CHANGE.  "IPMAX" DOES NOT NEED 
; VALUES MUCH BIGGER THAN 10 SINCE OVERFLOW AND FEEDBACK SHOW UP.
; "AM" AND" "IPMAX" DETERMINE REED STIFFNESS AND EMBROCHURE      ( HOW TIGHT
; THE REED IS PRESSED BY THE PLAYER).
; "IDAMP" ACCORDING TO MY ACOUSTICS BOOK SHOULD BE BETWEEN 1400HZ TO 2000HZ.
; 1000HZ SOUNDS FINE TO ME!
; FOR SOME REASON PITCH IS IN THE WRONG OCTAVE.  I TRY TO BRING IT UP BY
; MULTIPLYING IT BY 2 BUT I THING IT'S STILL OFF.
; "AGROWL" IS A SIMPLE SIMULATION OF THE GROWLING SAX PLAYERS DO TO GET
; MULTIPHONICS.  IF "AGROWL" IS USED WITH "AM" EQUAL TO .03 AND A LOW 
; CUTTOF FREQUENCY FOR THE BELL I GET A HARMONIC.
; IN MIT'S CSOUND IMPLEMENTATION THE INSTRUMENT BEHAVES AND SOUNDS MUCH DIFFERENT.
; THE HARMONIC TRICK DOES NOT WORK AND THE CUTOFF FREQUENCY SOUNDS GOOD AT 1800HZ.


;          INIT SECTION

  idamp     =  1000                               ; Determines brightness of clarinet
  ipitch    =  4*cpspch(p4)                       ; Pitch (Something's wrong here! But it works)
  ipmax     =  10                                 ; Max mouth pressure
  ivol      =  1000                               ; Bring to audible level factor
  apbp      init      0                           ; Init the returning pressure wave

;               CONTROL SECTION

  apm       linseg    0, p3/2, ipmax, p3/2, 0     ; Mouth pressure
    
  am        =  .01                                ; Embrochure/reed stiffness factor

  krand     rand      1                           ; Random element
  krand     port      krand, 1/kr
  apm       =  apm - (krand * ipmax)/10

  kvs       line      0, p3, 1                    ; Simple time varying vibrato
  kpitch    oscil     kvs*50, kvs*5, 3
  kpitch    =  ipitch - kpitch + krand * 50
  agrowl    oscil     apm, 100, 4                 ; Growling
  apm       =  apm + agrowl

;agrowl         soundin         4,0,4                                           ; Resonating a Soundfile
;apm            =                       agrowl

;          WAVEGUIDE STARTS HERE

; The ugly variable names mean:

; apdp:                         Closed reed pressure drop
; apbp, apbm:                   Traveling pressure waves
; atr:                          Reed responce to pressure
; abell:                                Pressure wave at bell
; arefl:                                Reflected pressure wave at bell
; aout:                         Output from bell

  apdp      =  2*apbp - apm
  atr       =  1 - am*(apdp - ipmax)
;atr            reed                    apdp, ipmax, am                         ; My reed opcode (not used now)
  apbm      =  apm/2 + atr * apdp/2               ; Start from reed

;               MIT CSOUND IMPLEMENTATION (no vibrato and pitch bends)

;abell          delay            apbm, .5/ipitch                                ; Go to bell
;arefl          tone                    -abell, idamp                                   ; Damp/reflect on bell
;aout           atone            abell, idamp                                   ; Get out of bell
;apbp           delay            arefl, .5/ipitch                               ; Go back to reed
    

;               EXTENDED CSOUND IMPLEMENTATION

  abell     vdelay    apbm, 500/kpitch, 1000      ; Go to bell
  arefl     butterlp  -abell, idamp               ; Damp/reflect on bell
  aout      butterhp  abell, idamp                ; Get out of bell
  apbp      vdelay    arefl, 500/kpitch, 1000     ; Go back to reed

            outs      aout*ivol, aout*ivol        ; Give it to me!
endin

;   Hi! Mike.   This is my Csound implementation of the clarinet waveguide.      Some of the 
;   opcodes I use are mine.  vdelay is my variable delay, it takes time in sec/1000
;   its last argument is max time.       Butterlp/hp are lo/hi-pass Butterworths.  It is 
;   setup now to run in MIT's Csound but is doesn't work and sound as well.  You'll notice
;   that I don't use any tricky math to get the reed moving.  I got most of it from
;   J. Smith's STAN-M-39 report.  If you don't have it you should get it, since he explains
;   most of the tricky parts.    It is a 1987 paper so he is not as secretive about waveguides
;   as he is now.  For the Csound implementation the lookup table might be useless since
;   it has to be huge and computing it in real time is not so slow.  The equation is:

;                          {      1, for hd <= hdc
;        reed( hd) = {
;                          {      1 - m * ( hd - hdc), for hd > hdc

;        m and hdc correspond to embrochoure and reed stiffness
;        hd is the pressure difference corresponding to the reed closure
;
;   This is a simple and fast implementation for C.  My Csound implementation does not
;   use this exactly, because I can't have if-then on audio rate.  The reason you got into
;   all the strange math might be that you are using velocity, force or energy density
;   waves, or that you have a more exact reed simulation.  This formula is an aproximation
;   since it does not include bernoulli's force or some other not so significant factors.
;   I'd like to see what you have.       You can also find some reed equations in the winter 
;   92 computer music journal.  I also have a few things on lip simulation for brass.

;   I hope I helped!
;   Paris.
;   ps. I'm also getting ready the bowed string and brass model.
