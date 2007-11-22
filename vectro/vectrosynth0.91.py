'''

;Vectrosynth
;Version 0.91
;1-2-2007
;A Vectorial synthesizer for csound5.
;by Giorgio Zucco
;Released under the GPL license (see gpl.txt).

;Vectrosynth is a experimental synth for vectorial synth,is realized for
;csound 5.05 thanks to Fltk library;
;Vectrosynth is :
;4 oscillator with 44 shapable waveforms(also include the STK library),with independent LFO,ADSR(and Random ADSR) for every OSC;
;2 Filters section (Multifilter mode until a two filters in serial,);
;2 effects section (with 11 fx);
;Morphing between four Oscillator with rate control;
;Global Reverb(reverbsc)
;Mixer 
;selected standard tuning and microtonal tuning;

;specials thanks to librarys of Steven Cook(for effects work),Ian McCurdy!
;this is a first realease,in this moment is a "Work in progress" to effects panel!!
;run with Csound5.04-win32-d.exe or most higher;

;for Save Presets :

;1)store a bank empty of snapshots click on 'Save Bank'
;2)Make a personal sound patch;
;3)select an snapshot number using the counter
;4)Click on 'Save Snapshot' to store the current settings

;for restore Presets :
;To restore a previously stored bank of snapshots click on 'Load Bank'
;Presets can be retrieved by selecting snapshot numbers in the button bank


;A pdf manual is work in progress,sorry :-( 


;for contacts,questions,send mail to:
;giorgiobrx@libero.it

'''


from wxPython.wx import *
import wx
import csnd



csound = csnd.CppSound ()


