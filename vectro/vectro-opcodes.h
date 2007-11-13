
;#include   "additive1.udo"
opcode additive1,a,kki

gitemp ftgen 0, 0, 4096,10,1

; Generate two empty tables for adsynt.
gifrqs ftgen 0, 0, 256, 7, 0, 256, 0
; A table for frequency and amp parameters.
giamps ftgen 0, 0, 256, 7, 0, 256, 0
kampx,kcps,ivoice  xin
index = 0 
loop: 
ifreq pow index + 1, 1.5 
iamp = 1 / (index+1) 
tableiw ifreq, index, gifrqs 
tableiw iamp, index, giamps 
index = index + 1
if (index < ivoice) igoto loop 
asig adsynt kampx,kcps,gitemp,gifrqs,giamps,ivoice
aout =  asig
;asig  additive1   iamp,icps,gitemp,ivoice
xout aout             ; write output

       endop
;*************************************************************
;opcode pan4delay,aa,aiiiiiiiiii

;al,ar    pan4delay    asig,ilevl,itap1,itap2,itap3,itap4,irate1,irate2,irate3,irate4,ifdbk 

;ain,ilevl,itap1,itap2,itap3,itap4,irate1,irate2,irate3,irate4,ifdbk   xin

;atap1    init 0
;atap2    init 0
;atap3    init 0
;atap4    init 0
;ataps    sum  atap1, atap2, atap3, atap4
;afdbk    = ataps*(ifdbk)
;apan1    oscil  .5, irate1, 1
;apan2    oscil  .5, irate2, 1
;apan3    oscil  .5, irate3, 1
;apan4    oscil  .5, irate4, 1
;apan1    = apan1 + .5
;apan2    = apan2 + .5
;apan3    = apan3 + .5
;apan4    = apan4 + .5
;atap1    delay  ain + afdbk, itap1, itap1
;atap2    delay  ain + afdbk, itap2, itap2
;atap3    delay  ain + afdbk, itap3, itap3
;atap4    delay  ain + afdbk, itap4, itap4
;al       = atap1*sqrt(apan1) + atap2*sqrt(1 - apan2)
;ar       = atap1*sqrt(1 - apan1) + atap2*sqrt(apan2)
;al       = al + atap3*sqrt(apan3) + atap4*sqrt(1 - apan4)
;ar       = ar + atap3*sqrt(1 - apan3) + atap4*sqrt(apan4)

;kfade     linsegr  1, 0.01, 1, 0.33, 0
;aout1 = al*kfade
;aout2 = ar*kfade
;xout aout1,aout2              ; write output

       ;endop
;************************************************************************
;CHORD
opcode chord,a,kki


kamp,kfreq,ifn  xin
;gitemp ftgen 0, 0, 8193,9,1,3,0 ,   3  ,  1 ,   0 ,   9  , .3333 ,   180 
;f10    0    1024      9    1    3      0    3    1    0    9   .3333    180 
setksmps 10

a1 oscil   kamp,kfreq,ifn
a2 oscil   kamp,kfreq*.8,ifn
a3 oscil   kamp,kfreq*1.5,ifn

aout =  (a1+a2+a3)*.2
xout aout             ; write output

       endop


;*****************************************************************************
;ORGAN (Hans Mikelson)

opcode Organ,a,kiiiiiiiiii

; GEN functions **********************************************************
; Sine




kamp,ifreq,idraw1,idraw2,idraw3,idraw4,idraw5,idraw6,idraw7,idraw8,idraw9  xin

setksmps 10

  iphase = p2
  ikey = 12*int((ifreq)-6) + 100*((ifreq)-6)
 


  iwheel1  = ((ikey-12) > 12 ? 116:117)
  iwheel2  = ((ikey+7)  > 12 ? 116:117)
  iwheel3  = (ikey      > 12 ? 116:117)
  iwheel4  = 118
  
  asubfund oscil idraw1,  .5*ifreq,      iwheel1, iphase/(ikey-12)
  asub3rd  oscil idraw2,  1.4983*ifreq,  iwheel2, iphase/(ikey+7)
  afund    oscil idraw3,  ifreq,         iwheel3, iphase/ikey
  a2nd     oscil idraw4,  2*ifreq,       iwheel4, iphase/(ikey+12)
  a3rd     oscil idraw5,  2.9966*ifreq,  iwheel4, iphase/(ikey+19)
  a4th     oscil idraw6,  4*ifreq,       iwheel4, iphase/(ikey+24)
  a5th     oscil idraw7,  5.0397*ifreq,  iwheel4, iphase/(ikey+28)
  a6th     oscil idraw8,  5.9932*ifreq,  iwheel4, iphase/(ikey+31)
  a8th     oscil idraw9,  8*ifreq,       iwheel4, iphase/(ikey+36)

  aout = kamp*(asubfund + asub3rd + afund + a2nd + a3rd + a4th + a5th + a6th + a8th)*.5
 

