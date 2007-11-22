;=======================================================================;
; Echoes from Mir.orc                                                                             ;        
;=======================================================================;
; "Echoes from Mir" (the Space Station) by Sal Sofia (c.) 1998            ;
;=======================================================================;
;                                                                                                                 ;
;=======================================================================;
;=======================================================================;
; FM Instrument by John M. Chowning                                                       ;
;=======================================================================;
; FM Orchestra Coded and Compiled by Dr. Richard Boulanger                        ;
;=======================================================================;
;                                                                                                                 ;
;=======================================================================;
;============================== HEADER =================================;
;=======================================================================; 

  sr        =  44100       
  kr        =  4410                    
  ksmps     =  10         
  nchnls    =  2

;=======================================================================; 
;========================== INITIALIZATION =============================;
;=======================================================================;

  ga1       init      0
  ga2       init      0
  garvb     init      0
  gadel     init      0
  gaout     init      0
;=======================================================================;
;=============================< INSTR 1 >===============================;
;=======================================================================;

instr 1
; p4            =               AMPLITUDE OF OUTPUT WAVE
; p5            =               CARRIER FREQUENCY IN Hz
; p6            =               MODULATING FREQUENCY IN Hz
; p7            =               MODULATION INDEX 1
; p8            =               MODULATION INDEX 2
; p9            =               CARRIER ENVELOPE FUNCTION
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance
                                                
  i1        =  1/p3                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7*p6                              ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8-p7)*p6                         ; CALCULATES DEVIATION FOR INDEX 2 
   
  ibalance  =  p12                                ; PANNING:1=LEFT,0.5=CENTER,0=RIGHT.        
  adetun    oscili    1,p5*1.0068,1               ; DETUNED FREQ. CENTS (11.7641)

  ampcar    oscili    p4/1.7,i1,p9                ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3,i1,p10                   ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2,p6,1              ; MODULATING OSCILLATOR
  asig      oscili    ampcar,p5+amod,1            ; CARRIER OSCILLATOR
   
  attack    linen     1,p11,p3,0
  anoclick  expseg    0.00001,0.05,1,p3-0.1,1,0.05,0.00001

  aout      =  anoclick+adetun
            outs      asig*aout*attack*anoclick*ibalance,asig*aout*attack*anoclick*(1-ibalance)       
  ga1       =  ga1+(aout+asig+anoclick+attack)
  gadel     =  (aout+asig+anoclick+attack)
  garvb     =  (aout+asig+anoclick+attack)
endin
;=======================================================================;
;==============================< INSTR 2 >==============================;
;=======================================================================;

instr 2
; p4            =               AMPLITUDE OF OUTPUT WAVE
; p5            =               CARRIER FREQUENCY IN Hz
; p6            =               MODULATING FREQUENCY IN Hz
; p7            =               MODULATION INDEX 1
; p8            =               MODULATION INDEX 2
; p9            =               CARRIER ENVELOPE FUNCTION   l
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance
   
  i1        =  10/p3                              ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7*p6                              ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8-p7)*p6                         ; CALCULATES DEVIATION FOR INDEX 2

  ibalance  =  p12
  
  adetun    oscili    1,p5*1.0068,1               ; DETUNE         
  ahum2     oscili    1,p5/1.34,1                 ; PERFECT 5TH. BELOW p5
  aprime    oscili    1,p5*2,1          
  apart1    oscili    1,p5*2.7,1   
  apart2    oscili    1,p5*5.2,1   
  apart3    oscili    1,p5*8.4,1  
  apart4    oscili    1,p5*12.2,1 

  ampcar    oscili    p4/1.7,i1,p9                ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3,i1,p10                   ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2,p6,1              ; MODULATING OSCILLATOR
  asig      oscili    ampcar,p5+amod,1            ; CARRIER OSCILLATOR

  attack    linen     1,p11,p3,0
  anoclick  expseg    0.00001,0.05,1,p3-0.1,1,0.05,0.00001

  aout      =  anoclick+adetun+ahum2+aprime+apart1+apart2+apart3+apart4 
            outs      asig*attack*anoclick*aout*ibalance,asig*attack*anoclick*aout*(1-ibalance)  
  gadel     =  (asig+attack+aout+anoclick)
  garvb     =  (asig+attack+aout+anoclick)
