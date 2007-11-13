 sr = 44100
 kr = 2205
 ksmps = 20
 nchnls = 1

 instr 1
 kamp envlpx p5,  p6,  p3,  p7,  1,  p8,  .01 ; amplitude envelope
 ; ==== get source audio signal, determined by p9 =======
 if p9 > 0 goto pulse    ; if p9 is 0, use white noise for audio source signal
   asource  rand  kamp   ; white noise source signal
 goto filter
   ; - - - - - - - - - - -
 pulse:
 if p9 = 2 goto soundfile
 ;      if p9 = 1 , generate a pulse train source signal :
  ipitch = cpspch(p4)  ; pitch for buzz
  if ipitch > 500 igoto hinote ;setting number of harmonics in buzz -
    iharmonics = 20            ; use 20 harmonics for pitches below Bb4
    igoto makebuzz
  hinote:
    iharmonics = int((sr*.5)/ipitch) ;for higher pitches, as many partials as
                                     ;possible up to the nyquist frequency
   makebuzz:
   asource  buzz  kamp, ipitch, iharmonics, 100 ; pulse train source signal
   goto filter
   ; - - - - - - - - - - -
 soundfile:          ; if p9 = 2, use soundfile for source audio signal
   asource  soundin  p12 , p13
   asource = asource * (kamp/32767)  ; impose new envelope on soundfile
 ; - - - - - - - - - - -

 filter:
 ;FILTER CENTER FREQUENCIES & RELATIVE AMPS. FROM FUNCTIONS 80-87, 90-94
 iformant1 table 0, p10   ; 1st formant frequency
 iformant2 table 1, p10   ; 2nd   "   "   "
 iformant3 table 2, p10   ; 3rd   "   "   "
 iformant4 table 3, p10   ; 4th   "   "   "
 iformant5 table 4, p10   ; 5th   "   "   "
 iamp1 table 5, p10  ; relative amplitude of 1st formant
 iamp2 table 6, p10  ;    "    "    "    "   2nd
 iamp3 table 7, p10  ;    "    "    "    "   3rd
 iamp4 table 8, p10  ;    "    "    "    "   4th
 iamp5 table 9, p10  ;    "    "    "    "   5th

 ;  5 BANDPASS FILTERS TO SUPPLY THE 5 FORMANTS
 a2 reson iamp1*asource, iformant1, 1.2*p11  * iformant1,1
 a3 reson iamp2*asource, iformant2, 1.05*p11 * iformant2,1
 a4 reson iamp3*asource, iformant3,  .9*p11  * iformant3,1
 a5 reson iamp4*asource, iformant4,  .8*p11  * iformant4,1
 a6 reson iamp5*asource, iformant5,  .7*p11  * iformant5,1
 aformants  = a2 + a3 + a4 + a5 + a6
 aout  balance aformants, asource ; restore amplitude lost in filtering
   out aout
 endin