xout aout            ; write output

       endop
;********************************************
;********************************************
;******************************************
;**************************************************************************
;CHANT

opcode Chant,a,kkiiii


gi17 ftgen 0,0 ,1024, -7 , 600, 256,  400, 256,  250, 256 , 400 ,256 , 350
gi18 ftgen 0,0 ,1024, -7, 1040 ,256, 1620, 256, 1750 ,256 , 750, 256 , 600
gi19 ftgen 0,0 ,1024, -7, 2250, 256, 2400 ,256 ,2600, 256 ,2400, 256, 2400
gi20 ftgen 0,0, 1024, -7 ,2450, 256, 2800, 256, 3050, 256, 2600, 256, 2675
gi21 ftgen 0,0, 1024, -7, 2750, 256, 3100, 256, 3340, 256, 2900,256 ,2950,
gi22 ftgen 0,0, 1024, -7 ,  60, 256,   40, 256 ,  60, 256 ,  40, 256 ,  40
gi23 ftgen 0,0, 1024 ,-7,   70, 256,   80, 256 ,  90, 256 ,  80 ,256 ,  80
gi24 ftgen 0,0, 1024, -7 , 110, 256,  100, 256 , 100, 256 , 100, 256, 100
gi25 ftgen 0,0, 1024, -7,  120, 256 , 120, 256 , 120, 256,  120 ,256 , 120
gi26 ftgen 0,0 ,1024, -7,  130, 256 , 120, 256 , 120, 256 , 120 ,256 , 120
gi27 ftgen 0,0, 16384, 19 ,.5, .5, 270, .5 ; Rising sigmoid

klevl,kpitch,ivibr,ivibd,irate,idet xin
setksmps 10

ileng    = 100

iseed    = rnd(1)
k1       randi  .5, irate, iseed
k1       = k1 + .5

k3       lfo  ivibd, ivibr,5
k1f      table  k1, gi17, 1
k2f      table  k1, gi18, 1
k3f      table  k1, gi19, 1
k4f      table  k1, gi20, 1
k5f      table  k1, gi21, 1
k1b      table  k1, gi22, 1
k2b      table  k1, gi23, 1
k3b      table  k1, gi24, 1
k4b      table  k1, gi25, 1
k5b      table  k1, gi26, 1
kpitch   = kpitch + k3 + idet
a1       fof  1.0, kpitch, k1f, 0, k1b, .003, .02, .007, 1000, 1, gi27, ileng
a2       fof  0.7, kpitch, k2f, 0, k2b, .003, .02, .007, 1000, 1,  gi27, ileng
a3       fof  0.5, kpitch, k3f, 0, k3b, .003, .02, .007, 1000, 1,  gi27, ileng
a4       fof  0.4, kpitch, k4f, 0, k4b, .003, .02, .007, 1000, 1,  gi27, ileng
a5       fof  0.3, kpitch, k5f, 0, k5b, .003, .02, .007, 1000, 1,  gi27, ileng
aout =      (a1 + a2 + a3 + a4 + a5)
aout2 = (aout*.5)*klevl

xout aout2           ; write output

       endop
;*******************************************************************
;*******************************************************************
;*******************************************************************
;*******************************************************************

;*************CHOWNING-UDO*****************
;*******************************************


opcode CHOWglass,a,kki

kamp,knote,ifunc xin
setksmps 10

kgate         linenr    kamp, 0, .2, .01
imfreq        =         1.4 * 200
immax         =         10 * imfreq
kmenv         linseg    1, 5/6, 0, 5 - (5/6), 0
koenv         expseg    0.8, 5/6, 1, 5 - (5/6) , .01
amod          poscil    kmenv * immax, 1.414*knote, ifunc
aout          poscil    koenv * 1, knote + amod, ifunc
 
xout aout*kgate         

       endop
;********************************************
;********************************************
opcode CHOWPad,a,kkii
kamp,knote,ifilter,ifunc xin

