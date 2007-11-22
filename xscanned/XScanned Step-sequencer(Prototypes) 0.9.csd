

;XScanned  Step-sequencer version
;Version 0.9
;9-4-2007
;A Scanned synthesizer for csound5.
;by Giorgio Zucco
;Released under the GPL license (see gpl.txt).


;for contacts,questions,send mail to:
;giorgiobrx@libero.it

 
<CsoundSynthesizer> 
<CsOptions> 

-odevaudio1 -m0 -M0 -b1024 -B4000 
</CsOptions>
<CsInstruments>


sr = 44100
kr = 441
ksmps = 100
nchnls = 2

#define PRESETS #"Scans-preset.txt"# ;edit filename and directory for presets-save
#define GColor #193, 255, 193,# ;GLOBAL color
#define  AudioFilename #"Scanned.aif"#  ;edit filename and directory for audio recording
#define LEVELRECORDING #1.5# ;level mic initial

gafx1 init 0
gafx2 init 0
ga1   init 0 
ga2   init 0;inizializzo il vu-meter
gafout1   init 0 ;hard disk recording
gafout2   init 0
gafout3   init 0
gafout4   init 0


;maxalloc 1,3

;omni midi
massign 1,1
massign 2,1
massign 3,1
massign 4,1
massign 5,1
massign 6,1
massign 7,1
massign 8,1
massign 9,1
massign 10,1
massign 11,1
massign 12,1
massign 13,1
massign 14,1
massign 15,1
massign 16,1
;set here the color of panel;The range for each RGB component is 0-255
;FLcolor   115,0,0 
 
FLpanel "XScanned Step-sequencer 0.9", 580,610, 100, 100
itabswidth = 560
itabsheight = 600
ix = 5
iy = 5
FLtabs itabswidth,itabsheight, ix,iy

    itab1width = 560
    itab1height = 600
    itab1x = 10
    itab1y = 40
    FLgroup "Scanned", itab1width, itab1height, itab1x, itab1y


;BORDERS			ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihbordosc	FLbox  	" ", 	6,        9,    15,    369,    202,   10, 45

 
;some widgets should contained here
gk1,gih1 FLslider "Scan-rate",.05, 1, -1,  5,   -1, 340,13,15, 50
;FLsetColor 0,128,0,gih1
FLsetFont 2,gih1
FLsetTextColor 0,0,0,gih1
FLsetColor2 $GColor gih1
FLsetTextSize 10, gih1

gk2,gih2 FLslider "stiffness",.01, 1, -1,  5,   -1, 340,13,15, 75
;FLsetColor 0,128,0,gih2
FLsetFont 2,gih2
FLsetTextColor 0,0,0,gih2
FLsetColor2 $GColor gih2
FLsetTextSize 10, gih2

gk3,gih3 FLslider "centering",.01, 1, -1,  5,   -1, 340,13,15, 105
;FLsetColor 0,128,0,gih3
FLsetFont 2,gih3
FLsetTextColor 0,0,0,gih3
FLsetColor2 $GColor gih3
FLsetTextSize 10, gih3

gk5,gih5 FLslider "mass",2, 50, -1,  5,   -1, 340,13,15, 135
;FLsetColor 0,128,0,gih5
FLsetFont 2,gih5
FLsetTextColor 0,0,0,gih5
FLsetColor2 $GColor gih5
FLsetTextSize 10, gih5

gk11,gih11 FLslider "position",0.1, 1, -1,  5,   -1, 340,13,15, 160
;FLsetColor 0,128,0,gih5
FLsetFont 2,gih11
FLsetTextColor 0,0,0,gih11
FLsetColor2 $GColor gih11
FLsetTextSize 10, gih11

gk12,gih12 FLslider "left-hammer",.1, .9, -1,  5,   -1, 340,13,15, 190
;FLsetColor 0,128,0,gih5
FLsetFont 2,gih12
FLsetTextColor 0,0,0,gih12
FLsetColor2 $GColor gih12
FLsetTextSize 9, gih12