endin
;=======================================================================;
;===============================< INSTR 3 >=============================;
;=======================================================================;

instr 3
; p4    =               AMPLITUDE OF OUTPUT WAVE
; p5    =               CARRIER FREQUENCY IN Hz
; p6    =               MODULATING FREQUENCY IN Hz
; p7    =               MODULATION INDEX 1
; p8    =               MODULATION INDEX 2
; p9    =               CARRIER ENVELOPE FUNCTION   l
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance
         
  i1        =  1/p3                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7*p6                              ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8-p7)*p6                         ; CALCULATES DEVIATION FOR INDEX 2
  
  adetun    oscili    1,p5*1.0068,1               ; DETUNE         
  ahum2     oscili    1,p5/1.34,1                 ; PERFECT 5TH. BELOW p5
  aprime    oscili    1,p5*2,1   
  apart1    oscili    1,p5*2.7,1      
  apart2    oscili    1,p5*5.2,1      
  apart3    oscili    1,p5*8.4,1  
  apart4    oscili    1,p5*12.2,1 

  ampcar    oscili    p4/1.9,i1,p9                ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3,i1,p10                   ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2,p6,1              ; MODULATING OSCILLATOR
  asig      oscili    ampcar,p5+amod,1            ; CARRIER OSCILLATOR

  ahum3     oscili    ampcar,p5/1.34+amod,1
  a5        oscili    ahum3,p5+amod,1
  a6        oscili    a5,p5+ahum3,1

  ibalance  =  p12
  attack    linen     1,p11,p3,0
  anoclick  expseg    0.00001,0.05,1,p3-0.1,1,0.05,0.00001

  aout      =  anoclick+a6+adetun+ahum2+aprime+apart1+apart2+apart3+apart4
            outs      attack*aout*anoclick*ibalance,attack*aout*anoclick*(1-ibalance)  
  ga1       =  (asig+attack+aout+anoclick)/1.5
  ga2       =  ga2+(asig+attack+aout+anoclick)
  gadel     =  gadel+(asig+attack+aout+anoclick)*p13
  garvb     =  garvb+(asig+attack+aout+anoclick)*p14
endin
  
;=======================================================================;
;=============================< INSTR 4 >===============================;
;=======================================================================;

instr 4
; p4    =               AMPLITUDE OF OUTPUT WAVE
; p5    =               CARRIER FREQUENCY IN Hz
; p6    =               MODULATING FREQUENCY IN Hz
; p7    =               MODULATION INDEX 1
; p8    =               MODULATION INDEX 2
; p9    =               CARRIER ENVELOPE FUNCTION
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance
; p13   =               DELAY SEND FACTOR 
; p14   =               REVERB SEND FACTOR 

  i1        =  1/p3                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7*p6                              ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8-p7)*p6                         ; CALCULATES DEVIATION FOR INDEX 2 
   
  ibalance  =  p12                                ; PANNING:1=LEFT,0.5=CENTER,0=RIGHT.        
  adetun    oscili    1,p5*1.0068,1               ; DETUNED FREQ. CENTS (11.7641)

  ampcar    oscili    p4*2,i1,p9                  ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3,i1,p10                   ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2,p6,1              ; MODULATING OSCILLATOR
  asig      oscili    ampcar,p5+amod,1            ; CARRIER OSCILLATOR
   
  attack    linen     1,p11,p3,0
  anoclick  expseg    0.00001,0.05,1,p3-0.1,1,0.05,0.00001

  amix      =  adetun+attack+anoclick
            outs      asig*adetun*attack*anoclick*ibalance,asig*adetun*attack*anoclick*(1-ibalance)
  gadel     =  (gadel/2)+(asig*p13)    
  garvb     =  (garvb/2)+(asig*p14) 
