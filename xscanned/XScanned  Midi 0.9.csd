

;XScanned 
;Version 0.9
;9-4-2007
;A Scanned synthesizer for csound5.
;by Giorgio Zucco
;Released under the GPL license (see gpl.txt).

;-to put ftgenscanu.h and matrix files to c:\csound\bin 


;for Save Presets :

;1)store a bank empty of snapshots click on 'Save Bank'
;2)Make a personal sound patch;
;3)select an snapshot number using the counter
;4)Click on 'Save Snapshot' to store the current settings

;for restore Presets :
;To restore a previously stored bank of snapshots click on 'Load Bank'
;Presets can be retrieved by selecting snapshot numbers in the button bank


;for contacts,questions,send mail to:
;giorgiobrx@libero.it

 
<CsoundSynthesizer> 
<CsOptions> 

-odac1 -m0 -M0 -+rtmidi=virtual -b1024 -B4000 
;-odac1 -m0 -M0 -b4096 -B4000 
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


maxalloc 1,6

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
 
FLpanel "XScanned 0.9", 580,610, 100, 100
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


gk6,gih6 FLknob "Reverb", .2,.95, -1, 1, -1,  50, 440, 12,40
;FLsetColor 0,128,0,gih6
;FLsetFont 4,gih6
FLsetTextColor 0,0,0,gih6
FLsetColor2 $GColor gih6
;FLsetTextSize 9, gih6
;springs
gk4,gih4 FLcount "", 1, 5, 1, 5, 1, 160, 22, 390, 146,0, 3, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 4,gih4
;FLsetTextColor 64, 64, 64,gih4
FLsetColor2 $GColor gih4


;Scanned type
gkscanty,giscanty FLcount "", 0, 3, 1, 3, 1, 160, 22, 390, 96,0,1,0,0
;FLsetColor 0,128,0,gih4
FLsetFont 4,giscanty
;FLsetTextColor 64, 64, 64,giscanty
FLsetColor2 $GColor giscanty

;FLsetTextColor 255,255,80,gihv5osc


gktraj,gitraj FLcount "Trajectory", 7, 11, 1, 11, 1, 160, 22, 390, 200,0, 3, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 4,gitraj
;FLsetTextColor 64, 64, 64,gitraj
FLsetColor2 $GColor gitraj

;**************filter******************************
;BORDERS			ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihbordfilt	FLbox  	" ", 	6,        9,    15,    284,    250,   280, 245


gkfilt,gifilt FLcount "", 0, 11, 1, 11, 1, 130, 19, 290, 262,0, 1, 0, 0
;FLsetColor 0,128,0,gih4
FLsetFont 4,gifilt
;FLsetTextColor 64, 64, 64,gifilt
FLsetColor2 $GColor gifilt

;JOYSTICK FILTERS
;koutx, kouty, ihandlex, ihandley FLjoy "label", iminx, imaxx, iminy, imaxy, iexpx, iexpy, idispx, idispy, iwidth, iheight, ix,  iy
gkjoy1,gkjoy2,gihjoy1,gihjoy2 FLjoy "Filters", 650,   22000,.1,    .8,    -1,    0,    -1,     -1,     190,    165,     290, 314
FLsetColor 200, 180, 200, gihjoy1

;Auto filter
gkauto,gihauto    FLbutton "Auto", 1,0, 2, 80, 15, 447,252, 0, 1, 0, 0
FLsetColor2 $GColor gihauto

gkratefl,giratefl FLslider "rate",.1, 6, -1,  5,   -1, 120,10,430, 280

;kQ resonators
gkmodal,gimodal FLknob "Resonators", 60,14000, -1, 1, -1,  52, 495, 312,40
;FLsetColor 0,128,0,gih6
;FLsetFont 4,gih6
FLsetTextSize 12, gimodal
FLsetTextColor 0,0,0,gimodal
FLsetColor2 $GColor gimodal
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
gkselfx,giselfx FLcount "", 0, 4, 1, 4, 1,122, 22, 32, 568,0, 1, 0, 0
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

FLsetVal_i  100,gimodal ;resonators

;************************************************************************************************
FLpanel "Snapshot",560,275,450,110;start of container

FLcolor -2
gkget, ih		FLbutBank	11,     9,     9,    320,    270,   230,  0,    0,    20,   0,   0 
FLcolor -1

FLcolor -2
gkloadbank,ih		FLbutton	"Load Bank", 	0,    0,    11, 150,  40,   40, 0,   0,  21, 0,   0
FLsetFont 2,ih
FLcolor -1