gk13,gih13 FLslider "right-hammer",.1, .9, -1,  5,   -1, 340,13,15, 215
;FLsetColor 0,128,0,gih5
FLsetFont 2,gih13
FLsetTextColor 0,0,0,gih13
FLsetColor2 $GColor gih13
FLsetTextSize 9, gih13


gk6,gih6 FLknob "Reverb", .2,.95, -1, 1, -1,  60, 440, 40,50
;FLsetColor 0,128,0,gih6
FLsetFont 4,gih6
FLsetTextColor 0,0,0,gih6
FLsetColor2 $GColor gih6

;springs
gk4,gih4 FLcount "", 1, 5, 1, 5, 1, 160, 22, 390, 126,0, 3, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 4,gih4
FLsetTextColor 64, 64, 64,gih4
FLsetColor2 $GColor gih4

;FLsetTextColor 255,255,80,gihv5osc


gktraj,gitraj FLcount "Trajectory", 7, 10, 1, 10, 1, 160, 22, 390, 180,0, 3, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 4,gitraj
FLsetTextColor 64, 64, 64,gitraj
FLsetColor2 $GColor gitraj

;**************filter******************************
;BORDERS			ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihbordfilt	FLbox  	" ", 	6,        9,    15,    284,    250,   280, 245


gkfilt,gifilt FLcount "", 0, 3, 1, 3, 1, 130, 19, 290, 262,0, 1, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 4,gifilt
FLsetTextColor 64, 64, 64,gifilt
FLsetColor2 $GColor gifilt

;JOYSTICK FILTERS
;koutx, kouty, ihandlex, ihandley FLjoy "label", iminx, imaxx, iminy, imaxy, iexpx, iexpy, idispx, idispy, iwidth, iheight, ix,  iy
gkjoy1,gkjoy2,gihjoy1,gihjoy2 FLjoy "Filters", 650,   22000,.1,    .8,    -1,    0,    -1,     -1,     190,    165,     310, 314
FLsetColor 200, 180, 200, gihjoy1

;Auto filter
gkauto,gihauto    FLbutton "Auto", 1,0, 2, 80, 15, 447,252, 0, 1, 0, 0
FLsetColor2 $GColor gihauto

gkratefl,giratefl FLslider "rate",.1, 6, -1,  5,   -1, 120,10,430, 280
;******************************************************************************************************************


;BORDERS			ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihbordadsr	FLbox  	" ", 	6,        9,    15,    264,    250,   10, 245

;*****************ADSR
;some widgets should contained here
gk7,gih7 FLslider "A",.01,2, 0,  1,   -1, 215,15,30, 260
;FLsetColor 0,128,0,gih1
FLsetFont 4,gih7
FLsetTextColor 0,0,0,gih7
FLsetColor2 $GColor gih7

gk8,gih8 FLslider "D",0,.5, 0,  1,   -1, 215,15,30, 300
;FLsetColor 0,128,0,gih1
FLsetFont 4,gih8
FLsetTextColor 0,0,0,gih8
FLsetColor2 $GColor gih8

gk9,gih9 FLslider "S",0.01,1, 0,  1,   -1, 215,15,30, 340
;FLsetColor 0,128,0,gih1
FLsetFont 4,gih9
FLsetTextColor 0,0,0,gih9
FLsetColor2 $GColor gih9


gk10,gih10 FLslider "R",0,1, 0,  1,   -1, 215,15,30, 380
;FLsetColor 0,128,0,gih1
FLsetFont 4,gih10
FLsetTextColor 0,0,0,gih10
FLsetColor2 $GColor gih10


;RANDOMIZE ADSR
gkrand,gihrand     FLbutton "Rand-ADSR", 1,0, 2, 100, 20, 25,420, 0, 5, 0, 0
FLsetColor2 $GColor gihrand
;RANDOMIZE global
gkglrand,giglhrand     FLbutton "Global-rand", 1,0, 2, 100, 20, 150,420, 0, 7, 0, 0
FLsetColor2 $GColor giglhrand

;VU METER
;**********************************************************************************************