endin
;=======================================================================;
;=============================< INSTR 5 >===============================;
;=======================================================================;

instr 5
; p4    =               AMPLITUDE OF OUTPUT WAVE
; p5    =               CARRIER FREQUENCY IN Hz
; p6    =               MODULATING FREQUENCY IN Hz
; p7    =               MODULATION INDEX 1
; p8    =               MODULATION INDEX 2
; p9    =               CARRIER ENVELOPE FUNCTION
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance 
; p13   =               DELAY SEND FACTOR 
; p14   =               REVERB SEND FACTOR 

  i1        =  1/p3                               ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7*p6                              ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8-p7)*p6                         ; CALCULATES DEVIATION FOR INDEX 2

  ibalance  =  p12                                ; PANNING:1=LEFT,0.5=CENTER,0=RIGHT.
  ahum      oscili    1,.34*p5,1                  ; ONE OCTAVE AND PERFECT 5TH BELOW p5.
  aprime    oscili    1,p5,1  
  aperf5    oscili    1,p5*1.49,1                 ; PERFECT 5TH. UP FROM p5 (IN MICROT.)
   
  ampcar    oscili    p4*2,i1,p9                  ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3,i1,p10                   ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod+i2,p6,1              ; MODULATING OSCILLATOR
  asig      oscili    ampcar,p5+amod,1            ; CARRIER OSCILLATOR

  attack    linen     1,p11,p3,0
  anoclick  expseg    0.00001,0.05,1,p3-0.1,1,0.05,0.00001

  amix      =  anoclick+attack+ahum+aprime+aperf5
            outs      asig*amix*anoclick*attack*ibalance,asig*amix*anoclick*attack*(1-ibalance)
  gadel     =  gadel+((amix+asig+ahum+aperf5+anoclick+attack)*p13)     
  garvb     =  garvb+((amix+asig+ahum+aperf5+anoclick+attack)*p14) 
endin

;=======================================================================;
;===============================< INSTR 6 >=============================;
;=======================================================================;

instr 6
; p4    =               AMPLITUDE OF OUTPUT WAVE
; p5    =               CARRIER FREQUENCY IN Hz
; p6    =               MODULATING FREQUENCY IN Hz
; p7    =               MODULATION INDEX 1
; p8    =               MODULATION INDEX 2
; p9    =               CARRIER ENVELOPE FUNCTION
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance
                                                        
  i1        =  1 / p3                             ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7 * p6                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8 - p7) * p6                     ; CALCULATES DEVIATION FOR INDEX 2

  ibalance  =  p12
 
  adetun    oscili    1, p5 * 1.0068, 1           ; DETUNE(~11.7641 CENTS)
  ahum2     oscili    1, p5 / 1.34, 1             ; PERFECT 5th. BELOW p5
  aprime    oscili    1, p5 * 2, 1     
   
  ampcar    oscili    p4 * 2, i1, p9              ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3, i1, p10                 ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod + i2, p6, 1          ; MODULATING OSCILLATOR
  asig      oscili    ampcar, p5 + amod, 1        ; CARRIER OSCILLATOR

  attack    linen     1, p11, p3, 0
  anoclick  expseg    0.00001, 0.05, 1, p3 - 0.1, 1, 0.05, 0.00001
  amix      =  adetun + ahum2 + aprime + attack + anoclick
            outs      amix * attack * anoclick * ibalance, amix * attack * anoclick * (1-ibalance)
  gadel     =  gadel + (amix + asig + anoclick + attack) * p13
  garvb     =  garvb + (amix + asig + anoclick + attack) * p14 
endin
;=======================================================================;
;=============================< INSTR 7 >===============================;
;=======================================================================;