setksmps 10
gitemp1  ftgen 0,0 ,4096,10,1
kamp2        linenr    kamp, .2, 2, .01
aop1        foscil    kamp2, 1, knote, knote, 2, ifunc
aop2        foscil    kamp2, 1, knote+2, knote+2, 2, ifunc
aop3        foscil    kamp2, 1, knote-2, knote-2, 2, ifunc
aouf        =         aop1 + aop2 + aop3
kfrs           oscil     200, .2, gitemp1
kfr         =         kfrs + 500
aoul           tone      aouf, kfr
aour           reson     aouf, kfr*4,ifilter
aout        =         (aour/3 + aoul)/10
xout aout         
endop
;********************************************
;********************************************
opcode CHOWPerc,a,kki


kamp,kcps,ifunc xin
setksmps 10

keg       expseg    .001, .01, 1, .1, .8, 999, .001
keg       linenr    keg * kamp, .01, .333, .05
kmeg      expseg    .001, .01,12000/1000, .25, .2, 999, .001
a1        foscili   keg, kcps, 1, 1.4, kmeg, 1
         
xout a1        

       endop
;********************************************
;********************************************
opcode CHOWPiano,a,kki

kamp,kcps,ifunc xin
setksmps 1
;gitemp100  ftgen 0,0 ,128 ,7, 0, 128 , 1

kndx	expon	1,	.3,	.01

a1	foscili	kamp,	kcps,	1,	12,	kndx,	ifunc
a2	foscili	kamp,	kcps + .1,	1,	12,	kndx,	ifunc
a3	foscili	kamp,	kcps - .1,	1,	12,	kndx,	ifunc

aosc	=	a1 + a2 + a3
kenv	mxadsr	.01,	.1,	.8,	.1
aosc	=	aosc * .5

aout =	(aosc*kenv)*.6
       
xout aout         

       endop
;********************************************
;********************************************
opcode CHOWrebell,a,kki


gifc2 ftgen 0,0.0 ,512 ,7 ,1 ,512 ,1
gifc3 ftgen 0,0.0, 512, 7 ,.5 ,512, .5
gifc4 ftgen 0,0.0 ,513 ,7 ,1 ,512, 0, 1, 0
gifc5 ftgen 0,0.0, 513 ,7 ,0 ,512, 1, 1, 1
gifc6 ftgen 0,0.0 ,513, 7, 1, 256, 0, 256, 1 ,1, 1


kamp,knote,ifunc xin

kgate          linenr    kamp,0,1.5,.01
kpitch1        =         knote       
kpitch2        =         kpitch1 * 1.001     
kpitch3        =         kpitch1 * 0.998     
imodbase       =         (19 <= 5 ? 19 : 5)      
imodmax        =         (19 <= 5 ? 5 : 19)       
indxbase       =         (1 <= 2 ? 1 : 2)        
indxmax        =         (1 <= 2 ? 2 : 1)   
irand = rnd(int(8)  )   
kmodchg        oscil1i   0.00,(imodmax - imodbase),irand ,gifc4       
kmod           =         imodbase + kmodchg      
kndxchg        oscil1i   0.00,(indxmax - indxbase),5,gifc5       
kndx           =         indxbase + kndxchg      
afm1           foscili   (1*.45),kpitch1,1,kmod,kndx,ifunc       
afm2           foscili   (1*.35),kpitch2,1,kmod,kndx,ifunc        
afm3           foscili   (1*.32),kpitch3,1,kmod,kndx,ifunc       
afmttl         =         afm1+afm2+afm3      
aosc1          poscil     (1 *.45),kpitch1,ifunc      
aosc2          poscil     (1 *.35),kpitch2,ifunc       
aosc3          poscil     (1 *.32),kpitch3,ifunc      
aoscttl        =         aosc1+aosc2+aosc3       
afm            =         afmttl - aoscttl;                   
icfbase        =         (3000 <= 12000 ? 3000 : 12000)      
icfmax         =         (3000 <= 12000 ? 12000 : 3000)      
kcfchg         oscil1i   0.00,(icfmax - icfbase),5,gifc6      
kcf            =         icfbase + kcfchg        
ibwbase        =         (100 <= 400 ? 100 : 400)        
ibwmax         =         (100 <= 400 ? 400 : 100)        
kbwchg         oscil1i   0.00,(ibwmax - ibwbase),5,gifc6      
kbw            =         ibwbase + kbwchg        
aflt1          reson     afm,kcf,kbw,1       
aflt2          reson     afm,(kcf*.9),(kbw*1.11),1       
abal           balance   (aflt1+aflt2),afm       
asig           envlpx    abal,.2,gifc5,(gifc5*.39),gifc5,1,.01                       

xout asig*kgate         

       endop
