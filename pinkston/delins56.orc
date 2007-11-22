  sr        =  22050                              ;sr should equal 
  kr        =  22050                              ;kr when using
  ksmps     =  1                                  ;audio feedback
  nchnls    =  2       
;=========================================================                      
instr   5       
  imain     =  p4                                 ;main amp factor
  isend     =  p5                                 ;send amp factor
  gasend    init      0       
  asig      soundin   "richard.wav"               ;the source sound
  amain     =  asig*imain                         ;atten main sig 
            outs      amain,amain     
  gasend    =  gasend+asig*isend                  ;add to effects send
endin           
;===========================================================                    
instr   6       
  ifeed     =  p4                                 ;feedback factor
  ilfohz1   =  p5                                 ;1st LFO speed
  ilfohz2   =  p6                                 ;2nd LFO speed
  imaxdel   =  p7                                 ;max delay time
  ivdel1    =  p8*imaxdel                         ;tap1 vary amount
  ivdel2    =  p9*imaxdel                         ;tap2 vary amount
  avary1    oscili    ivdel1,ilfohz1,1            ;Hamming window fn
  avary2    oscili    ivdel2,ilfohz2,1,.5         ;start out of phase
  afixed    delayr    imaxdel                     ;imaxdel sec buffer
  aout1     deltapi   .001+avary1                 ;two varying taps
  aout2     deltapi   .0005+avary2                ;stagger a little
  afeed     =  (aout1+aout2)*ifeed                ;feedback both
  ainput    balance   gasend+afeed,gasend         ;balance with orig
            delayw    ainput                      ;delay w/feedbk
            outs      aout1,aout2                 ;split outputs
  gasend    =  0                                  ;zero send var
endin           