instr 7
; p4    =               AMPLITUDE OF OUTPUT WAVE
; p5    =               CARRIER FREQUENCY IN Hz
; p6    =               MODULATING FREQUENCY IN Hz
; p7    =               MODULATION INDEX 1
; p8    =               MODULATION INDEX 2
; p9    =               CARRIER ENVELOPE FUNCTION
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance
; p13   =               IRELEASE
   
                                                        
  i1        =  1 / p3                             ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7 * p6                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8 - p7) * p6                     ; CALCULATES DEVIATION FOR INDEX 2 
  
  ibalance  =  p12
  irelease  =  p13
                                                 
  adetun    oscili    1, p5 * 1.0068, 1           ; DETUNED FREQ. CENTS (11.7641)

  ampcar    oscili    p4 / 1.8, i1, p9            ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3, i1, p10                 ; AMPLITUDE ENVELOPE FOR THE MODULATOR
  amod      oscili    ampmod + i2, p6, 1          ; MODULATING OSCILLATOR
  asig1     oscili    ampcar, p5 + amod, 1        ; CARRIER OSCILLATOR
   
  attack    linen     1, p11, p3, 0
  anoclick  expseg    0.00001, 0.05, 1, p3 - 0.1, 1, 0.05, 0.00001

  a1        linseg    0.01, p3 / 2, 50, p3 / 2, 0.01
  k1        line      100, p3, 10000
  asig2     grain     k1, 3000, a1, 4000, 2013, .01, 10, 5, .01
 
  amix      =  (asig1 + adetun) / 2 
            outs      amix * anoclick * ibalance, amix * anoclick * (1-ibalance) 
; gadel         =               (amix + attack + irelease + anoclick) * p14
; garvb         =               (amix + attack + irelease + anoclick) * p15 
; gaout         =               asig2 * 2
        
         
   
  ga1       =  ga1 + (amix + attack + irelease + anoclick)
  gadel     =  gadel +  (amix + attack + irelease + anoclick)
  gaout     =  gaout + (asig2 * 2)             
endin

;=======================================================================;
;=============================< INSTR 8 >===============================;
;=======================================================================;

instr 8
; p4    =               AMPLITUDE OF OUTPUT WAVE
; p5    =               CARRIER FREQUENCY IN Hz
; p6    =               MODULATING FREQUENCY IN Hz
; p7    =               MODULATION INDEX 1
; p8    =               MODULATION INDEX 2
; p9    =               CARRIER ENVELOPE FUNCTION   l
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance
; p13   =               arelease
                                                        
  i1        =  10 / p3                            ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7 * p6                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8 - p7) * p6                     ; CALCULATES DEVIATION FOR INDEX 2

  ibalance  =  p12
  arelease  =  p13
                                                                                        
  adetun    oscili    1, p5 * 1.0068, 1           ; DETUNE        
  ahum2     oscili    1, p5 / 1.34, 1             ; PERFECT 5th. BELOW p5
  aprime    oscili    1, p5 * 2, 1   
  apart1    oscili    1, p5 * 2.7, 1  
  apart2    oscili    1, p5 * 5.2, 1  
  apart3    oscili    1, p5 * 8.4, 1  
  apart4    oscili    1, p5 * 12.2, 1 

  ampcar    oscili    p4 / 2, i1, p9              ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3, i1, p10                 ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod + i2, p6, 1          ; MODULATING OSCILLATOR
  asig      oscili    ampcar, p5 + amod, 1        ; CARRIER OSCILLATOR

  attack    linen     1, p11, p3, 0
  anoclick  expseg    0.00001, 0.05, 1, p3 - 0.1, 1, 0.05, 0.00001