;********************************************
;********************************************
opcode CHOWSoprano,a,kki
kveloc,knote,ifunc xin
;setksmps 10
kgate          linenr    kveloc,0,2,.01
        k7     =         knote
        k2     =         7000
        k2     =         (k2/k7)+.5
        k2     =         int(k2)
        k3     =         .04
        k4     =         .25
        k5     =         5*.4
        k6     =         5
        k8     =         k5/k4
        k9     =         exp(1.5*log(7000/32767))
        k10    =         .00311*log(k7)
        k11    =         sqrt(7000/32767)
        k12    =         (1-k3)*k11
        k13    =         k4*k7
        k14    =         k9*k3
a1             linen     k12,.1,3,.08
a2             poscil     k13,k7,ifunc
a8             =         k7+a2
a4             linenr    k10,.6,3,.1
a4             poscil     a4,k6,ifunc
a5             randi     k10,16
a6             linseg    -.03,.07,.03,.03,0,3-.1,0
a6             =         a4+a5+a6+1.
a1             oscili    a1,(a8+a2)*a6,ifunc
a7             =         (a2*k8)+k2
a3             linseg    0,.07,.1,.03,1.,3-.18,1,.02,.1,.06,0
a3             =         a3*(k9*k3)
a3             oscili    a3,a7*a6,ifunc
aout    =  (a1+a3)*kgate
xout aout*1.2        

       endop
;********************************************
;********************************************
opcode CHOWString,a,kki

kamp,knote,ifunc xin
setksmps 10
iveloc         ampmidi   1

kgate          linenr    1, 0, .2, .01
ifc            =         cpspch(5.00)
ifm1           =         ifc
ifm2           =         ifc*3
ifm3           =         ifc*4
indx1          =         7.5/log(ifc)                  ;RANGE FROM CA 2 TO 1
indx2          =         15/sqrt(ifc)                  ;RANGE FROM CA 2.6 TO .5
indx3          =         1.25/sqrt(ifc)                ;RANGE FROM CA .2 TO .038
kvib           init      0               
timout    0,.75,transient

kvbctl         linen     1,.5,2-.75,.1
krnd           randi     .0075,15                      ;RANDOM DEVIATION IN VIB WIDTH        
kvib           poscil   kvbctl*.03+krnd,5.5*kvbctl,ifunc

transient:
timout    .2,2,continue

ktrans         linseg    1,.2,0,1,0     ;TRANSIENT ENVELOPE
anoise         randi     ktrans,.2*ifc         ;NOISE... 
attack         poscil    anoise,knote,ifunc
 
continue:      

amod1          poscil   ifm1*(indx1+ktrans),knote,ifunc
amod2          poscil    ifm2*(indx2+ktrans),knote*3,ifunc
amod3          poscil    ifm3*(indx3+ktrans),knote*4,ifunc
asig           poscil    kamp,(amod1+amod2+amod3)*(1+kvib),ifunc
asig           linen     asig+attack,.2,2,.2

xout  asig *kgate      
       endop
;********************************************
;********************************************
opcode CHOWTrumpet,a,kki

gitemp2 ftgen 0,0,129,9,.35,1,0
gitemp3 ftgen 0,0,129,9,.4,1,0
gitemp4 ftgen 0,0,129,9,.25,1,0
gitemp5 ftgen 0,0,129,9,.3875,1.4142,0
 
kamp,knote,ifunc xin

setksmps 10

kgate          linenr         kamp/2, 0, .2, .01
irandev        =              .007
ifreqrand      =              125
ivibatt        =              .6
ivibdec        =              .2
ivibwth        =              .007
ivibrate       =              7
iportdev       =              .03
iportatt       =              .06
iportdec       =              .01
iampfac        =              .833
iafrmfac       =              1-iampfac
imax           =              2.66
iratio         =              1.8/imax
ifundatt       =              .03
ifunddec       =              .15
ifrmatt        =              .03
ifrmdec        =              .3
imodatt        =              .03
imoddec        =              .01

kphs           linen          ivibwth, ivibatt, 1, ivibdec
kvfac          tablei         kphs, gitemp4, ifunc
kvibgate       =              kvfac*ivibwth 
kport          envlpx         iportdev, iportatt, 1, iportdec, gitemp5, 1, .01
krand          randi          irandev, ifreqrand, -1
kosc           poscil          kvibgate, ivibrate, ifunc
kvib           =              (krand+1)*(kosc+1)*(kport+1)
       
kgatemod       envlpx         imax*knote, imodatt, 1, imoddec, gitemp3, 1.2, .01, .2
kgatefd        envlpx         iampfac, ifundatt, 1, ifunddec, gitemp2, 1, .01
kgatefrm       envlpx         iafrmfac, ifrmatt, 1, ifrmdec, gitemp2, 1, .01
amod           poscil         kgatemod, knote*kvib, ifunc
afund          poscil         kgatefd, knote*kvib+amod, ifunc
afrm           poscil         kgatefrm, (int(1500/knote+.5)*knote)*kvib+amod*iratio, ifunc
xout            (afund+afrm)*kgate
 endop