gk90,gihvu	FLslider	"Vu-meter", 0,32000,0,1, -1, 205,18, 360,574
	FLsetColor2 22,20, 220,  gihvu
        FLsetColor  193,215,88, gihvu
FLsetFont 4,gihvu

;****************RECORDING*******************************************************
;fout
ihlevelrec 	FLbox  	" ", 	                 6,     9,    15,    285,    55,     280, 505	;border
;FLsetColor 130,137,156,ihlevelrec   ;grigio

gkhdrec,gihdrec    FLbutton "", 1,0, 2, 54, 29, 480,518, 0, 9, 0, 0
FLsetTextColor 255,0,0,gihdrec
;gkrand2,gihrand2   FLbutton "RAND-LFO", 1,0, 2, 110, 20,  550,600, 0, 13, 0, 0

;gkhdrec2,gihdrec2    FLbutton "@square  Rec", 1,0, 2, 60, 30, 730,635, 0, 13, 0, 0
;FLsetTextColor 255,0,0,gihdrec2
;gkrand2,gihrand2   FLbutton "RAND-LFO", 1,0, 2, 110, 20,  550,600, 0, 13, 0, 0

gklevrec,gilevrec FLslider "Level-recording" ,1,3, 0, 1,   -1, 130,11,302, 511
FLsetColor2 $GColor gilevrec
FLsetFont 4,gilevrec
;*****************************LFO********************************************
ihbordlfo 	FLbox  	" ", 	                 6,     9,    15,    265,    55,     10, 505	;border
;FLsetColor 130,137,156,ihbordlfo   


gklfoty,gilfoty FLcount "", 0, 5, 1, 5, 1, 94, 18, 172, 512,0, 10, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 2,gilfoty
;FLsetTextColor 64, 64, 64,gilfoty
FLsetColor2 $GColor gilfoty
FLsetTextSize 11, gilfoty

gklforate,gilforate FLknob "Lfo-rate", .1,50, -1, 1, -1,  40, 110, 507,50
FLsetColor 130,137,156,gilforate
FLsetFont 1,gilforate
FLsetTextColor 0,0,0,gilforate
FLsetColor2 $GColor gilforate
FLsetTextSize 10, gilforate

gklfolevl,gilfolevl FLknob "Lfo-level", .1,50, -1, 1, -1,  40, 40, 507,50
FLsetColor 130,137,156,gilfolevl
FLsetFont 1,gilfolevl
FLsetTextColor 0,0,0,gilfolevl
FLsetColor2 $GColor gilfolevl
FLsetTextSize 10, gilfolevl
;**************************************************************

;EFFECTS*********************************************************
gkselfx,giselfx FLcount "", 0, 3, 1, 3, 1,122, 22, 32, 568,0, 1, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 2,giselfx
;FLsetTextColor 64, 64, 64,gilfoty
FLsetColor2 $GColor giselfx
FLsetTextSize 12, giselfx

;tuning*********************************************************

gktuning,gituning FLcount "", 101, 115, 1, 115, 1,142, 22, 25, 454,0, 11, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 2,gituning
;FLsetTextColor 64, 64, 64,gilfoty
FLsetColor2 $GColor gituning
FLsetTextSize 12, gituning
FLhide   gituning

FLgroupEnd



    itab2width = 550
    itab2height = 600
    itab2x = 10
    itab2y = 40
    FLgroup "About", itab2width, itab2height, itab2x, itab2y
giabout1	FLbox	"XScanned Version 0.9\A Scanned synthesizer for csound5 by Giorgio Zucco", 1, 5, 18, 280, 120, 65, 111
       
    FLgroupEnd

    
FLtabsEnd
FLpanelEnd
; Run the widget thread!



FLsetVal_i .1,gih1
FLsetVal_i .1,gih2
FLsetVal_i .1,gih3
FLsetVal_i  1,gih4
FLsetVal_i  2,gih5 ;damp
FLsetVal_i  .2,gih6  ;reverb
;adsr
FLsetVal_i .01,gih7
FLsetVal_i .1,gih8
FLsetVal_i .5,gih9
FLsetVal_i  .1,gih10
FLsetVal_i  7,gitraj
FLsetVal_i  0,gifilt
;level rec
FLsetVal_i $LEVELRECORDING,gilevrec
FLsetVal_i  .4,giratefl ;rate auto filter
FLsetVal_i  0,gilfoty ;lfo waveform
FLsetVal_i  101,gituning ;tuning
 