; amix  =               adetun + ahum2 + aprime + apart1 + apart2 + apart3 + apart4 
;               outs    asig * attack * anoclick * amix * ibalance, asig * attack * anoclick * amix * (1-ibalance)  
; gadel   =             (asig + attack + amix + anoclick) * p14
; garvb   =             (asig + attack + amix + anoclick) * p15 
        
  amix      =  adetun + ahum2 + aprime + apart1 + apart2 + apart3 + apart4 
            outs      asig * attack * anoclick * amix * ibalance, asig * attack * anoclick * amix * (1-ibalance)  
  ga1       =  ga1 + (asig + attack + amix + anoclick)
  gadel     =  gadel + (asig + attack + amix + anoclick) 
endin

;=======================================================================;
;=============================< INSTR 9 >===============================;
;=======================================================================;

instr 9
; p4    =               AMPLITUDE OF OUTPUT WAVE
; p5    =               CARRIER FREQUENCY IN Hz
; p6    =               MODULATING FREQUENCY IN Hz
; p7    =               MODULATION INDEX 1
; p8    =               MODULATION INDEX 2
; p9    =               CARRIER ENVELOPE FUNCTION l
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance
   
                                                        
  i1        =  1 / p3                             ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7 * p6                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8 - p7) * p6                     ; CALCULATES DEVIATION FOR INDEX 2

  ibalance  =  p12
  irelease  =  p13
  
  adetun    oscili    1, p5 *  1.0068, 1          ; DETUNE         
  ahum2     oscili    1, p5 /  1.34, 1            ; PERFECT 5th. BELOW p5
  aprime    oscili    1, p5 *  2, 1   
  apart1    oscili    1, p5 *  2.7, 1 
  apart2    oscili    1, p5 *  5.2, 1 
  apart3    oscili    1, p5 *  8.4, 1  
  apart4    oscili    1, p5 * 12.2, 1 
                                                                
  ampcar    oscili    p4 / 2, i1, p9              ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3, i1, p10                 ; AMPLITUDE ENVELOPE FOR THE MODULATOR
  amod      oscili    ampmod + i2, p6, 1          ; MODULATING OSCILLATOR
  asig      oscili    ampcar, p5 + amod, 1        ; CARRIER OSCILLATOR

  ahum3     oscili    ampcar, p5 / 1.34 + amod,1
  a5        oscili    ahum3, p5 + amod, 1
  a6        oscili    a5, p5 + ahum3, 1

  attack    linen     1, p11, p3, 0
  anoclick  expseg    0.00001, 0.05, 1, p3 - 0.1, 1, 0.05, 0.00001
; amix  =               anoclick + irelease + a6 + adetun + ahum2 + aprime + apart1 + apart2 + apart3 + apart4  
;               outs            asig * attack * amix * anoclick * ibalance, asig * attack * amix * anoclick * (1-ibalance)  
; gadel         =               (asig + attack + anoclick) * p14  
; garvb         =               (asig + attack + anoclick) * p15
        
  aout      =  anoclick + a6 + adetun + ahum2 + aprime + apart1 + apart2 + apart3 + apart4      
            outs      asig + attack * aout * anoclick * ibalance, attack * aout * anoclick * (1-ibalance)     
  ga1       =  asig + attack + aout + anoclick
  gadel     =  gadel + (asig + attack + anoclick)                
endin
;=======================================================================;
;=============================< INSTR 15 >==============================;
;=======================================================================;