;********************************************
;********************************************
opcode CHOWVibr,a,kki

kamp,kifc,ifunc xin

setksmps 10

gitemp100  ftgen 0,0 ,128 ,7, 0, 128 , 1
       
        kifm1        =         kifc

        kifm2        =         kifc*3

        kifm3        =         kifc*4

        kindx1       =         7.5/log(kifc)        ;RANGE FROM CA 2 TO 1

        kindx2       =         15/sqrt(kifc)        ;RANGE FROM CA 2.6 TO .5

        kindx3       =         1.25/sqrt(kifc)      ;RANGE FROM CA .2 TO .038

        kvib        init      0               
 

                    timout    0,0.75,transient               ;DELAYS VIBRATO FOR P8 SECONDS

        kvbctl      linen     1,.5,10,.1                    ;VIBRATO CONTROL ENVELOPE

        krnd        randi     .0075,15                      ;RANDOM DEVIATION IN VIB WIDTH        

        kvib        oscili    kvbctl*.03+krnd,5.5*kvbctl,ifunc  ;VIBRATO GENERATOR

        

transient:

                    timout    .2,10,continue                ;EXECUTE FOR .2 SECS ONLY

        ktrans      linseg    1,.2,0,1,0                    ;TRANSIENT ENVELOPE 

        anoise      randi     ktrans,.2*kifc                 ;NOISE... 

        attack      poscil     anoise,2000,ifunc                  ;...CENTERED AROUND 2KHZ
 

continue:      

        amod1       oscili    kifm1*(kindx1+ktrans),kifm1,ifunc 

        amod2       oscili    kifm2*(kindx2+ktrans),kifm2,ifunc 

        amod3       oscili    kifm3*(kindx3+ktrans),kifm3,ifunc 

        asig        oscili    kamp,(kifc+amod1+amod2+amod3)*(1+kvib),ifunc

        asig        linen     asig+attack,.26,10,.2

        imax        ampmidi   1, gitemp100

        kgate       linenr    imax, 0, 1, .01

                    aout   =    asig * kgate

xout aout         

       endop
;********************************************
;********************************************
opcode CHOWwown,a,kki

gitemp1 ftgen  0, 0, 513, 7, 0, 100, 1, 392, .9 ,20, 0
gitemp2 ftgen  0, 0, 513, 7, 0, 100, 1 ,412, 1
 
kamp,knote,ifunc  xin
setksmps 10

kgate          linenr    kamp,0,2,.01
 
k1             randi     5,10                     ;5,100 =BUZZY
k2             linseg    1,5,10
i1             =         1/5                      ; ONE CYCLE PER DURATION OF NOTE
i2             =         1 * 440                  ; CALCULATES DEVIATION FOR INDEX 1
i3             =         (10-1) * (440*.5)+11     ; CALCULATES DEVIATION FOR INDEX 2
 
ampcar         poscil     1,i1,gitemp1                 ; AMPLITUDE ENVELOPE FOR THE CARRIER
ampmod         poscil     i3+k2,i1,gitemp2               ; AMPLITUDE ENVELOPE FOR THE MODULATOR
amod           oscili    ampmod+i2+k1,knote,ifunc     ; MODULATING OSCILLATOR ALSO K1+P6
k3             linseg    440,5,440*.9
asig           oscili    ampcar,k3+amod,ifunc         ; CARRIER OSCILLATOR
k1             linseg    1,5*.9,1,5*.1,1*.1
xout      (asig *k1)*kgate

endop
;********************************************
;********************************************
opcode CHOWClar,a,kk

gitemp1 ftgen  0,0, 8192, -12, 8
gitemp2 ftgen  0,0, 8192, 9,   1, 1, 0
gitemp3 ftgen  0,0, 8192, 9,   1, 1, 90


kamp,knote  xin
setksmps 10
;inote          cpsmidib

;iveloc         ampmidi 1

kgate          linenr    kamp,0,1,.01

kenv           linseg    0,0.1,1,2-0.3,1,0.2,0

kramp          linseg    0,2/2,4,2/2,0

k1             =         kramp * (.8 - 1/.8)/2

k2a            =         kramp * (.8 + 1/.8)/2

k2b            =         200 * k2a

k3a            table     k1*2,gitemp1,0,0,0

k3b            =         k3a * (-1/2)