csound.setOrchestra('''




;sr = 44100
;kr = 441
;kr = 126
;kr = 105
;ksmps = 350
;ksmps = 420
;ksmps = 100
;nchnls = 2



sr     = 44100
;kr     = 126
;ksmps  = 350
kr     = 441
ksmps  = 100
nchnls = 2

;*********************************************************************************************************
;*******************INIT SETTINGS*************************************************************************
#define LOOPDUR #8# ;duration loop record

#define PRESETS #"Presets.txt"# ;edit filename and directory for presets-save

#define  AudioFilename #"Test.wav"#  ;edit filename and directory for audio recording

#define LEVELRECORDING #1.5# ;level mic initial
#define TUNING #101#  ;init tuning (101 = standard ,102 = quartertones ; 103 = decatonic)
#define InitPreset #1# ;OSC1 ;waveform number 1 to 44  (31 = STKMandolin)

;adsr init settings
#define Attack #.001#
#define Decay #.4#
#define Sustain #.4#
#define Release #.2#

#define Graindens #12#  ;density for grain
#define Globrevinit #.01# ;Global reverb init
#define KnobColor #175 ,238 ,238,# ;GLOBAL color

;drawbar organ opcode :
#define Drawbar1 #5#
#define Drawbar2 #4#
#define Drawbar3 #10#
#define Drawbar4 #4#
#define Drawbar5 #10#
#define Drawbar6 #5#
#define Drawbar7 #10#
#define Drawbar8 #6#
#define Drawbar9 #2#

;*********************************************************************************************************
;*******************END SETTINGS*************************************************************************

zakinit 53, 55 ;outs to sound loop-player

;cpuprc 1, 5  ;cpu%
;limita la polifonia a 20 voci
maxalloc 1,20

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



#define Knobsize #45#


ga1	  init 0 ;inizializzo il vu-meter
gareverb1 init 0 ;global reverb 
gareverb2 init 0
gafout1   init 0 ;hard disk recording
gafout2   init 0
gafout3   init 0 ;hard disk recording
gafout4   init 0

gitemp ftgen 1 ,0 ,4096, 10 ,1;sine
gitemp ftgen 2 ,0,1024 ,7 ,0 ,1024, 1, 1024, -1 ,1024, 0;saw down
gitemp ftgen 3, 0 ,1024, 7, 0 ,1024 ,-1 ,1024, 1 ,1024, 0;saw up
gitemp ftgen 4 ,0 ,1024 ,7 ,0 ,512, 1 ,512, 0 ,512, -1 ,512, 0;triangle
gitemp ftgen 5 ,0 ,2, 2 ,1,-1
gitemp ftgen 6,0 ,1024 ,7, 0 ,1024 ,1 ; + Ramp
gitemp ftgen 7 ,0 ,1024, 7 ,-1, 512, 1 ,128, -1 ; Triangle
gitemp ftgen 8,0, 1024 ,7 ,1, 1024, 1, 0 ,-1 ,1024, -1 ; Square
gitemp ftgen 9,0 ,1024 ,-9 ,.5 ,1, 270 ; Rising Sigmoid for sine shaper
gitemp ftgen 10 ,0, 256, 7, 0 ,128, 1 ,0 ,-1, 128, 0
gitemp ftgen 11 ,0, 1024 ,21, 1
itri1 ftgen 12, 0, 8192, 10, 1, 0 .111, 0, .04, 0 .02, 0 .012 ;Triangular1
gibell ftgen 20,0,8193,9,1,1,0,1.02,.28,0,.98,.14,0,4,.22,0,7,.39,0 ;bell
gibuzz ftgen 26,0, 8193,9,1,1,.25
;f22 0 8192 9 1 1 .25
gicosine           ftgen                   21, 0, 8193,    11,     1 
gicookblank        ftgen                   22, 0, 8193,     10,     0 
gicook3            ftgen                   23, 0, 8193,     10,     1, .4, .2, .1, .1, .05
giexponentialrise  ftgen                   24, 0, 8193,     5,      .001, 513, 1 
githirteen         ftgen                   25, 0, 8193,     9,      1, .3, 0


gitemp ftgen 27, 0, 8193,9,1,3,0 ,   3  ,  1 ,   0 ,   9  , .3333 ,   180 
gitemp ftgen 28, 0, 512 ,10, .8, 1 ,.8 , .7 ,.6 , .5 , .4, .3, 0 ,0 ,0, 0 ,0, 0 ,0, .1, 0 ,0 ,0, .1, .1 ,0 ,0 ,0, 0, .05 ,0, 0, 0 ,.05, 0, 0 ,0 ,0, 0, 0, 0 ,0 ,0 ,.05 ,0 ,0 ,0, 0, 0 ,0 ,0 ,0 ,0, 0 ,0 ,0 ,0 ,.05, 0, 0, 0, 0 ,0, 0, .5
gitemp ftgen 49,  0 ,   2049 ,  11 ,   4 ,   1  ,  1 
gitemp ftgen 50 , 0 ,  1025,    13  ,  1 ,  1 ,  0  ,  5  ,  0 ,   3,    0 ,  1
gitemp ftgen 51,  0, 1025, 13, 1, 1, 0, 0, 1 ,0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1
gitemp ftgen 52,  0 ,1025 ,13, 1, 1, 0, 1, 0, 1, 0 ,1, 0, 1, 0, 1, 0, 1, 0, 1
gitemp ftgen 53 , 0 ,4097, 8, 8, 2032, 1 ,32 ,-1 ,2032 ,-8 ;cubic spline 1
gitemp ftgen 56,  0 ,1024, 10, 1 ,0 ,.5, 0 ,0, 0, 0 , .1, 0, .1, 0 ,.1, 0, .1, 0, .1, 0, .05, 0, .05, 0 ,.05, 0 ,.05, 0, 0 ,0, 0, 0, .1, 0 ,.1, 0, 0, 0, .1, 0,.1, 0 ,0, 0 ,0 ,0 ,.1, 0, .1
gitemp ftgen 57 , 0 ,1024 ,10 ,  0, 0, 0, 1, 1, 1,   0, 0, 0 ,0 ,0, 0, 0, 0, 0 ,0, 0, 0, 0 ,0,0 ,0 ,0, 0, 0, 0, 0, 0, 0 ,0 ,0, 0 ,0 ,0 ,0 ,0, .1 ,0 ,0, 0, .1, 0, 0.1
gitemp ftgen 58 , 0, 1024, 10,   1, 0, 0 ,0, 0 ,.3, .1 ,  0, 0 ,0 ,0 ,0, 0, 0 ,0 ,0 ,0 ,0, 0 ,0, 0, 0, 0 ,0 ,0 ,0, 0, 0, 0 ,0 , .1 ,0, 0 ,0 ,.1, 0 ,0, 0.1
gitemp	ftgen 199 , 0 ,1024, 10 ,1 ,0, .2 ,.2 ,.03, .12, .22, .11 ,.022, .0101, .0167
gitemp	ftgen 200   , 0 ,1024 , 8, 0, 512, 1 ,512, 0

gitemp	ftgen 91 ,0, 8193, 19 ,1 ,1 ,0, 1 
gitemp	ftgen 1000,     0 , 128 ,   7 ,  0,   30 ,   0 ,    2,   1,  2, 0, 30, 0, 30, 0, 2, -1, 2, 0, 30, 0
gitemp	ftgen 2000 ,    0 , 128 ,  -7,   1,   128,   1
gitemp	ftgen 3000 ,    0 , 128 ,  -7 ,  0 ,  64 ,   100,   64 , 0
gitemp	ftgen 4000 ,    0 , 128 ,  -7 ,  1 ,  128,   1
gitemp	ftgen 5000 ,    0 , 128,   -7 ,  0 , 128 ,  0
;tables for talkbox

gitemp	ftgen 31, 0, 1024, -7,  650, 256,  400, 256,  290, 256,  400, 256,  350 
gitemp	ftgen 32, 0, 1024, -7, 1080, 256, 1700, 256, 1870, 256,  800, 256,  600
gitemp	ftgen 33, 0, 1024, -7, 2650, 256, 2600, 256, 2800, 256, 2600, 256, 2700
gitemp	ftgen 34, 0, 1024, -7, 2900, 256, 3200, 256, 3250, 256, 2800, 256, 2900
gitemp	ftgen 35, 0, 1024, -7, 3250, 256, 3580, 256, 3540, 256, 3000, 256, 3300
gitemp	ftgen 36, 0, 1024, -7,   80, 256,   70, 256,   40, 256,   40, 256,   40
gitemp	ftgen 37, 0, 1024, -7,   90, 256,   80, 256,   90, 256,   80, 256,   60
gitemp	ftgen 38, 0, 1024, -7,  120, 256,  100, 256,  100, 256,  100, 256,  100
gitemp	ftgen 39, 0, 1024, -7,  130, 256,  120, 256,  120, 256,  120, 256,  120
gitemp	ftgen 40, 0, 1024, -7,  140,256,  120, 256,  120, 256,  120, 256,  120

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
gitemp	ftgen 110,0,64,-2,10 ,1,261.626,60,1, 1, 2, 3, 5, 8, 13, 21, 34, 55;fibonacci
gitemp	ftgen 111,0,64,-2,5 ,2,261.626,60,1,1.125,1.25,1.5,1.6666666666666666666666666666667
gitemp	ftgen 112,0,64,-2,13 ,3,261.626,60,1.08,1.1904761904761904761904761904762,1.2857142857142857142857142857143,1.4,1.5306122448979591836734693877551,1.6666666666666666666666666666667,1.8,1.96,2.1428571428571428571428571428571,2.3333333333333333333333333333333,2.52,2.7777777777777777777777777777778,3
gitemp	ftgen 113,0,64,-2,23 ,2,261.626,60,1.0000,1.0404,1.0813,1.1226,1.1644,1.2066,1.2493,1.2925,1.3361,1.3802,1.4248,1.4699,1.5155,1.5616,1.6082,1.6553,1.7030,1.7511,1.7998,1.8490,1.8988,1.9491,2.0000 ;Narsing
gitemp	ftgen 114,0,64,-2,22 ,2,261.626,60,1,1.0534979423868312757201646090535,1.0666666666666666666666666666667,1.1111111111111111111111111111111,1.125,1.1851851851851851851851851851852,1.2,1.25,1.265625,1.3333333333333333333333333333333,1.35,1.40625,1.423828125,1.5,1.5802469135802469135802469135802,1.6,1.6666666666666666666666666666667,1.6875,1.7777777777777777777777777777778,1.8,1.875,1.8984375 ;indian
gitemp	ftgen 115,0,64,-2,19 ,2.25,261.626,60,1, 1.05, 1.09375, 1.1428571428571428571428571428571, 1.2, 1.25, 1.3125, 1.3714285714285714285714285714286, 1.4285714285714285714285714285714,1.5,1.575, 1.6666666666666666666666666666667, 1.7142857142857142857142857142857,1.8, 1.875, 1.96875, 2.0571428571428571428571428571429, 2.1428571428571428571428571428571, 2.25

;************************************************************************************************ 
;organ
gitemp            ftgen                   116, 0, 65537,    10,     1, .02, .01
gitemp            ftgen                   117, 0, 65537,    10,     1, 0, .2, 0, .1, 0, .05, 0, .02
gitemp            ftgen                   118, 0, 65537,    10,     1, .5, .33, .25,  .0, .1,  .1, .1

;set here the color of panel;The range for each RGB component is 0-255
;FLcolor   135,216,140
 
FLpanel "VECTROSYNTH O.91",880,680,50,50,3;start of container
FLtabs   850,650, 5,5 

 
;FLcolor  206,50,64,130,137,156


;GENERATORS
;4 VCO + 4 LFO + NOISE
;FLcolor   135,216,140  
FLgroup "OSCILLATORS",880,650, 10,40,1 
;CONTROLLI PER  DETUNED
;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY

FLvkeybd "keyboard.map", 520, 100, 18,560



ihbordosc	FLbox  	" ", 	6,        9,    15,    461,    270,   390, 45	;border  lfo
FLsetColor 130,137,156,ihbordosc
;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY


ihbordosc 	FLbox  	" ", 	6,        9,    15,    220,    270,   94, 45	;border 
FLsetColor 130,137,156,ihbordosc  ;grigio

;FLcolor  $COLOR1,$COLOR2,0, 207,105,0

;gkrgb,ihvrgb FLslider "LFO-Level",1,$COLOR2, -1,  5,   -1, 180,30,650, 470


;*********************************************************************************
;VECTORIAL SINTHESIS
;gkvect,ihvvect FLcount "WAVEFORMS", 1,4, 1, 4,1, 120, 20, 270, 570,-1, 1, 0, 1


;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihrgmd 	FLbox  	" ", 	                 6,     9,    15,    260,    100,     273, 480	;border
gkvect,ihvvect		FLbutBank	2,     2,     1,       120,  20,      290,  490,    0,       0,     0,   0


;text				         ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihrgmd	FLbox  	"ON        OFF", 	         1,     2,     15,    122,    20,       285, 510


ihvect3 FLvalue "",70,   20,    440, 490
FLsetColor 193,215,88,ihvect3
FLsetFont 1,ihvect3
FLsetTextColor 0,0,0,ihvect3


;ivectrx FLvalue "" ,60,   20,    412, 500
gk150,ihvect2 FLslider "VECTORIAL-rate" ,0.001,0.02, 0, 1,   ihvect3, 200,15,300, 545
FLsetColor 193,215,88,ihvect2
FLsetColor2 $KnobColor ihvect2
FLsetFont 4,ihvect2
;FLsetTextColor 255,255,255,ihvect2

;*******************************************************************************************





;*********************************************************************************



ihv1 FLvalue "TUNE",60,   20,    102, 55
FLsetColor 193,215,88,ihv1
FLsetFont 1,ihv1
FLsetTextColor 0,0,0,ihv1
gk1,itune1 FLknob "OSC-1", .1,2, 0, 1, ihv1,$Knobsize, 30, 45,50
FLsetColor2 $KnobColor itune1
;FLcolor2 130,137,156
FLsetFont 6,itune1
;FLsetTextColor 255,255,255,itune1

ihv2 FLvalue "TUNE",60,   20,    102, 125
FLsetColor 193,215,88,ihv2
FLsetFont 1,ihv2
FLsetTextColor 0,0,0,ihv2
gk2,itune2 FLknob "OSC-2", .1,2, 0, 1, ihv2,$Knobsize, 30, 110,50
FLsetColor2 $KnobColor itune2
FLsetFont 6,itune2
;FLsetTextColor 255,255,255,itune2

ihv3 FLvalue "TUNE",60,   20,    102, 195
FLsetColor 193,215,88,ihv3
FLsetFont 1,ihv3
FLsetTextColor 0,0,0,ihv3
gk3,itune3 FLknob "OSC-3", .1,2, 0, 1, ihv3,$Knobsize, 30, 180,50
FLsetColor2 $KnobColor itune3
FLsetFont 6,itune3
;FLsetTextColor 255,255,255,itune3

ihv4 FLvalue "TUNE",60,   20,    102, 265
FLsetColor 193,215,88,ihv4
FLsetFont 1,ihv4
FLsetTextColor 0,0,0,ihv4
gk4,itune4 FLknob "OSC-4", .1,2, 0, 1, ihv4,$Knobsize, 30, 250,50
FLsetColor2 $KnobColor itune4
FLsetFont 6,itune4
;FLsetTextColor 255,255,255,itune4

;0, 1, 0, 0   permette di evitare il trig ogni cambio suono
;0, 1, 0, 1
;-1, 1, 0, 1
;*********************************************************************************************************
;SINTETIZZATORI
;gk5,ihv5osc FLcount "WAVEFORMS", 1,7, 1, 7,1, 120, 20, 170, 70,-1, 1, 0, 1
gk5,gihv5osc FLcount "", 1,65, 1, 65,1, 120, 20, 175, 55,0, 1, 0, 0
FLsetColor 130,137,156,gihv5osc
FLsetFont 10,gihv5osc
FLsetTextColor 255,255,80,gihv5osc


gk6,gihv6osc FLcount "", 0,65, 1, 65, 1, 120, 20, 175, 125,0, 1, 0, 0
FLsetColor 130,137,156,gihv6osc
FLsetFont 10,gihv6osc
FLsetTextColor 255,255,80,gihv6osc

gk7,gihv7osc FLcount "", 0,65, 1, 65, 1, 120, 20, 175, 195,0, 1, 0, 0
FLsetColor 130,137,156,gihv7osc
FLsetFont 10,gihv7osc
FLsetTextColor 255,255,80,gihv7osc


gk8,gihv8osc FLcount "", 0,65, 1, 65, 1, 120, 20, 175, 265,0, 1, 0, 0
FLsetColor 130,137,156,gihv8osc
FLsetFont 10,gihv8osc
FLsetTextColor 255,255,80,gihv8osc

;************************************************************************************************
;LFO OSCILLATORS
ihv17 FLvalue "FREQUENCY",60,   20,    412, 55
FLsetColor 193,215,88,ihv17
FLsetFont 1,ihv17
FLsetTextColor 0,0,0,ihv17
gk9,ilfo1 FLknob "LFO", .1,12, -1, 1,ihv17,$Knobsize, 328, 40,50
FLsetColor2 $KnobColor ilfo1
FLsetFont 6,ilfo1
;FLsetTextColor 255,255,255,ilfo1



ihv18 FLvalue "FREQUENCY",60,   20,    412, 125
FLsetColor 193,215,88,ihv18 
FLsetFont 1,ihv18
FLsetTextColor 0,0,0,ihv18
gk10,ilfo2 FLknob "LFO", .1,12, -1, 1, ihv18,$Knobsize, 328, 115,50
FLsetColor2 $KnobColor ilfo2
FLsetFont 6,ilfo2
;FLsetTextColor 255,255,255,ilfo2


ihv19 FLvalue "FREQUENCY",60,   20,    412, 195
FLsetColor 193,215,88,ihv19
FLsetFont 1,ihv19
FLsetTextColor 0,0,0,ihv19
gk11,ilfo3 FLknob "LFO", .1,12, -1, 1, ihv19,$Knobsize, 328, 185,50
FLsetColor2 $KnobColor ilfo3
FLsetFont 6,ilfo3
;FLsetTextColor 255,255,255,ilfo3

ihv20 FLvalue "FREQUENCY",60,   20,    412, 265
FLsetColor 193,215,88,ihv20
FLsetFont 1,ihv20
FLsetTextColor 0,0,0,ihv20
gk12,ilfo4 FLknob "LFO", .1,12, -1, 1, ihv20,$Knobsize, 328, 255,50
FLsetColor2 $KnobColor ilfo4
FLsetFont 6,ilfo4
;FLsetTextColor 255,255,255,ilfo4

;LFO waveforms
gk13,ihv9 FLcount "LFO-WAVEFORMS", 1, 12, 1, 17, 1, 120, 20, 490, 55,-1, 1, 0, 1
FLsetColor 130,137,156,ihv9
FLsetFont 1,ihv9 
;FLsetTextColor 0,0,0,ihv9 


gk14,ihv10 FLcount "LFO-WAVEFORMS", 1, 12, 1, 1, 1, 120, 20, 490, 125,-1, 1, 0, 1
FLsetColor 130,137,156,ihv10
FLsetFont 1,ihv10
;FLsetTextColor 0,0,0,ihv10

gk15,ihv11 FLcount "LFO-WAVEFORMS", 1, 12, 1, 1, 1, 120, 20, 490, 195,-1, 1, 0, 1
FLsetColor 130,137,156,ihv11
FLsetFont 1,ihv11 
;FLsetTextColor 0,0,0,ihv11 

gk16,ihv12 FLcount "LFO-WAVEFORMS", 1, 12, 1, 1, 1, 120, 20, 490, 265,-1, 1, 0, 1
FLsetColor 130,137,156,ihv12
FLsetFont 1,ihv12
;FLsetTextColor 0,0,0,ihv12




;LEVELS LFO OSCILLATORS

gk17,ihv13vol FLslider "LFO-Level",.01, 240, -1,  5,   -1, 180,24,650, 55
FLsetColor 130,137,156,ihv13vol
FLsetFont 4,ihv13vol
FLsetTextColor 0,0,0,ihv13vol
FLsetColor2 $KnobColor ihv13vol
gk18,ihv14vol FLslider "LFO-Level",.01, 240, -1,  5,   -1, 180,24,650, 125
FLsetColor 130,137,156,ihv14vol
FLsetFont 4,ihv14vol
FLsetTextColor 0,0,0,ihv14vol
FLsetColor2 $KnobColor ihv14vol

gk19,ihv15vol FLslider "LFO-Level",.01, 240, -1,  5,   -1, 180,24,650, 195
FLsetColor 130,137,156,ihv15vol
FLsetFont 4,ihv15vol
FLsetTextColor 0,0,0,ihv15vol
FLsetColor2 $KnobColor ihv15vol

gk20,ihv16vol FLslider "LFO-Level",.01, 240, -1,  5,   -1, 180,24,650, 265
FLsetColor 130,137,156,ihv16vol
FLsetFont 4,ihv16vol
FLsetTextColor 0,0,0,ihv16vol
FLsetColor2 $KnobColor ihv16vol
;***********************************************************************************************
;ADSR


;OSC1 ADSR
;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihadsrbord 	FLbox  	" ", 	          6,     9,    15,    830,    155,     20, 320	;border
FLsetColor 130,137,156,ihadsrbord 


gk65,giadsr1a FLslider	"A", 0.001, 3,  0, 5, -1, 150, 20,40,325
gk66,giadsr1b FLslider	"D", 0, .5,    0, 5, -1, 150, 20,40,360
gk67,giadsr1c FLslider	"S", 0.1, 1,   0, 5, -1, 150, 20,40,395
gk68,giadsr1d FLslider	"R", 0, 2,     0, 5, -1, 150, 20,40,430
FLsetColor 130,137,156,giadsr1a
FLsetColor 130,137,156,giadsr1b
FLsetColor 130,137,156,giadsr1c
FLsetColor 130,137,156,giadsr1d
FLsetColor2 $KnobColor giadsr1a
FLsetColor2 $KnobColor giadsr1b
FLsetColor2 $KnobColor giadsr1c
FLsetColor2 $KnobColor giadsr1d
;OSC2 ADSR


gk69,giadsr1a2 FLslider	"A", 0.01, 3,  0, 5, -1, 150, 20,240,325
gk70,giadsr1b2 FLslider	"D", 0, .5,    0, 5, -1, 150, 20,240,360
gk71,giadsr1c2 FLslider	"S", 0.01, 1,  0, 5, -1, 150, 20,240,395
gk72,giadsr1d2 FLslider	"R", 0, 2,     0, 5, -1, 150, 20,240,430
FLsetColor 130,137,156,giadsr1a2
FLsetColor 130,137,156,giadsr1b2
FLsetColor 130,137,156,giadsr1c2
FLsetColor 130,137,156,giadsr1d2
FLsetColor2 $KnobColor giadsr1a2
FLsetColor2 $KnobColor giadsr1b2
FLsetColor2 $KnobColor giadsr1c2
FLsetColor2 $KnobColor giadsr1d2
;OSC3 ADSR


gk73,giadsr1a3 FLslider	"A", 0.01, 3,  0, 5, -1, 150, 20,440,325
gk74,giadsr1b3 FLslider	"D", 0, .5,    0, 5, -1, 150, 20,440,360
gk75,giadsr1c3 FLslider	"S", 0.01, 1,  0, 5, -1, 150, 20,440,395
gk76,giadsr1d3 FLslider	"R", 0, 2,     0, 5, -1, 150, 20,440,430
FLsetColor 130,137,156,giadsr1a3
FLsetColor 130,137,156,giadsr1b3
FLsetColor 130,137,156,giadsr1c3
FLsetColor 130,137,156,giadsr1d3
FLsetColor2 $KnobColor giadsr1a3
FLsetColor2 $KnobColor giadsr1b3
FLsetColor2 $KnobColor giadsr1c3
FLsetColor2 $KnobColor giadsr1d3
;OSC4 ADSR


gk173,giadsr1a4 FLslider "A", 0.01, 3,   0, 5, -1, 150, 20,640,325
gk174,giadsr1b4 FLslider "D", 0, .5,     0, 5, -1, 150, 20,640,360
gk175,giadsr1c4 FLslider "S", 0.01, 1,   0, 5, -1, 150, 20,640,395
gk176,giadsr1d4 FLslider "R", 0, 2,      0, 5, -1, 150, 20,640,430
FLsetColor 130,137,156,giadsr1a4
FLsetColor 130,137,156,giadsr1b4
FLsetColor 130,137,156,giadsr1c4
FLsetColor 130,137,156,giadsr1d4
FLsetColor2 $KnobColor giadsr1a4
FLsetColor2 $KnobColor giadsr1b4
FLsetColor2 $KnobColor giadsr1c4
FLsetColor2 $KnobColor giadsr1d4

ihmicrtune 	FLbox  	" ", 	                 6,     9,    15,    315,    100,     532.9, 480	;border

;VU METER
;**********************************************************************************************

gk90,gihvu	FLslider	"", 0,32000,0,1, -1, 275,18, 550,554
	FLsetColor2 22,20, 220,  gihvu
        FLsetColor  193,215,88, gihvu
FLsetFont 6,gihvu


;**************************************************************************


;RANDOMIZE
gkrand,gihrand     FLbutton "RAND-ADSR", 1,0, 2, 110, 20, 550,490, 0, 5, 0, 0
;gkrand2,gihrand2   FLbutton "RAND-LFO", 1,0, 2, 110, 20,  550,600, 0, 13, 0, 0

;TUNING
gktuning,gituning FLcount "", 101,115, 1, 101,115, 135, 20, 695, 490,0, 11, 0, 1
FLsetColor 130,137,156,gituning
FLsetFont 10,gituning
;FLsetTextColor 105,205,230,gituning

;k155,gicon FLtext "label",1, 127, 1, 1, 50, 50, 550, 550
gkpulsew,gipulsew FLslider "Vco-pulse" ,0.01,0.95, 0, 1,   -1, 130,11,550, 519
FLsetFont 1,gipulsew
FLsetColor2 $KnobColor gipulsew
FLsetColor 193,215,88,gipulsew

;****************RECORDING*******************************************************
;fout
ihlevelrec 	FLbox  	" ", 	                 6,     9,    15,    275,    45,     550, 585	;border
FLsetColor 130,137,156,ihlevelrec   ;grigio

gkhdrec,gihdrec    FLbutton "", 1,0, 2, 54, 29, 730,595, 0, 12, 0, 0
FLsetTextColor 255,0,0,gihdrec
;gkrand2,gihrand2   FLbutton "RAND-LFO", 1,0, 2, 110, 20,  550,600, 0, 13, 0, 0

;gkhdrec2,gihdrec2    FLbutton "@square  Rec", 1,0, 2, 60, 30, 730,635, 0, 13, 0, 0
;FLsetTextColor 255,0,0,gihdrec2
;gkrand2,gihrand2   FLbutton "RAND-LFO", 1,0, 2, 110, 20,  550,600, 0, 13, 0, 0

gklevrec,gilevrec FLslider "Level-recording" ,1,3, 0, 1,   -1, 130,11,560, 595
FLsetColor2 $KnobColor gilevrec
FLsetFont 4,gilevrec

;ihrecordbt  FLbox  "RECORD", 1, 1,12, 22, 12, 747, 660

;gihmessage   FLbox  "Recording to disk init :", 1, 4,12, 165, 13, 535,610
;FLsetTextColor 0,0,0,gihmessage 
;PORTAMENTO
;ihport FLvalue "Value",60,   25,    800, 442
;FLsetFont 2,ihport
;FLsetTextColor 0,0,255,ihport
;gk91,iglide FLknob "Portamento", .1,3, -1, 1, ihport,  65, 800,360,50
;FLsetColor 115,210,0,iglide
;FLsetFont 2,iglide
;FLsetTextColor 0,0,255,iglide
;********************************LOOP REC PANEL********************************************************************
;LOOP REC PANEL

ihlooprec	FLbox  	" ", 	                 6,     9,    15,    275,    43,     550, 632	;border
FLsetColor 130,137,156,ihlooprec   ;grigio

gklooplay,gilooplay FLslider "Level-loop", 0.1,4, 0, 1,   -1, 80, 15, 555, 638 ;volume
FLsetFont 4,gilooplay
FLsetColor2 $KnobColor  gilooplay


gkloopstart,giloopstart    FLbutton "", 1,0, 2, 54, 29, 730,640, 0,15, 0,0
;FLsetTextColor 255,0,0,giloopstart



ihvpitchloop FLvalue "",25,   15,    686, 637
FLsetColor 193,215,88,ihvpitchloop
FLsetFont 1,ihvpitchloop
FLsetTextColor 0,0,0,ihvpitchloop
gkloopitch,giloopitch FLknob "pitch", 1,2, -1, 3, ihvpitchloop,         25, 660, 635,50
FLsetTextSize 12, giloopitch

;RECORD
;gkRecord,ihRecord		FLbutton	"Record",	1,  -1,     2,     150,     28,   350,  0,    0,      2,      0,       -1

;JITTER*********************************************************************************************

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihrgmd 	FLbox  	" ", 	                 6,     9,    15,    260,    100,     15, 480	;border


gk132,iadsr1a FLknob "amp", 0.1,9, -1, 3, -1,         36, 30, 485,50
gk133,iadsr1b FLknob "cps1", 1,90, -1, 1, -1,         36, 90, 485,50
gk134,iadsr1c FLknob "cps2", 1,90, -1, 1, -1,         36, 150,485,50
gk135,iadsr1d FLknob "cps3", 1,90, -1, 1, -1,         36, 210,485,50
FLsetColor2 $KnobColor  iadsr1a
FLsetColor2 $KnobColor  iadsr1b
FLsetColor2 $KnobColor iadsr1c
FLsetColor2 $KnobColor iadsr1d
;FLsetTextColor 255,255,255,iadsr1a
;FLsetTextColor 255,255,255,iadsr1b
;FLsetTextColor 255,255,255,iadsr1c
;FLsetTextColor 255,255,255,iadsr1d
FLsetFont 4,iadsr1a
FLsetFont 4,iadsr1b
FLsetFont 4,iadsr1c
FLsetFont 4,iadsr1d
gk136,ihjitt FLslider "Level-Jitter" ,.1,9, -1, 1,   -1, 240,12,30, 539
FLsetColor 193,215,88,ihjitt
;FLsetFont 4,ihjitt
FLsetColor2 $KnobColor ihjitt
;*****************************************************************************************************

FLgroup_end 
 



;***************************************************************************************************************************
;***************************************************************************************************************************
;****************************************FILTERS PANEL*********************************************************************
;***************************************************************************************************************************
;FILTERS PANEL
;MOOG FILTER,RESONANCE
;FLcolor   0,128,128  

FLgroup "FILTERS",880,650, 10,40
;some widgets should contained here
;borders
;BORDERS		        ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ihbord6	 	FLbox  	" ", 	6,        9,    15,    860,    210,   20, 45	;border
ihbord7 	FLbox  	" ", 	6,        9,    15,    860,    220,   20, 265	;border  second filters


ihv5 FLvalue "Value",60,   25,    102, 70
FLsetColor 193,215,88,ihv5
FLsetFont 1,ihv5
FLsetTextColor 0,0,0,ihv5
gk21,gicutfilt1 FLknob "CUT-OFF", 250,22000, -1, 1, ihv5,  $Knobsize+10, 30, 50,50
FLsetColor2 $KnobColor gicutfilt1
FLsetFont 6,gicutfilt1
;FLsetTextColor 255,255,255,gicutfilt1



ihv6 FLvalue "Value",60,   25,    102, 170
FLsetColor 193,215,88,ihv6
FLsetFont 1,ihv6
FLsetTextColor 0,0,0,ihv6
gk22,gireso FLknob "Resonance", .1,.9, -1, 1, ihv6,  $Knobsize+10, 30, 150,50
FLsetColor2 $KnobColor gireso
FLsetFont 6,gireso
;FLsetTextColor 255,255,255,gireso

;LFO MOOG FILTERS
ihv26 FLvalue "Frequency",60,   25,    270, 70
FLsetColor 193,215,88,ihv26
FLsetFont 1,ihv26
FLsetTextColor 0,0,0,ihv26
gk34,ilfocut FLknob "LFO-cut off", .5,8, -1, 1,ihv26,  $Knobsize+10, 200, 60,50
FLsetColor2 $KnobColor ilfocut
FLsetFont 6,ilfocut
;FLsetTextColor 255,255,255,ilfocut


gk36,ihv28 FLcount "LFO-WAVEFORMS", 1, 5, 1, 1, 1, 120, 20, 350, 70,-1, 1, 0, 1
;FLsetColor 0,128,0,ihandle
FLsetFont 4,ihv28 


gk38,ihv30 FLslider "LFO-Level",1,150, -1,  5,   -1, 180,30,500, 70
FLsetColor2 $KnobColor ihv30
FLsetFont 4,ihv30
FLsetTextColor 0,0,0,ihv30

;SELECTIONS FIRST FILTERS
gkselfilt, ihbutfil1		FLbutBank	4,     6,     1,       620,  30,  230,      170,    0,       0,     0,   0 
ihsfa  FLbox  "MOOGVCF2", 1, 2,12, 25, 13,   255, 210
ihsfb  FLbox  "LOWPASS2", 1, 2,12, 25, 13,   360, 210
ihsfc  FLbox  "MOOGLADDER", 1, 2,12, 25, 13, 460, 210
ihsfd  FLbox  "LPF18", 1, 2,12, 25, 13,      545, 210
ihsfe  FLbox  "STATEVAR", 1, 2,12, 25, 13,   655, 210
ihsff  FLbox  "BYPASS",   1, 2,12, 25, 13,   755, 210

;FLsetTextColor 255,255,255,ihsfa
;FLsetTextColor 255,255,255,ihsfb
;FLsetTextColor 255,255,255,ihsfc
;FLsetTextColor 255,255,255,ihsfd
;FLsetTextColor 255,255,255,ihsfe
;FLsetTextColor 255,255,255,ihsff
;END MOOG FILTER

;SECOND FILTER

;SELECTIONS SECOND FILTERS
gkselfilt2, ihbutfil2		FLbutBank	4,     5,     1,       420,  30, 25,      280,    0,       0,     0,   0 
ihsfa2  FLbox   "STATEVAR", 1, 2,11, 25, 13,43, 305
ihsfa3  FLbox  "SVFILTER", 1, 2,11, 25, 13,123, 305
ihsfa5  FLbox  "MOOGVCF2", 1, 2,11, 25, 13,213, 305
ihsfa6  FLbox  "FOFILTER", 1, 2,11, 25, 13,293, 305
ihsfa4 FLbox  "BYPASS ",  1, 2,11, 25, 13, 386, 305
;FLsetTextColor 255,255,255,ihsfa2
;FLsetTextColor 255,255,255,ihsfa3
;FLsetTextColor 255,255,255,ihsfa4 
;FLsetTextColor 255,255,255,ihsfa5
;FLsetTextColor 255,255,255,ihsfa6



ihstvar	FLbox  	" ", 	                 6,     9,    15,    220,    155,     20, 330	;border

;statevar
gkb1,gistvar1 FLknob "Cutoff",250,14000, -1, 1, -1 ,  40, 28, 340,50
FLsetColor2 $KnobColor gistvar1
;FLsetColor 51,50,58,gistvar1
gkb2,gistvar2 FLknob "Reso",.1,.9, -1, 1, -1 ,    40, 28, 400,50
FLsetColor2 $KnobColor gistvar2 
;FLsetColor 51,50,58,gistvar2

ihstvartext	FLbox  	"STATEVAR ", 	                 1,     9,    12,    12,    25,     60, 455
;FLsetTextColor 255,255,255,ihstvartext 
FLsetFont 4,ihstvartext

gk100,gihpstv FLslider "HP" ,.01,2, -1, 1,   -1, 120,12,90, 350
FLsetColor 193,215,88,gihpstv
FLsetFont 1,gihpstv
FLsetColor2 $KnobColor gihpstv

gk101,gilpstv FLslider "LP" ,.01,2, -1, 1,   -1, 120,12,90, 380
FLsetColor 193,215,88,gilpstv
FLsetFont 1,gilpstv
FLsetColor2 $KnobColor gilpstv

gk102,gibpstv FLslider "BP" ,.01,2, -1, 1,   -1, 120,12,90, 410
FLsetColor 193,215,88,gibpstv
FLsetFont 1,gibpstv
FLsetColor2 $KnobColor gibpstv

gk103,gibrstv FLslider "BR" ,.01,2, -1, 1,   -1, 120,12,90, 440
FLsetColor 193,215,88,gibrstv
FLsetFont 1,gibrstv
FLsetColor2 $KnobColor gibrstv

;SVFILTER
ihstsvf	FLbox  	" ", 	                 6,     9,    15,    160,    155,     230, 330	;border
gkb7,gistsvf1 FLknob "Cutoff",100,8000, -1, 1, -1 ,  40, 238, 340,50
FLsetColor2 $KnobColor gistsvf1
;FLsetTextColor 255,255,255,gistsvf1
gkb8,gistsvf2 FLknob "Q",1,10, -1, 1, -1 ,    40, 238, 400,50
FLsetColor2 $KnobColor gistsvf2
;FLsetTextColor 255,255,255,gistsvf2

ihstvartxt2	FLbox  	"SVFILTER", 	                 1,     9,    12,    12,    25,     260, 455
;FLsetTextColor 255,255,255,ihstvartxt2
FLsetFont 4,ihstvartxt2

gk104,gilpsvf FLslider "LP" ,.1,1, -1, 1,   -1, 90,12,290, 350
FLsetColor 193,215,88,gilpsvf
FLsetFont 1,gilpsvf
FLsetColor2 $KnobColor gilpsvf

gk105,gihpsvf FLslider "HP" ,.1,1, -1, 1,   -1, 90,12,290, 380
FLsetColor 193,215,88,gihpsvf
FLsetFont 1,gihpsvf
FLsetColor2 $KnobColor gihpsvf

gk106,gibpsvf FLslider "BP" ,.1,1, -1, 1,   -1, 90,12,290, 410
FLsetColor 193,215,88,gibpsvf 
FLsetFont 1,gibpsvf
FLsetColor2 $KnobColor gibpsvf

;MOOG2
ihmoogvcf2	FLbox  	" ", 	                 6,     9,    15,    140,    155,     388, 330	;border

imoogtx1 FLvalue "",50,   20,    450, 350
FLsetColor 193,215,88,imoogtx1
FLsetFont 1,imoogtx1
FLsetTextColor 255,255,255,imoogtx1
gk110,gimgv2 FLknob "Cutoff",250,22000, -1, 1, imoogtx1 ,  40, 398, 340,50
FLsetColor2 $KnobColor gimgv2
FLsetFont 1,gimgv2
;FLsetTextColor 255,255,255,imgv2

imoogtx2 FLvalue "",50,   20,    450, 420
FLsetColor 193,215,88,imoogtx2
FLsetFont 1,imoogtx2
;FLsetTextColor 255,255,255,imoogtx2
gk111,gimgv3 FLknob "Reso",.1,.9, -1, 1, imoogtx2 ,  40, 398, 400,50
FLsetColor2 $KnobColor gimgv3
FLsetFont 1,gimgv3
;FLsetTextColor 255,255,255,imgv3

ihmogvcf2x	FLbox  	"MOOGVCF2", 	                 1,     9,    12,    12,    25,     426, 455
;FLsetTextColor 255,255,255,ihmogvcf2x
FLsetFont 4,ihmogvcf2x

;FOFILTER
ihfofilter	FLbox  	" ", 	                 6,     9,    15,    140,    155,     528, 330	;border

ifofilter2	FLbox  	"FOFILTER", 	                 1,     9,    12,    12,    25,     560, 455
;FLsetTextColor 255,255,255,ifofilter2
FLsetFont 4,ifofilter2



ifofilter3 FLvalue "",50,   20,    580, 350
FLsetColor 193,215,88,ifofilter3
FLsetFont 1,ifofilter3
;FLsetTextColor 255,255,255,ifofilter3
gk112,gifofilter4 FLknob "KCF",250,10000, -1, 1, ifofilter3 ,  40, 530, 340,50
FLsetColor2 $KnobColor gifofilter4
FLsetFont 1,gifofilter4
;FLsetTextColor 255,255,255,ifofilter4


gk113,gifofilter5 FLslider "kris" ,.001,.1, -1, 1,   -1, 110,12,540, 400
FLsetColor 193,215,88,gifofilter5
FLsetFont 1,gifofilter5
FLsetColor2 $KnobColor gifofilter5


gk114,gifofilter6 FLslider "kdec" ,.01,.04, -1, 1,   -1,110,12,540, 430
FLsetColor 193,215,88,gifofilter6
FLsetFont 1,gifofilter6
FLsetColor2 $KnobColor gifofilter6

;************************************************************************************************************
ihcordx FLvalue "",49,20,20, 640
FLsetColor 193,215,88,ihcordx
FLsetFont 1,ihcordx
ihcordy FLvalue "",49,20,75, 640
FLsetColor 193,215,88,ihcordy
FLsetFont 1,ihcordy
;JOYSTICK FILTERS
;koutx, kouty, ihandlex, ihandley FLjoy "label", iminx, imaxx, iminy, imaxy, iexpx, iexpy, idispx, idispy, iwidth, iheight, ix,  iy
gk21,gk22,gihjoy1,gihjoy2 FLjoy "FILTER1-CUTOFF,RESONANCE", 650,   22000,.1,    .8,    -1,    0,    ihcordx,     ihcordy,     210,    170,     150, 494
;FLsetColor 255,255,255,gihjoy1
;FLsetColor2 255,0,255,gihjoy1
FLsetFont 1,gihjoy2
;FLsetTextColor 0,20,220,gihjoy1
;FLsetFont 1,gihjoy2
;FLsetTextColor 0,20,220,gihjoy2
FLsetColor $KnobColor gihjoy1


gkfiltvect,ihfiltvect   FLbutton "Auto-filter1", 1,0, 2, 87, 20, 20,575, 0,  0,    0,     1,      0,      3600



gkfiltvect2,ihfiltvect2 FLknob "RATE", 0.1,9, -1, 3, -1 ,  50, 35, 500,50
FLsetColor2 $KnobColor ihfiltvect2
FLsetFont 2,ihfiltvect2




;**********************************************************************************************************************************
;END SECOND FILTER

;ADSR FILTER
;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihrgmd9	FLbox  	" ", 	                 6,     9,    15,    175,    190,     520, 485	;border

ihrgmd10 FLbox   	" ", 	         6,     9,    15,    175,    190,     700, 485	;border

;ADSR FILTER1

;ihrgmd 	FLbox  	"FILTER1-ADSR", 	                 1,     9,    12,    50,    20,     645, 636

;adsr filters
iadsrfil   FLbox  "Filter1", 1, 2,15, 55, 13, 525, 492
iadsrfil2  FLbox  "Filter2", 1, 2,15, 55, 13, 705, 492


gk78,iadsrfl1 FLslider "A" ,.01,2, -1, 5,   -1, 140,12,540, 520
FLsetColor2 $KnobColor iadsrfl1
FLsetFont 1,iadsrfl1
FLsetTextColor 0,0,0,iadsrfl1

gk79,iadsrfl2 FLslider "D",.1,1, -1,  5,   -1, 140,12,540, 560
FLsetColor2 $KnobColor iadsrfl2
FLsetFont 1,iadsrfl2
FLsetTextColor 0,0,0,iadsrfl2

gk80,iadsrfl3 FLslider "S",.1,.5, -1,  5,   -1, 140,12,540, 600
FLsetColor2 $KnobColor iadsrfl3
FLsetFont 1,iadsrfl3
FLsetTextColor 0,0,0,iadsrfl3

gk81,iadsrfl4 FLslider "R",.1,2, -1,  5,   -1, 140,12,540, 640
FLsetColor2 $KnobColor iadsrfl4
FLsetFont 1,iadsrfl4
FLsetTextColor 0,0,0,iadsrfl4


;ADSR FILTER2

;ihrgmd 	FLbox  	"FILTER2-ADSR", 	                 1,     9,    12,    50,    20,     725, 636


gk82,iadsrflb1 FLslider "A" ,.01,2, -1, 5,   -1, 140,12,720, 520
FLsetColor2 $KnobColor iadsrflb1
FLsetFont 1,iadsrflb1
FLsetTextColor 0,0,0,iadsrflb1

gk83,iadsrflb2 FLslider "D",.1,1, -1,  5,   -1, 140,12,720, 560
FLsetColor2 $KnobColor iadsrflb2
FLsetFont 1,iadsrflb2 
FLsetTextColor 0,0,0,iadsrflb2 

gk84,iadsrflb3 FLslider "S",.1,.5, -1,  5,   -1, 140,12,720, 600
FLsetColor2 $KnobColor iadsrflb3
FLsetFont 1,iadsrflb3
FLsetTextColor 0,0,0,iadsrflb3

gk85,iadsrflb4 FLslider "R",.1,2, -1,  5,   -1, 140,12,720, 640
FLsetColor2 $KnobColor iadsrflb4
FLsetFont 1,iadsrflb4
FLsetTextColor 0,0,0,iadsrflb4

;TITOLI 

ihfiltlab1	FLbox  	"FILTER 1", 	                 1,     9,    18,  84,    55,    770, 55
ihfiltlab2	FLbox  	"FILTER 2", 	                 1,     9,    18,  84,    55,    770, 275
;FLsetTextColor 255,255,255,ihfiltlab1
;FLsetTextColor 255,255,255,ihfiltlab2
FLsetFont 6,ihfiltlab1
FLsetFont 6,ihfiltlab2


;;RANDOMIZE
gkrandfilt2,gihrandfilt2     FLbutton "Auto-filter2", 1,0, 2, 110, 20, 390,580, 0, 13, 0, 0
;gkrand2,gihrand2   FLbutton "RAND-LFO", 1,0, 2, 110, 20,  550,600, 0, 13, 0, 0

gkrndfiltvect2,gihrndfiltvect2 FLknob "RATE", 0.1,9, -1, 3, -1 ,  50, 415, 500,480
FLsetColor2 $KnobColor gihrndfiltvect2
FLsetFont 2,gihrndfiltvect2


FLgroup_end 

;************************************************************************************************ 
;************************************************************************************************
;************************************************************************************************
;************************************************************************************************ 
;EFFECTS PANEL
;ANALOG ECHO,PHASER 
;FLcolor   192,192,192  
FLgroup "EFFECTS",880,650, 10,40,1 

ihfx1lab1	FLbox  	"FX1", 	                 1,     9,    18,  84,    55,    770, 40
ihfx2lab2	FLbox  	"FX2", 	                 1,     9,    18,  84,    55,    770, 300
;FLsetTextColor 255,255,255,ihfx1lab1
;FLsetTextColor 255,255,255,ihfx2lab2
FLsetFont 6,ihfx1lab1
FLsetFont 6,ihfx2lab2



;kout, ihandle FLbutBank                      itype, inumx, inumy,   iwidth, iheight, ix, iy, iopcode [, kp1] [, kp2] [, kp3] [, kp4] [, kp5] [....] [, kpN]
gkselfx, ihbutfx1		FLbutBank	4,     6,     1,       560,  30,      30,  50,    0,       0,     0,   0
ihsfx1  FLbox  "FLANGER", 1, 2,12, 25, 13, 45, 80
;FLsetTextColor 255,255,255,ihsfx1
ihsfx1  FLbox  "RING-MOD", 1, 2,12, 25, 13, 135, 80
;FLsetTextColor 255,255,255,ihsfx1
ihsfx1  FLbox  "PHASER", 1, 2,12, 25, 13, 225, 80
;FLsetTextColor 255,255,255,ihsfx1
ihsfx1  FLbox  "DELAY", 1, 2,12, 25, 13, 318, 80
;FLsetTextColor 255,255,255,ihsfx1
ihsfx1  FLbox  "TALKBOX", 1, 2,12, 25, 13, 415, 80
;FLsetTextColor 255,255,255,ihsfx1
ihsfx1  FLbox  "BYPASS", 1, 2,12, 25, 13, 510,80
;FLsetTextColor 255,255,255,ihsfx1




;************************************************************************************************                                                     
;FLANGER                                              ;iwidth, iheight, ix,  iy

ihflang	 	FLbox  	" ", 	6,        9,    15,    180,    150,     20, 140	;border
;FLsetColor 0,255,255,ihflang

ihflg FLvalue "Level",40,   20,    30, 200
FLsetColor 193,215,88,ihflg
FLsetFont 1,ihflg 
;FLsetTextColor 255,255,255,ihflg 
gk45,giflang FLknob "", 0.1,3, -1, 1, ihflg ,  40, 28, 150,50
FLsetColor2 $KnobColor giflang

ihflg2 FLvalue "Depth",40,   20,    90, 200
FLsetFont 1,ihflg2
;FLsetTextColor 255,255,255,ihflg2
FLsetColor 193,215,88,ihflg2
gk46,giflang2 FLknob "", 0.1,9, -1, 1, ihflg2 ,  40, 85, 150,50
FLsetColor2 $KnobColor giflang2

ihflg3 FLvalue "Rate",40,   20,    140, 200
FLsetFont 1,ihflg3
;FLsetTextColor 255,255,255,ihflg3 
FLsetColor 193,215,88,ihflg3
gk47,giflang3 FLknob "", 0.1,3, -1, 1, ihflg3 ,  40, 140, 150,50
FLsetColor2 $KnobColor giflang3

ihflangtx	 	FLbox  	"FLANGER", 	1,        9,    15,    33,    24,     50, 260
FLsetFont 2,ihflangtx
;FLsetTextColor 255,255,255,ihflangtx

;************************************************************************************************
;RING MODULATOR PANEL

;FLsetFont 2,ihrgmdtx
;FLsetTextColor 0,0,255,ihrgmdtx
;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihrgmd 	FLbox  	" ", 	                 6,     9,    15,    225,    150,     200, 140	;border

ihrgmd 	FLbox  	"RING-MOD ", 	         1,     9,    15,    20,    15,       240, 264	;border
FLsetFont 2,ihrgmd
;FLsetTextColor 255,255,255,ihrgmd


ihrgmd2 FLvalue "HZ",40,   20,210, 200
FLsetFont 1,ihrgmd2 
;FLsetTextColor 255,255,255,ihrgmd2
FLsetColor 193,215,88,ihrgmd2
gk48,girgmd FLknob "", 16,4800, -1, 1, ihrgmd2 ,  40, 210, 150,50
FLsetColor2 $KnobColor girgmd

ihrgmd3 FLvalue "HZ-LFO",40,   20,255, 200
FLsetFont 1,ihrgmd3 
;FLsetTextColor 255,255,255,ihrgmd3
FLsetColor 193,215,88,ihrgmd3
gk49,girgmd2 FLknob "", .5,16, -1, 1, ihrgmd3 ,  40, 255, 150,50
FLsetColor2 $KnobColor girgmd2

gk50,girgmd3 FLslider "Level",.1, 44, -1,  1,   -1, 114,16,305, 170 ;level LFO
FLsetColor 193,215,88,girgmd3
FLsetFont 1,girgmd3
FLsetColor2 $KnobColor girgmd3

gk51,girgmd4 FLcount "Lfo-Waveform", 1, 16, 1, 16, 6, 80, 30, 320, 220,-1, 1, 0, 1
;FLsetColor 0,255,0,girgmd4
FLsetFont 1,girgmd4
;FLsetTextColor 255,255,255,girgmd4
;***************************************************************************************************
;PHASER2 PANEL
;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX,  IY
ihph2 	FLbox  	" ", 	                 6,     9,    15,    180,    150,     425, 140	;border

ihph2tx FLbox  	"PHASER", 	         1,     9,    14,    20,    15,       452, 269	;border
FLsetFont 2,ihph2tx
;FLsetTextColor 255,255,255,ihph2tx

ihph3 FLvalue "Level",42,   20,430, 192
;FLsetFont 1,ihph3
;FLsetTextColor 255,255,255,ihph3
FLsetColor 193,215,88,ihph3
gk52,giph2 FLknob "", .1,1, -1, 1, ihph3 ,  40, 430, 150,50
FLsetColor2 $KnobColor giph2

ihph4 FLvalue "Lfo-Hz",42,   20,475, 192
;FLsetFont 1,ihph4
;FLsetTextColor 255,255,255,ihph4
FLsetColor 193,215,88,ihph4
gk53,giph3 FLknob "", .5,12, -1, 1, ihph4 ,  40, 476, 150,50
FLsetColor2 $KnobColor giph3

ihph5 FLvalue "Mod",42,   20,518, 192
;FLsetFont 1,ihph4
;FLsetTextColor 255,255,255,ihph5
FLsetColor 193,215,88,ihph5
gk54,giph4 FLknob "", 200,8000, -1, 1, ihph5 ,  40, 520, 150,50
FLsetColor2 $KnobColor giph4

gk55,giph5 FLslider "kPhSep",.25, 4, -1,  6,   -1, 14,114,568, 150 ;level LFO


gkorder,ihorder FLtext "Iorder",1, 50, 1, 1, 50,20, 430, 230



;FOUR EFFECTX FX1
ihphx 	FLbox  	" ", 	                 6,     9,    15,    145,    150,     605, 140	;border
ihph6x 	FLbox  	"DELAY", 	         1,     9,    15,    20,    15,       636, 264	;border
FLsetFont 2,ihph6x
;FLsetTextColor 255,255,255,ihph6x 



ihdelk1 FLvalue "Delay",42,   15,618, 190
;FLsetFont 1,ihph3
;FLsetTextColor 255,255,255,ihdelk1
FLsetColor 193,215,88,ihdelk1
gk120,gidelk FLknob "", .1,3, -1, 1, ihdelk1 ,  40, 618, 150,50
FLsetColor2 $KnobColor gidelk

ihdelk2 FLvalue "Decay",42,   15,685, 190
;FLsetFont 1,ihph3
;FLsetTextColor 255,255,255,ihdelk2
FLsetColor 193,215,88,ihdelk2
gk121,gidelk2 FLknob "", .1,.9, -1, 1, ihdelk2 ,  40, 685, 150,50
FLsetColor2 $KnobColor gidelk2

gk122,gidelk3 FLslider "Level",.1, 1, -1,  1,   -1, 100,16,625, 230 ;level LFO
FLsetColor 193,215,88,gidelk3
FLsetFont 1,gidelk3
FLsetColor2 $KnobColor gidelk3


;TALK BOX
ihph7 	FLbox  	" ", 	                 6,     9,    15,    130,    150,     750, 140	;border
ihph8 	FLbox  	"TALKBOX", 	         1,     9,    15,    20,    15,       782, 264	;border
FLsetFont 2,ihph8
;FLsetTextColor 255,255,255,ihph8

ihtkb FLvalue "Level",42,   15,758, 190
;FLsetFont 1,ihph3
;FLsetTextColor 255,255,255,ihtkb
FLsetColor 193,215,88,ihtkb
gk140,gitkb FLknob "", .1,1, -1, 1, ihtkb ,  40, 758, 150,50
FLsetColor2 $KnobColor gitkb

ihtkb2 FLvalue "Rate",42,   15,825, 190
;FLsetFont 1,ihph3
;FLsetTextColor 255,255,255,ihtkb2
FLsetColor 193,215,88,ihtkb2
gk141,gitkb2 FLknob "", .1,3, -1, 1, ihtkb2 ,  40, 825, 150,50
FLsetColor2 $KnobColor gitkb2


;************************************************************************************************

;************************************************************************************************

;second effects
gkselfx2, ihbutfx2		FLbutBank	4,     9,     1,       760,  30,  30,      300,    0,       0,     0,   0



ihsfx2  FLbox  "CHORUS",      1, 2,11, 25, 13,      40,325
;FLsetTextColor 255,255,255,ihsfx2
ihsfx2  FLbox  "ECHO",        1, 2,11, 25, 13,     120,325
;FLsetTextColor 255,255,255,ihsfx2
ihsfx2  FLbox  "VCOMB",       1, 2,11, 25, 13,     210,325
;FLsetTextColor 255,255,255,ihsfx2
ihsfx2  FLbox  "EQUALIZER",     1, 2,11, 25, 13,     290,325
;FLsetTextColor 255,255,255,ihsfx2
ihsfx2  FLbox  "STEPFL", 1, 2,11, 22, 13,          375, 325
;FLsetTextColor 255,255,255,ihsfx2
ihsfx2  FLbox  "SPACE", 1, 2,11, 22, 13,           460, 325
;FLsetTextColor 255,255,255,ihsfx2
ihsfx2  FLbox  "BYPASS",      1, 2,11, 25, 13,    720, 325


;****************************************************************************
;CHORUS

ihchorus 	FLbox  	" ", 	6,        9,    15,    200,    150,     20, 360	;border
ihchorus 	FLbox  	"CHORUS", 	   1,     9,    15,    20,     15,       50, 484	;border
FLsetFont 2,ihchorus 
;FLsetTextColor 255,255,255,ihchorus 

ihcho FLvalue "Level",40,   20,    35, 420
FLsetFont 1,ihcho 
;FLsetTextColor 255,255,255,ihcho 
FLsetColor 193,215,88,ihcho 
gk57,gicho FLknob "", .1,2, -1, 1, ihcho ,  $Knobsize, 28, 370,50
FLsetColor2 $KnobColor gicho

ihcho2 FLvalue "Depth",40,   20,    95, 420
FLsetFont 1,ihcho2
;FLsetTextColor 255,255,255,ihcho2
FLsetColor 193,215,88,ihcho2
gk58,gicho2 FLknob "", 0.1,11, -1, 1, ihcho2 ,  $Knobsize, 85, 370,50
FLsetColor2 $KnobColor gicho2

ihcho3 FLvalue "Rate",40,   20,    145, 420
FLsetFont 1,ihcho3
;FLsetTextColor 255,255,255,ihcho3 
FLsetColor 193,215,88,ihcho3
gk59,gicho3 FLknob "", 0.1,3, -1, 1, ihcho3 ,  $Knobsize, 140, 370,50
FLsetColor2 $KnobColor gicho3

;****************************************************************************
;ANALOG DELAY

ihdelay	FLbox  	" ", 	                 6,     9,    15,    250,    150,     220, 360	;border

ihdelay FLbox  	"ECHO", 	         1,     9,    15,    20,    15,       240, 484	;border
FLsetFont 2,ihdelay
;FLsetTextColor 255,255,255,ihdelay


ihandel FLvalue "DELAY",40,   20,235, 420
FLsetFont 1,ihandel 
;FLsetTextColor 255,255,255,ihandel
FLsetColor 193,215,88,ihandel
gk60,gidely FLknob "", .1,10, -1, 1, ihandel , $Knobsize, 230, 370,50
FLsetColor2 $KnobColor gidely

ihandel2 FLvalue "ECHO",40,   20,290, 420
FLsetFont 1,ihandel2
;FLsetTextColor 255,255,255,ihandel2
FLsetColor 193,215,88,ihandel2
gk61,gidely2 FLknob "", .1,1.5, -1, 1, ihandel2 ,  $Knobsize, 285, 370,50
FLsetColor2 $KnobColor gidely2

gk62,gihandel FLslider "LEVEL",.01, 4, -1,  1,   -1, 114,16,345, 380 ;level LFO
FLsetColor 193,215,88,gihandel
FLsetFont 1,gihandel
FLsetColor2 $KnobColor gihandel



ihandel3 FLvalue "FILTER",50,   20,370, 465
FLsetFont 1,ihandel3
;FLsetTextColor 255,255,255,ihandel3
FLsetColor 193,215,88,ihandel3
gk63,gidely3 FLknob "", 2000,20000, -1, 1, ihandel3 ,  $Knobsize, 370, 415,50
FLsetColor2 $KnobColor gidely3


;****************************************************************************
;COMB
ihcomb 	FLbox  	" ", 	                 6,     9,    15,    210,    150,     471, 360	;border

ihcomb 	FLbox  	"VCOMB", 	         1,     9,    15,    20,    15,       500, 484	;border
FLsetFont 2,ihcomb
;FLsetTextColor 255,255,255,ihcomb

gk127,gicomb FLslider "Reverb-time",.01, 9, -1,  1,   -1, 164,15,488, 370 ;level LFO
FLsetColor 193,215,88,gicomb
FLsetFont 1,gicomb
FLsetColor2 $KnobColor gicomb

gk128,gicomb2 FLslider "Loop-time",.01, 2.5, -1,  1,   -1, 164,15,488, 410 ;level LFO
FLsetColor 193,215,88,gicomb2
FLsetFont 1,gicomb2
FLsetColor2 $KnobColor gicomb2

gk129,gicomb3 FLslider "Max-loop-time",.01, 20, -1,  1,   -1, 164,15,488, 450 ;level LFO
FLsetColor 193,215,88,gicomb3
FLsetFont 1,gicomb3
FLsetColor2 $KnobColor gicomb3


;DISTORTION fx
ihcomb 	FLbox  	" ", 	                 6,     9,    15,    210,    150,     661, 360	;border

ihdist 	FLbox  	"EQUALIZER", 	         1,     9,    15,    20,    15,       715, 484	;border
FLsetFont 2,ihdist
;FLsetTextColor 255,255,255,ihdist


idist1 FLvalue "kceq",40,   20,690, 410
FLsetFont 1,idist1 
;FLsetTextColor 255,255,255,idist1
FLsetColor 193,215,88,idist1
gk123,gidist1 FLknob "", 100,20000, -1, 1, idist1 ,  40, 690, 370,50
FLsetColor2 $KnobColor gidist1


idist2 FLvalue "kveq",40,   20,750, 410
FLsetFont 1,idist2 
;FLsetTextColor 255,255,255,idist2
FLsetColor 193,215,88,idist2
gk124,gidist2 FLknob "", 1,15, -1, 1, idist2 ,  40, 750, 370,50
FLsetColor2 $KnobColor gidist2

idist3 FLvalue "Q",40,   20,810, 410
FLsetFont 1,idist3 
;FLsetTextColor 255,255,255,idist2
FLsetColor 193,215,88,idist3
gk254,gidist8 FLknob "", .1,1, -1, 1, idist3 ,  40, 810, 370,50
FLsetColor2 $KnobColor gidist8

;gk1,ihandle FLcount "label", 1, 444, 1, 1, 1, 200, 40, 550, 550,-1, 1, 0, 1


gk255,gidist3 FLcount "MODE",0, 2, 1,  2,   1, 114,15,715, 450,0, 1, 0, 0
FLsetColor 130,137,156,gidist3
FLsetFont 10,gidist3
FLsetTextColor 0,0,0,gidist3




;STEP-FLANGER

ihchorus 	FLbox  	" ", 	6,        9,    15,    200,    150,     20, 520	;border
;ihchorus 	FLbox  	"CHORUS", 	   1,     9,    15,    20,     15,       50, 474	;border

istepfl 	FLbox  	"STEPFLANGER", 	   1,     9,    14,    20,     15,       68, 644	;border
FLsetFont 2,istepfl 
;FLsetTextColor 255,255,255,istepfl  


istepfl2 FLvalue "Level",40,   20,    35, 580
FLsetFont 1,istepfl2
;FLsetTextColor 255,255,255,istepfl2
FLsetColor 193,215,88,istepfl2
gk143,gistepfl FLknob "", 0.1,1, -1, 1, istepfl2 ,  $Knobsize, 28, 524,50
FLsetColor2 $KnobColor gistepfl

istepfl3 FLvalue "Depth",40,   20,    95, 580
FLsetFont 1,istepfl3
;FLsetTextColor 255,255,255,istepfl3
FLsetColor 193,215,88,istepfl3 
gk144,gistepfl2 FLknob "", 0.1,20, -1, 1,istepfl3 ,  $Knobsize, 85, 524,50
FLsetColor2 $KnobColor gistepfl2

istepfl4 FLvalue "Rate",40,   20,    145, 580
FLsetFont 1,istepfl4
;FLsetTextColor 255,255,255,istepfl4 
FLsetColor 193,215,88,istepfl4
gk145,gistepfl3 FLknob "", 0.1,30, -1, 1, istepfl4 ,  $Knobsize, 140, 524,50
FLsetColor2 $KnobColor gistepfl3



;BBCUT


;spatialization
ihchorus 	FLbox  	" ", 	6,        9,    15,    250,    150,     220, 520	;border
ihchorus 	FLbox  	"SPACE", 	   1,     9,    15,    20,     15,       240, 644	;border
;
FLsetFont 2,ihchorus 


;koutx, kouty, ihandlex, ihandley FLjoy "label", iminx, imaxx, iminy, imaxy, iexpx, iexpy, idispx, idispy, iwidth, iheight, ix,  iy
gk221,gk222,gihrndspace1,gihrndspace2 FLjoy "", .1,  3,   .1, 4,    -1,     0,    -1,     -1,     160,    136,     290, 524
;FLsetColor 255,255,255,gihjoy1
;FLsetColor2 255,0,255,gihjoy1
FLsetFont 1,gihrndspace2
;FLsetTextColor 0,20,220,gihjoy1
;FLsetFont 1,gihjoy2
;FLsetTextColor 0,20,220,gihjoy2
FLsetColor $KnobColor gihrndspace1

;seven EFFECTS
ihchorus 	FLbox  	" ", 	6,        9,    15,    192,    150,     471, 520	;border
;ihchorus 	FLbox  	"CHORUS", 	   1,     9,    15,    20,     15,       50, 474	;border


;EIGHT EFFECTS
ihchorus 	FLbox  	" ", 	6,        9,    15,    206,    150,     663, 520	;border
;ihchorus 	FLbox  	"CHORUS", 	   1,     9,    15,    20,     15,       50, 474	;border

gkrndspace,ihrndspace   FLbutton "AUTO", 1,0, 2, 55, 20, 225,605, 0,  0,    0,     1,      0,      3600



gkrndspace2,ihrndspace2 FLknob "RATE", 0.1,9, -1, 3, -1 ,  40, 235, 530,50
;FLsetColor 51,50,58,ihfiltvect2
FLsetColor2 $KnobColor ihrndspace2


FLgroup_end 
;******************************************************************************************************************************************

;************************************************************************************************
;MIXER

;FLcolor   255,255,255  
FLgroup "MIXER",880,650, 10,40,1

ihmixer 	FLbox  	" ", 	                 6,     9,    15,    710,    520,     40, 60	;border




itap1  FLvalue "Level",50,30,680,70 
FLsetColor 193,215,88,itap1
FLsetFont 4,itap1
gk28,imulti1 FLslider "OSC1",.01, 1, 0,  1,   itap1,   620,    30,    60, 70
FLsetColor 0,255,255,imulti1
FLsetColor2 $KnobColor imulti1
FLsetFont 4,imulti1


itap2  FLvalue "Level",50,30,680,170 
FLsetColor 193,215,88,itap2
FLsetFont 4,itap2
gk29,imulti2 FLslider "OSC2",.01, 1, 0,  1,   itap2,   620,    30,    60, 170
FLsetColor 0,255,255,imulti2
FLsetColor2 $KnobColor imulti2
FLsetFont 4,imulti2

itap3  FLvalue "Level",50,30,680,270 
FLsetColor 193,215,88,itap3
FLsetFont 4,itap3
gk30,imulti3 FLslider "OSC3",.01, 1, 0,  1,   itap3,   620,    30,    60, 270
FLsetColor 0,255,255,imulti3
FLsetColor2 $KnobColor imulti3
FLsetFont 4,imulti3

itap4  FLvalue "Level",50,30,680,370
FLsetColor 193,215,88,itap4
FLsetFont 4,itap4
gk31,imulti4 FLslider "OSC4",.01, 1, 0,  1,   itap4,   620,    30,    60, 370
FLsetColor 0,255,255,imulti4 
FLsetColor2 $KnobColor imulti4
FLsetFont 4,imulti4

itap5  FLvalue "Level",50,30,680,470
FLsetColor 193,215,88,itap5
FLsetFont 4,itap5
gkrevsc,irevsc FLslider "GLOBAL REVERB",.01, .97, 0,  1,   itap5,   620,    30,    60, 470
FLsetColor 0,255,255,irevsc
FLsetColor2 $KnobColor irevsc
FLsetFont 4,irevsc




FLgroup_end 


;**********************************************************************************************************


;************************************************************************************************




;about
;FLcolor   255,255,255  
FLgroup "ABOUT",880,650, 10,40,1 
;some widgets should contained here
giabout1	FLbox	"VECTROSYNTH Version 0.91\A vectorial synthesizer for csound5 by Giorgio Zucco", 1, 5, 18, 280, 120, 65, 111

 
FLgroup_end 

FLtabs_end 
 
;gkexit,ihandle FLbutton "Exit",90,150, 1,55,35,800,5,0,99,0,3
 
FLpanelEnd
;Run the widget thread!
 


;************************************************************************************************
FLpanel "Snapshot",560,275,450,110;start of container

FLcolor -2
gkget, ih		FLbutBank	11,     9,     9,    320,    270,   230,  0,    0,    7,   0,   0 
FLcolor -1

FLcolor -2
gkloadbank,ih		FLbutton	"Load Bank", 	0,    0,    11, 150,  40,   40, 0,   0,  8, 0,   0
FLsetFont 2,ih
FLcolor -1

FLcolor -2
FLsetTextColor 0,0,255,ih
gksavebank,ih		FLbutton	"Save Bank", 	0,    0,    11, 150,  40,   40, 40,  0,  9, 0,   0
FLsetFont 2,ih
FLsetTextColor 0,0,255,ih
FLcolor -1

FLcolor -2
gksavesnap,ih		FLbutton	"Save Snapshot",  0,    0,    11, 150,  40,   40, 80,  0,  10, 0,   0
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


;************************************************************************************************
;INIT SETTINGS  GUI
;osc 
FLsetVal_i 1, itune1
FLsetVal_i 1, itune2
FLsetVal_i 1, itune3
FLsetVal_i 1, itune4
FLsetVal_i $InitPreset, gihv5osc
FLsetVal_i 0, gihv6osc
FLsetVal_i 0, gihv7osc
FLsetVal_i 0, gihv8osc
;lfo oscillator
FLsetVal_i 1, ilfo1
FLsetVal_i 1, ilfo2
FLsetVal_i 1, ilfo3
FLsetVal_i 1, ilfo4
;LFO waveform
FLsetVal_i 1, ihv9
FLsetVal_i 1, ihv10
FLsetVal_i 1, ihv11
FLsetVal_i 1, ihv12
;LEVELS LFO OSCILLATORS
FLsetVal_i 0.01, ihv13vol
FLsetVal_i 0.01, ihv14vol
FLsetVal_i 0.01, ihv15vol
FLsetVal_i 0.01, ihv16vol
;MORPHING
FLsetVal_i 1,ihvvect
;*********************************************
;FILTERS
;LFO MOOG FILTERS
FLsetVal_i  1, ilfocut
FLsetVal_i  1, ihv28 ;lfo waveform
FLsetVal_i 0.1, ihv30
;bypass filt1
FLsetVal_i  5, ihbutfil1
;bypass filt2
FLsetVal_i  4, ihbutfil2
;filters2
;STATEVAR
FLsetVal_i  1000,gistvar1
FLsetVal_i 0.4, gistvar2
;SVFILTER
FLsetVal_i  1000, gistsvf1
FLsetVal_i 10, gistsvf2
;adsr filters
FLsetVal_i  0.1, iadsrfl1
FLsetVal_i  1, iadsrfl2
FLsetVal_i  1, iadsrfl3
FLsetVal_i  1, iadsrfl4
FLsetVal_i  0.1, iadsrflb1
FLsetVal_i  1, iadsrflb2
FLsetVal_i  1, iadsrflb3
FLsetVal_i  1, iadsrflb4
;**************************
;mixer
FLsetVal_i             .7, imulti1
FLsetVal_i             .7, imulti2
FLsetVal_i             .7, imulti3
FLsetVal_i            . 7, imulti4
;FLsetVal_i             2, imaster
;effects
;EFFECTS
FLsetVal_i  5, ihbutfx1
FLsetVal_i  8, ihbutfx2
;FLANGER
FLsetVal_i             1  , giflang
FLsetVal_i             2, giflang2
FLsetVal_i             1 , giflang3
;RING MOD

FLsetVal_i             400 , girgmd
FLsetVal_i             1 , girgmd2

FLsetVal_i             1 , girgmd3

FLsetVal_i             1 , girgmd4

;PHASER
FLsetVal_i             1 , giph2
FLsetVal_i             1 , giph3

FLsetVal_i             800 , giph4

FLsetVal_i             .40 , giph5
FLsetVal_i             1 , ihorder


;chorus
FLsetVal_i             1 , gicho

FLsetVal_i             2 , gicho2

FLsetVal_i             1 , gicho3


;DELAY

FLsetVal_i             2 , gidely
FLsetVal_i             .5 , gidely2

FLsetVal_i             1 , gihandel

FLsetVal_i             7000 , gidely3

;vco pulse
FLsetVal_i             .4 , gipulsew

;rndspace init
FLsetVal_i             1 , ihrndspace
FLsetVal_i             1 , ihrndspace2

;equalizer
FLsetVal_i             100 ,gidist1
FLsetVal_i             2 ,gidist2
FLsetVal_i             .1 ,gidist8

;adsr
FLsetVal_i             $Attack,giadsr1a
FLsetVal_i             $Decay ,giadsr1b
FLsetVal_i             $Sustain ,giadsr1c
FLsetVal_i             $Release ,giadsr1d

FLsetVal_i             $Attack,giadsr1a2
FLsetVal_i             $Decay ,giadsr1b2
FLsetVal_i             $Sustain ,giadsr1c2
FLsetVal_i             $Release ,giadsr1d2

FLsetVal_i             $Attack,giadsr1a3
FLsetVal_i             $Decay ,giadsr1b3
FLsetVal_i             $Sustain ,giadsr1c3
FLsetVal_i             $Release ,giadsr1d3

FLsetVal_i             $Attack,giadsr1a4
FLsetVal_i             $Decay ,giadsr1b4
FLsetVal_i             $Sustain ,giadsr1c4
FLsetVal_i             $Release ,giadsr1d4

;vectorial rate init
FLsetVal_i             0.009 ,ihvect2

;filter1 init
FLsetVal_i             8000 ,gicutfilt1 
FLsetVal_i             0.5 ,gireso

;statevar

FLsetVal_i             1 ,gihpstv
FLsetVal_i             1 ,gilpstv
FLsetVal_i             1 ,gibpstv
FLsetVal_i             1 ,gibrstv 

;svfilter

FLsetVal_i             .5 ,gilpsvf
FLsetVal_i             .5 ,gihpsvf
FLsetVal_i             .5 ,gibpsvf 

;moogvcf2
FLsetVal_i             10000,gimgv2
FLsetVal_i             .5, gimgv3
;fofilter
FLsetVal_i     2000,gifofilter4
FLsetVal_i      .03,gifofilter5
FLsetVal_i      .02,gifofilter6
;delay simple
FLsetVal_i  1,gidelk
FLsetVal_i  .4,gidelk2
FLsetVal_i  .5,gidelk3
;talkbox
FLsetVal_i 1,gitkb
FLsetVal_i 1.5,gitkb2
;vcomb
FLsetVal_i 7,gicomb
FLsetVal_i .2,gicomb2
FLsetVal_i .05,gicomb3
;stepfl
FLsetVal_i 1,gistepfl
FLsetVal_i 10,gistepfl2
FLsetVal_i 10,gistepfl3
;global reverb
FLsetVal_i $Globrevinit,irevsc

;tuning
FLsetVal_i $TUNING,gituning
;level rec
FLsetVal_i $LEVELRECORDING,gilevrec

FLsetVal_i $LOOPDUR,gilooplay

FLsetVal_i 1,giloopitch
FLsetVal_i 1,gilooplay

;udo-opcodes
;********************************************************
#include "vectro-opcodes.h"
;********************************************************

instr 1



ipchstk cpstmid	 i(gktuning) 
ipch    cpstmid	 i(gktuning)  
iamp ampmidi 2000
iampstk  ampmidi 8000
iampstk2 ampmidi 30000
iampscan ampmidi 4000
;kenv linsegr  0,.08,1,.3,.5,.1,0
kenv linsegr 1,.1,1,.3,.5,.2,0


kbend   pchbend -2,2  ;pitch bend
;idur	= p3

klfox1 oscil  gk17,(gk9),i(gk13), -1 ;lfo con vari waveform
klfox2 oscil  gk18,(gk10),i(gk14),-1 ;lfo con vari waveform
klfox3 oscil  gk19,(gk11),i(gk15),-1 ;lfo con vari waveform
klfox4 oscil  gk20,(gk12),i(gk16),-1 ;lfo con vari waveform

klfo1 = klfox1 + 1
klfo2 = klfox2 + 1
klfo3 = klfox3 + 1
klfo4 = klfox4 + 1


;;kport  port ipch,i(gk91)

;ADSR osc1
;ADSR osc1
  ; Attack time.
 iattack = i(gk65)
  ; Decay time.
  idecay = i(gk66)
  ; Sustain level.
  isustain = i(gk67)
  ; Release time.
 irelease = i(gk68)

 kadsr mxadsr iattack, idecay, isustain, irelease





ipch = ipch*2
;CONTROLLER MIDI
;midi controller real time GUI

;cutoff
;imidi1 init  1


;ictrmidi1 =  gimidi1
;koct		ctrl7		1,         1,       250,    22000

;trig		changed		koct	
						
;		OPCODE      |   TRIGGER | VALUE | HANDLE
		;LsetVal	ktrig,     koct,  gicutfilt1
;Resonance
;koct2		ctrl7		1,            103,       .1,.99
;ktrig2		changed		koct2
;		OPCODE      |   TRIGGER | VALUE | HANDLE
		;FLsetVal	ktrig2,     koct2,gireso

;cutoff
;koct3		ctrl7		1,            104,       250,    22000
;ktrig3		changed		koct3	
						
;		OPCODE      |   TRIGGER | VALUE | HANDLE
		;FLsetVal	ktrig3,     koct3,gifilt2  
;Resonance
;koct4		ctrl7		1,            105,       .1,.99
;ktrig4		changed		koct4
;		OPCODE      |   TRIGGER | VALUE | HANDLE
		;FLsetVal	ktrig4,     koct4,gifilt3
;*******************************************************************
;JITTER
kj jitter2 gk136, gk132, gk133, gk132, gk134,gk132, gk135
;***********************************************************************
;*******************************************************************************************************************
;GENERATORI
;OSC1
kpulsew = gkpulsew
iselosc = i(gk5)


if   (iselosc == 1)  goto apluck
if   (iselosc == 2)  goto adx7  ;change to Chant-udo
if   (iselosc == 3)  goto agranul
if   (iselosc == 4)  goto arumore
if   (iselosc == 5)  goto ascanned
if   (iselosc == 6)  goto vcosaw
if   (iselosc == 7)  goto vcosq
if   (iselosc == 8)  goto vcosawosc1
if   (iselosc == 9)  goto vcosqb
if   (iselosc == 10) goto vcotrgl
if   (iselosc == 11) goto afmb3
if   (iselosc == 12) goto additosc1
if   (iselosc == 13) goto addit2osc1
if   (iselosc == 14) goto addit3osc1
if   (iselosc == 15) goto addit4osc1
if   (iselosc == 16) goto agbuzz1
if   (iselosc == 17) goto abell
if   (iselosc == 18) goto achord
if   (iselosc == 19) goto aspline1
if   (iselosc == 20) goto acid
;STK
if   (iselosc == 21) goto aSTKBandedWG  ;aumentare iamp
if   (iselosc == 22) goto aSTKBeeThree
if   (iselosc == 23) goto aSTKBlowBotl   ;!?!?! :-(
if   (iselosc == 24) goto aSTKBlowHole
if   (iselosc == 25) goto aSTKBowed
;if   (iselosc == 18) goto aSTKBrass  ;inutile e nausenante come wgbrass :-(
if   (iselosc == 26) goto aSTKClarinet
if   (iselosc == 27) goto aSTKDrummer
if   (iselosc == 28) goto aSTKFlute
if   (iselosc == 29) goto aSTKFMVoices
if   (iselosc == 30) goto aSTKHevyMetl
if   (iselosc == 31) goto aSTKMandolin
if   (iselosc == 32) goto aSTKModalBar
if   (iselosc == 33) goto aSTKMoog
if   (iselosc == 34) goto aSTKPercFlut
if   (iselosc == 35) goto aSTKPlucked
if   (iselosc == 36) goto aSTKResonate
if   (iselosc == 37) goto aSTKRhodey
if   (iselosc == 38) goto aSTKSaxofony
;if   (iselosc == 32) goto aSTKShakers
;if   (iselosc == 33) goto aSTKSimple
if   (iselosc == 39) goto aSTKSitar
if   (iselosc == 40) goto aSTKStifKarp
if   (iselosc == 41) goto aSTKTubeBell
if   (iselosc == 42) goto aSTKVoicForm
if   (iselosc == 43) goto aSTKWhistle
if   (iselosc == 44) goto aSTKWurley
;end STK
;Chowning-preset
if   (iselosc == 45) goto aCHOWglass
if   (iselosc == 46) goto aCHOWPad
if   (iselosc == 47) goto aCHOWPerc
if   (iselosc == 48) goto aCHOWPiano
if   (iselosc == 49) goto aCHOWrebell
if   (iselosc == 50) goto aCHOWSoprano
if   (iselosc == 51) goto aCHOWString
if   (iselosc == 52) goto aCHOWVibr
if   (iselosc == 53) goto aCHOWClar
if   (iselosc == 54) goto aCHOWwown
if   (iselosc == 55) goto aCHOWLoop

;Risset-preset
if   (iselosc == 56) goto aRissBell
if   (iselosc == 57) goto aRissClar
if   (iselosc == 58) goto aRissDrum
if   (iselosc == 59) goto aRissDrum2
if   (iselosc == 60) goto aRissGliss
if   (iselosc == 61) goto aRissFlute
if   (iselosc == 62) goto aRissHarmon
if   (iselosc == 63) goto aRissNoise
if   (iselosc == 64) goto aRissOctave
if   (iselosc == 65) goto aRissRing
;end-Risset

;addit4osc1



;GBUZZ
agbuzz1:
asound1  gbuzz     (iampstk*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,(sr*.4)/ipch,2,.9,21
FLsetText "buzz",gihv5osc
goto  outosc1

;BELL
abell:
asound1  poscil    (iampscan*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,gibell
FLsetText "bell",gihv5osc
goto  outosc1

;CHORD
achord:
asound1  chord    (iampscan*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,27
FLsetText "chord",gihv5osc
goto  outosc1

aspline1:
asound1  poscil   (iampscan*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,53
FLsetText "Spline1",gihv5osc
goto  outosc1

addit2osc1:
asound1  poscil   (iampscan*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,28
FLsetText "Additive2",gihv5osc
goto  outosc1

addit3osc1:
asound1  poscil   (iampscan*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,56
FLsetText "Additive3",gihv5osc
goto  outosc1

addit4osc1:
asound1  poscil   (iampscan*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,58
FLsetText "Additive4",gihv5osc
goto  outosc1



acid:
asound1  poscil   (iampscan*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,51
FLsetText "Acid",gihv5osc
goto  outosc1




;PLUCK
apluck:
FLsetText "pluck",gihv5osc
asound1  pluck     (iamp*kadsr)*gk28,((((ipch*(gk1)) +klfo1)*powoftwo(kbend)))+kj ,400,0,1
goto  outosc1



;FM
adx7:
FLsetText "Chant",gihv5osc
asound1  Chant     (iamp*kadsr)*gk28,((((ipch*(gk1)) +klfo1)*powoftwo(kbend)))+kj ,1,1,1,0
goto  outosc1

;*************************************************************************************
;VCOSAW	
vcosaw:
FLsetText "VCO-Saw",gihv5osc
asound1  vco2    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,0,kpulsew
goto  outosc1


;VCOSQUARE
vcosq:
FLsetText "VCO-Square",gihv5osc
asound1  vco2    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,2,kpulsew
goto  outosc1

;vcosawosc1
vcosawosc1:
FLsetText "VCO-Saw2",gihv5osc
asound1  vco2    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,4,kpulsew
goto  outosc1


;vcosqb
vcosqb:
asound1  vco2    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,10,kpulsew
FLsetText "VCO-Square2",gihv5osc
goto  outosc1

;vcotriangle
vcotrgl:
asound1  vco2    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,12,kpulsew
FLsetText "VCO-Triangle",gihv5osc
goto  outosc1
;**************************************************************************************



;FMB3
afmb3:
;asound1  fmb3 (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj, 5, 5, 0.005,6,1, 1, 1, 1, 1
asound1 Organ ((iamp/20)*kadsr)*gk28,ipch/2,$Drawbar1,$Drawbar2,$Drawbar3,$Drawbar4,$Drawbar5,$Drawbar6,$Drawbar7,$Drawbar8,$Drawbar9
FLsetText "Organ",gihv5osc
goto  outosc1



;GRAIN
agranul:
asound1 grain     (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,$Graindens,(iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))*2+kj,.05,199,200,.5,0
FLsetText "Grain",gihv5osc
goto  outosc1


;NOISE
arumore:
asound1  oscil     (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,11,-1 ;noise
FLsetText "Noise",gihv5osc
goto  outosc1


;SCANS
ascanned:
ascan   scantable (iampscan*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,1000,2000,3000,4000,5000  ;scan
asound1 dcblock ascan
FLsetText "Scanned",gihv5osc
goto  outosc1

;ADDITIVE
additosc1:
asound1  additive1     (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,14
FLsetText "Additive",gihv5osc
goto  outosc1

;FMWURLIE
;afmwurlosc1:
;asound1  fmwurlie     (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,6,1,0.005,6,1,1,1,1,1
;goto  outosc1


;FMBELL
;afmbellosc1:
;asound1  fmbell     (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,1,2,0.2,6,1,gicook3,1,1,1
;goto  outosc1

;FMPERCFL
;afmpercflosc1:
;asound1  fmpercfl     (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,5,5,0.005,6,1,1,1, 1,1
;goto  outosc1

;STK ****************************************************************************************
aSTKBandedWG:
astk1  STKBandedWG  ipchstk,1
asound1 =   (astk1*kadsr*iampstk2)*gk28
FLsetText "BandedWG",gihv5osc
goto  outosc1

aSTKBeeThree:
astk1  STKBeeThree  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "BeeThree",gihv5osc
goto  outosc1

aSTKBlowBotl:
astk1  STKBlowBotl  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "BlowBotl",gihv5osc
goto  outosc1

aSTKBlowHole:
astk1  STKBlowHole  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "BlowHole",gihv5osc
goto  outosc1

aSTKBowed:
;astk1  STKBowed  ipchstk,1.0, 1, 4, 2, 0, 4, 0, 11, 50
astk1  STKBowed  ipchstk,2.0
asound1 =   (astk1*kadsr*iampstk*2)*gk28
FLsetText "Bowed",gihv5osc
goto  outosc1

aSTKBrass:
astk1  STKBrass  ipchstk,1
asound1 =   (astk1*kadsr*iampstk2)*gk28
FLsetText "Brass",gihv5osc
goto  outosc1

aSTKClarinet:
astk1  STKClarinet  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Clarinet",gihv5osc
goto  outosc1

aSTKDrummer:
astk1  STKDrummer  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Drummer",gihv5osc
goto  outosc1

aSTKFlute:
astk1  STKFlute  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Flute",gihv5osc
goto  outosc1

aSTKFMVoices:
astk1  STKFMVoices  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "FMVoices",gihv5osc
goto  outosc1

aSTKHevyMetl:
astk1  STKHevyMetl  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "HevyMetl",gihv5osc
goto  outosc1

aSTKMandolin:
astk1  STKMandolin  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Mandolin",gihv5osc
goto  outosc1

aSTKModalBar:
astk1  STKModalBar  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "ModalBar",gihv5osc
goto  outosc1

aSTKMoog:
astk1  STKMoog  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Moog",gihv5osc
goto  outosc1

aSTKPercFlut:
astk1  STKPercFlut  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "PercFlut",gihv5osc
goto  outosc1

aSTKPlucked:
astk1  STKPlucked  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Plucked",gihv5osc
goto  outosc1

aSTKResonate:
astk1  STKResonate  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Resonate",gihv5osc
goto  outosc1

aSTKRhodey:
astk1  STKRhodey  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Rhodey",gihv5osc
goto  outosc1

aSTKSaxofony:
astk1  STKSaxofony  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Saxofony",gihv5osc
goto  outosc1

aSTKSitar:
astk1  STKSitar  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Sitar",gihv5osc
goto  outosc1

aSTKStifKarp:
astk1  STKStifKarp  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "StifKarp",gihv5osc
goto  outosc1

aSTKTubeBell:
astk1  STKTubeBell  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "TubeBell",gihv5osc
goto  outosc1

aSTKVoicForm:
astk1  STKVoicForm  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "VoicForm",gihv5osc
goto  outosc1

aSTKWhistle:
astk1  STKWhistle  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Whistle",gihv5osc
goto  outosc1


aSTKWurley:
astk1  STKWurley  ipchstk,1
asound1 =   (astk1*kadsr*iampstk)*gk28
FLsetText "Wurley",gihv5osc
goto  outosc1

;end STK *********************************************************************************************************************
;chowning **************************************************************************************************
aCHOWglass:
asound1  CHOWglass    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWglass",gihv5osc
goto  outosc1

aCHOWPad:
asound1  CHOWPad    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,200,1
FLsetText "CHOWPad",gihv5osc
goto  outosc1

aCHOWPerc:
asound1  CHOWPerc    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWPerc",gihv5osc
goto  outosc1

aCHOWPiano:
asound1  CHOWPiano    (iamp)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWPiano",gihv5osc
goto  outosc1

aCHOWrebell:
asound1  CHOWrebell    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWrebell",gihv5osc
goto  outosc1

aCHOWSoprano:
asound1  CHOWSoprano    (iamp)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWSoprano",gihv5osc
goto  outosc1

aCHOWString:
asound1  CHOWTrumpet    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWTrumpet",gihv5osc
goto  outosc1

aCHOWVibr:
asound1  CHOWVibr    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWVibr",gihv5osc
goto  outosc1

aCHOWClar:
asound1  CHOWClar    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj 
FLsetText "CHOWClar",gihv5osc
goto  outosc1

aCHOWwown:
asound1  CHOWwown    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,1 
FLsetText "CHOWwown",gihv5osc
goto  outosc1

aCHOWLoop:
asound1  CHOWLoop    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,1 
FLsetText "CHOWLoop",gihv5osc
goto  outosc1
;****************************************************************************
;RISSET
aRissBell:
asound1  RissBell    iamp,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,1
FLsetText "RissBell",gihv5osc
goto  outosc1

aRissClar:
asound1  RissClar    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj
FLsetText "RissClar",gihv5osc
goto  outosc1

aRissDrum:
asound1  RissDrum    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj
FLsetText "RissDrum",gihv5osc
goto  outosc1

aRissDrum2:
asound1  RissDrum2    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj
FLsetText "RissDrum2",gihv5osc
goto  outosc1

aRissGliss:
asound1  RissGliss    iamp,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,1
FLsetText "RissGliss",gihv5osc
goto  outosc1

aRissFlute:
asound1  RissFlute    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj
FLsetText "RissFlute",gihv5osc
goto  outosc1

aRissHarmon:
asound1  RissHarmon    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj
FLsetText "RissHarmon",gihv5osc
goto  outosc1

aRissNoise:
asound1  RissNoise    iamp,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj
FLsetText "RissNoise",gihv5osc
goto  outosc1

aRissOctave:
asound1  RissOctave    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj,.1,1
FLsetText "RissOctave",gihv5osc
goto  outosc1

aRissRing:
asound1  RissRing    (iamp*kadsr)*gk28,((((ipch*gk1) +klfo1)*powoftwo(kbend)))+kj
FLsetText "RissRing",gihv5osc
goto  outosc1

;****************************************************************************
outosc1:

aosc1 = asound1

;*************************************************************************************************************
;OSC2
;ADSR osc2
 
kadsr2 mxadsr i(gk69), i(gk70), i(gk71), i(gk72)


iselosc2 = i(gk6)

if   (iselosc2 == 0) goto aoscbpy1 ;bypass
if   (iselosc2 == 1) goto apluckb
if   (iselosc2 == 2) goto adx7b
if   (iselosc2 == 3) goto agranulb
if   (iselosc2 == 4) goto arumoreb
if   (iselosc2 == 5) goto ascannedb


if   (iselosc2 == 6)  goto vcosawb
if   (iselosc2 == 7)  goto vcosqb2
if   (iselosc2 == 8)  goto vcosawosc2
if   (iselosc2 == 9)  goto vcosqbb
if   (iselosc2 == 10) goto vcotrglb

if   (iselosc2 == 11) goto afmb3b
if   (iselosc2 == 12) goto additosc2

if   (iselosc2 == 13) goto addit2osc2
if   (iselosc2 == 14) goto addit3osc2
if   (iselosc2 == 15) goto addit4osc2
if   (iselosc2 == 16) goto agbuzz1osc2
if   (iselosc2 == 17) goto abellosc2
if   (iselosc2 == 18) goto achordosc2
if   (iselosc2 == 19) goto aspline1osc2
if   (iselosc2 == 20) goto acidosc2
;STK
if   (iselosc2 == 21) goto aSTKBandedWG2  
if   (iselosc2 == 22) goto aSTKBeeThree2
if   (iselosc2 == 23) goto aSTKBlowBotl2   
if   (iselosc2 == 24) goto aSTKBlowHole2
if   (iselosc2 == 25) goto aSTKBowed2
if   (iselosc2 == 26) goto aSTKClarinet2
if   (iselosc2 == 27) goto aSTKDrummer2
if   (iselosc2 == 28) goto aSTKFlute2
if   (iselosc2 == 29) goto aSTKFMVoices2
if   (iselosc2 == 30) goto aSTKHevyMetl2
if   (iselosc2 == 31) goto aSTKMandolin2
if   (iselosc2 == 32) goto aSTKModalBar2
if   (iselosc2 == 33) goto aSTKMoog2
if   (iselosc2 == 34) goto aSTKPercFlut2
if   (iselosc2 == 35) goto aSTKPlucked2
if   (iselosc2 == 36) goto aSTKResonate2
if   (iselosc2 == 37) goto aSTKRhodey2
if   (iselosc2 == 38) goto aSTKSaxofony2
if   (iselosc2 == 39) goto aSTKSitar2
if   (iselosc2 == 40) goto aSTKStifKarp2
if   (iselosc2 == 41) goto aSTKTubeBell2
if   (iselosc2 == 42) goto aSTKVoicForm2
if   (iselosc2 == 43) goto aSTKWhistle2
if   (iselosc2 == 44) goto aSTKWurley2
;end STK
;chowning
if   (iselosc2 == 45) goto aCHOWglass2
if   (iselosc2 == 46) goto aCHOWPad2
if   (iselosc2 == 47) goto aCHOWPerc2
if   (iselosc2 == 48) goto aCHOWPiano2
if   (iselosc2 == 49) goto aCHOWrebell2
if   (iselosc2 == 50) goto aCHOWSoprano2
if   (iselosc2 == 51) goto aCHOWString2
if   (iselosc2 == 52) goto aCHOWVibr2
if   (iselosc2 == 53) goto aCHOWClar2
if   (iselosc2 == 54) goto aCHOWwown2
if   (iselosc2 == 55) goto aCHOWLoop2
;**********end-chowning**************************
;Risset-preset
if   (iselosc2 == 56) goto aRissBell2
if   (iselosc2 == 57) goto aRissClar2
if   (iselosc2 == 58) goto aRissDrum2x
if   (iselosc2 == 59) goto aRissDrum22
if   (iselosc2 == 60) goto aRissGliss2
if   (iselosc2 == 61) goto aRissFlute2
if   (iselosc2 == 62) goto aRissHarmon2
if   (iselosc2 == 63) goto aRissNoise2
if   (iselosc2 == 64) goto aRissOctave2
if   (iselosc2 == 65) goto aRissRing2
;end-Risset

apluckb:
asound2  pluck     (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,400,0,1
FLsetText "pluck",gihv6osc
goto  outosc2

;FM
adx7b:
asound2  Chant     (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,1,1,1,0
FLsetText "Chant",gihv6osc
goto  outosc2

;GBUZZ
agbuzz1osc2:
asound2  gbuzz     (iampstk*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,(sr*.4)/ipch,2,.9,21
FLsetText "buzz",gihv6osc
goto  outosc2

;BELL
abellosc2:
asound2  poscil    (iampscan*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,gibell
FLsetText "bell",gihv6osc
goto  outosc2

;CHORD
achordosc2:
asound2  chord    (iampscan*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,27
FLsetText "chord",gihv6osc
goto  outosc2

aspline1osc2:
asound2  poscil   (iampscan*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,53
FLsetText "Spline1",gihv6osc
goto  outosc2

addit2osc2:
asound2  poscil   (iampscan*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,28
FLsetText "Additive2",gihv6osc
goto  outosc2

addit3osc2:
asound2  poscil   (iampscan*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,56
FLsetText "Additive3",gihv6osc
goto  outosc2

addit4osc2:
asound2  poscil   (iampscan*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,58
FLsetText "Additive4",gihv6osc
goto  outosc2

acidosc2:
asound2  poscil   (iampscan*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,51
FLsetText "Acid",gihv6osc
goto  outosc2

;*************************************************************************************
;VCOSAW	
vcosawb:
asound2  vco2    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,0,kpulsew
FLsetText "VCO-Saw",gihv6osc
goto  outosc2

;VCOSQUARE
vcosqb2:
asound2  vco2    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,2,kpulsew
FLsetText "VCO-Square",gihv6osc
goto  outosc2

;vcosawosc2
vcosawosc2:
asound2  vco2    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,4,kpulsew
FLsetText "VCO-Saw2",gihv6osc
goto  outosc2

;vcosqb
vcosqbb:
asound2  vco2    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,10,kpulsew
FLsetText "VCO-Square2",gihv6osc
goto  outosc2

;vcotriangle
vcotrglb:
asound2  vco2    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,12,kpulsew
FLsetText "VCO-Triangle",gihv6osc
goto  outosc2
;**************************************************************************************
;FMB3
afmb3b:
asound2 Organ ((iamp/20)*kadsr2)*gk29,ipch/2,$Drawbar1,$Drawbar2,$Drawbar3,$Drawbar4,$Drawbar5,$Drawbar6,$Drawbar7,$Drawbar8,$Drawbar9
FLsetText "Organ",gihv6osc
goto  outosc2

agranulb:
asound2 grain     (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,$Graindens,(iamp*kadsr2)*gk29,((((ipch*gk1) +klfo1)*powoftwo(kbend)))*2+kj,.05,199,200,.5,0
FLsetText "Grain",gihv6osc
goto  outosc2

arumoreb:
asound2  oscil     (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,11,-1 ;noise
FLsetText "Noise",gihv6osc
goto  outosc2

ascannedb:
ascan   scantable (iampscan*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,1000,2000,3000,4000,5000  ;scan
asound2 dcblock ascan
FLsetText "Scanned",gihv6osc
goto  outosc2

;ADDITIVE
additosc2:
asound2  additive1     (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,14
FLsetText "Additive",gihv6osc
goto  outosc2

;STK ****************************************************************************************
aSTKBandedWG2:
astk2  STKBandedWG  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk2)*gk29
FLsetText "BandedWG",gihv6osc
goto  outosc2

aSTKBeeThree2:
astk2  STKBeeThree  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "BeeThree",gihv6osc
goto  outosc2

aSTKBlowBotl2:
astk2  STKBlowBotl  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "BlowBotl",gihv6osc
goto  outosc2

aSTKBlowHole2:
astk2  STKBlowHole  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "BlowHole",gihv6osc
goto  outosc2

aSTKBowed2:
;astk1  STKBowed  ipchstk,1.0, 1, 4, 2, 0, 4, 0, 11, 50
astk2  STKBowed  ipchstk,2.0
asound2 =   (astk2*kadsr2*iampstk*2)*gk29
FLsetText "Bowed",gihv6osc
goto  outosc2

aSTKBrass2:
astk2  STKBrass  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk2)*gk29
FLsetText "Brass",gihv6osc
goto  outosc2

aSTKClarinet2:
astk2  STKClarinet  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Clarinet",gihv6osc
goto  outosc2

aSTKDrummer2:
astk2  STKDrummer  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Drummer",gihv6osc
goto  outosc2

aSTKFlute2:
astk2  STKFlute  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Flute",gihv6osc
goto  outosc2

aSTKFMVoices2:
astk2  STKFMVoices  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "FMVoices",gihv6osc
goto  outosc2

aSTKHevyMetl2:
astk2  STKHevyMetl  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "HevyMetl",gihv6osc
goto  outosc2

aSTKMandolin2:
astk2  STKMandolin  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Mandolin",gihv6osc
goto  outosc2

aSTKModalBar2:
astk2  STKModalBar  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "ModalBar",gihv6osc
goto  outosc2

aSTKMoog2:
astk2  STKMoog  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Moog",gihv6osc
goto  outosc2

aSTKPercFlut2:
astk2  STKPercFlut  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "PercFlut",gihv6osc
goto  outosc2

aSTKPlucked2:
astk2  STKPlucked  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Plucked",gihv6osc
goto  outosc2

aSTKResonate2:
astk2  STKResonate  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Resonate",gihv6osc
goto  outosc2

aSTKRhodey2:
astk2  STKRhodey  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Rhodey",gihv6osc
goto  outosc2

aSTKSaxofony2:
astk2  STKSaxofony  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Saxofony",gihv6osc
goto  outosc2

aSTKSitar2:
astk2  STKSitar  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Sitar",gihv6osc
goto  outosc2

aSTKStifKarp2:
astk2  STKStifKarp  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "StifKarp",gihv6osc
goto  outosc2

aSTKTubeBell2:
astk2  STKTubeBell  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "TubeBell",gihv6osc
goto  outosc2

aSTKVoicForm2:
astk2  STKVoicForm  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "VoicForm",gihv6osc
goto  outosc2

aSTKWhistle2:
astk2  STKWhistle  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Whistle",gihv6osc
goto  outosc2


aSTKWurley2:
astk2  STKWurley  ipchstk,1
asound2 =   (astk2*kadsr2*iampstk)*gk29
FLsetText "Wurley",gihv6osc
goto  outosc2

;end STK *********************************************************************************************************************
;chowning **************************************************************************************************
aCHOWglass2:
asound2  CHOWglass    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWglass",gihv6osc
goto  outosc2

aCHOWPad2:
asound2  CHOWPad    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,200,1
FLsetText "CHOWPad",gihv6osc
goto  outosc2

aCHOWPerc2:
asound2  CHOWPerc    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWPerc",gihv6osc
goto  outosc2

aCHOWPiano2:
asound2  CHOWPiano    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWPiano",gihv6osc
goto  outosc2

aCHOWrebell2:
asound2  CHOWrebell   (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWrebell",gihv6osc
goto  outosc2

aCHOWSoprano2:
asound2  CHOWSoprano   (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWSoprano",gihv6osc
goto  outosc2

aCHOWString2:
asound2  CHOWTrumpet   (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWTrumpet",gihv6osc
goto  outosc2

aCHOWVibr2:
asound2  CHOWVibr   (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWVibr",gihv6osc
goto  outosc2

aCHOWClar2:
asound2  CHOWClar   (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj 
FLsetText "CHOWClar",gihv6osc
goto  outosc2

aCHOWwown2:
asound2  CHOWwown   (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,1
FLsetText "CHOWwown",gihv6osc
goto  outosc2

aCHOWLoop2:
asound2  CHOWLoop   (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,1
FLsetText "CHOWLoop",gihv6osc
goto  outosc2
;************end-chowning*****************************************************************************************
;****************************************************************************
;RISSET
aRissBell2:
asound2  RissBell    iamp,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,1
FLsetText "RissBell",gihv6osc
goto  outosc2

aRissClar2:
asound2  RissClar    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj
FLsetText "RissClar",gihv6osc
goto  outosc2

aRissDrum2x:
asound2  RissDrum    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj
FLsetText "RissDrum",gihv6osc
goto  outosc2

aRissDrum22:
asound2  RissDrum2    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj
FLsetText "RissDrum2",gihv6osc
goto  outosc2

aRissGliss2:
asound2  RissGliss    iamp,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,1
FLsetText "RissGliss",gihv6osc
goto  outosc2

aRissFlute2:
asound2  RissFlute    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj
FLsetText "RissFlute",gihv6osc
goto  outosc2

aRissHarmon2:
asound2  RissHarmon    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj
FLsetText "RissHarmon",gihv6osc
goto  outosc2

aRissNoise2:
asound2  RissNoise    iamp,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj
FLsetText "RissNoise",gihv6osc
goto  outosc2

aRissOctave2:
asound2  RissOctave    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj,.1,1
FLsetText "RissOctave",gihv6osc
goto  outosc2

aRissRing2:
asound2  RissRing    (iamp*kadsr2)*gk29,((((ipch*gk2) +klfo2)*powoftwo(kbend)))+kj
FLsetText "RissRing",gihv6osc
goto  outosc2

;****************************************************************************


aoscbpy1:
asound2 = asound1       ;bypass
FLsetText "BYPASS",gihv6osc
goto  outosc2

outosc2:

aosc2 = asound2


;******************************************************************************************************************
;OSC3
;ADSR osc3
  
kadsr3 mxadsr i(gk73), i(gk74), i(gk75), i(gk76)

iselosc3 = i(gk7)

if   (iselosc3 == 0) goto aoscbpyc  ;bypass
if   (iselosc3 == 1) goto apluckc
if   (iselosc3 == 2) goto adx7c
if   (iselosc3 == 3) goto agranulc
if   (iselosc3 == 4) goto arumorec
if   (iselosc3 == 5) goto ascannedc
if   (iselosc3 ==  6)  goto vcosawc
if   (iselosc3 ==  7)  goto vcosqbc
if   (iselosc3 ==  8)  goto vcosawosc3
if   (iselosc3 ==   9) goto vcosqbcosc3
if   (iselosc3 ==  10) goto vcotrglc
if   (iselosc3 ==  11) goto afmb3c
if   (iselosc3 ==  12) goto additosc3

if   (iselosc3 == 13) goto addit2osc3
if   (iselosc3 == 14) goto addit3osc3
if   (iselosc3 == 15) goto addit4osc3
if   (iselosc3 == 16) goto agbuzz1osc3
if   (iselosc3 == 17) goto abellosc3
if   (iselosc3 == 18) goto achordosc3
if   (iselosc3 == 19) goto aspline1osc3
if   (iselosc3 == 20) goto acidosc3
;STK
if   (iselosc3 == 21) goto aSTKBandedWG3  
if   (iselosc3 == 22) goto aSTKBeeThree3
if   (iselosc3 == 23) goto aSTKBlowBotl3   
if   (iselosc3 == 24) goto aSTKBlowHole3
if   (iselosc3 == 25) goto aSTKBowed3
if   (iselosc3 == 26) goto aSTKClarinet3
if   (iselosc3 == 27) goto aSTKDrummer3
if   (iselosc3 == 28) goto aSTKFlute3
if   (iselosc3 == 29) goto aSTKFMVoices3
if   (iselosc3 == 30) goto aSTKHevyMetl3
if   (iselosc3 == 31) goto aSTKMandolin3
if   (iselosc3 == 32) goto aSTKModalBar3
if   (iselosc3 == 33) goto aSTKMoog3
if   (iselosc3 == 34) goto aSTKPercFlut3
if   (iselosc3 == 35) goto aSTKPlucked3
if   (iselosc3 == 36) goto aSTKResonate3
if   (iselosc3 == 37) goto aSTKRhodey3
if   (iselosc3 == 38) goto aSTKSaxofony3
if   (iselosc3 == 39) goto aSTKSitar3
if   (iselosc3 == 40) goto aSTKStifKarp3
if   (iselosc3 == 41) goto aSTKTubeBell3
if   (iselosc3 == 42) goto aSTKVoicForm3
if   (iselosc3 == 43) goto aSTKWhistle3
if   (iselosc3 == 44) goto aSTKWurley3
;end STK
;chowning
if   (iselosc3 == 45) goto aCHOWglass3
if   (iselosc3 == 46) goto aCHOWPad3
if   (iselosc3 == 47) goto aCHOWPerc3
if   (iselosc3 == 48) goto aCHOWPiano3
if   (iselosc3 == 49) goto aCHOWrebell3
if   (iselosc3 == 50) goto aCHOWSoprano3
if   (iselosc3 == 51) goto aCHOWString3
if   (iselosc3 == 52) goto aCHOWVibr3
if   (iselosc3 == 53) goto aCHOWClar3
if   (iselosc3 == 54) goto aCHOWwown3
if   (iselosc3 == 55) goto aCHOWLoop3
;end chowning
;Risset-preset
if   (iselosc3 == 56) goto aRissBell3
if   (iselosc3 == 57) goto aRissClar3
if   (iselosc3 == 58) goto aRissDrum3x
if   (iselosc3 == 59) goto aRissDrum33
if   (iselosc3 == 60) goto aRissGliss3
if   (iselosc3 == 61) goto aRissFlute3
if   (iselosc3 == 62) goto aRissHarmon3
if   (iselosc3 == 63) goto aRissNoise3
if   (iselosc3 == 64) goto aRissOctave3
if   (iselosc3 == 65) goto aRissRing3
;end-Risset


apluckc:
asound3  pluck     (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,400,0,1
FLsetText "pluck",gihv7osc
goto  outosc3

;FM
adx7c:
asound3  Chant     (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,1,1,1,0
FLsetText "Chant",gihv7osc
goto  outosc3

;GBUZZ
agbuzz1osc3:
asound3  gbuzz     (iampstk*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,(sr*.4)/ipch,2,.9,21
FLsetText "buzz",gihv7osc
goto  outosc3

;BELL
abellosc3:
asound3  poscil    (iampscan*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,gibell
FLsetText "bell",gihv7osc
goto  outosc3

;CHORD
achordosc3:
asound3  chord    (iampscan*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,27
FLsetText "chord",gihv7osc
goto  outosc3

aspline1osc3:
asound3  poscil   (iampscan*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,53
FLsetText "Spline1",gihv7osc
goto  outosc3

addit2osc3:
asound3  poscil   (iampscan*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,28
FLsetText "Additive2",gihv7osc
goto  outosc3

addit3osc3:
asound3  poscil   (iampscan*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,56
FLsetText "Additive3",gihv7osc
goto  outosc3

addit4osc3:
asound3  poscil   (iampscan*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,58
FLsetText "Additive4",gihv7osc
goto  outosc3

acidosc3:
asound3  poscil   (iampscan*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,51
FLsetText "Acid",gihv7osc
goto  outosc3

;*************************************************************************************
;VCOSAW	
vcosawc:
asound3  vco2    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,0,kpulsew
FLsetText "VCO-Saw",gihv7osc
goto  outosc3

;VCOSQUARE
vcosqbc:
asound3  vco2    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,2,kpulsew
FLsetText "VCO-Square",gihv7osc
goto  outosc3

;vcosawosc3
vcosawosc3:
asound3  vco2    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,4,kpulsew
FLsetText "VCO-Saw2",gihv7osc
goto  outosc3

;vcosqb
vcosqbcosc3:
asound3  vco2    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,10,kpulsew
FLsetText "VCO-Square2",gihv7osc
goto  outosc3

;vcotriangle
vcotrglc:
asound3  vco2    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,12,kpulsew
FLsetText "VCO-Triangle",gihv7osc
goto  outosc3
;**************************************************************************************

;FMB3
afmb3c:
asound3 Organ ((iamp/20)*kadsr3)*gk30,ipch/2,$Drawbar1,$Drawbar2,$Drawbar3,$Drawbar4,$Drawbar5,$Drawbar6,$Drawbar7,$Drawbar8,$Drawbar9
FLsetText "Organ",gihv7osc
goto  outosc3

agranulc:
asound3 grain     (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,$Graindens,(iamp*kadsr3)*gk30,((((ipch*gk1) +klfo1)*powoftwo(kbend)))*2+kj,.05,199,200,.5,0
FLsetText "Grain",gihv7osc
goto  outosc3

arumorec:
asound3  oscil     (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,11,-1 ;noise
FLsetText "Noise",gihv7osc
goto  outosc3

ascannedc:
ascan   scantable (iampscan*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,1000,2000,3000,4000,5000  ;scan
asound3 dcblock ascan
FLsetText "Scanned",gihv7osc
goto  outosc3

;ADDITIVE
additosc3:
asound3  additive1     (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,14
FLsetText "Additive",gihv7osc
goto  outosc3

;STK ****************************************************************************************
aSTKBandedWG3:
astk3  STKBandedWG  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk2)*gk30
FLsetText "BandedWG",gihv7osc
goto  outosc3

aSTKBeeThree3:
astk3  STKBeeThree  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "BeeThree",gihv7osc
goto  outosc3

aSTKBlowBotl3:
astk3  STKBlowBotl  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "BlowBotl",gihv7osc
goto  outosc3

aSTKBlowHole3:
astk3  STKBlowHole  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "BlowHole",gihv7osc
goto  outosc3

aSTKBowed3:
;astk1  STKBowed  ipchstk,1.0, 1, 4, 2, 0, 4, 0, 11, 50
astk3  STKBowed  ipchstk,2.0
asound3 =   (astk3*kadsr3*iampstk*2)*gk30
FLsetText "Bowed",gihv7osc
goto  outosc3

aSTKBrass3:
astk3  STKBrass  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk2)*gk30
FLsetText "Brass",gihv7osc
goto  outosc3

aSTKClarinet3:
astk3  STKClarinet  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Clarinet",gihv7osc
goto  outosc3

aSTKDrummer3:
astk3  STKDrummer  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Drummer",gihv7osc
goto  outosc3

aSTKFlute3:
astk3  STKFlute  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Flute",gihv7osc
goto  outosc3

aSTKFMVoices3:
astk3  STKFMVoices  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "FMVoices",gihv7osc
goto  outosc3

aSTKHevyMetl3:
astk3  STKHevyMetl  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "HevyMetl",gihv7osc
goto  outosc3

aSTKMandolin3:
astk3  STKMandolin  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Mandolin",gihv7osc
goto  outosc3

aSTKModalBar3:
astk3  STKModalBar  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "ModalBar",gihv7osc
goto  outosc3

aSTKMoog3:
astk3  STKMoog  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Moog",gihv7osc
goto  outosc3

aSTKPercFlut3:
astk3  STKPercFlut  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "PercFlut",gihv7osc
goto  outosc3

aSTKPlucked3:
astk3  STKPlucked  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Plucked",gihv7osc
goto  outosc3

aSTKResonate3:
astk3  STKResonate  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Resonate",gihv7osc
goto  outosc3

aSTKRhodey3:
astk3  STKRhodey  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Rhodey",gihv7osc
goto  outosc3

aSTKSaxofony3:
astk3  STKSaxofony  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Saxofony",gihv7osc
goto  outosc3

aSTKSitar3:
astk3  STKSitar  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Sitar",gihv7osc
goto  outosc3

aSTKStifKarp3:
astk3  STKStifKarp  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "StifKarp",gihv7osc
goto  outosc3

aSTKTubeBell3:
astk3  STKTubeBell  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "TubeBell",gihv7osc
goto  outosc3

aSTKVoicForm3:
astk3  STKVoicForm  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "VoicForm",gihv7osc
goto  outosc3

aSTKWhistle3:
astk3  STKWhistle  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Whistle",gihv7osc
goto  outosc3


aSTKWurley3:
astk3  STKWurley  ipchstk,1
asound3 =   (astk3*kadsr3*iampstk)*gk30
FLsetText "Wurley",gihv7osc
goto  outosc3

;end STK *********************************************************************************************************************
;chowning **************************************************************************************************
aCHOWglass3:
asound3  CHOWglass    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWglass",gihv7osc
goto  outosc3

aCHOWPad3:
asound3  CHOWPad    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,200,1
FLsetText "CHOWPad",gihv7osc
goto  outosc3

aCHOWPerc3:
asound3  CHOWPerc    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWPerc",gihv7osc
goto  outosc3

aCHOWPiano3:
asound3  CHOWPiano    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWPiano",gihv7osc
goto  outosc3

aCHOWrebell3:
asound3  CHOWrebell    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWrebell",gihv7osc
goto  outosc3

aCHOWSoprano3:
asound3  CHOWSoprano    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWSoprano",gihv7osc
goto  outosc3

aCHOWString3:
asound3  CHOWTrumpet    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWTrumpet",gihv7osc
goto  outosc3

aCHOWVibr3:
asound3  CHOWVibr    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWVibr",gihv7osc
goto  outosc3

aCHOWClar3:
asound3  CHOWClar    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj 
FLsetText "CHOWClar",gihv7osc
goto  outosc3

aCHOWwown3:
asound3  CHOWwown    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWwown",gihv7osc
goto  outosc3

aCHOWLoop3:
asound3  CHOWLoop    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWLoop",gihv7osc
goto  outosc3
;*******************end-chowning******************************************************************************
;****************************************************************************
;RISSET
aRissBell3:
asound3  RissBell    iamp,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "RissBell",gihv7osc
goto  outosc3

aRissClar3:
asound2  RissClar    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj 
FLsetText "RissClar",gihv7osc
goto  outosc3

aRissDrum3x:
asound3  RissDrum    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj 
FLsetText "RissDrum",gihv7osc
goto  outosc3

aRissDrum33:
asound3  RissDrum2    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj 
FLsetText "RissDrum2",gihv7osc
goto  outosc3

aRissGliss3:
asound3  RissGliss     iamp,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj ,1
FLsetText "RissGliss",gihv7osc
goto  outosc3

aRissFlute3:
asound3  RissFlute    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj 
FLsetText "RissFlute",gihv7osc
goto  outosc3

aRissHarmon3:
asound3  RissHarmon    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj 
FLsetText "RissHarmon",gihv7osc
goto  outosc3

aRissNoise3:
asound3  RissNoise    iamp,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj 
FLsetText "RissNoise",gihv7osc
goto  outosc3

aRissOctave3:
asound3  RissOctave    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj,.1,1
FLsetText "RissOctave",gihv7osc
goto  outosc3

aRissRing3:
asound3  RissRing    (iamp*kadsr3)*gk30,((((ipch*gk3) +klfo3)*powoftwo(kbend)))+kj 
FLsetText "RissRing",gihv7osc
goto  outosc3

;****************************************************************************


aoscbpyc:
asound3 = asound2
FLsetText "BYPASS",gihv7osc
goto  outosc3


outosc3:

aosc3 = asound3

;**************************************************************************************************************
;OSC4

kadsr4 mxadsr i(gk173), i(gk174), i(gk175), i(gk176)

iselosc4 = i(gk8)

if   (iselosc4 == 0) goto aoscbpyd ;bypass
if   (iselosc4 == 1) goto apluckd
if   (iselosc4 == 2) goto adx7d
if   (iselosc4 == 3) goto agranuld
if   (iselosc4 == 4) goto arumored
if   (iselosc4 == 5) goto ascannedd
if   (iselosc4 == 6)  goto vcosaw4
if   (iselosc4 == 7)  goto vcosq4
if   (iselosc4 == 8)  goto vcosawosc4
if   (iselosc4 == 9)  goto vcosqb4
if   (iselosc4 == 10) goto vcotrgl4
if   (iselosc4 == 11) goto afmb34
if   (iselosc4 == 12) goto additosc4
if   (iselosc4 == 13) goto addit2osc4
if   (iselosc4 == 14) goto addit3osc4
if   (iselosc4 == 15) goto addit4osc4
if   (iselosc4 == 16) goto agbuzz1osc4
if   (iselosc4 == 17) goto abellosc4
if   (iselosc4 == 18) goto achordosc4
if   (iselosc4 == 19) goto aspline1osc4
if   (iselosc4 == 20) goto acidosc4
;STK
if   (iselosc4 == 21) goto aSTKBandedWG4  
if   (iselosc4 == 22) goto aSTKBeeThree4
if   (iselosc4 == 23) goto aSTKBlowBotl4   
if   (iselosc4 == 24) goto aSTKBlowHole4
if   (iselosc4 == 25) goto aSTKBowed4
if   (iselosc4 == 26) goto aSTKClarinet4
if   (iselosc4 == 27) goto aSTKDrummer4
if   (iselosc4 == 28) goto aSTKFlute4
if   (iselosc4 == 29) goto aSTKFMVoices4
if   (iselosc4 == 30) goto aSTKHevyMetl4
if   (iselosc4 == 31) goto aSTKMandolin4
if   (iselosc4 == 32) goto aSTKModalBar4
if   (iselosc4 == 33) goto aSTKMoog4
if   (iselosc4 == 34) goto aSTKPercFlut4
if   (iselosc4 == 35) goto aSTKPlucked4
if   (iselosc4 == 36) goto aSTKResonate4
if   (iselosc4 == 37) goto aSTKRhodey4
if   (iselosc4 == 38) goto aSTKSaxofony4
if   (iselosc4 == 39) goto aSTKSitar4
if   (iselosc4 == 40) goto aSTKStifKarp4
if   (iselosc4 == 41) goto aSTKTubeBell4
if   (iselosc4 == 42) goto aSTKVoicForm4
if   (iselosc4 == 43) goto aSTKWhistle4
if   (iselosc4 == 44) goto aSTKWurley4
;end STK
;chowning
if   (iselosc4 == 45) goto aCHOWglass4
if   (iselosc4 == 46) goto aCHOWPad4
if   (iselosc4 == 47) goto aCHOWPerc4
if   (iselosc4 == 48) goto aCHOWPiano4
if   (iselosc4 == 49) goto aCHOWrebell4
if   (iselosc4 == 50) goto aCHOWSoprano4
if   (iselosc4 == 51) goto aCHOWString4
if   (iselosc4 == 52) goto aCHOWVibr4
if   (iselosc4 == 53) goto aCHOWClar4
if   (iselosc4 == 54) goto aCHOWwown4
if   (iselosc4 == 55) goto aCHOWLoop4
;******end-chowning********************************
;Risset-preset
if   (iselosc4 == 56) goto aRissBell4
if   (iselosc4 == 57) goto aRissClar4
if   (iselosc4 == 58) goto aRissDrum4x
if   (iselosc4 == 59) goto aRissDrum44
if   (iselosc4 == 60) goto aRissGliss4
if   (iselosc4 == 61) goto aRissFlute4
if   (iselosc4 == 62) goto aRissHarmon4
if   (iselosc4 == 63) goto aRissNoise4
if   (iselosc4 == 64) goto aRissOctave4
if   (iselosc4 == 65) goto aRissRing4
;end-Risset



apluckd:
asound4  pluck     (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,400,0,1
FLsetText "pluck",gihv8osc
goto  outosc4

;FM
adx7d:
asound4  Chant     (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,1,1,1,0
FLsetText "Chant",gihv8osc
goto  outosc4


;GBUZZ
agbuzz1osc4:
asound4  gbuzz     (iampstk*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,(sr*.4)/ipch,2,.9,21
FLsetText "buzz",gihv8osc
goto  outosc4

;BELL
abellosc4:
asound4  poscil    (iampscan*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,gibell
FLsetText "bell",gihv8osc
goto  outosc4

;CHORD
achordosc4:
asound4  chord    (iampscan*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,27
FLsetText "chord",gihv8osc
goto  outosc4

aspline1osc4:
asound4  poscil   (iampscan*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,53
FLsetText "Spline1",gihv8osc
goto  outosc4

addit2osc4:
asound4  poscil   (iampscan*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,28
FLsetText "Additive2",gihv8osc
goto  outosc4

addit3osc4:
asound4  poscil   (iampscan*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,56
FLsetText "Additive3",gihv8osc
goto  outosc4

addit4osc4:
asound4  poscil   (iampscan*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,58
FLsetText "Additive4",gihv8osc
goto  outosc4

acidosc4:
asound4  poscil   (iampscan*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,51
FLsetText "Acid",gihv8osc
goto  outosc4

;*************************************************************************************
;VCOSAW	
vcosaw4:
asound4  vco2    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,0,kpulsew
FLsetText "VCO-Saw",gihv8osc
goto  outosc4

;VCOSQUARE
vcosq4:
asound4  vco2    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,2,kpulsew
FLsetText "VCO-Square",gihv8osc
goto  outosc4

;vcosawosc3
vcosawosc4:
asound4  vco2    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,4,kpulsew
FLsetText "VCO-Saw2",gihv8osc
goto  outosc4

;vcosqb
vcosqb4:
asound4  vco2    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,10,kpulsew
FLsetText "VCO-Square2",gihv8osc
goto  outosc4

;vcotriangle
vcotrgl4:
asound4  vco2    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,12,kpulsew
FLsetText "VCO-Triangle",gihv8osc
goto  outosc4
;**************************************************************************************
;FMB3
afmb34:
asound4 Organ ((iamp/20)*kadsr4)*gk31,ipch/2,$Drawbar1,$Drawbar2,$Drawbar3,$Drawbar4,$Drawbar5,$Drawbar6,$Drawbar7,$Drawbar8,$Drawbar9
FLsetText "Organ",gihv8osc
goto  outosc4

agranuld:
asound4 grain     (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,$Graindens,(iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))*2+kj,.05,199,200,.5,0
FLsetText "Grain",gihv8osc
goto  outosc4

arumored:
asound4  oscil     (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,11,-1 ;noise
FLsetText "Noise",gihv8osc
goto  outosc4


ascannedd:
ascan   scantable (iampscan*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,1000,2000,3000,4000,5000  ;scan
asound4 dcblock ascan
FLsetText "Scanned",gihv8osc
goto  outosc4

aoscbpyd:
asound4 = asound2
FLsetText "BYPASS",gihv8osc
goto  outosc4

;ADDITIVE
additosc4:
asound4  additive1     (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,14
FLsetText "Additive",gihv8osc
goto  outosc4

;STK ****************************************************************************************
aSTKBandedWG4:
astk4  STKBandedWG  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk2)*gk31
FLsetText "BandedWG",gihv8osc
goto  outosc4

aSTKBeeThree4:
astk4  STKBeeThree  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "BeeThree",gihv8osc
goto  outosc4

aSTKBlowBotl4:
astk4  STKBlowBotl  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "BlowBotl",gihv8osc
goto  outosc4

aSTKBlowHole4:
astk4  STKBlowHole  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "BlowHole",gihv8osc
goto  outosc4

aSTKBowed4:
;astk1  STKBowed  ipchstk,1.0, 1, 4, 2, 0, 4, 0, 11, 50
astk4  STKBowed  ipchstk,2.0
asound4 =   (astk4*kadsr4*iampstk*2)*gk31
FLsetText "Bowed",gihv8osc
goto  outosc4

aSTKBrass4:
astk4  STKBrass  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk2)*gk31
FLsetText "Brass",gihv8osc
goto  outosc4

aSTKClarinet4:
astk4  STKClarinet  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Clarinet",gihv8osc
goto  outosc4

aSTKDrummer4:
astk4  STKDrummer  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Drummer",gihv8osc
goto  outosc4

aSTKFlute4:
astk4  STKFlute  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Flute",gihv8osc
goto  outosc4

aSTKFMVoices4:
astk4  STKFMVoices  ipchstk,1
asound3 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "FMVoices",gihv8osc
goto  outosc4

aSTKHevyMetl4:
astk4  STKHevyMetl  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "HevyMetl",gihv8osc
goto  outosc4

aSTKMandolin4:
astk4  STKMandolin  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Mandolin",gihv8osc
goto  outosc4

aSTKModalBar4:
astk4  STKModalBar  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "ModalBar",gihv8osc
goto  outosc4

aSTKMoog4:
astk4  STKMoog  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Moog",gihv8osc
goto  outosc4

aSTKPercFlut4:
astk4  STKPercFlut  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "PercFlut",gihv8osc
goto  outosc4

aSTKPlucked4:
astk4  STKPlucked  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Plucked",gihv8osc
goto  outosc4

aSTKResonate4:
astk4  STKResonate  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Resonate",gihv8osc
goto  outosc4

aSTKRhodey4:
astk4  STKRhodey  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Rhodey",gihv8osc
goto  outosc4

aSTKSaxofony4:
astk4  STKSaxofony  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Saxofony",gihv8osc
goto  outosc4

aSTKSitar4:
astk4  STKSitar  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Sitar",gihv8osc
goto  outosc4

aSTKStifKarp4:
astk4  STKStifKarp  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "StifKarp",gihv8osc
goto  outosc4

aSTKTubeBell4:
astk4  STKTubeBell  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "TubeBell",gihv8osc
goto  outosc4

aSTKVoicForm4:
astk4  STKVoicForm  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "VoicForm",gihv8osc
goto  outosc4

aSTKWhistle4:
astk4  STKWhistle  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Whistle",gihv8osc
goto  outosc4


aSTKWurley4:
astk4  STKWurley  ipchstk,1
asound4 =   (astk4*kadsr4*iampstk)*gk31
FLsetText "Wurley",gihv8osc
goto  outosc4

;end STK *********************************************************************************************************************
;chowning **************************************************************************************************
aCHOWglass4:
asound4  CHOWglass    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWglass",gihv8osc
goto  outosc4

aCHOWPad4:
asound4  CHOWPad    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,200,1
FLsetText "CHOWPad",gihv8osc
goto  outosc4

aCHOWPerc4:
asound4  CHOWPerc    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWPerc",gihv8osc
goto  outosc4

aCHOWPiano4:
asound4  CHOWPiano    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWPiano",gihv8osc
goto  outosc4

aCHOWrebell4:
asound4  CHOWrebell    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWrebell",gihv8osc
goto  outosc4

aCHOWSoprano4:
asound4  CHOWSoprano    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWSoprano",gihv8osc
goto  outosc4

aCHOWString4:
asound4  CHOWTrumpet    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWTrumpet",gihv8osc
goto  outosc4

aCHOWVibr4:
asound4  CHOWVibr    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWVibr",gihv8osc
goto  outosc4

aCHOWClar4:
asound4  CHOWClar    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj 
FLsetText "CHOWClar",gihv8osc
goto  outosc4

aCHOWwown4:
asound4  CHOWwown    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWwown",gihv8osc
goto  outosc4

aCHOWLoop4:
asound4  CHOWLoop    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "CHOWLoop",gihv8osc
goto  outosc4
;*******************end-chowning******************************************************************************
;****************************************************************************
;RISSET
aRissBell4:
asound4  RissBell    iamp,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "RissBell",gihv8osc
goto  outosc4

aRissClar4:
asound4  RissClar    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj 
FLsetText "RissClar",gihv8osc
goto  outosc4

aRissDrum4x:
asound4  RissDrum    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj 
FLsetText "RissDrum",gihv8osc
goto  outosc4

aRissDrum44:
asound4  RissDrum2    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj 
FLsetText "RissDrum2",gihv8osc
goto  outosc4

aRissGliss4:
asound4  RissGliss    iamp,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj ,1
FLsetText "RissGliss",gihv8osc
goto  outosc4

aRissFlute4:
asound4  RissFlute    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj 
FLsetText "RissFlute",gihv8osc
goto  outosc4

aRissHarmon4:
asound4  RissHarmon    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj 
FLsetText "RissHarmon",gihv8osc
goto  outosc4

aRissNoise4:
asound4  RissNoise    iamp,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj  
FLsetText "RissNoise",gihv8osc
goto  outosc4

aRissOctave4:
asound4  RissOctave    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj,.1 ,1
FLsetText "RissOctave",gihv8osc
goto  outosc4

aRissRing4:
asound4  RissRing    (iamp*kadsr4)*gk31,((((ipch*gk4) +klfo4)*powoftwo(kbend)))+kj 
FLsetText "RissRing",gihv8osc
goto  outosc4

;****************************************************************************



outosc4:

aosc4 = asound4


;************************************************************************************************

;OUTPUT TO  FILTERS
;controllo volume dal mixer
;amix =	(aosc1*gk28 +aosc2*gk29 +aosc3*gk30 + arand*gk31)*.5

;NOISE PINK
;rumore colorato
;awhite unirand 2.0
; Normalize to +/-1.0
;awhite = awhite - 1.0  
;apink  pinkish awhite, 1, 0, 0, 1
;arand  = (apink*(iamp*kadsr3))*gk31
;amix =	(aosc1 +aosc2 +aosc3 + arand)*.5
iselvector = i(gkvect)
if (iselvector==  0) goto  vectorial
if (iselvector == 1) goto  amixage

;******************************************************************************
vectorial:
ka2 init 0
kx2  =   sin(ka2) 
ky2  =   cos(ka2) 
ka2  =   ka2 + gk150  ;rate,incremento la velocità
kvect1  =   (1-kx2)*(1-ky2)
kvect2 =   kx2*(1-ky2)
kvect3  =   (1-kx2)*ky2
kvect4 =   kx2*ky2
amix    =  ((aosc4*kvect1+aosc3*kvect2  + aosc2*kvect3 + aosc1*kvect4)*.4)
goto   vectronouts



amixage:
amix =	((aosc1 +aosc2 +aosc3 + aosc4)*.4)
goto   vectronouts
;**********************************************************************



;SINTESI SOTTRATTIVA
;************************************************************************************************
;FIRST FILTERS
vectronouts:
;klfocut  lfo 200,1.5,1  ;range is 0 to 1
;klforeso lfo .5,1.5,1
klfocut  oscil  gk38 ,(gk34),i(gk36);lfo con vari waveform
;klforeso poscil  gk39 ,i(gk35),i(gk37),-1 ;lfo con vari waveform

;FILTERS TYPE


;afilter3  moogladder  amix,gk21+klfocut,gk22     ;uscita suono filtrato


;abypass1 = amix

;FILTER1
;gk37
;SELECTIONS
;if (gkselfilt = 0) then
;asumfilt = afilter1 
kcf  tonek gk21,10
kres tonek gk22,10

kadsrf1 madsr i(gk78), i(gk79),i(gk80), i(gk81)

iselfilt = i(gkselfilt)

if   (iselfilt == 0) goto amoog
if   (iselfilt == 1) goto alow
if   (iselfilt == 2) goto amladder
if   (iselfilt == 3) goto amlpf18
if   (iselfilt == 4) goto amstvar
if   (iselfilt == 5) goto abypass





amoog:
afilter1  moogvcf2    amix,(kcf*kadsrf1)+klfocut,kres     ;uscita suono filtrato
goto  uscita1

alow:
afilter1  lowpass2    amix,(kcf*kadsrf1)+klfocut,kres     ;uscita suono filtrato
goto  uscita1

amladder:
afilter1  moogladder  amix,(kcf*kadsrf1)+klfocut,kres     ;uscita suono filtrato
goto  uscita1

amlpf18:

afilter1 lpf18   amix/1000,((kcf)*.9*kadsrf1)+klfocut,kres,0  ;uscita suono filtrato
afilter1 = afilter1 *3000
goto  uscita1

amstvar:
ahp,alp,abp,abr    statevar  amix,(kcf*kadsrf1)*.3 + klfocut,kres
afilter1 = (ahp+alp+abp+abr)*.5
goto  uscita1


abypass:
afilter1  = amix
goto  uscita1


uscita1:
asumfilt = afilter1

;************************************************************************************************
;SECOND FILTERS

;klfocut2  oscil  gk44 ,(gk42),i(gk43);lfo con vari waveform
kadsrf2 madsr i(gk82), i(gk83),i(gk84), i(gk85)


iselfilt2 = i(gkselfilt2)

if   (iselfilt2 == 0) goto amstvar2
if   (iselfilt2 == 1) goto asvfilt2
if   (iselfilt2 == 2) goto amoog2
if   (iselfilt2 == 3) goto afofilt2
if   (iselfilt2 == 4) goto abypass2

amstvar2:
ahp2,alp2,abp2,abr2    statevar  asumfilt,(gkb1*kadsrf2)*.3,gkb2
afilter2 = (ahp2*gk100+alp2*gk101+abp2*gk102+abr2*gk103)*.5

goto  uscita2


asvfilt2:
alowsv, ahighsv, abandsv svfilter  asumfilt,(gkb7*kadsrf2),gkb8
asvfilt = (alowsv*gk104+ahighsv*gk105+abandsv*gk106)

afilter2 balance asvfilt,asumfilt

goto  uscita2



amoog2:
afilter2  moogvcf2    asumfilt,(gk110*kadsrf2),gk111
goto  uscita2

afofilt2:
afofilx  fofilter  asumfilt,gk112*kadsrf2, gk113,gk114
afilter2 = afofilx/12
goto  uscita2


abypass2:
afilter2  = afilter1
goto  uscita2



uscita2:
asumfilt2 = afilter2
;afilt clip afiltx,1,20000
;************************************************************************************************

;************************************************************************************************


;FIRST EFFECTS
;
iselfx1 = i(gkselfx)

if   (iselfx1 == 0) goto aflang1
if   (iselfx1 == 1) goto aringmodx
if   (iselfx1 == 2) goto aphaserx
if   (iselfx1 == 3) goto adeldek
if   (iselfx1 == 4) goto avoicex
if   (iselfx1 == 5) goto abypass3
;suono di uscita : asumfilt2
; Vary the delay amount from 0 to 0.01 seconds.
;FLANGER
aflang1:
kfeedback = 0.5
idepthx   = i(gk46)/2000  ; LFO depth in ms
irate1x   = i(gk47 )     ; L LFO rate
idelayx   = 0.25/1000
alfx1    oscili  idepthx, irate1x,1
alfx1    = alfx1 + idepthx
aflanger flanger asumfilt2,alfx1 + idelayx, kfeedback;flanger
afx1 = aflanger*gk45 + asumfilt2 
goto  uscita3


;RING MOD
aringmodx:
klforing  oscil  gk50,i(gk49),i(gk51),-1 
afx1 oscil asumfilt2,(gk48)+klforing,1 
goto  uscita3


;PHASER2
                  ;(range =  .25 to 4 )
;ilfowave = 1 + i(gk26)  
aphaserx:
kPhQ = .45 ;x
klfo2	oscil	.5,gk53,1,-1 ;x  freq
kmod	= gk54*(1+klfo2)        ;(range = 200 to 8000) ;x  freq
kmod limit kmod,20,sr/4
istages = i(gkorder)            ;x num      ;( range = 1  to  16 iorder)
kPhSep  = gk55           ;x  freq      ;(range =  .25 a 4 )
kPhFdbk = .5          ;x  freq       ;(-.99 a .95)
aphs	phaser2 asumfilt2,kmod, kPhQ, istages, 2, kPhSep, kPhFdbk
afx1 = (asumfilt2 + aphs*gk52) 
goto  uscita3
  
;DELAY SIMPLE
adeldek:
adelay init 0
adelay delay asumfilt2+adelay*gk121,i(gk120)
kfadelay     linsegr  1, 0.01, 1, 0.33, 0
afx1 = (asumfilt2+adelay*gk122)*kfadelay 

goto  uscita3


avoicex:
;Random Vowel Reson Filter by Steven Cook
ivoicelevl = i(gk140)/550
iratevoice = i(gk141)
iseed    = rnd(1)
krnd     randi  .5, iratevoice, iseed
krnd     = krnd + .5
k1f      table  krnd, 31, 1
k2f      table  krnd, 32, 1
k3f      table  krnd, 33, 1
k4f      table  krnd, 34, 1
k5f      table  krnd, 35, 1
k1b      table  krnd, 36, 1
k2b      table  krnd, 37, 1
k3b      table  krnd, 38, 1
k4b      table  krnd, 39, 1
k5b      table  krnd, 40, 1
a1voc    reson  asumfilt2, k1f, k1b
a2voc    reson  asumfilt2, k2f, k2b
a3voc    reson  asumfilt2, k3f, k3b
a4voc    reson  asumfilt2, k4f, k4b
a5voc    reson  asumfilt2, k5f, k5b
aoutvoice     sum  a1voc , a2voc, a3voc , a4voc , a5voc 

afx1 = aoutvoice*ivoicelevl
goto  uscita3




abypass3:
afx1  = afilter2 ;segnale dal filtro secondo
goto  uscita3




uscita3:
afirstfx  = afx1 ;primo segnale con effetti




;***************************************************************************************************

;SECOND EFFECTS


;
iselfx2 = i(gkselfx2)

if   (iselfx2 == 0) goto achorus
if   (iselfx2 == 1) goto amtapd
if   (iselfx2 == 2) goto acomb
if   (iselfx2 == 3) goto apareq
if   (iselfx2 == 4) goto astepfl1
if   (iselfx2 == 5) goto autospace
if   (iselfx2 == 8) goto abypass4


;gk127
;COMB
;afx6 nreverb afirstfx,.8,.3
acomb:
avcomb  vcomb afirstfx,gk127,gk128,i(gk129)
;afx2 = avcomb + afirstfx
kfadecomb     linsegr  1, 0.01, 1, 0.33, 0
afx3L =   ((avcomb + afirstfx)*.5)*kfadecomb 
afx3R  =  ((avcomb + afirstfx)*.5)*kfadecomb 
goto  uscita5

apareq:
aparequa   pareq   afirstfx, gk123, gk124,gk254,i(gk255) ; Parmetric equalization
afx3L =   (aparequa)*.5
afx3R  =  (aparequa)*.5
goto  uscita5



;CHORUS by Steven Cook
achorus:
idepth   = i(gk58)/1000                           ; Depth factor
irate1   = i(gk59)*.9                              ; LFO 1 rate
irate2   = i(gk59)                                ; LFO 2 rate
irate3   = i(gk59)*1.2                               ; LFO 3 rate
irate4   = i(gk59)*2                               ; LFO 4 rate
imin     = 1/kr                              ; Minimum delay
idepth1  = idepth*(1/irate1)                 ; Scale depth 1
idepth2  = idepth*(1/irate2)                 ; Scale depth 2
idepth3  = idepth*(1/irate3)                 ; Scale depth 3
idepth4  = idepth*(1/irate4)                 ; Scale depth 4
alfo1a   oscil  idepth1, irate1, 91           ; LFO 1   0 degrees
alfo1b   oscil  idepth1, irate1, 91, .333     ; LFO 1 120 degrees
alfo1c   oscil  idepth1, irate1, 91, .667     ; LFO 1 240 degrees
alfo2a   oscil  idepth2, irate2, 91           ; LFO 2   0 degrees
alfo2b   oscil  idepth2, irate2, 91, .333     ; LFO 2 120 degrees
alfo2c   oscil  idepth2, irate2, 91, .667     ; LFO 2 240 degrees
alfo3a   oscil  idepth3, irate3, 91           ; LFO 3   0 degrees
alfo3b   oscil  idepth3, irate3, 91, .333     ; LFO 3 120 degrees
alfo3c   oscil  idepth3, irate3, 91, .667     ; LFO 3 240 degrees
alfo4a   oscil  idepth4, irate4, 91           ; LFO 4   0 degrees
alfo4b   oscil  idepth4, irate4, 91, .333     ; LFO 4 120 degrees
alfo4c   oscil  idepth4, irate4, 91, .667     ; LFO 4 240 degrees
ax       delayr  1                           ; Create 1s delay line
abbd1	 deltapi  alfo1a + alfo2a + imin     ; Tap 1
abbd2	 deltapi  alfo1b + alfo2b + imin     ; Tap 2
abbd3    deltapi  alfo1c + alfo2c + imin     ; Tap 3
abbd4    deltapi  alfo3a + alfo4a + imin     ; Tap 4
abbd5    deltapi  alfo3b + alfo4b + imin     ; Tap 5
abbd6    deltapi  alfo3c + alfo4c + imin     ; Tap 6
         delayw  afirstfx                         ; Input signal into delay
aouts1 =   (abbd1 + abbd2 + abbd3)      ; Level, sum and output
aouts2 =   (abbd4 + abbd5 + abbd6)     ; Level, sum and output

afx3L =   afirstfx + ((aouts1 )*.7 )*gk57
afx3R  =  afirstfx + ((aouts2 )*.7 )*gk57

goto  uscita5




;ANALOG DELAY
amtapd:

afdbk    init 0            ; Initialize feedback


idelay   = i(gk60)            ; Delay
ifdbk    = .4            ; Feedback amount
iecho    = i(gk61)            ; Reverb amount
afirstfx = afirstfx + afdbk*ifdbk ;Sum input and feedback
atemp    delayr  1               ; Create 1s delay
atap1    deltap .0396*idelay    ; Tap 1
atap2    deltap .0662*idelay    ; Tap 2
atap3    deltap .1194*idelay    ; Tap 3
atap4    deltap .1726*idelay    ; Tap 4
atap5    deltap .2790*idelay    ; Tap 5
atap6    deltap .3328*idelay    ; Tap 6
 delayw afirstfx
afdbk    butterlp  atap6, gk63     ; Lopass filter feedback
abbd1     sum   atap1, atap2, atap3; Sum taps
abbd2     sum   atap4, atap5, atap6 ; Sum taps
abbd3     butterlp  abbd1, gk63      ; Lowpass filter output
abbd4     butterlp  abbd2, gk63      ; Lowpass filter output
afxecho1   = (((abbd3*iecho) *.3)*gk62 +afirstfx) 
afxecho2   = (((abbd4*iecho) *.3)*gk62 +afirstfx)
kfadecho     linsegr  1, 0.01, 1, 0.33*idelay*(1+ifdbk)*(1+iecho), 0
afx3L =  afxecho1*kfadecho
afx3R =  afxecho2*kfadecho
goto  uscita5



;STEPFLANGER

astepfl1:

kdelstep   = 0.65/1000 ; Delay in ms
kdepthstep   = gk144/2000 ; LFO depth in ms
kratestep    = gk145      ; LFO rate in Hz
kfeedstep   = 0.90      ; Feedback (+/-)

imaxstep     = i(kdelstep) + i(kdepthstep) + .1

iseedstep    = rnd(2)
alfostep     randh  kdepthstep, kratestep, iseedstep 
alfostep    = alfostep + kdepthstep
aflangestep  flanger  afirstfx, alfostep + kdelstep,kfeedstep,imaxstep
astepfl     = afirstfx + (aflangestep)*gk143
afx3L =  astepfl
afx3R =  astepfl
goto  uscita5

;autospace
autospace:
;ahtrf1,ahtrf2 locsig afirstfx,gk221,gk222,.1
;afx3L = ahtrf1*100
;afx3R = ahtrf2*100
kapan  poscil    1,gk222,1
afx3L =   (afirstfx*kapan)
afx3R  =  (afirstfx*(gk221-kapan))


goto  uscita5

;bypass
abypass4:
afx3L = afx1
afx3R = afx1
goto  uscita5



uscita5:
aspacefxL  = afx3L
aspacefxR  = afx3R


;**********************************************************************************************************************************

;OUTPUTS
aoutputsL clip  aspacefxL,1,ampdb(85)
aoutputsR clip  aspacefxR,1,ampdb(85)
ga1	=	(ga1+aoutputsL ) ;vumeter
ga1	=	(ga1+aoutputsR ) ;vumeter

gareverb1	=	gareverb1+aoutputsL
gareverb2	=	gareverb2+aoutputsR
;adampingx linsegr 0.0,.0015,1.0,p3,0.1,.002,0.0


zaw gareverb1, 1  ;uscita   var1
zaw gareverb2, 2  ;uscita   var2


outs	(((aoutputsL))*.5),(((aoutputsR))*.5)

;outs to hard disk recording

vincr gafout1, aoutputsL
vincr gafout2, aoutputsR




;equalizer
;outs	((aL)*kenv)*gk56,((aR)*kenv)*gk56
iselmod = i(gk255)
if (iselmod = 0) goto modo1
if (iselmod = 1) goto modo2
if (iselmod = 2) goto modo3

modo1:
FLsetText "Peaking",gidist3
goto end

modo2:
FLsetText "Low Shelving",gidist3
goto end


modo3:
FLsetText "High Shelving",gidist3
goto end


end:

endin



;************************************************************************************************
;************************************************************************************************
;************************************************************************************************

;GLOBAL REVERB
instr 2


al,ar reverbsc gareverb1,gareverb2,gkrevsc, 12000, sr, .2, 0
asigld dcblock al
asigrd dcblock ar
asigl clip asigld, 2, 32000
asigr clip asigrd, 2, 32000
kdclick linseg 0, .01, 1, p3-.02, 1, .01, 0
outs asigl * kdclick, asigr * kdclick

vincr gafout3, (asigl * kdclick)*.6
vincr gafout4, (asigr * kdclick)*.6



gareverb1 = 0
gareverb2 = 0
endin



;************************************************************************************************
;************************************************************************************************
;************************************************************************************************

instr 3
;example by Gabriel Maldonado

outs	ga1,ga1
ktrig	metro	15
kval	max_k	ga1, ktrig, 0
	FLsetVal	ktrig, kval, gihvu


ga1	=	0

	endin

;************************************************************************************************
;************************************************************************************************
;************************************************************************************************

instr 4 ;vector filter


if	(gkfiltvect ==  1 )kgoto  CONTINUE
if	(gkfiltvect ==  0 )kgoto FERMO


CONTINUE:

krand  randomi	1,22000,gkfiltvect2  ;rate
krand2 randomi	1,.1,gkfiltvect2   ;rate
FLsetVal 1, krand,gihjoy1
FLsetVal 1, krand2,gihjoy2

FERMO:

endin
;************************************************************************************************
;************************************************************************************************
;************************************************************************************************

instr 5
;gkrand,gihrand 
irandom = i(gkrand)
if	(irandom ==  1 )igoto CONTINUE
if	(irandom ==  0 )igoto END


CONTINUE:
iatkrnd   random   0.01,3
idecrnd   random   0,.5
iasusrnd  random   0.01,1
irelrnd   random   0,2

iatkrnd2   random   0.01,3
idecrnd2   random   0,.5
iasusrnd2  random   0.01,1
irelrnd2   random   0,2

iatkrnd3   random   0.01,3
idecrnd3   random   0,.5
iasusrnd3  random   0.01,1
irelrnd3   random   0,2

iatkrnd4   random   0.01,3
idecrnd4   random   0,.5
iasusrnd4  random   0.01,1
irelrnd4   random   0,2
;irand randomi 1,444,gihandle
;irand = int(irand)

;irand = rnd(444)
FLsetVal_i iatkrnd,giadsr1a
FLsetVal_i idecrnd,giadsr1b
FLsetVal_i iasusrnd,giadsr1c
FLsetVal_i irelrnd,giadsr1d

FLsetVal_i iatkrnd2,giadsr1a2
FLsetVal_i idecrnd2,giadsr1b2
FLsetVal_i iasusrnd2,giadsr1c2
FLsetVal_i irelrnd2,giadsr1d2

FLsetVal_i iatkrnd3,giadsr1a3
FLsetVal_i idecrnd3,giadsr1b3
FLsetVal_i iasusrnd3,giadsr1c3
FLsetVal_i irelrnd3,giadsr1d3

FLsetVal_i iatkrnd4,giadsr1a4
FLsetVal_i idecrnd4,giadsr1b4
FLsetVal_i iasusrnd4,giadsr1c4
FLsetVal_i irelrnd4,giadsr1d4




END:
endin


;************************************************************************************************
;************************************************************************************************
;************************************************************************************************


instr 6 ;rndspace


if	(gkrndspace ==  1 )kgoto  CONTINUE
if	(gkrndspace ==  0 )kgoto FERMO


CONTINUE:

krand  randomi	.1,3,gkrndspace2  ;rate
krand2 randomi	.1,4,gkrndspace2   ;rate
FLsetVal 1, krand,gihrndspace1
FLsetVal 1, krand2,gihrndspace2

FERMO:

endin

;save presets
;************************************************************************************************
;************************************************************************************************
;************************************************************************************************
	
      instr		7		;RETRIEVE SNAPSHOT

inumsnap		FLgetsnap	i(gkget)	;VARIABLE gkget IS DEFINED BY THE VALUE OUTPUT BY THE BUTTON BANK

			endin

      instr		8		;LOAD SNAPSHOT BANK
			FLloadsnap	$PRESETS	

			endin                                                   

      instr		9		;SAVE SNAPSHOT BANK
			FLsavesnap	$PRESETS	

			endin						

      instr		10		;STORE SNAPSHOT

inumsnap, inumval 	FLsetsnap	i(gkstore)	;gkstore IS THE DETERMINED BY THE FLTK COUNTER

      
                        endin





;************************************************************************************************
;************************************************************************************************
;************************************************************************************************

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

			
;************************************************************************************************
;************************************************************************************************
;************************************************************************************************
;hard disk recording
instr 12

a1 zar 3  ;loop rec-play signal
a2 zar 4


iname = i(gkhdrec)

if	(gkhdrec ==  1 )kgoto RECORD
if	(gkhdrec ==  0 )kgoto STOP
turnoff
RECORD:

fout $AudioFilename, 14, (gafout1+gafout3+a1)*gklevrec,(gafout2+gafout4+a2)*gklevrec
clear gafout1,gafout2,gafout3,gafout4,a1,a2

kgoto uscita

STOP:

kgoto uscita
uscita:

;prototype :-(
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
;************************************************************************************************
;************************************************************************************************
;************************************************************************************************
;************************************************************************
;random filter-bank2
instr 13
;gkrandfilt2,gihrandfilt2 

if	(gkrandfilt2 ==  1 )kgoto  CONTINUE
if	(gkrandfilt2 ==  0 )kgoto FERMO
;,gihrndfiltvect2

CONTINUE:
;statevar
krand  randomi	250,13200,gkrndfiltvect2  
krand2 randomi	.1,.9,gkrndfiltvect2 
FLsetVal 1, krand,gistvar1
FLsetVal 1, krand2,gistvar2
krand3  randomi	.01,2,gkrndfiltvect2  
FLsetVal 1, krand3,gihpstv
krand4  randomi	.02,1.8,gkrndfiltvect2  
FLsetVal 1, krand4,gilpstv
krand5  randomi	.02,1.9,gkrndfiltvect2  
FLsetVal 1, krand5,gibpstv
krand6  randomi	.01,1.999,gkrndfiltvect2  
FLsetVal 1, krand6,gibrstv
;svfilter
krand7  randomi	100,8000,gkrndfiltvect2 
FLsetVal 1, krand7,gistsvf1
krand8  randomi	1,10,gkrndfiltvect2 
FLsetVal 1, krand8,gistsvf2
krand9  randomi	.1,1,gkrndfiltvect2 
FLsetVal 1, krand9,gilpsvf
krand10  randomi .2,1,gkrndfiltvect2 
FLsetVal 1, krand10,gihpsvf
krand11  randomi .1,.9,gkrndfiltvect2 
FLsetVal 1, krand11,gibpsvf
;moogvcf2
krand12  randomi 250,22000,gkrndfiltvect2 
FLsetVal 1, krand12,gimgv2
FLsetVal 1, krand11,gimgv3
;fofilter
krand15  randomi 250,5000,gkrndfiltvect2
FLsetVal 1, krand15,gifofilter4
krand13  randomi .001,.05,gkrndfiltvect2 
FLsetVal 1, krand13,gifofilter5
krand14  randomi .001,.02,gkrndfiltvect2 
FLsetVal 1, krand14,gifofilter6

FERMO:

endin
;************************************************************************
;************************************************************************
;************************************************************************
;************************************************************************
instr 14

;LOOP REC-PLAY
a1 zar 1
a2 zar 2

aoutsndloop1,krec sndloop (a1),gkloopitch,gkloopstart,$LOOPDUR, 0.00005              
aoutsndloop2,krec sndloop (a2),gkloopitch,gkloopstart,$LOOPDUR, 0.00005              
            
;asum sum aoutsndloop1,aoutsndloop1

;adamping  linsegr  1,.1,1,.3,.5,.2,0


outs  (aoutsndloop1) *gklooplay,(aoutsndloop2 )*gklooplay

;stereo outs
zaw  (aoutsndloop1)*gklooplay,3
zaw  (aoutsndloop2)*gklooplay,4

endin

instr 15
;prototype :-(
iname2 = i(gkloopstart)
if	(iname2 ==  1 )goto TEXT1
if	(iname2 ==  0 )goto TEXT2
TEXT1:
FLsetText "@square",giloopstart
goto uscita2
TEXT2:
FLsetText "@circle",giloopstart
goto uscita2
uscita2:




endin
;************************************************************************
;************************************************************************
;************************************************************************
;************************************************************************









 ''')



