; VOICES = WIND
; ©1995 MICHAEL BERRY

  sr        =  44100                
  kr        =  4410                
  ksmps     =  10                
  nchnls    =  2                
                
instr   1
;------------------------------------------------------
;----------SOUND INPUT---------------------------------
;------------------------------------------------------                 
  iformq    table     p9,101                      ; formant base fc.
  igen      =  p9+110                             ; which formant table
  icontr    =  p8+150                             ; which pitch envl.
  iampfac   =  p10*29500                          ; amplitude multiplier
  idur      =  p3-.1                              ; duration incl. refl.
  irange    =  (p6==p7?1:abs(p6-p7))              ; diff. start + finish
  ilowpit   =  (p6>p7?p7:p6)                      ; which is lower?
  iratio    =  p12
  ktabctl   line      0,p3-.1,1
  ktabctl   =  ktabctl*(p7-p6)/irange             ; correct for direction
  kpitlin   tablei    ktabctl,icontr,1,0,1        ; lookup pitch modifier
  kpit      =  kpitlin*irange+ilowpit             ; make fund. pitch
  kband     =  40-kpit*.015                       ; vary bandwidth
  imode     =  (idur>.3?p11*.03:p11*idur*.1)      ; apply amp envelope modifier
  ioff      =  (idur>.3?p11*.03*iratio:p11*idur*.1*iratio)
  kamp      linen     iampfac,imode,idur,ioff     ; amp envelope
  kvib      randi     kpit*.01,5,.1               ; fundamental vibrato
  kvib2     randi     kpit*.01,.5,.2              ; fundamental slow vibrato
  kpit      =  kpit+kvib+kvib2
  kforlin   line      iformq,idur,p13*iformq      ; formant alterator
  iformod   =  iformq*.05              
  kforvib   randi     iformod,7,.3                ; formant vibrato
  kform     =  kforlin+kforvib-60                 ; make formant pitch
  asample   fof       kamp,kpit,kform,0,kband,.005,.02,.007,60,igen,102,idur
;------------------------------------------------------
;----------INITIAL WAVEFRONT CALCULATION--------------- 
;------------------------------------------------------       
  id        =  p4                                 ; start distance
  iang      =  p5                                 ; start angle (full forward=0)        
  ix        =  cos((iang-90)/57.2958)*id*-1       ; start x coord        
  iy        =  sin((iang-90)/57.2958)*id*-1       ; start y coord;        
  irxr      table     0,5                         ; right wall dist.        
  irxl      table     1,5                         ; left wall dist.        
  iryf      table     2,5                         ; front wall dist.        
  iryb      table     3,5                         ; rear wall dist.        
  irefl     table     4,5                         ; reflectivity (1=max)        
  idismod   =  1/id                               ; sets 1 foot speaker separation        
  idismod   =  (idismod>=1?.9999:idismod)         ; prevent pos. ampl.
  asamp     =  idismod*asample                    ; distance amp. calc.      
  ihzmod    table     idismod,2,1                
  ihzmod    =  (ihzmod*19700)+300        
  asamp     tone      asamp,ihzmod,0              ; distance rolloff   
;-----------------------------------------------------------              
;-----------RIGHT PAN AND ITD DELAY CLACULATION-------------
;----------------------------------------------------------- 
  itempr    =  (iang>90?iang-270:iang+90)*.5
  ipanr     table     itempr/360,3,1,0,1          ; amp info right cos table        
  asampr    =  ipanr*asamp                        ; pan ampl. diff.                
  amainr    tone      asampr,800,0                ; unaffected by ITD        
  adelr     =  asampr-amainr                      ; affected by ITD       
  iitdr     table     (iang+90)/360,3,1,0,1                
if   iitdr>-.036&&iitdr<.036 goto left        
  iitdr     =  abs(iitdr)*.00063        
  asigr     delay     adelr,iitdr                 ; stationary ITD
  asampr    =  amainr+asigr                       ; recombine parts