instr 15
; p4    =               AMPLITUDE OF OUTPUT WAVE
; p5    =               CARRIER FREQUENCY IN Hz
; p6    =               MODULATING FREQUENCY IN Hz
; p7    =               MODULATION INDEX 1
; p8    =               MODULATION INDEX 2
; p9    =               CARRIER ENVELOPE FUNCTION
; p10   =               MODULATOR ENVELOPE FUNCTION
; p11   =               ATTACK
; p12   =               ibalance 
; p13   =               DELAY SEND FACTOR 
; p14   =               REVERB SEND FACTOR 
                                                        
  i1        =  1 / p3                             ; ONE CYCLE PER DURATION OF NOTE
  i2        =  p7 * p6                            ; CALCULATES DEVIATION FOR INDEX 1
  i3        =  (p8 - p7) * p6                     ; CALCULATES DEVIATION FOR INDEX 2

  ibalance  =  p12                                 
  ahum      oscili    1, .34 * p5, 1              ; ONE OCTAVE AND PERFECT 5th BELOW p5.
  aprime    oscili    1, p5, 1         
  aperf5    oscili    1, p5 * 1.49, 1             ; PERFECT 5th. UP FROM p5 (IN MICROT.)
   
  ampcar    oscili    p4 * 2, i1, p9              ; AMPLITUDE ENVELOPE FOR THE CARRIER
  ampmod    oscili    i3, i1, p10                 ; AMPLITUDE ENVELOPE FOR THE MODULATOR

  amod      oscili    ampmod + i2, p6, 1          ; MODULATING OSCILLATOR
  asig      oscili    ampcar, p5 + amod, 1        ; CARRIER OSCILLATOR

  attack    linen     1, p11, p3, 0
  anoclick  expseg    0.00001, 0.05, 1, p3 - 0.1, 1, 0.05, 0.00001

  amix      =  anoclick + attack + ahum + aprime + aperf5 
            outs      amix * anoclick * attack * ibalance, amix * anoclick * attack * (1-ibalance)
  gadel     =  gadel + ((asig + ahum + aperf5 + anoclick + attack) * p13)      
  garvb     =  garvb + ((asig + ahum + aperf5 + anoclick + attack) * p14) 
endin
;==========================================================================;
;=============================< INSTR 16 >=================================;
;==========================================================================;
; SOURCE CODE FROM: Professor Tom Erbe                                                          ;
;==========================================================================;
;       INSTRUMENT 16, STEREO REVERB TO INSTRUMENT 7 (asig2 grain)
                                                
instr 16
  kdist     linseg    1,p3/2,16,p3/2,1            ; GO >FROM 1 FOOT TO 16 FEET AWAY AND BACK
  kang      phasor    8/p3                        ; PAN 8 TIMES
  kradang   =  kang * 6.28318                     ; ANGLE (0 IS STRAIGHT AHEAD, 90 IS
                                                                        ; STRAIGHT TO THE RIGHT)
  kdistg    =  1/kdist                            ; DISTANCE DOUBLES, GAIN HALVES
  kangg     =  sin(kradang)                       ; GOES FROM -1 TO 1, WE NEED 0dB TO -12dB GAIN
                                                                        ; OR GAIN FROM 1 TO 0.25
  kfbg      =  cos(kradang)                       ; -1 IS REAR, 1 IS FRONT
  kfront    =  kfbg * 0.75
  kback     =  kfbg * 0.5
                                                                        
  afront    reson     (gaout * kdistg), 5000, 2000, 1
  aback     reson     (gaout * kdistg), 8000, 2000, 1

  amix      =  (afront * kfront) + (aback * kback) + (gaout * kdistg)
  kanggl    =  (1 - kangg) * 0.5                  ; 1: FULL LEFT, 0: FULL RIGHT
  kanggr    =  (1 + kangg) * 0.5                  ; 0: FULL LEFT, 1: FULL RIGHT
  alft1     =  ((kanggl * 0.75) + .25) * amix
  arght1    =  ((kanggr * 0.75) + .25) * amix

  alpl1     tone      alft1,1500                  ; 2 POLE FILTER FOR 12dB DROP AT 3K
  alpl2     tone      alpl1,1500 
  alpr1     tone      arght1,1500                 ; 2 POLE FILTER FOR 12dB DROP AT 3K
  alpr2     tone      alpr1,1500

  alft2     =  (alpl2 * kanggr) + (alft1 * kanggl)
  arght2    =  (alpr2 * kanggl) + (arght1 * kanggr)

  anull     delayr    1       
  alft3     deltapi   (0.0003 + (kanggr*0.0012))  ; UP TO 1.2 MSEC DELAY +
                                                                        ; 3 MSEC > CONTROL RATE OF 4410
            delayw    alft2
  anulr     delayr    1
  arght3    deltapi   (0.0003 + (kanggl*0.0012))  ; UP TO 1.2 MSEC DELAY
            delayw    arght2
                
  arvbl     reverb    (gaout * .125), 1           ; 1 SECOND LEFT REVERB
  arvbr     reverb    (gaout * .125), .7          ; .7 SECOND RIGHT REVERB

  alft4     =  alft3 + (arvbl * 0.05)
  arght4    =  arght3 + (arvbr * 0.05)
            outs      alft4,arght4
  gaout     =  0