FLcolor -2
FLsetTextColor 0,0,255,ih
gksavebank,ih		FLbutton	"Save Bank", 	0,    0,    11, 150,  40,   40, 40,  0,  22, 0,   0
FLsetFont 2,ih
FLsetTextColor 0,0,255,ih
FLcolor -1

FLcolor -2
gksavesnap,ih		FLbutton	"Save Snapshot",  0,    0,    11, 150,  40,   40, 80,  0,  23, 0,   0
FLsetFont 2,ih
FLsetTextColor 0,0,255,ih
FLcolor -1


FLcolor -2
gkstore,ih	 	FLcount		"Snapshot Number",	0,     41,    1, 5,  21, 150,   30,  40, 130, -1
FLsetFont 4,ih
FLsetTextColor 0,0,255,ih
;FLcolor -2
FLcolor -1








FLpanelEnd

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
;scantable
gitemp	ftgen 1000,0 ,128,  7, 0, 30 ,0 ,2, 1 ,2, 0, 30, 0, 30, 0, 2, -1, 2, 0, 30, 0

gitemp	ftgen 2000, 0, 128, -7, 1, 128, 1

gitemp	ftgen  3000, 0, 128, -7, 0, 64, 100, 64, 0

gitemp	ftgen  4000, 0, 128, -7, 1, 128, 1

gitemp	ftgen  5000, 0, 128, -7, 0, 128, 0

;************************************************
;spatd3d
gitmp    ftgen   99, 0, 64, -2,3,48,-1, 0.01,0.25, 123,1, 21.982,0.05, 0.87,4000.0,0.6,0.7, 2,1,1.753,0.05,0.87,3500.0,0.5,0.7,2,1, 15.220, 0.05, 0.87, 5000.0, 0.8, 0.7, 2,1,  9.317, 0.05, 0.87, 5000.0, 0.8, 0.7, 2,1, 17.545, 0.05, 0.87, 5000.0, 0.8, 0.7, 2,1, 12.156, 0.05, 0.87, 5000.0, 0.8, 0.7, 2
;********************************
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
opcode  ScannedMap,a,kk

; Initial condition
;f1 0 16 7 0 8 1 8 0
gitemp1  ftgen 0, 0 ,128, 7, 0 ,64, 1, 64, 0

; Masses
gitemp2  ftgen 0, 0, 128, -7, 1, 128, 1

; Centering force
gitemp4  ftgen 0,  0, 128, -7, 0, 128, 2
gitemp14  ftgen 0, 0, 128, -7, 2 ,64, 0 ,64, 2

; Damping
gitemp5  ftgen 0,0, 128, -7, 1, 128, 1

; Initial velocity
gitemp6  ftgen 0, 0, 128, -7, -.0,128 ,.0

; Trajectories
gitemp7  ftgen 0, 0, 128, -5 ,.001, 128 ,128
gitemp77  ftgen 0, 0, 128, -23, "spiral-8,16,128,2,1over2"

kamp,kfreq xin

a0	=	0
	 xscanu	gitemp1, .01, gitemp6, gitemp2, "grid_128,8", gitemp14, gitemp5,2, .01, .05, -.05, .1, .5, 0, 0, a0, 0, 0 
  a1     xscans      kamp, kfreq, gitemp7, 0, 2
  a2     xscans      kamp, kfreq, gitemp77, 0, 2
  k1,k2  xscanmap       0, 1000, 1000, 127
            ;display k2, .5  ; note - display is updated ever 500ms
            aout =         (a1+a2)
xout aout
endop

;********************************************
;********************************************
;********************************************
;********************************************
;***************RESONATORS OPCODES***********
;********************************************
;********************************************
opcode Chladni_plates,a,ak

asig,kq xin
;([62, 107, 360, 460, 863] Hz +-2Hz)
a1 mode  asig,62,kq
a2 mode  asig,107,kq
a3 mode  asig,360,kq
a4 mode  asig,460,kq
a5 mode  asig,863,kq

asum  sum  a1,a2,a3,a4,a5

aout = asum*0.05
aout2  balance  aout,asig

xout aout2            ; write output

       endop
;********************************************
;********************************************
;********************************************


opcode Tibetan_bowl ,a,ak

asig,kq xin

;( [221, 614, 1145, 1804, 2577, 3456, 4419] Hz) 934g, 180mm

