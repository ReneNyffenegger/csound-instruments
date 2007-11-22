;Sample Orchestra #3

  sr        =  44100                           
  kr        =  2205                            
  ksmps     =  20                              
  nchnls    =  2                               
                                                        
;Portamento/Panning Instrument
;p4=amp p5=pch p6=portsize (oct)  p7=delay  p8=ofn p9=p3 in beats
                                                                
instr   1,2,3,4                                 
  ipitch    =  octpch(p5)                         ;center pitch in oct
  itempo    =  p3/p9                              ;ratio seconds/beats
  idelay    =  p7*itempo                          ;convert beats to secs
  iport     =  p6                                 ;p6 in oct
  ilfn      =  (iport > 0 ? 4 : 5)                ;fn 4 = 1/4 sine
  irfn      =  (iport > 0 ? 5 : 4)                ;fn 5 = 1/4 cos
  kport     init      0                           ;initialize kvars
  kleft     init      .707                        ;sqrt(.5) for mono
  kright    init      .707                            
if (iport == 0) goto continue                     ;skip if not needed
  kport     oscil1i   idelay,iport,p3-idelay,2    ;fn 2 is linear ramp
                                                        
  kleft     oscil1i   idelay,1,p3-idelay,ilfn
  kright    oscil1i   idelay,1,p3-idelay,irfn
continue:                                                       
  kgate     envlpx    p4,p3*.1,p3,p3/4,3,1,.01    ;fn 3 is exponential
  asig      oscili    kgate,cpsoct(ipitch+kport),p8           
            outs      asig*kleft,asig*kright      ;stereo placement
endin                                   

;                 Simple Gating Instrument with Chorus
; p4=amp      p5=pch1       p6=pch2        p7=risefac      p8=decfac
; p9=ofn1      p10=ofn2     p11=gatefn    p12=beathz     p13=gatehz
                                                        
instr   5,6,7,8                         
  irise     =  p3*p7                              ;p7 is a rise factor
  idecay    =  p3*p8                              ;p8 is a decay factor
  iss       =  p3-(irise+idecay)                  ;steady state rest of p3
  igatehz   =  (p13 == 0 ? 1/p3 : p13)            ;default to once per note
  ihalf     =  p4/2                            
  ipitch1   =  cpspch(p5)                      
  idet1     =  ipitch1 + p12                      ;add beat freq in hz
  ipitch2   =  cpspch(p6)                      
  idet2     =  ipitch2 - p12                      ;subtract beat freq
                                                
  kgate     oscili    1,igatehz,p11               ;p11 has gating control fn#
  kenvlp    expseg    .001,irise,1,iss,1,idecay,.001
  asig1     oscili    ihalf,ipitch1,p9            ;straight sound one
  adet1     oscili    ihalf,idet1,p9              ;detuned sound one
  asig1     =  asig1 + adet1                      ;sound one
  asig2     oscili    ihalf,ipitch2,p10           ;straight sound two
  adet2     oscili    ihalf,idet2,p10             ;detuned sound two
  asig2     =  asig2 + adet2                      ;sound two
  aout1     =  asig1 * kgate                      ;gate them...
  aout2     =  asig2 * (1-kgate)                       
  aoutsig   =  (aout1 + aout2) * kenvlp           ;output the sum
            outs      aoutsig,aoutsig
endin                                   
                                                        
;               Basic FM Instrument with Variable Vibrato
; p4=amp      p5=pch(fund)     p6=vibdel       p7=vibrate      p8=vibwth
; p9=rise    p10=decay     p11=max index    p12=car fac   p13=modfac 
; p14=index rise  p15=index decay  p16=left channel factor p17=original p3

instr   9,10,11,12              
;--------------------------------------------------------------------------------
;initialization block:
  kpitch    init      cpspch (p5)             
  itempo    =  p3/p17                             ;ratio seconds/beats
  idelay    =  p6 * itempo                        ;convert beats to secs                                  
  irise     =  p9 * itempo             
  idecay    =  p10 * itempo            
  indxris   =  (p14 == 0 ? irise : p14 * itempo)
  indxdec   =  (p15 == 0 ? idecay : p15 * itempo)
if (p16 != 0) igoto panning                       ;if a panfac, use it, else
  ilfac     =  .707                               ;default is mono (sqrt(.5))
                                        
  irfac     =  .707            
            igoto     perform                 
panning:                                        
  ilfac     =  sqrt(p16)               
  irfac     =  sqrt(1-p16)             
;--------------------------------------------------------------------------------
;performance block:
perform:
if (p7 == 0 || p8 == 0) goto continue
  kontrol   oscil1    idelay,1,.5,2               ;vib control
  kvib      oscili    p8*kontrol,p7*kontrol,1     ;vibrato unit
  kpitch    =  cpsoct(octpch(p5)+kvib)            ;varying fund pitch in hz
                                        
continue:                                       
  kamp      linen     p4,irise,p3,idecay
  kindex    linen     p11,indxris,p3,indxdec
  asig      foscili   kamp,kpitch,p12,p13,kindex,1 ;p12,p13=carfac,mod fac
            outs      asig*ilfac,asig*irfac
endin                   
;---------------------------------------------
instr     13
  iamp      =  p4/4                               ;sum of all 4 partials won't exceed p4
  ifn       =  p7          
  kev1      linseg    0, .04, iamp, p3/2, iamp, p3/2-.04, 0
  kev2      expseg    .01, .03, iamp, p3*.9, iamp/6, p3*.1-.03, 1
  kev3      expseg    .01, .02, iamp, .38, .01    ;transients
  kev4      expseg    .01, .01, iamp, .29, .01
  icps      =  cpspch(p5)
  asig1     oscili    kev1,icps,ifn               ;use four successive f-tables
  asig2     oscili    kev2,icps,ifn+1
  asig3     oscili    kev3,icps,ifn+2
  asig4     oscili    kev4,icps,ifn+3
  asum      =  asig1+asig2+asig3+asig4
  irfac     =  sqrt(1-p6)
  ilfac     =  sqrt(p6)
  aright    =  (asum) * (irfac)
  aleft     =  (ilfac) * (asum)
            outs      aleft,aright
endin