left:                   
;--------------------------------------------------------- 
;-----------LEFT PAN AND ITD CALCULATION------------------
;---------------------------------------------------------
  itempl    =  (iang<-90?iang+270:iang-90)*.5
  ipanl     table     itempl/360,3,1,0,1          ; amp info left        
  asampl    =  ipanl*asamp                   
  amainl    tone      asampl,800,0         
  adell     =  asampl-amainl                           
  iitdl     table     (iang+90)/360,3,1,0,1                
if   iitdl>-.036&&iitdl<.036 goto enda        
  iitdl     =  abs(iitdl)*.00063        
  asigl     delay     adell,iitdl
  asampl    =  amainl+asigl
enda:
;--------------------------------------------------------                
;-------------EARLY REFLECTION CALCULATION RIGHT WALL----
;--------------------------------------------------------         
  ix1       =  2*irxr-ix                
  id1       =  sqrt(iy*iy+ix1*ix1)        
  iang1a    tablei    ix1/id1,50,1,0,0            ; arccos lookup                
  iang1b    =  (ix1=id1?0:iang1a*iy/abs(iy))
  iang1     =  (iang1b<-90?iang1b+270:iang1b-90)                
  idelay1   =  (id1-id)*.002066115
if   idelay1>.1||idelay1<.000022675 goto 2        
  asamp1    delay     asample,idelay1
  idismo1   =  1/id1                              ; sets 1 foot speaker separation        
  idismo1   =  (idismo1>=1?.9999:idismo1)         ; prevent pos. ampl.
  asamp1    =  idismo1*asamp1*irefl               ; distance amp. calc. 
  ihzmod1   table     idismo1,2,1                
  ihzmod1   =  (ihzmod1*19700)+300        
  asamp1    tone      asamp1,ihzmod1,0            ; distance rolloff 
;-----------------------------------------------------------                
;-----------RIGHT PAN AND ITD DELAY CLACULATION-------------
;----------------------------------------------------------- 
  itempr1   =  (iang1>90?iang1-270:iang1+90)*.5
  ipanr1    table     itempr1*.002777,3,1,0,1     ; amp info right cos table        
  asampr1   =  ipanr1*asamp1                      ; pan ampl. diff.                
  amainr1   tone      asampr1,800,0               ; unaffected by ITD        
  adelr1    =  asampr1-amainr1                    ; affected by ITD       
  iitdr1    table     (iang1+90)/360,3,1,0,1                
if   iitdr1>-.036&&iitdr1<.036 goto left1        
  iitdr1    =  abs(iitdr1)*.00063        
  asigr1    delay     adelr1,iitdr1               ; stationary ITD
  asampr1   =  amainr1+asigr1                     ; recombine parts
left1:
;---------------------------------------------------------                    
;-----------LEFT PAN AND ITD CALCULATION------------------
;--------------------------------------------------------- 
  itempl1   =  (iang1<-90?iang1+270:iang1-90)*.5
  ipanl1    table     itempl1*.0027777,3,1,0,1    ; amp info left        
  asampl1   =  ipanl1*asamp1                   
  amainl1   tone      asampl1,800,0         
  adell1    =  asampl1-amainl1                           
  iitdl1    table     (iang1+90)/360,3,1,0,1                
if   iitdl1>-.036&&iitdl1<.036 goto enda1        
  iitdl1    =  abs(iitdl1)*.00063        
  asigl1    delay     adell1,iitdl1
  asampl1   =  amainl1+asigl1
enda1:                
  asampr    =  asampr+asampr1
  asampl    =  asampl+asampl1
2:              
;--------------------------------------------------------                
;-------------EARLY REFLECTION CALCULATION LEFT WALL----- 
;--------------------------------------------------------      
  ix2       =  -(2*irxl+ix)                
  id2       =  sqrt(iy*iy+ix2*ix2)        
  iang2a    tablei    -ix2/id2,50,1,0,0           ; arccos lookup                
  iang2     =  (ix2=id2?90:90-(iang2a*iy/abs(iy)))
  idelay2   =  (id2-id)*.002066115
