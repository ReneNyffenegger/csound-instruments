  sr        =  44100
  kr        =  4410
  ksmps     =  10
                
;macro includes
#include"PITCHC~1.TXT"  ;pitch converters
#include"SHUTOF~1.TXT"  ;shutoff macros
#include"MONOOUT.TXT"   ;monophonic output
#include"CHCLEAR.TXT"   ;channel clearer


;other includes go here
#include"ZAKINI~1.TXT"  ;the zak initializer
#include"TUNING~1.TXT"  ;the tuning proclaimer
#include"MODEPR~1.TXT"  ;the mode proclaimer
#include"CHORDP~1.TXT"  ;the chord proclaimer
#include"STRUMMER.TXT"  ;the strum performer


;instrument macros
$monoOut(198'0)
$chClear(199)

instr 70                ;a simple plucked string sound
$getPitch(p5)

  axcite    linseg    0,.1,1,.1,0,p3,0
  astring   wgpluck   icps, ampdb(p4), 1/5, 1/7, 10, 1000, axcite
  kdclk     linseg    0,.005,0,.01,1,p3-.026,1,.01,0,.001,0
            out       astring*kdclk
$forcedShutoff
endin


;This is just the first subtractive French horn with a forcedShutoff
;macro added at the end---otherwise, the "schedule" opcode gets
;bogged down.

instr 71        
                                                ;LEGATO INSTRUMENT TEMPLATE
;MAIN INIT BLOCK (ASSUMES TIE)

  idur      =  abs(p3)                            ; main init block
  ireg      =  p14                                ;register

$getPitch(p6)                   ;former pitch
  ipch1     =  ioct      
$getPitch(p13)
  ipch1     =  (p13==0?ipch1:ioct)
$getPitch(p5)                   ;initial pitch
  ipch2     =  ioct      
  iffa      =  icps*(1.5^(-ireg))                 ;effective frequency at attack
$getPitch(p12) 
  ipch3     =  (ioct<1?ipch2:ioct)                ;target pitch of glissando
  icps      =  cpsoct(ipch3)
  iffd      =  icps*(1.5^(-ireg))                 ;effective frequency at decay

  iport     =  0.031     +.02*abs(p5-p6) 

;ATT/DEC DUE TO PITCH RELATIVE TO REGISTER
  iatt      =  (iffa<85?.35:(iffa>300?.09:.35-.26*(iffa-85)/215)) ; ATTACK TIME
  idec      =  (iffd<85?.35:(iffd>200?.01:.35-.34*(iffd-85)/115)) ; DECAY TIME
  iatt      =  (iatt+(p4>86?.03:(p4<70?.45:.45-.42*(p4-70)/16)) )/2
  idec      =  (idec+(p4>96?.35:(p4<60?.01:.01+.34*(p4-60)/30)) )/2       

  irise     =  idur*p9                            ; set swell peak position
                                                        ; ... (ifall set later)
  idovib    =  1                                  ; assume we use vibrato
                                                        ; assume this is a tied note

  iswell    =  ampdb((p8+p4)<0?0:p8+p4)
  iiamp     =  ampdb(p4)                          ;tied note starts at score amp
  isusamp   =  ampdb(p4)
  inamp     =  ampdb(p7)


  i1        =  -1                                 ; phase for tied note

  itie      tival                                 ; TIED NOTE?
            tigoto    tie

;INIT BLOCK FOR FIRST OR SINGLE NOTES
  i1        =  rnd(1)                             ; first note, reset phase
  iiamp     =  0                                  ; set start db


;SHORT NOTE ADJUSTMENT BLOCK
tie:
  iadjust   =  iatt+idec                          ; long note, we're safe
if idur >= iadjust igoto doamp                    ; adjust ramp durations for
  iatt      =  (idur/2)-0.005                     ; ... short notes, 10msec limit
  idec      =  iatt                               ; can't have zero timespan
  iadjust   =  idur-0.01                          ; (ensure ilen != 0 for linseg)
  idovib    =  0                                  ; no vibrato on short notes
  iport     =  iport*.5                           ; even tighter pitch ramp

;AMPLITUDE BLOCK (ALL NOTE PERFORMANCE)
doamp:
  ilen      =  idur-iadjust        

  kamp      linseg    iiamp, iatt*.4, isusamp*(itie==1?.5:.1), iatt*.6, isusamp, ilen, isusamp, idec, inamp
  adclick   linseg    (iiamp>1?1:0),.010,1,idur-.020,1,.010,(inamp>1?1:0)

if (itie == 1) goto pitch                         ; no chiff on tied notes

;CHIFF (FIRST OR SINGLE NOTE PERFORMANCE) BLOCK
  koct      linseg    ipch2-.0055,idur,ipch3-.004 ;for singles

if (itie==0) goto expr

pitch:                  
;TIED NOTE PERFORMANCE BLOCK
;PORTAMENTO BLOCK---MODIFY FOR MARCATO
  i3        =  (p13==0?1:0)                       ;guard for glissandi in legato phrases
  koct      linseg    ipch1-(.004*i3), iport, ipch2+(.0055*i3), idur-iport, ipch3-.004

;EXPRESSION BLOCK (ALL NOTE PERFORMANCE BLOCK)
expr:
                                                ; make expression envelope
; p8 sets peak of expression point, p9 moves it if p9==0 (illegal for linseg)
  irise     =  (p9>0.?irise:iatt)                 ; set maximum accent shape
  ifall     =  idur-irise
  kswell    linseg    0, irise, iswell-isusamp, ifall, 0 ; make swell

;JITTER
  kj1       randi     .005, 1/.07, .815*i1
  kj2       randi     .005, 1/.111, .311*i1
  kj3       randi     .005, 1/1.218, .671*i1

if idovib == 0 goto play                          ; skip vibrato if short note
;VIBRATO
  kvibd     linseg    .7,iatt/2,.1, irise-iatt/2, 1, ifall, .7 ; VIBRATO DEPTH ENVELOPE
  ivibd     =  (p10==0?.01:p10)/100               ; VIBRATO DEPTH factor
  kvibd     =  kvibd*ivibd                    
  ivibr1    =  4+rnd(1)        
  ivibr2    =  6+rnd(1)        
  kvrate    linseg    ivibr1, irise, ivibr2,.25,ivibr2-1, ifall-.25, ivibr1-2 ; TIME-VARYING VIBRATO RATE
  kvib      oscil     kvibd, kvrate, 1,i1     
;TREMOLO
  ktremd    =  10^((kvib/ivibd)*p11/20)
  ktremd    =  (ktremd-1)/(ktremd+1)
  ktrem     =  1+ktremd

;port ~11.4c, jitter, ~up to 18c, vib, .5%=17c, 1%=35c

;SOUND PRODUCTION
play:
                                                ; make the note

  kcps      =  cpsoct(koct+kj1+kj2+kj3)*(1+kvib)


  kamp1     limit     (kamp+kswell)*ktrem,0,65536


  irmod     =  1.5^ireg
                                                        ;kq===fraction of audible partials
  kq        =  kamp1/65536                  
  krl       =  10^(-4.81648/(1+kq*(-2+sr/(2*kcps)))) ;everything rolls off to 2^-16 by the nyquist
  krlmax    =  10^(-9.63296*kcps/(sr-2*kcps))


  alips     gbuzz     kamp1,kcps,1378,1,krl,13,i1             

;a great many partials (1378---enough for 16Hz at 44.1kHz), ensured
;to rolloff to 2^-16 by the Nyquist frequency

  kchifa    linseg    (iiamp>1?.0005:.015)*isusamp/(irmod^2),iatt/2,0,ilen,0 ;.0005,ilen+idec,.0005
  abreath   rand      kchifa                      ;,icps,i1
  asig      =  alips+abreath

;effective formant frequencies
  iff1      =  196*irmod
  iff2      =  311*irmod
  iff3      =  381*irmod
  iff4      =  474*irmod
  iff5      =  585*irmod
  iff6      =  677*irmod
  iff7      =  775*irmod
  iff8      =  840*irmod
  iff9      =  885*irmod
  iff10     =  991*irmod
  iff11     =  1058*irmod
  iff12     =  1478*irmod
  iff13     =  1584*irmod
  iff14     =  1700*irmod
  iff15     =  1780*irmod
  iff16     =  1900*irmod
  iff17     =  2025*irmod
  iff18     =  2094*irmod
  iff19     =  2178*irmod
  iff20     =  3665*irmod
  iff21     =  4686*irmod
  iff22     =  9970*irmod
  iff23     =  11306*irmod
  iff24     =  12716*irmod
  iff25     =  13800*irmod


  k2        =  krlmax^(1/kcps)
;these factors correct for the rolloff given the register and cf
  ka1       =  34.1*(k2^(kcps-iff1))*(iff1>sr/2?0:1)
  ka2       =  12.4*(k2^(kcps-iff2))*(iff2>sr/2?0:1)
  ka3       =  33.3*(k2^(kcps-iff3))*(iff3>sr/2?0:1)
  ka4       =  86.1*(k2^(kcps-iff4))*(iff4>sr/2?0:1)
  ka5       =  33.5*(k2^(kcps-iff5))*(iff5>sr/2?0:1)
  ka6       =  20.6*(k2^(kcps-iff6))*(iff6>sr/2?0:1)
  ka7       =  26.6*(k2^(kcps-iff7))*(iff7>sr/2?0:1)
  ka8       =  15.3*(k2^(kcps-iff8))*(iff8>sr/2?0:1)
  ka9       =  19.8*(k2^(kcps-iff9))*(iff9>sr/2?0:1)
  ka10      =  13.8*(k2^(kcps-iff10))*(iff10>sr/2?0:1)
  ka11      =  10.8*(k2^(kcps-iff11))*(iff11>sr/2?0:1)
  ka12      =  3.60*(k2^(kcps-iff12))*(iff12>sr/2?0:1)
  ka13      =  1.81*(k2^(kcps-iff13))*(iff13>sr/2?0:1)
  ka14      =  2.85*(k2^(kcps-iff14))*(iff14>sr/2?0:1)
  ka15      =  3.50*(k2^(kcps-iff15))*(iff15>sr/2?0:1)
  ka16      =  1.47*(k2^(kcps-iff16))*(iff16>sr/2?0:1)
  ka17      =  .744*(k2^(kcps-iff17))*(iff17>sr/2?0:1)
  ka18      =  .580*(k2^(kcps-iff18))*(iff18>sr/2?0:1)
  ka19      =  .770*(k2^(kcps-iff19))*(iff19>sr/2?0:1)
  ka20      =  .077*(k2^(kcps-iff10))*(iff20>sr/2?0:1)
  ka21      =  .063*(k2^(kcps-iff21))*(iff21>sr/2?0:1)
  ka22      =  .017*(k2^(kcps-iff22))*(iff22>sr/2?0:1)
  ka23      =  .013*(k2^(kcps-iff23))*(iff23>sr/2?0:1)
  ka24      =  .013*(k2^(kcps-iff24))*(iff24>sr/2?0:1)
  ka25      =  .008*(k2^(kcps-iff25))*(iff25>sr/2?0:1)
                                                                ;"1/Q"--6dB
  a1        reson     asig*ka1,iff1,76*irmod,0,itie ;.388...5.15
  a2        reson     asig*ka2,iff2,102*irmod,0,itie ;.328
  a3        reson     asig*ka3,iff3,21*irmod,   0,itie ;.055
  a4        reson     asig*ka4,iff4,52*irmod,   0,itie ;.110
  a5        reson     asig*ka5,iff5,52*irmod,   0,itie ;.089
  a6        reson     asig*ka6,iff6,66*irmod,   0,itie ;.097
  a7        reson     asig*ka7,iff7,82*irmod,   0,itie ;.106
  a8        reson     asig*ka8,iff8,52*irmod,   0,itie ;.062
  a9        reson     asig*ka9,iff9,50*irmod,   0,itie ;.056
  a10       reson     asig*ka10,iff10,144*irmod,  0,itie ;.145
  a11       reson     asig*ka11,iff11,23*irmod,  0,itie ;.022
  a12       reson     asig*ka12,iff12,81*irmod,  0,itie ;.055
  a13       reson     asig*ka13,iff13,139*irmod, 0,itie ;.090
  a14       reson     asig*ka14,iff14,43*irmod,  0,itie ;.025
  a15       reson     asig*ka15,iff15,26*irmod,  0,itie ;.015
  a16       reson     asig*ka16,iff16,12*irmod,  0,itie ;.0063
  a17       reson     asig*ka17,iff17,40*irmod,  0,itie ;.020
  a18       reson     asig*ka18,iff18,78*irmod,  0,itie ;.037
  a19       reson     asig*ka19,iff19,177*irmod, 0,itie ;.081
  a20       reson     asig*ka20,iff20,100*irmod, 0,itie ;.027
  a21       reson     asig*ka21,iff21,187*irmod, 0,itie ;.040
  a22       reson     asig*ka22,iff22,109*irmod, 0,itie ;.011
  a23       reson     asig*ka23,iff23,36*irmod, 0,itie ;.0032
  a24       reson     asig*ka24,iff24,14*irmod, 0,itie ;.0011
  a25       reson     asig*ka25,iff25,405*irmod,0,itie ;.029

  afs       =  a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16+a17+a18+a19+a20+a21+a22+a23+a24+a25

  af        balance   afs,alips,(idur>.2?(icps>100?10:icps/20):5/idur),itie 

            zawm      af*adclick,p15
$forcedShutoff
endin