a1 mode  asig,221,kq
a2 mode  asig,614,kq
a3 mode  asig,1145,kq
a4 mode  asig,1804,kq
a5 mode  asig,2577,kq
a6 mode  asig,3456,kq
a7 mode  asig,4419,kq


asum  sum  a1,a2,a3,a4,a5,a6,a7

aout = asum*0.03


aout2  balance  aout,asig


xout aout2            ; write output

       endop

;********************************************
;********************************************
;********************************************



opcode Handbell ,a,ak

a1,kq xin

a2 mode  a1, 1312.0,kq
a3 mode  a1, 1314.5,kq
a4 mode  a1, 2353.3,kq
a5 mode  a1,  2362.9,kq
a6 mode  a1, 3306.5,kq
a7 mode  a1, 3309.4,kq
a8 mode  a1,  3923.8 ,kq
a9 mode  a1,   3928.2,kq
a10 mode a1,  4966.6,kq
a11 mode a1,  4993.7,kq
a12 mode a1,  5994.4,kq
a13 mode a1,  6003.0,kq
a14 mode a1,  6598.9,kq
a15 mode a1,  6619.7,kq
a16 mode a1,  7971.7,kq
a17 mode a1,  7753.2,kq
a18 mode a1,  8413.1,kq
a19 mode a1,  8453.3,kq
a20 mode a1,   9292.4,kq
a21 mode a1,  9305.2,kq
a22 mode a1,  9602.3,kq
a23 mode a1,  9912.4,kq

aout = (a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16+a17+a18+a19+a20+a21+a22+a23)*.01

aout2  balance  aout,a1

xout aout2            ; write output

       endop




;*********************************************************************
;*********************************************************************
;*********************************************************************
;*********************************************************************

;*********************************************************************
opcode Vibraphone1 ,a,akk


; 	[1, 3.984, 10.668, 17.979, 23.679, 33.642]
asig,kfreq,kq xin

; kfreq best range  20 to 300!


;( [221, 614, 1145, 1804, 2577, 3456, 4419] Hz) 934g, 180mm

a1 mode  asig,kfreq,kq
a2 mode  asig,kfreq*3.984,kq
a3 mode  asig,kfreq*10.668,kq
a4 mode  asig,kfreq*17.979,kq
a5 mode  asig,kfreq*23.679,kq
a6 mode  asig,kfreq*33.642,kq


asum  sum  a1,a2,a3,a4,a5,a6

aout = asum*0.03


aout2  balance  aout,asig


xout aout2            ; write output

       endop


;********************************************************
;*******************************************************
opcode Wine_Glass ,a,akk


; 	 	[1, 2.32, 4.25, 6.63, 9.38]
asig,kfreq,kq xin

; kfreq best range  20 to 300!


;( [221, 614, 1145, 1804, 2577, 3456, 4419] Hz) 934g, 180mm

a1 mode  asig,kfreq,kq
a2 mode  asig,kfreq*2.32,kq
a3 mode  asig,kfreq*4.25,kq
a4 mode  asig,kfreq*6.63,kq
a5 mode  asig,kfreq*9.38,kq



asum  sum  a1,a2,a3,a4,a5

aout = asum*0.03


aout2  balance  aout,asig


xout aout2            ; write output

       endop


;***********************************************
;TUBE

opcode Cylindrical_pipe ,a,ak

a1,kq xin

a2 mode  a1, 61,kq
a3 mode  a1, 184,kq
a4 mode  a1, 306,kq
a5 mode  a1, 429,kq
a6 mode  a1, 551,kq
a7 mode  a1, 674,kq
a8 mode  a1, 796 ,kq
a9 mode  a1, 919,kq


aout = (a2+a3+a4+a5+a6+a7+a8+a9)*.1

aout2  balance  aout,a1

xout aout2            ; write output

       endop

;*******************************************
;TUBE2
opcode Cylindrical_pipe2 ,a,ak

a1,kq xin

a2 mode  a1, 230,kq
a3 mode  a1, 344,kq
a4 mode  a1, 458,kq
a5 mode  a1, 578,kq
a6 mode  a1, 695,kq
a7 mode  a1, 814,kq
a8 mode  a1, 931 ,kq



aout = (a2+a3+a4+a5+a6+a7+a8)*.1

aout2  balance  aout,a1

xout aout2            ; write output

       endop


;*******************************************

;*******************************************

;*******************************************

;*******************************************

opcode Membrane ,a,akk



asig,kfreq,kq xin