if   idelay2>.1||idelay2<.000022675 goto 3       
  asamp2    delay     asample,idelay2
  idismo2   =  1/id2                              ; sets 1 foot speaker separation        
  idismo2   =  (idismo2>=1?.9999:idismo2)         ; prevent pos. ampl.
  asamp2    =  idismo2*asamp2*irefl               ; distance amp. calc. 
  ihzmod2   table     idismo2,2,1                
  ihzmod2   =  (ihzmod2*19700)+300        
  asamp2    tone      asamp2,ihzmod2,0            ; distance rolloff 
;-----------------------------------------------------------                
;-----------RIGHT PAN AND ITD DELAY CLACULATION-------------
;----------------------------------------------------------- 
  itempr2   =  (iang2>90?iang2-270:iang2+90)*.5
  ipanr2    table     itempr2*.002777,3,1,0,1     ; amp info right cos table        
  asampr2   =  ipanr2*asamp2                      ; pan ampl. diff.                
  amainr2   tone      asampr2,800,0               ; unaffected by ITD        
  adelr2    =  asampr2-amainr2                    ; affected by ITD       
  iitdr2    table     (iang2+90)/360,3,1,0,1                
if   iitdr2>-.036&&iitdr2<.036 goto left2       
  iitdr2    =  abs(iitdr2)*.00063        
  asigr2    delay     adelr2,iitdr2               ; stationary ITD
  asampr2   =  amainr2+asigr2                     ; recombine parts
left2:
;---------------------------------------------------------                    
;-----------LEFT PAN AND ITD CALCULATION------------------
;--------------------------------------------------------- 
  itempl2   =  (iang2<-90?iang2+270:iang2-90)*.5
  ipanl2    table     itempl2*.0027777,3,1,0,1    ; amp info left        
  asampl2   =  ipanl2*asamp2                   
  amainl2   tone      asampl2,800,0         
  adell2    =  asampl2-amainl2                           
  iitdl2    table     (iang2+90)/360,3,1,0,1                
if   iitdl2>-.036&&iitdl2<.036 goto enda2        
  iitdl2    =  abs(iitdl2)*.00063        
  asigl2    delay     adell2,iitdl2
  asampl2   =  amainl2+asigl2
enda2:                
  asampr    =  asampr+asampr2
  asampl    =  asampl+asampl2
3:              
;--------------------------------------------------------                
;-------------EARLY REFLECTION CALCULATION FRONT WALL---- 
;--------------------------------------------------------       
  iy3       =  2*iryf-iy             
  id3       =  sqrt(iy3*iy3+ix*ix)        
  iang3a    tablei    iy3/id3,50,1,0,0            ; arccos lookup             
  iang3     =  (iy3=id3?0:-(iang3a*ix/abs(ix)))
  idelay3   =  (id3-id)*.002066115
if      idelay3>.1||idelay3<.000022675 goto 4       
  asamp3    delay     asample,idelay3
  idismo3   =  1/id3                              ; sets 1 foot speaker separation        
  idismo3   =  (idismo3>=1?.9999:idismo3)         ; prevent pos. ampl.
  asamp3    =  idismo3*asamp3*irefl               ; distance amp. calc. 
  ihzmod3   table     idismo3,2,1                
  ihzmod3   =  (ihzmod3*19700)+300        
  asamp3    tone      asamp3,ihzmod3,0            ; distance rolloff 
;-----------------------------------------------------------                
;-----------RIGHT PAN AND ITD DELAY CLACULATION-------------
;----------------------------------------------------------- 
  itempr3   =  (iang3>90?iang3-270:iang3+90)*.5
  ipanr3    table     itempr3*.002777,3,1,0,1     ; amp info right cos table        
  asampr3   =  ipanr3*asamp3                      ; pan ampl. diff.                
  amainr3   tone      asampr3,800,0               ; unaffected by ITD        
  adelr3    =  asampr3-amainr3                    ; affected by ITD       
  iitdr3    table     (iang3+90)/360,3,1,0,1