a1             poscil     k2b,knote*2,gitemp3

a2             poscil     k1,knote*2,gitemp3

a3             =         kenv* exp(a2+k3b)

asig           poscil     a3,knote+a1,gitemp2

   xout asig*kgate

endop
;********************************************
;********************************************
opcode CHOWLoop,a,kki                                 

gitemp1 ftgen  0,  0,  513, 5,   .7,  16,      .8,48, 1 ,    64,      .8, 128,.2, 256, .001

gitemp2 ftgen  0,  0,  513, 7,  0 ,   12,      1,  52, 0,    460,     0


kamp,kfreq,ifunc  xin
    
kgate     linenr    kamp, 0, .2, .01
i1        =         1/.2
idev1     =         0 * 110
idev2     =         (25-0) * 110
ampcar    poscil    1, i1, gitemp1
ampmod    poscil    idev2, i1,gitemp2
amod      oscili    ampmod+idev1, kfreq*1,ifunc
asig      oscili    ampcar, kfreq+amod,ifunc

xout      asig*kgate 

  endop
;********************************************
;********************************************
;*************RISSET-UDO*****************
;*******************************************
opcode RissBell,a,iki

gisine  ftgen 0 , 0 , 32768  , -9  ,  -2 ,1 ,1 , 1,  1, 1, 1
;f2 0 513 5 1024 512 1
;gisine  ftgen 0 , 0 , 513 ,5, 1024, 512, 1


iamp,kfqc,ifunc   xin
setksmps 10
idur  = 100
;kamp  = klevel/11  ; scale iamp to the number of oscillators
ilevel = iamp/11
kae1    expon    ilevel,        idur,       ifunc
kae2    expon   (ilevel* .67), (idur*.9  ), ifunc
kae3    expon    ilevel,       (idur*.65 ), ifunc
kae4    expon   (ilevel*1.8 ), (idur*.55 ), ifunc
kae5    expon   (ilevel*2.67), (idur*.325), ifunc
kae6    expon   (ilevel*1.67), (idur*.35 ), ifunc
kae7    expon   (ilevel*1.46), (idur*.25 ), ifunc
kae8    expon   (ilevel*1.33), (idur*.2  ), ifunc
kae9    expon   (ilevel*1.33), (idur*.15 ), ifunc
kae10   expon   ilevel,        (idur*.1  ), ifunc
kae11   expon   (ilevel*1.33), (idur*.075), ifunc

a1    poscil    kae1, (kfqc* .56), gisine
a2    poscil    kae2, (kfqc* .56+1),gisine
a3    poscil    kae3, (kfqc* .92), gisine
a4    poscil    kae4, (kfqc* .92+1.7),gisine
a5    poscil    kae5, (kfqc*1.19), gisine
a6    poscil    kae6, (kfqc*1.7 ), gisine
a7    poscil    kae7, (kfqc*2   ), gisine
a8    poscil    kae8, (kfqc*2.74), gisine
a9    poscil    kae9, (kfqc*3   ), gisine
a10   poscil    kae10,(kfqc*3.76), gisine
a11   poscil    kae11,(kfqc*4.07), gisine

aout =        (a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11)*.5

kdeclick  linsegr  1, 0.01, 1, 0.33*1, 0

xout aout *kdeclick            ; write output

       endop

;******************************************************
;******************************************************
opcode RissClar,a,kk

gisine1  ftgen 0 ,0 ,512, 7, -1, 200, -.5, 112, .5 ,200, 1
gisine3  ftgen 0 ,  0, 512, 9, 1, 1, 0

kveloc,knote  xin

setksmps 10
kgate         linenr         kveloc,0,.2,.01
a1            linen          255,.085,.75,100
a1            poscil         a1,knote,gisine3
a1            table          a1+256,gisine1
xout            a1*kgate
endop

;******************************************************
;******************************************************
opcode RissDrum2,a,kk

gitemp1  ftgen 0 ,0, 512, 5, 1, 512, .004
gitemp2  ftgen 0 ,0, 512, 5, 1, 512, .00012
gitemp3  ftgen 0 ,0, 512, 9, 10, 1, 0, 16, 1.5, 0, 22, 2, 0, 23, 1.5, 0
gitemp4  ftgen 0 ,0, 512, 9, 1, 1, 0

kveloc,knote  xin

setksmps 10

kgate     linenr    kveloc/2, 0, .2, .01

                             
i3             =         23000/2                           
i4             =         23000/6                            
i5             =         3000/2.5
 
