  sr        =  44100
  kr        =  44100
  ksmps     =  1
            zakinit   3,3
        
instr 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Midi controlled Acoustic Guitar
; commuted waveguide synthesis
; cubic interp. for fractional delays (*deltap3*)
; Guitar loop filter from Tero Tolonen (*filter2*)
; Impulse response from Dr. Julius Smith 
; implemented by Josep M Comajuncosas / Aug´98-Sept´2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; yet to do :
; compensation yet for the phase delay induced by the loop filter
; transient eliminator for the variable delays caused by pitchbend
; quick way to overcome this : use a pitchshifter external to the model
; also removed the interpolator for a better sound (the pitch error is ok with that chorus!)
  ipi       =  3.141592654

;MIDI setup
  iampn     ampmidi   1                           ;                     normalised amplitude
  kmp       linsegr   1, 10, 1, .04 ,0            ;        add some release to MIDI event

  ifreq     cpsmidi                               ;                       base pitch
  kfreq     cpsmidib  2                           ;                    continuous pitch

;kfreq tonek kfreq,10;ERROR però és genial!!!

;PERFORMANCE setup
  iamp      =  8000                               ;                        expected maximum output amplitude
  ipluck    gauss     .45*(1-iampn)               ;          pluck point (at your taste)
  ipluck    =  ipluck + .5*(1-iampn)

;STRING setup
  iatt2     =  .996                               ;                      attenuation
  ifco2     =  -.058                              ;                     freq dependent decay 

;MODEL : excitacion/IR->lowpass->comb->main waveguide->pitch shifter->sound output

; IR of the body used as the string excitation signal
  anoise    loscil3   1, sr/ftlen(4), 4, sr/ftlen(4),0,0,ftlen(4),0,0,ftlen(4)

; lowpass filter the excitation signal at low amplitude levels
  anoise    butterlp  anoise,sr/3*iampn^2         ; tune this at your own taste

; filtering caused by plucking point
  acomb     delay     anoise, ipluck*(1/ifreq)
  anoize    =  anoise - acomb

; Main Waveguide : main delay->allpass->lowpass
; Non commutable model but, just experimenting... :)

  idlt2     init      1/ifreq
  awgout2   init      0
  awg2      init      0

  atemp2    delayr    1/20
  awg20     deltapn   int(idlt2*kr)

;allpass filter
  ifrqap1   exprand   1-iampn
  ifrqap1   =  (5000)*ifrqap1

  ilimit1   =  (1-ipi*ifrqap1/sr)/(1+ipi*ifrqap1/sr)
  kdel1     downsamp  awg20
  klimit1   =  ilimit1
  ax1       delay1    awg20
  awg2      =  klimit1 * (awg20 + awg2) - ax1

;lowpass filter
  alpf2     filter2   awg2, 1, 1, 1+ifco2, ifco2
  awgout2   =  iatt2*alpf2

  ainput    =  anoize
            delayw    ainput+awgout2              ;write into delay line 2
  aout      =  awgout2

;pitch shifter (uncommented, included in the Csound docs.)
  kfreqsh   =  kfreq - ifreq
  ain       =  aout
  areal, aimag hilbert  ain 
  asin      oscili    1, kfreqsh, 1 
  acos      oscili    1, kfreqsh, 1, .25 
  amod1     =  areal * acos 
  amod2     =  aimag * asin 
  aout2     =  (amod1 + amod2) * 0.7 

; sound output
  aout      =  iamp*iampn*kmp*aout2
  abody1    resonz    aout,105,80,1
  abody2    resonz    aout,230,100,1
  aout1     =  aout+abody1+abody2
            out       aout1
            zawm      aout1,1
endin

instr 27
;----------------------------------------------------------------------------------
; body resonances
;----------------------------------------------------------------------------------
  asig0     zar       1
;asig convolve .05*asig0,"guitar.cv"
;out asig0
            zacl      0,2
endin