csound.setScore('''

f0 360000

i2  0   360000
i3  0   360000
i4  0   360000
i5  0   360000
i6  0   360000
i11 0   360000
i12 0   360000
i13 0   360000
i14 0   360000
i15 0   360000







           ''' )


class MioFrame(wxFrame):
    def __init__(self):
        wxFrame.__init__(self, None, -1, "VECTROSYNTH 0.91", size=(300, 200))
        panel = wx.Panel(self)
        panel.SetBackgroundColour('white')
        

        ID_INFO = wxNewId()
        ID_ESCI = wxNewId()
        ID_TEXT = wxNewId()

        menu_file = wxMenu()
        menu_file.Append(ID_INFO, "&Play...","")
        menu_file.AppendSeparator()
        menu_file.Append(ID_ESCI, "&Exit",
                         "")
        menu_file.AppendSeparator()
        menu_file.Append(ID_TEXT, "&About",
                         "")
        
        EVT_MENU(self, ID_INFO, self.OnInfo)
        EVT_MENU(self, ID_ESCI, self.OnEsci)
        EVT_MENU(self, ID_TEXT, self.OnAbout)



        menu_bar = wxMenuBar()
        menu_bar.Append(menu_file, "&File");
        self.SetMenuBar(menu_bar)


        self.CreateStatusBar()
        
        self.SetStatusText("Vectrosynth 0.91")

    def OnInfo(self, event):
       
       csound.setCommand('csound -odac -M0 -+rtmidi=virtual -b1024 -B4000 test.orc test.sco')
       csound.exportForPerformance ()
       csound.perform()



    def OnEsci(self, event):
        # Distrugge il frame.
        self.Close(1)

    def OnAbout(self, event):
        wxMessageBox("VECTROSYNTH 0.91 by Giorgio Zucco (first release 1-2 2007)")







class MiaApp(wxApp):
    def OnInit(self):
        frame = MioFrame()
        frame.Show(1)
        self.SetTopWindow(frame)
        return 1

app = MiaApp()
app.MainLoop()