a1             oscili    i3,1,gitemp2                         
a1             randi     a1,400                             
a1             oscili    a1,500,gitemp4                         
a2             oscili    i4,1,gitemp2                         
a2             oscili    a2,knote*.1,gitemp3                     
a3             oscili    i5,1,gitemp1                            
a3             oscili    a3,knote,gitemp4                        
a4             linseg    1,1-.05,1,.05,0,.01,0
aout = (a4*(a1+a2+a3))*.0002
xout       aout*kgate

endop

;******************************************************
;******************************************************
opcode RissDrum,a,kk

gitemp1  ftgen 0 , 0 ,512, 9 ,1, 1, 0
gitemp2  ftgen 0 , 0, 512, 5 ,4096 ,512, 1
gitemp3  ftgen 0 , 0, 512, 9 ,10 ,1 ,0, 16, 1.5, 0 ,22, 2 ,0, 23 ,1.5, 0
gitemp4  ftgen 0 , 0, 512, 9, 1, 1, 0
gitemp5  ftgen 0 , 0, 512, 5, 256, 512, 1

kveloc,knote  xin

setksmps 10

kgate     linenr    kveloc/2, 0, .2, .01
i1        =         6000*.3
i2        =         500*.1
i3        =         1
i4        =         6000*.8
i5        =         500
a1     randi     6000,4000
a1     poscil     a1,i3,gitemp2
a1     poscil     a1,3000,gitemp1
a2     poscil     i1,i3,gitemp2
a2     poscil     a2,knote*.01,gitemp3
a3     poscil     i4,i3,gitemp5
a3     poscil     a3,knote,gitemp4
aout = (a1+a2+a3)*.0001
xout       aout*kgate
 
endop

;******************************************************
;******************************************************
;************************************************
opcode RissGliss,a,iki




iamp,kfreq,ifunc  xin

setksmps 10
;-irise

irise = .5
kenv1 expseg .01, irise, iamp*1200,1000-irise,1
k1 randi kfreq*.05, 1, .2/(1000)
k2 randi kfreq*.25, .1, .3/(1000)
a1 oscili kenv1, kfreq+k1+k2, ifunc
kenv11 expseg .01, irise, iamp*.83*1200,1000-irise,1
k11 randi kfreq*.05*1.154, 1, .2/(1000)
k12 randi kfreq*.25*1.154, .1, .3/(1000)
a11 oscili kenv11, kfreq*1.154+k11+k12, ifunc
kenv21 expseg .01, irise, iamp*.33*1200,1000-irise,1
k21 randi kfreq*.051*.417, 1, .2/(1000)
k22 randi kfreq*.25*1.417, .1, .3/(1000)
a21 oscili kenv21, kfreq*1.417+k21+k22, ifunc
kenv31 expseg .01, irise, iamp*.67*1200,1000-irise,1
k31 randi kfreq*.05*1.604, 1, .2/(1000)
k32 randi kfreq*.25*1.604, .1, .3/(1000)
a31 oscili kenv31, kfreq*1.604+k31+k32, ifunc
kenv41 expseg .01, irise, iamp*1200,1000-irise,1
k41 randi kfreq*.05*2.521, 1, .2/(1000)
k42 randi kfreq*.25*2.521, .1, .3/(1000)
a41 oscili kenv41, kfreq*2.521+k41+k42, ifunc
kenv51 expseg .01, irise, iamp*.33*1200,1000-irise,1
k51 randi kfreq*.05*2.792, 1, .2/(1000)
k52 randi kfreq*.25*2.792, .1, .3/(1000)
a51 oscili kenv51, kfreq*2.792+k51+k52, ifunc
kenv61 expseg .01, irise, iamp*.33*1200,1000-irise,1
k61 randi kfreq*.05*3.383, 1, .2/(1000)
k62 randi kfreq*.25*3.383, .1, .3/(1000)
a61 oscili kenv61, kfreq*3.383+k61+k62, ifunc
a1=(a1+a11+a21+a31+a41+a51+a61)*.01

;kenv71 expseg .01, irise, 1, 100*.5, 1, 100*.5-irise, 1

;kdeclick linsegr  0,.1,1,.3,.5,0.001,.01
kdeclick  linsegr  0.01, 0.01, 1, 0.33*1, 0

xout ((a1)*kdeclick)*.02       ; write output

       endop
;******************************************************
;******************************************************
;************************************************
opcode RissFlute,a,kk

gitemp1  ftgen 0 ,0, 512, 9 ,1 ,.26,0
gitemp2  ftgen 0 , 0, 512, 10, 1, .4, .2, .1, .1, .05     

kamp,kfreq  xin

setksmps 10