;************************************************************************************************


FLrun
 



;scanned
;f1 0 128 7 0 64 1 64 0

gitemp	ftgen 11111 ,   0, 128, 10, 1 
gitemp	ftgen  22222,   0 ,128, -7,  1, 128, .8

gitemp	ftgen  1, 0, 16384, -23,  "string-128"
gitemp	ftgen  2, 0, 16384, -23,  "circularstring-128"
gitemp	ftgen  3, 0, 16384, -23,  "grid-128,8"
gitemp	ftgen  4, 0, 16384, -23,  "cylinder-128,8"
gitemp	ftgen  5, 0, 16384, -23,  "torus-128,8"
;gitemp	ftgen  6, 0, 16384, -23,  ""

gitemp	ftgen  4444,   0, 128, -7, 0, 64,  6,  64, 0
gitemp	ftgen  5555, 0, 128, -7, 1, 128, .0001
gitemp	ftgen  6666, 0, 128, -7, 0, 128, 0
gitemp	ftgen  7,   0, 128, -8, 0.001, 128, 128
gitemp	ftgen  8, 0,128,	-5,.001,	32,64,64	,96,32
gitemp	ftgen  9,   0, 128, -5, 0.001, 128, 128
gitemp	ftgen  10, 0, 128, -7, 0, 128, 128
gitemp	ftgen  11,   0, 128, -23, "spiral-8,16,128,2,1over2"
;gitemp	ftgen  12,   0, 128, -23, "full-128"


;tuning
gitemp	ftgen 101,0,64,-2,12,2,261.626,60,1,1.059463,1.1224619,1.1892069,1.2599207,1.33483924,1.414213,1.4983063,1.5874001,1.6817917,1.7817962,1.8877471,2
gitemp	ftgen 102,0,64,-2,24,2,261.626,60,1,1.0293022,1.059463,1.0905076,1.1224619,1.1553525,1.1892069,1.2240532,1.2599207,1.2968391,1.33483924,1.3739531,1.414213,1.4556525,1.4983063,1.54221,1.5874001,1.6339145,1.6817917,1.73107,1.7817962,1.8340067,1.8877471,1.9430623,2
gitemp	ftgen 103,0,64,-2,10,2,261.626,60,1,1.0717734,1.148698,1.2311444,1.3195079,1.4142135,1.5157165,1.6245047,1.7411011,1.8660659,2
gitemp	ftgen 104,0,64,-2,8 ,2,261.626,60,1,1.125,1.265625,1.3333333333333333333333333333333,1.5,1.6875,1.8984375,2
gitemp	ftgen 105,0,64,-2,36,2,261.626,60,1,1.0194406,1.0392591,1.059463,1.0800596,1.1010566,1.1224618,1.1442831,1.1665286,1.1892067,1.2123255,1.2358939,1.2599204,1.284414,1.3093838,1.334839,1.3607891,1.3872436,1.4142125,1.4417056,1.4697332,1.4983057,1.5274337,1.5571279,1.5873994,1.6182594,1.6497193,1.6817909,1.7144859,1.7478165,1.7817951,1.8164343,1.8517469,1.8877459,1.9244448,1.9618572,2
gitemp	ftgen 106,0,16,-2,12,2,261.626,60,1,1.111111111,1.142857143,1.25,1.285714286,1.388888889,1.428571429,1.5,1.607142857,1.666666667,1.714285714,1.928571429
gitemp	ftgen 107,0,64,-2,36,2,30.5,24,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36
gitemp	ftgen 108,0,64,-2,7 ,2,261.626,60,1,1.125,1.265625,1.423828125,1.5,1.6875,1.8984375,2
gitemp	ftgen 109,0,64,-2,7 ,2,261.626,60,1,1.125,1.25,1.3333333333333333333333333333333,1.5,1.6666666666666666666666666666667,1.875,2
gitemp	ftgen 110,0,64,-2,10 ,1,261.626,60,1, 1, 2, 3, 5, 8, 13, 21, 34, 55
gitemp	ftgen 111,0,64,-2,5 ,2,261.626,60,1,1.125,1.25,1.5,1.6666666666666666666666666666667
gitemp	ftgen 112,0,64,-2,13 ,3,261.626,60,1.08,1.1904761904761904761904761904762,1.2857142857142857142857142857143,1.4,1.5306122448979591836734693877551,1.6666666666666666666666666666667,1.8,1.96,2.1428571428571428571428571428571,2.3333333333333333333333333333333,2.52,2.7777777777777777777777777777778,3
gitemp	ftgen 113,0,64,-2,23 ,2,261.626,60,1.0000,1.0404,1.0813,1.1226,1.1644,1.2066,1.2493,1.2925,1.3361,1.3802,1.4248,1.4699,1.5155,1.5616,1.6082,1.6553,1.7030,1.7511,1.7998,1.8490,1.8988,1.9491,2.0000 ;Narsing
gitemp	ftgen 114,0,64,-2,22 ,2,261.626,60,1,1.0534979423868312757201646090535,1.0666666666666666666666666666667,1.1111111111111111111111111111111,1.125,1.1851851851851851851851851851852,1.2,1.25,1.265625,1.3333333333333333333333333333333,1.35,1.40625,1.423828125,1.5,1.5802469135802469135802469135802,1.6,1.6666666666666666666666666666667,1.6875,1.7777777777777777777777777777778,1.8,1.875,1.8984375 ;indian
gitemp	ftgen 115,0,64,-2,19 ,2.25,261.626,60,1, 1.05, 1.09375, 1.1428571428571428571428571428571, 1.2, 1.25, 1.3125, 1.3714285714285714285714285714286, 1.4285714285714285714285714285714,1.5,1.575, 1.6666666666666666666666666666667, 1.7142857142857142857142857142857,1.8, 1.875, 1.96875, 2.0571428571428571428571428571429, 2.1428571428571428571428571428571, 2.25
;****************************************************


