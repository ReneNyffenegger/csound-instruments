  sr        =  44100
  kr        =  44100
  ksmps     =  1

instr 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Midi controlled Acoustic Guitar
; commuted waveguide synthesis
; linear interp. for fractional delays (*biquad*) by now...
; Guitar loop filter from Tero Tolonen (*filter2*)
; Impulse response from Dr. Julius Smith 
; implemented by Josep M Comajuncosas / Aug´98-Feb´99
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; note there is no compensation yet
; for the phase delay induced by the loop filter.
; Anyway the guitar is not terribly out of tune ;-)

; Model parameters : better not touch them !
  iatt1     =  .996                               ;  attenuation
  ifco1     =  -.058                              ; freq dependent decay

  iatt2     =  .992                               ;  attenuation
  ifco2     =  -.053                              ; freq dependent decay 
  ichorus   =  1.002                              ; detuning factor ~1

  iamp      =  8000                               ;expected maximum output amplitude

; MIDI setup
  ifrequency   pchmidi  
            print     ifrequency                  ; displays current note being played
  ifreq     cpsmidi   

  iampn     ampmidi   1                           ;normalised amplitude
            print     iampn

  ipluck    =  .5*(1.05-iampn)                    ;    pluck point (dependent on note loudness)
 
  kmp       linsegr   1, 10, 1, .04 ,0            ; add some release

  kfreq     cpsmidib                              ;+ range in semitones (+-2?)

;table lookup for fine tuning up to .08*sr (about 3500Hz at sr=44100, enough for a guitar)
;kfreqn = kfreq/sr
;kfreqncorr tablei kfreqn/.08,2,1,0,0
;kfreq = kfreq*kfreqncorr

  kdlt1     =  1/kfreq
  kdlt2     =  kdlt1/ichorus

;calculations for fractional delay interpolation filter
;delay time *in samples* (integer)
  kdltn1    =  int(sr*kdlt1)
  kdltn2    =  int(sr*kdlt2)
;remainig fractional delay *in fractions of a sample*
  kdltf1    =  frac(sr*kdlt1)                     ;note than time=int(time)+frac(time) ;-)
  kdltf2    =  frac(sr*kdlt2)

;string excitation (single impulse) convolved w.IR of the body
;= IR of the body of course...

  knoise    oscil1i   0, 1, ftlen(3)/sr, 3
  anoise    upsamp    knoise

; lowpass filter the excitation signal
; at low amplitude levels
  anoise    butterlp  anoise,iampn*iampn*sr/2     ; tune this at your own taste

; filtering caused by plucking point

  acomb     delay     anoise, ipluck*ifreq
  anoize    =  anoise - acomb

; Set waveguide 
; w. Loop filter and Fractional delay filter
; 2 parallel structures to simulate coupling of vertical & horizontal polarisations

  awgout1   init      0
  awgout2   init      0

  ainput    =  anoize

  imp       =  .5
  ainput1   =  ainput*imp
  ainput2   =  ainput*(1-imp)

  atemp1    delayr    1/20
  awg1      deltapn   kdltn1
  alpf1     filter2   awg1, 1, 1, 1+ifco1, ifco1
  afdf1     biquad    alpf1, 1-kdltf1, kdltf1,0,1,0,0
  awgout1   =  iatt1*afdf1
            delayw    ainput1+awgout1

  igc       =  .01

  atemp2    delayr    1/20
  awg2      deltapn   kdltn2
  alpf2     filter2   awg2, 1, 1, 1+ifco2, ifco2
  afdf2     biquad    alpf2, 1-kdltf2, kdltf2,0,1,0,0
  awgout2   =  .97*iatt2*alpf2
            delayw    ainput2+igc*awgout1+awgout2

  ainput2   =  awgout2

  imo       =  .5

  aout      =  imo*awgout1 + (1-imo)*awgout2

;sound output
            out       iamp*iampn*kmp*aout

endin