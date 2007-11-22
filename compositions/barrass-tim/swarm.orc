; SWARM (ORCHESTRA OF FLIES) FLY INSTRUMENT
; Tim Barrass 1997

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gidelayperdist      =   .0045

instr 1
  idur      =  abs(p3)

  irot1     =  p4                                 ; radians
  irot2     =  p5                                 ; radians

  idist1    =  p6
  idist2    =  p7
        
  idir1     =  p8-45
  idir2     =  p9-45

  iwingfreq =  cpspch(p10)
  iflight   =  p11
  ivol      =  p12

  krot      line      irot1,idur,irot2
  kdist     line      idist1, idur,idist2
  kdir      line      idir1,idur,idir2

  iflyradius   =      2/iwingfreq
  ijointfreq   =      iwingfreq*8
  ibuzzfreq =  iwingfreq*2
  ibuzzrandvary       =   2
  iguessdoppler       =   0.1*((1.1*ibuzzfreq)+ibuzzrandvary)
  inumharmonics       =   int(sr/4/((1.1*ibuzzfreq)+ibuzzrandvary+iguessdoppler)) ; goes to half Nyquist
;------------------------------------------------------------
; ---------PITCHENVELOPE-------------------------------------
;------------------------------------------------------------
  itakeofffreq =      1.05*ibuzzfreq
  kbuzzfreq =  ibuzzfreq
if iflight     =         0 goto buzz
if iflight     =         -1 goto buzz
if iflight     =         1 goto freqenv

freqenv:
  kbuzzfreq linseg    ibuzzfreq, (.15*idur), itakeofffreq, (.3*idur), ibuzzfreq, idur, ibuzzfreq
            goto      buzz
;----------------------------------------------------------------------
; ---------------STATIC FLYING SOUND, ONE FOR EACH WING----------------
;----------------------------------------------------------------------
buzz:

  kfreqvar1 randi     ibuzzrandvary,2.7,-.5
  kbuzzfreq1   =      kbuzzfreq+kfreqvar1
;anoise1       randi     2700,sr/4,-.3 ; this gets sped up in delay
  aclicksrc1   oscil  2700,ijointfreq,1,-1
  aclicks1  oscil     aclicksrc1, kbuzzfreq1,3,-1
  abuzzsrc1 gbuzz     3500,kbuzzfreq1,inumharmonics,1,1,2,-1
  anoisybuzz1  =      abuzzsrc1+aclicks1
  abuzz1    diff      anoisybuzz1,1
    
  kfreqvar2 randi     ibuzzrandvary,2.3,-.6
  kbuzzfreq2   =      kbuzzfreq+kfreqvar2
;anoise2       randi     2700,sr/4,-.4
  aclicksrc2   oscil  2700,ijointfreq,1,-1
  aclicks2  oscil     aclicksrc2,kbuzzfreq2,3,-1
  abuzzsrc2 gbuzz     3500,kbuzzfreq2,inumharmonics,1,1,2,-1
  anoisybuzz2  =      abuzzsrc2+aclicks2
  abuzz2    diff      anoisybuzz2,1

;--------------------------------------------------
; -----------------ROTATION------------------------
;--------------------------------------------------
  kwingoffset  =      iflyradius*sin(krot)
  kdel1     =  (kdist + kwingoffset)*gidelayperdist
  kdel2     =  (kdist - kwingoffset)*gidelayperdist

;------------------------------------------------------------
;-------DOPPLER COMBINED WITH RELATIVE WING PLACEMENT--------
;------------------------------------------------------------
  adel1     delayr    .05,1
  adelwing1 deltap    kdel1
            delayw    abuzz1
  adel2     delayr    .05,1
  adelwing2 deltap    kdel2
            delayw    abuzz2
  afly      =  (adelwing1 + adelwing2)
;-----------------------------------------------------------------
; ---------AMPLITUDE ENVELOPE-------------------------------------
;-----------------------------------------------------------------
if iflight     =         0   goto spacialise
if iflight     =         -1  goto landing
if iflight     =         1   goto takeoff

landing:
  kenv      linseg    1,(5/iwingfreq),0,idur,0
  afly      =  afly*kenv
            goto      spacialise

takeoff:
  kenv      linseg    0,(.3*idur),1.1,(.4*idur),1,idur,1
  afly      =  afly*kenv
            goto      spacialise

; -----------------------------------------------
spacialise:
  aflysig   tone      afly,(19000/(kdist*kdist)+1000),1 
  kdistamp  =  ivol/(sqrt(kdist*kdist*kdist))
  kleftamp  =  sqrt(1-kdir/90)
  krightamp =  sqrt(kdir/90)
  aleft     =  aflysig*kdistamp*kleftamp
  aright    =  aflysig*kdistamp*krightamp
            outs      aleft, aright
endin