;************************************************
;STEREOCHORUS

opcode Stereochorus,aa,aiiiiii

;asig1,asig2  Stereochorus   asource,ilevel,depth,rate1,rate2,rate3,rate4

;f91 0 8193 19 1 1 0 1 ; Unipolar sine  ;chorus

gisine ftgen 0,0, 8193 ,19, 1, 1, 0, 1 

asig,ilevl,idepth,irate1,irate2,irate3,irate4, xin

imin     = 1/kr                              ; Minimum delay
idepth1  = idepth/1000*(1/irate1)                 ; Scale depth 1
idepth2  = idepth/1000*(1/irate2)                 ; Scale depth 2
idepth3  = idepth/1000*(1/irate3)                 ; Scale depth 3
idepth4  = idepth/1000*(1/irate4)                 ; Scale depth 4
alfo1a   oscil  idepth1, irate1, gisine           ; LFO 1   0 degrees
alfo1b   oscil  idepth1, irate1, gisine, .333     ; LFO 1 120 degrees
alfo1c   oscil  idepth1, irate1, gisine, .667     ; LFO 1 240 degrees
alfo2a   oscil  idepth2, irate2, gisine           ; LFO 2   0 degrees
alfo2b   oscil  idepth2, irate2, gisine, .333     ; LFO 2 120 degrees
alfo2c   oscil  idepth2, irate2, gisine, .667     ; LFO 2 240 degrees
alfo3a   oscil  idepth3, irate3, gisine           ; LFO 3   0 degrees
alfo3b   oscil  idepth3, irate3, gisine, .333     ; LFO 3 120 degrees
alfo3c   oscil  idepth3, irate3, gisine, .667     ; LFO 3 240 degrees
alfo4a   oscil  idepth4, irate4, gisine           ; LFO 4   0 degrees
alfo4b   oscil  idepth4, irate4, gisine, .333     ; LFO 4 120 degrees
alfo4c   oscil  idepth4, irate4, gisine, .667     ; LFO 4 240 degrees
ax       delayr  1                           ; Create 1s delay line
abbd1	 deltapi  alfo1a + alfo2a + imin     ; Tap 1
abbd2	 deltapi  alfo1b + alfo2b + imin     ; Tap 2
abbd3    deltapi  alfo1c + alfo2c + imin     ; Tap 3
abbd4    deltapi  alfo3a + alfo4a + imin     ; Tap 4
abbd5    deltapi  alfo3b + alfo4b + imin     ; Tap 5
abbd6    deltapi  alfo3c + alfo4c + imin     ; Tap 6
         delayw  asig                        ; Input signal into delay