a1 mode  asig,kfreq,kq
a2 mode  asig,kfreq*1.59334,kq
a3 mode  asig,kfreq*2.13555,kq
a4 mode  asig,kfreq*2.65307,kq
a5 mode  asig,kfreq*2.29542,kq
a6 mode  asig,kfreq*2.9173,kq
a7 mode  asig,kfreq*3.50015,kq
a8 mode  asig,kfreq*4.05893,kq
a9 mode  asig,kfreq*3.59848,kq
a10 mode  asig,kfreq*4.23044,kq
a11 mode  asig,kfreq*4.83189,kq
a12 mode  asig,kfreq*5.41212,kq
a13 mode  asig,kfreq*4.90328,kq
a14 mode  asig,kfreq*5.5404,kq
a15 mode  asig,kfreq*6.15261,kq
a16 mode  asig,kfreq*6.74621,kq



aout = (a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11+a12+a13+a14+a15+a16)/15


aout2  balance  aout,asig


xout aout2            ; write output

       endop

;*******************************************************




instr 1

iampmidi  ampmidi  7000
iampmidi2  ampmidi 14000
;ifreq   cpsmidi
ifreq cpstmid	i(gktuning)

;**************************************
iattack = i(gk7)
  ; Decay time.
  idecay = i(gk8)
  ; Sustain level.
 isustain = i(gk9)
  ; Release time.
 irelease = i(gk10)

k1 mxadsr iattack, idecay, isustain, irelease
klfo lfo gklfolevl,gklforate,i(gklfoty)

;********************************************
irate = i(gk1)
il = i(gk2)
ir = i(gk3)


ispring = i(gk4)


iselscan = i(gkscanty)

if   (iselscan == 0) goto aScanned1
if   (iselscan == 1) goto aScanned2
if   (iselscan == 2) goto aScanned3
if   (iselscan == 3) goto aScanned4

;Scanned-udo
;a2 Scanned iampmidi,ifreq,irate,11111,6666,22222,i(gk4),4444,5555,gk5,il,ir,7777
;***************************************
aScanned1:
a0 = 0

;k2 linsegr  0,.01,1,.3,.5,.2,0
;scanu  11111,irate,6666,22222,i(gk4),4444,5555,gk5,il,ir,-.05,.1,.1,.6,0,a0,1,2
;     icondfunc, scnrat, ivelf, imasf, ispgmatrxf, icntrf, idampf, kmas, kspgstf, kcntr, kdamp, ilplkpos, irplkpos, kpos, kstrngth, ain, disp, id
scanu  11111,    irate, 6666,   22222, i(gk4),     4444,   5555,   gk5,   il,     ir,    -.05,   i(gk12),  i(gk13), gk11,  0,       a0,  0,    2

a1 scans  iampmidi*k1,ifreq+klfo ,i(gktraj),2
FLsetText "Scanu-custom",giscanty
goto  outfilt



;**********************************************
aScanned2:

a1 ScannedMap iampmidi*k1,ifreq+klfo 
FLsetText "Xscanmap",giscanty
goto  outfilt

;***********************************************
;**********************************************
aScanned3:

a1 scantable iampmidi2*k1,ifreq+klfo,1000,2000,3000,4000,5000
FLsetText "Scantable",giscanty
goto  outfilt

;***********************************************
aScanned4:
scanu  11111,    irate, 6666,   22222, i(gk4),     4444,   5555,   gk5,   il,     ir,    -.05,   i(gk12),  i(gk13), gk11,  0,       a0,  0,    2

asc1 scans  iampmidi*k1,ifreq+klfo ,7,2
asc2 scans  iampmidi*k1,ifreq+klfo ,i(gktraj),2
a1 = (asc1+asc2)*.5
FLsetText "Scanu-Dual scans",giscanty
goto  outfilt

;************************************************************
outfilt:

;FILTERS
kcf  tonek gkjoy1,10
kres tonek gkjoy2,10



iselfilt = i(gkfilt)

if   (iselfilt == 0) goto abypass
if   (iselfilt == 1) goto afilter1
if   (iselfilt == 2) goto afilter2
if   (iselfilt == 3) goto afilter3
if   (iselfilt == 4) goto afilter4
if   (iselfilt == 5) goto aresona1
if   (iselfilt == 6) goto aresona2
if   (iselfilt == 7) goto aresona3
if   (iselfilt == 8) goto aresona4
if   (iselfilt == 9) goto aresona5
if   (iselfilt == 10) goto aresona6
if   (iselfilt == 11) goto aresona7



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