endin
;==============================================================================; 
;============================< INSTR 60 >======================================;
;==============================================================================;
instr 60                        ; FEMALE A FOF (FONCTIONS d'ONDE FORMANTIQUE) COMPUTER MUSIC
                                                ; DODGE AND JERSE
  k1        oscili    p5 / 200, 4, 1
  k2        linen     1, .1, p3, .1

  a1        fof       p4, p5 + k1, 650, 0, 120, .003, .02, .007, 100, p6, p7, p3, 0, 0 
  a2        fof       p4 / 2.5, p5 + k1, 1100, 0, 120, .003, .02, .007, 100, p6, p7, p3, 0, 0 
  a3        fof       p4 / 4.4, p5 + k1, 2860, 0, 120, .003, .02, .007, 100, p6, p7, p3, 0, 0 
  a4        fof       p4 / 4.0, p5 + k1, 3300, 0, 120, .003, .02, .007, 100, p6, p7, p3, 0, 0 
  a5        fof       p4 / 8.8, p5 + k1, 4500, 0, 120, .003, .02, .007, 100, p6, p7, p3, 0, 0 
  a6        =  k2 * (a1 + a2 + a3 + a4 + a5) 
            outs      a6 / 2.8, a6 / 2.8
  gadel     =  gadel + (a6 / 2.3) * p8
  garvb     =  garvb + (a6 / 2.3) * p9
endin 
;==============================================================================;
;=================<      Global Reverb Instruments  >==============================;
;==============================================================================;
;==========================< INSTR 91 >========================================;
;==============================================================================;
  
instr   91                                      ; (HIGHEST INSTR NUMBER EXECUTED LAST)
  a2        reverb    ga2, 2.1                    ; REVERBERATE WHATEVER IS IN ga1
            outs      a2, a2                      ; AND OUTPUT THE RESULT
  ga2       =  0                                  ; EMPTY THE RECEIVER FOR THE NEXT PASS
endin

instr   99                                      ; (HIGHEST INSTR NUMBER EXECUTED LAST)
  a2        reverb    ga1, 2.1                    ; REVERBERATE WHATEVER IS IN ga1
            outs      a2, a2                      ; AND OUTPUT THE RESULT
  ga1       =  0                                  ; EMPTY THE RECEIVER FOR THE NEXT PASS
endin

;==============================================================================;
; FROM: TRAPPED IN CONVERT ORCHESTRA / Dr. Richard Boulanger/                       ;
;==============================================================================;
;==========================< INSTR 198 >=======================================;
;==============================================================================; 
instr   198
  asig      delay     gadel, 0.08
            outs      asig, asig
  gadel     =  0
endin
;==============================================================================;
;==========================< INSTR 199 >=======================================;
;==============================================================================; 
instr   199             ; p4 = PANRATE
  k1        oscil     .5, p4, 1
  k2        =  .5 + k1
  k3        =  1 - k2
  asig      reverb    garvb, 2.1
            outs      asig * k2, (asig * k3) * (-1)
  garvb     =  0
endin
;==========================================================================; 
;==========================================================================; 