aouts1 =   (abbd1 + abbd2 + abbd3)      ; Level, sum and output
aouts2 =   (abbd4 + abbd5 + abbd6)     ; Level, sum and output

afxL =   asig   + ((aouts1 )*.7 )*ilevl
afxR  =  asig   + ((aouts2 )*.7 )*ilevl

xout afxL,afxR            ; write output

       endop
;************************************************





instr 1
kdamping expseg    0.00003,.02,1,p3-.02,0.00003


iampmidi  = 6000

;ifreq   cpsmidi
ifreq = cpspch(p4)

irate = i(gk1)
il = i(gk2)
ir = i(gk3)


ispring = i(gk4)


;Scanned-udo
;a2 Scanned iampmidi,ifreq,irate,11111,6666,22222,i(gk4),4444,5555,gk5,il,ir,7777
;***************************************
a0 = 0

 iattack = i(gk7)
  ; Decay time.
  idecay = i(gk8)
  ; Sustain level.
 isustain = i(gk9)
  ; Release time.
 irelease = i(gk10)

k1 mxadsr iattack, idecay, isustain, irelease

;scanu  11111,irate,6666,22222,i(gk4),4444,5555,gk5,il,ir,-.05,.1,.1,.6,0,a0,1,2
;     icondfunc, scnrat, ivelf, imasf, ispgmatrxf, icntrf, idampf, kmas, kspgstf, kcntr, kdamp, ilplkpos, irplkpos, kpos, kstrngth, ain, disp, id

scanu  11111,    irate, 6666,   22222, i(gk4),     4444,   5555,   gk5,   il,     ir,    -.05,   i(gk12),  i(gk13), gk11,  0,       a0,  0,    2

klfo lfo gklfolevl,gklforate,i(gklfoty)

a1 scans  iampmidi*kdamping,ifreq+klfo ,i(gktraj),2

;FILTERS
kcf  tonek gkjoy1,10
kres tonek gkjoy2,10



iselfilt = i(gkfilt)

if   (iselfilt == 0) goto abypass
if   (iselfilt == 1) goto afilter1
if   (iselfilt == 2) goto afilter2
if   (iselfilt == 3) goto afilter3


afilter1:
afilt1  moogvcf2  a1,kcf,kres
FLsetText "Moog-filter",gifilt
goto fine

afilter2:
afilt1  lowpass2  a1,kcf,kres
FLsetText "lowpass2-filter",gifilt
goto fine

afilter3:
afilt1 butterhp  a1,kcf*.3
FLsetText "butterhp-filter",gifilt
goto fine





abypass:
afilt1 = a1
FLsetText "Bypass-filter",gifilt
goto fine

;********************************************
fine:
aout = afilt1

;Effects

iselfx = i(gkselfx)

if   (iselfx == 0) goto abypass2
if   (iselfx == 1) goto aefx1
if   (iselfx == 2) goto aefx2
if   (iselfx == 3) goto aefx3
;Effects

abypass2:
afx1 = aout
afx2 = aout
FLsetText "Bypass-fx",giselfx
goto endfx


aefx1:
;asig1,asig2 Stereochorus asource,ilevel,depth,rate1,rate2,rate3,rate4
afxL,afxR Stereochorus  aout,1,1,2.3,2.5,4.7,3.9
afx1 = aout + afxL*.7
afx2 = aout + afxR*.7
FLsetText "Chorus",giselfx
goto endfx