if   iitdr3>-.036&&iitdr3<.036 goto left3        
  iitdr3    =  abs(iitdr3)*.00063        
  asigr3    delay     adelr3,iitdr3               ; stationary ITD
  asampr3   =  amainr3+asigr3                     ; recombine parts
left3:  
;---------------------------------------------------------                 
;-----------LEFT PAN AND ITD CALCULATION------------------
;---------------------------------------------------------
  itempl3   =  (iang3<-90?iang3+270:iang3-90)*.5
  ipanl3    table     itempl3*.0027777,3,1,0,1    ; amp info left        
  asampl3   =  ipanl3*asamp3                   
  amainl3   tone      asampl3,800,0         
  adell3    =  asampl3-amainl3                           
  iitdl3    table     (iang3+90)/360,3,1,0,1
if   iitdl3>-.036&&iitdl3<.036 goto enda3        
  iitdl3    =  abs(iitdl3)*.00063        
  asigl3    delay     adell3,iitdl3
  asampl3   =  amainl3+asigl3
enda3:                
  asampr    =  asampr+asampr3
  asampl    =  asampl+asampl3
4:
;--------------------------------------------------------                
;-------------EARLY REFLECTION CALCULATION REAR WALL-----
;--------------------------------------------------------        
  iy4       =  -(2*iryb+iy)             
  id4       =  sqrt(iy4*iy4+ix*ix)        
  iang4a    tablei    -iy4/id4,50,1,0,0           ; arccos lookup             
  iang4b    =  (iy4=id4?180:iang4a*ix/abs(ix))
  iang4     =  (iang4b>0?iang4b-180:iang4b+180)
  idelay4   =  (id4-id)*.002066115
if              idelay4>.1||idelay4<.000022675 goto 5       
  asamp4    delay     asample,idelay4
  idismo4   =  1/id4                              ; sets 1 foot speaker separation        
  idismo4   =  (idismo4>=1?.9999:idismo4)         ; prevent pos. ampl.
  asamp4    =  idismo4*asamp4*irefl               ; distance amp. calc. 
  ihzmod4   table     idismo4,2,1                
  ihzmod4   =  (ihzmod4*19700)+300        
  asamp4    tone      asamp4,ihzmod4,0            ; distance rolloff 
;-----------------------------------------------------------                
;-----------RIGHT PAN AND ITD DELAY CLACULATION-------------
;-----------------------------------------------------------
  itempr4   =  (iang4>90?iang4-270:iang4+90)*.5
  ipanr4    table     itempr4*.002777,3,1,0,1     ; amp info right cos table        
  asampr4   =  ipanr4*asamp4                      ; pan ampl. diff.                
  amainr4   tone      asampr4,800,0               ; unaffected by ITD        
  adelr4    =  asampr4-amainr4                    ; affected by ITD       
  iitdr4    table     (iang4+90)/360,3,1,0,1
if   iitdr4>-.036&&iitdr4<.036 goto left4        
  iitdr4    =  abs(iitdr4)*.00063        
  asigr4    delay     adelr4,iitdr4               ; stationary ITD
  asampr4   =  amainr4+asigr4                     ; recombine parts
left4:  
;---------------------------------------------------------                  
;-----------LEFT PAN AND ITD CALCULATION------------------
;--------------------------------------------------------- 
  itempl4   =  (iang4<-90?iang4+270:iang4-90)*.5
  ipanl4    table     itempl4*.0027777,3,1,0,1    ; amp info left        
  asampl4   =  ipanl4*asamp4                   
  amainl4   tone      asampl4,800,0         
  adell4    =  asampl4-amainl4                           
  iitdl4    table     (iang4+90)/360,3,1,0,1
if              iitdl4>-.036&&iitdl4<.036 goto enda4        
  iitdl4    =  abs(iitdl4)*.00063        
  asigl4    delay     adell4,iitdl4
  asampl4   =  amainl4+asigl4
enda4:                
  asampr    =  asampr+asampr4
  asampl    =  asampl+asampl4
5:
            outs      asampl,asampr  
endin

