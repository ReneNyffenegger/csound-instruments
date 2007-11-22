  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
; p4     = amplitude of output wave
; p5     = carrier frequency in Hz
; p6     = modulating frequency in Hz
; p7     = modulation index 1
; p8     = modulation index 2
; p9     = carrier envelope function
; p10 = modulator envelope function

  i1        =  1/p3                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7 * p6                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8-p7) * p6                       ; CALCULATES DEVIATION FOR INDEX 2
                                                                        
  ampcar    oscil     p4,i1,p9                    ; AMP ENVELOPE FOR THE CARRIER
  ampmod    oscil     i3,i1,p10                   ; AMP ENVELOPE FOR THE MODULATOR
                
  amod      oscili    ampmod+i2,p6,1              ; MODULATING OSCILLATOR
  asig      oscili    ampcar,p5+amod,1            ; CARRIER OSCILLATOR
            out       asig
endin

; DOUBLE CARRIER FM
instr 2
; p4     = amplitude of output wave
; p5     = carrier frequency specified in Hz
; p6     = modulating frequency specified in Hz
; p7     = modulation index 1
; p8     = modulation index 2
; p9     = carrier envelope function
; p10 = modulator envelope function
; p11 = amplitude scaler for second carrier
; p12 = modulation index scaler for second carrier
; p13 = frequency of second carrier specified in Hz
                                        
  i1        =  1/p3                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7 * p6                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8-p7) * p6                       ; CALCULATES DEVIATION FOR INDEX 2

  ampcar    oscil     p4,i1,p9                    ; AMP ENV FOR THE CARRIER
  ampmod    oscil     i3,i1,p10                   ; AMP ENV FOR THE MODULATOR

  amod      oscili    ampmod+i2,p6,1              ; MODULATING OSC                
  asig1     oscili    ampcar,p5+amod,1            ; CARRIER OSC
  asig2     oscili    ampcar*p11,p13+(amod*p12),1 ; SECOND CARRIER    
            out       asig1+asig2
endin

; CHOWNING'S FM SOPRANO INSTRUMENT
instr   3
;**********************initialization...
  iamp      =  p6                                 ; RANGE 0 < AMP < 1
  ifenvfn   =  p7
  iportfn   =  p8
  ifmtfn1   =  p9
  ifmtfn2   =  p10
  ifmtfn3   =  p11
  ifundfn   =  p12
  irange    =  3                                  ; MAX RANGE OF 3 OCTAVES
  ibase     =  octpch(7.07)                       ; LOWEST NOTE = g3
  icaroct   =  octpch(p5)
  icarhz    =  cpspch(p5)
  ipoint    =  (icaroct-ibase)/irange*511.999

  ifmthz    table     ipoint,ifmtfn1              ; RELATIVE POS. OF FORMANT
  ifmthz    =  ifmthz*3000                        ; MAP ONTO FREQUENCY RANGE
  ifmthz    =  int(ifmthz/icarhz+.5)*icarhz       ; AS NEAREST HARMONIC

  ifmtfac   table     ipoint,ifmtfn2              ; RELATIVE AMP. OF FORMANT
  ifmtfac   =  ifmtfac*.1                         ; MAX VALUE = .1
  ifndfac   =  1-ifmtfac                          ; RELATIVE AMP. OF FUND

  ifmtndx   table     ipoint,ifmtfn3              ; RELATIVE INDEX OF FORMANT
  ifmtndx   =  ifmtndx*5                          ; MAX VALUE = 5

  ifndndx   table     ipoint,ifundfn              ; RELATIVE INDEX OF FUND
  ifndndx   =  ifndndx*.25                        ; MAX VALUE = .25

  ifndamp   =  ifndfac * sqrt(iamp)               ; AMP**.5 
  ifmtamp   =  ifmtfac * iamp * sqrt(iamp)        ; AMP**1.5

  imodhz    =  icarhz                             ; CALCULATE MODULATOR AND
  ipkdev1   =  ifndndx*imodhz                     ; PEAK DEVIATION

; COMPUTE VIBRATO PARAMETERS:
  ilog2pch  =  log(icarhz)/log(2)         
  ivibwth   =  .002*ilog2pch                      ; RELATE WIDTH TO FUND PCH
  ivibhz    =  5                                  ; FROM 5 TO 6.5 Hz AVERAGE
  irandhz   =  125                                ; FROM MORRILL TRUMPET DESIGN
  iportdev  =  .05                                ;  "     "          "    "

;************************* performance...
; VIBRATO
  krand     randi     ivibwth,irandhz
  kvibwth   linen     ivibwth,.6,p3,.1            ; GATE VIBRATO WIDTH
  kport     oscil1    0,iportdev,.2,iportfn       ; INITIAL PORTAMENTO
  kvib      oscili    kvibwth,ivibhz,1            ; fn1 = SINE
  kv        =  1+kvib+kport+krand                 ; VIBRATO FACTOR ALWAYS CA 1
; FM
  adev1     oscili    ipkdev1,imodhz*kv,1         ; MODULATOR
  adev2     =  adev1*ifmtndx/ifndndx              ; RESCALE FOR FORMANT CARRIER
  afundhz   =  (icarhz+adev1)*kv                  ; VIB THE MODULATED FUND...
  aformhz   =  (ifmthz+adev2)*kv                  ; ...AND MODULATED FORMANT

  afund     linen     ifndamp,.1,p3,.08
  afund     oscili    afund,afundhz,1
  aform     envlpx    ifmtamp,.1,p3,.08,ifenvfn,1,.01  
  aform     oscili    aform,aformhz,1

  asig      =  (afund+aform)*p4                   ; SCALE TO PEAK AMP HERE
            out       asig
endin