aefx2:
afxL comb  aout,3.7,.08
kdeclick  linsegr  0.01, 0.01, 1, 0.33*1, 0
afx1 = aout + afxL*kdeclick 
afx2 = aout + afxL*kdeclick 
FLsetText "Comb",giselfx
goto endfx


aefx3:
kstereo  lfo 1,.8,0
aleft =  (1-kstereo)
aright = (kstereo)

afx1 = aout* aleft
afx2 = aout* aright
FLsetText "Autopan",giselfx
goto endfx


endfx:

gafx1 = gafx1+afx1*.6
gafx2 = gafx1+afx2*.6

ga1	=	(ga1+afx1 ) ;vumeter
ga2	=	(ga2+afx2 ) ;vumeter

outs afx1,afx2
;***************************************

;outs to hard disk recording

vincr gafout1, afx1
vincr gafout2, afx2
endin



instr 2

al,ar reverbsc gafx1,gafx2,gk6, 10000, sr, .2, 0
asigld dcblock al
asigrd dcblock ar
asigl clip asigld, 2, 32000
asigr clip asigrd, 2, 32000
kdclick linseg 0, .01, 1, p3-.02, 1, .01, 0
outs asigl*kdclick , asigr *kdclick

vincr gafout3, (asigl * kdclick)*.6
vincr gafout4, (asigr * kdclick)*.6

gafx1 = 0
gafx2 = 0
endin



instr 3

ispring = i(gk4)

if (ispring == 1) goto  matrix1
if (ispring == 2) goto  matrix2
if (ispring == 3) goto  matrix3
if (ispring == 4) goto  matrix4
if (ispring == 5) goto  matrix5


matrix1:
FLsetText "string-128",gih4
goto end

matrix2:
FLsetText "circularstring-128",gih4
goto end

matrix3:
FLsetText "grid-128,8",gih4
goto end

matrix4:
FLsetText "cylinder-128,8",gih4
goto end


matrix5:
FLsetText "torus-128,8",gih4
goto end

end:
;some instruction should contained here

endin

instr 5
;gkrand,gihrand 
irandom = i(gkrand)
if	(irandom ==  1 )igoto CONTINUE
if	(irandom ==  0 )igoto END


CONTINUE:
iatkrnd   random   0.01,2
idecrnd   random   0,.5
iasusrnd  random   0.01,1
irelrnd   random   0,1

FLsetVal_i iatkrnd,gih7
FLsetVal_i idecrnd,gih8
FLsetVal_i iasusrnd,gih9
FLsetVal_i irelrnd,gih10

END:
endin

instr 6


outs	ga1,ga1
ktrig	metro	15
kval	max_k	ga1, ktrig, 0
	FLsetVal	ktrig, kval, gihvu


ga1	=	0

	endin

instr 7
;global randomize
irandom = i(gkglrand)
if	(irandom ==  1 )igoto CONTINUE
if	(irandom ==  0 )igoto END


CONTINUE:

;ADSR
iatkrnd   random   0.01,2
idecrnd   random   0,.5
iasusrnd  random   0.01,1
irelrnd   random   0,1
FLsetVal_i iatkrnd,gih7
FLsetVal_i idecrnd,gih8
FLsetVal_i iasusrnd,gih9
FLsetVal_i irelrnd,gih10


;Scanned parameters
igih1   random   .05, .5
igih2   random   .01, 1
igih3   random   .01, 1
igih5   random   2, 50
igih11  random   0.1, 1
igih12  random   .1, .9
igih13  random   .1, .9

;reverb
igih6   random   .2,.90
;matrix,trajector
igih4   random   1, 5
igitraj random   7, 10

FLsetVal_i igih1,gih1
FLsetVal_i igih2,gih2
FLsetVal_i igih3,gih3
FLsetVal_i igih5,gih5
FLsetVal_i igih6,gih6
FLsetVal_i igih4,gih4

FLsetVal_i igih11,gih11
FLsetVal_i igih12,gih12
FLsetVal_i igih13,gih13
FLsetVal_i igitraj,gitraj