k1        randi     (kamp*.01),5
k1        =         k1 + kamp
k2        poscil    k1,1/.24,gitemp1
k2        =         k2 + .74
a1        oscili    k2,kfreq,gitemp2
kdeclick  linsegr  0.1, 0.01, 1, 0.33*1, 0
      xout      a1*kdeclick
          endop
;******************************************************
;******************************************************

opcode RissHarmon,a,kk
gisine  ftgen 0 , 0, 1024, 10, 1 ,0, 0 ,0 , .7, .7, .7, .7 ,.7, .7 

kveloc,knote  xin

setksmps 10

kgate          linenr    kveloc,1,2,.01
i1             =         .03
i2             =         2*.03
i3             =         3*.03
i4             =         4*.03
ampenv         linenr    9,.01,1,.01      
a1             oscili    ampenv,knote,gisine       
a2             oscili    ampenv,knote+i1,gisine    
a3             oscili    ampenv,knote+i2,gisine    
a4             oscili    ampenv,knote+i3,gisine 
a5             oscili    ampenv,knote+i4,gisine 
a6             oscili    ampenv,knote-i1,gisine 
a7             oscili    ampenv,knote-i2,gisine 
a8             oscili    ampenv,knote-i3,gisine 
a9             oscili    ampenv,knote-i4,gisine 
aout =      ((a1+a2+a3+a4+a5+a6+a7+a8+a9)*kgate)*.05
xout aout
endop
;******************************************************
;******************************************************

opcode RissNoise,a,ik


gitemp1  ftgen 0 ,0,	8192,	10,	1
gitemp2  ftgen 0 ,0,	8192,	7,	-1,	8192,	1
gitemp3  ftgen 0 ,0,	8192,	7,	1,	4096,	1,	0,	-1,	4096,	-1
gitemp4  ftgen 0 ,0,	8192,	21,	1

iveloc,knote  xin

kenv	linsegr	0,.01,iveloc, 1, iveloc,2,iveloc*.2,.25, 0
aosc	poscil	kenv, 440, gitemp4
kenv	expon	2, 1, .01
aosc2	butterbp	aosc, knote, knote * kenv
aosc2	butterbp	aosc2, knote, knote * kenv
aosc	balance	aosc2, aosc
aosc	=	aosc * .7
xout	aosc

endop

;******************************************************
;******************************************************
opcode RissOctave,a,kkki



gitemp2  ftgen 0 ,0, 128, 8, 0, .5, 0, 63.5, 1, 63.5, 0, .5 ,0


kamp,kfreq,krate,ifunc  xin

setksmps 10
;-irise

iphsoff   =         (65/5)*.01

ka1       =         kamp
iph1      =         0
kamp1     poscil    ka1,krate,gitemp2,iph1
kfreq1    =         kfreq
asig1     poscil    kamp1,kfreq1,ifunc

ka2       =         kamp
iph2      =         iph1+iphsoff
kamp2     poscil    ka2,krate,gitemp2,iph2
kfreq2    =         kfreq*2
asig2     poscil    kamp2,kfreq2,ifunc

ka3       =         kamp
iph3      =         iph2+iphsoff
kamp3     poscil    ka3,krate,gitemp2,iph3
kfreq3    =         kfreq*3
asig3     poscil    kamp3,kfreq3,ifunc

ka4       =         kamp
iph4      =         iph3+iphsoff
kamp4     poscil    ka4,krate,gitemp2,iph4
kfreq4    =         kfreq*4
asig4     poscil    kamp4,kfreq4,ifunc

ka5       =         kamp
iph5      =         iph4+iphsoff
kamp5     poscil    ka5,krate,gitemp2,iph5
kfreq5    =         kfreq*5
asig5     poscil    kamp5,kfreq5,ifunc

add       =         asig1+asig2+asig3+asig4+asig5
;kenv      linseg    0,p3/2,1,p3/2,0
aout      =         add
kdeclick  linsegr  0.01, 0.01, 1, 0.33*1, 0
xout      (aout*.5)*kdeclick
   endop

;******************************************************
;******************************************************


opcode RissRing,a,kk


gitemp2  ftgen 0 ,0, 512, 7, 0, 43, 1, 171, 1, 84, -1, 171, -1, 43, 0
gitemp3  ftgen 0 ,0, 512, 9, 1, 1, 0


kveloc,knote  xin
kgate     linenr         kveloc/2, 0, .2, .01
a1        expseg         .2,2.3,1,1-.01,.001
a1        oscili         a1,knote,gitemp3
a2        oscili         10000,1500,gitemp2
aout = (a1*a2)*.001
xout       aout*kgate

endop

;******************************************************
;******************************************************