afilter4:
ahp,alp,abp,abr    statevar  a1,kcf*.3,kres
afilt1 = (ahp+alp+abp+abr)*.5
FLsetText "statevar-filter",gifilt
goto fine

aresona1:
afilt1  Chladni_plates  a1,gkmodal
FLsetText "Chladni-plates",gifilt
goto fine

aresona2:
afilt1  Tibetan_bowl  a1,gkmodal
FLsetText "Tibetan-bowl",gifilt
goto fine

aresona3:
afilt1  Handbell  a1,gkmodal
FLsetText "Handbell",gifilt
goto fine

aresona4:
afilt1  Wine_Glass  a1,100,gkmodal
FLsetText "Wine-Glass",gifilt
goto fine

aresona5:
afilt1  Cylindrical_pipe  a1,gkmodal
FLsetText "Cylindrical-pipe",gifilt
goto fine

aresona6:
afilt1  Cylindrical_pipe2  a1,gkmodal
FLsetText "Cylindrical-pipe2",gifilt
goto fine

aresona7:
afilt1  Membrane  a1,100,gkmodal
FLsetText "Membrane",gifilt
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
if   (iselfx == 4) goto aefx4
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


aefx4:
;***************************************
kazim   line 0, 2.5, 360        ; move sound source around
kdist   line 1, 10, 4           ; distance
; convert polar coordinates
kX      =  sin(kazim * 3.14159 / 180) * kdist
kY      =  cos(kazim * 3.14159 / 180) * kdist
kZ      =  0
;a1      =  a1 + 0.000001 * 0.000001     
imode   =  3    ; change this to 3 for 8 spk in a cube,
		; or 1 for simple stereo
aW, aX, aY, aZ  spat3d aout, kX, kY, kZ, 1.0, 99, imode, 2, 2
aW      =  aW * 1.4142
; stereo
;
aL     =  aW + aY              /* left                 */
aR     =  aW - aY              /* right                */
kdeclick  linsegr  0.01, 0.01, 1, 0.33*1, 0
afx1 = aL *kdeclick
afx2 = aR *kdeclick
FLsetText "Spat3d",giselfx
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

instr 11
inamex = i(gktuning)

if (inamex == 101) goto text1
if (inamex == 102) goto text2
if (inamex == 103) goto text3
if (inamex == 104) goto text4
if (inamex == 105) goto text5
if (inamex == 106) goto text6
if (inamex == 107) goto text7
if (inamex == 108) goto text8
if (inamex == 109) goto text9
if (inamex == 110) goto text10
if (inamex == 111) goto text11
if (inamex == 112) goto text12
if (inamex == 113) goto text13
if (inamex == 114) goto text14
if (inamex == 115) goto text15
;igoto end

text1:
FLsetText "Standard tuning",gituning
goto initplay

text2:
FLsetText "Quarter tones",gituning
goto initplay

text3:
FLsetText "Decatonic",gituning
goto initplay

text4:
FLsetText "Pythagorean",gituning
goto initplay

text5:
FLsetText "Third tones",gituning
goto initplay

text6:
FLsetText "Detuned",gituning
goto initplay

text7:
FLsetText "Harmonic",gituning
goto initplay

text8:
FLsetText "Chinese",gituning
goto initplay

text9:
FLsetText "Major Triad",gituning
goto initplay

text10:
FLsetText "Fibonacci",gituning
goto initplay

text11:
FLsetText "Pentatonic",gituning
goto initplay

text12:
FLsetText "Bohlen-Pierce",gituning
goto initplay

text13:
FLsetText "Bharata tuning",gituning
goto initplay

text14:
FLsetText "Indian shruti",gituning
goto initplay

text15:
FLsetText "Wendy Carlos Alpha",gituning
goto initplay

initplay:

endin

;save presets
;************************************************************************************************
;************************************************************************************************
;************************************************************************************************
	
      instr		20		

inumsnap		FLgetsnap	i(gkget)	

			endin

      instr		21		
			FLloadsnap	$PRESETS	

			endin                                                   

      instr		22		
			FLsavesnap	$PRESETS	

			endin						

      instr		23		

inumsnap, inumval 	FLsetsnap	i(gkstore)	

      
                        endin


</CsInstruments>
<CsScore>




f0    3600
i2  0 3600
i3  0 3600
i5  0 3600
i6  0 3600
i7  0 3600
i8  0 3600
i9  0 3600
i10 0 3600
i11 0 3600
</CsScore>
</CsoundSynthesizer>