;lfo
;gklfoty,gilfoty FLcount "", 0, 5, 1, 5, 1, 94, 18, 172, 512,0, 10, 0, 0
;gklforate,gilforate FLknob "Lfo-rate", .1,9, -1, 1, -1,  40, 110, 507,50
;gklfolevl,gilfolevl FLknob "Lfo-level", .01,10, -1, 1, -1,  40, 40, 507,50
ilfotype   random   0,5
ilforate   random   .1,50
ilfolevl   random   .1,50
FLsetVal_i ilfotype,gilfoty
FLsetVal_i ilforate,gilforate
FLsetVal_i ilfolevl,gilfolevl

;filter

;ifiltype  random   0,4
;icutoff   random   700,20000
;ireso     random   .1,.9

;FLsetVal_i ifiltype,gifilt
;FLsetVal_i icutoff,gihjoy1
;FLsetVal_i ireso,gihjoy2




END:
endin


instr 8 ;vector filter


if	(gkauto ==  1 )kgoto CONTINUE
if	(gkauto ==  0 )kgoto FERMO


CONTINUE:
;gkratefl,giratefl
krand  randomi	1,22000,gkratefl  ;rate
krand2 randomi	1,.1,gkratefl   ;rate
FLsetVal 1, krand,gihjoy1
FLsetVal 1, krand2,gihjoy2

FERMO:

endin

;hard disk recording
instr 9

iname = i(gkhdrec)

if	(gkhdrec ==  1 )kgoto RECORD
if	(gkhdrec ==  0 )kgoto STOP
turnoff
RECORD:


fout $AudioFilename, 14, (gafout1+gafout3)*gklevrec,(gafout2+gafout4)*gklevrec
clear gafout1,gafout2,gafout3,gafout4
kgoto uscita

STOP:
kgoto uscita
uscita:


iname2 = i(gkhdrec)
if	(iname2 ==  1 )goto TEXT1
if	(iname2 ==  0 )goto TEXT2
TEXT1:
FLsetText "@square",gihdrec
goto uscita2
TEXT2:
FLsetText "@circle",gihdrec
goto uscita2
uscita2:


endin

;lfo itype waveform
instr 10

ispring = i(gklfoty)

if (ispring == 0) goto  type1
if (ispring == 1) goto  type2
if (ispring == 2) goto  type3
if (ispring == 3) goto  type4
if (ispring == 4) goto  type5
if (ispring == 5) goto  type6

type1:
FLsetText "sine",gilfoty
goto end

type2:
FLsetText "triangles",gilfoty
goto end

type3:
FLsetText "square-bipolar",gilfoty
goto end

type4:
FLsetText "square-unipolar",gilfoty
goto end

type5:
FLsetText "saw-tooth",gilfoty
goto end

type6:
FLsetText "saw-tooth(down)",gilfoty
goto end

end:
;some instruction should contained here

endin



  instr 12

kloop = 16
kindex init 0

ktrigger seqtime 1, 0, kloop,0,93333


if (ktrigger > 0) then
   kpitch table kindex, 92222
   event "i", 1, 0, 1, kpitch
   kindex = kindex + 1
   kindex = kindex % kloop
endif



endin



</CsInstruments>
<CsScore>

;SEQUENCER*******************************************************************************
;;; table defining an integer pitch set
;f92222 0 4096 -2 8.02 6.04 9.03 6.03 9.06  8.11 6.07 7.00 8.05 7.07 8.10  7.04  6.03  6.07
f92222  0 4096 -2  7.00 7.03 7.02 7.06 7.05 7.09 7.08 7.12 6.00 8.03 9.02 6.06 9.05 5.09 6.08 5.12
;;; times for sequencer
f93333 0 4096 -2 .2 .2 .2 .2 .2 .2 .2 .2  .2 .2 .2 .2 .2 .2 .2 .2
;****************************************************************************************


f0    3600
i2  0 3600
i3  0 3600
i5  0 3600
i6  0 3600
i7  0 3600
i8  0 3600
i9  0 3600
i10 0 3600
i12 0 3600
</CsScore>
</CsoundSynthesizer>







