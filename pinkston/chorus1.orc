  sr        =  44100            
  kr        =  4410             
  ksmps     =  10               
  nchnls    =  2                

;===================================================;
;Simple chorus instrument based on heterodyning.    ;
;With 2 sine waves slightly detuned, the resultant  ;
;frequency will be the average of the 2 sine wave   ;
;frequencies and the beat frequency will be equal   ;
;to the difference between their frequencies:       ;
;sin(a) + sin(b) = 2 * sin((a+b)/2) * cos ((a-b)/2) ;
;Note: we hear two beats for each cos cycle - one   ;
;for the positive peak and one for the negative.    ;
;RP                                                 ;
;===================================================;
                                 
instr   1                
;---------------------------------------;initialization block:                          
  ipan      =  p9               
  ilfac     =  sqrt(p9)                 
  irfac     =  sqrt(1-p9)               
  idetune   =  p10                                ;detune factor in CPS   
;---------------------------------------;performance block:                             
  kgate     linen     p4,p6,p3,p7              
  asig1     oscili    kgate,cpspch(p5),p8         ;in tune oscil   
  asig2     oscili    kgate,cpspch(p5)+idetune,p8 ;out of tune oscil      
  asig      =  asig1+asig2                        ;sum will beat at idetune CPS   
            outs      asig*ilfac,asig*irfac       ;stereo placement and out       
endin                    
