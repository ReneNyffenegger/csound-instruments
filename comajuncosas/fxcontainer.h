#define FxContainer(FxSlot)
#
gkFx$FxSlot.inGain,iFx$FxSlot.inGainh FLslider	" ",0,1,giSldScl,6,-1,10, ifxpannelh-60,5,30
	FLsetVal_i   .25, iFx$FxSlot.inGainh
iFx$FxSlot.dB0in  FLbox  "@<",1, 5, 10, 8, 8, 15,49;49 is empyrical...;-)
	FLsetColor2 50, 255, 50, iFx$FxSlot.dB0in

gkFx$FxSlot.outGain,iFx$FxSlot.outGainh FLslider	" ", 0,1,giSldScl,6,-1,10, ifxpannelh-60,ifxpannell-15,30
	FLsetVal_i   .25, iFx$FxSlot.outGainh
iFx$FxSlot.dB0out  FLbox  "@>",1, 5, 10, 8, 8, ifxpannell-23,49;49 is empyrical...;-)
	FLsetColor2 50, 255, 50, iFx$FxSlot.dB0out

gkFx$FxSlot.inRms,giFx$FxSlot.inRmsh FLslider " ", 0,0.707,0,1, -1, 80,10,5,16
	FLsetColor2 50, 255, 50, giFx$FxSlot.inRmsh
	FLsetColor 0,0,0, giFx$FxSlot.inRmsh

gkFx$FxSlot.outRms,giFx$FxSlot.outRmsh FLslider " ", 0,0.707,0,1, -1, 80,10,ifxpannell-85,ifxpannelh-15-11
	FLsetColor2 50, 255, 50, giFx$FxSlot.outRmsh
	FLsetColor 0,0,0, giFx$FxSlot.outRmsh

gkFx$FxSlot.bypass, giFx$FxSlot.byp   FLbutton  " ", 1, 0, 2, 20, 20, 5, ifxpannelh-20-imargin, -1
	FLsetColor 0,0,0,giFx$FxSlot.byp
	FLsetColor2 255, 255, 50, giFx$FxSlot.byp


giFx0$FxSlot.name  FLbox  "-", 1, 4, 12, 160, 15,   ifxpannell/2-80,5
iFx$FxSlot.Fxn  FLbox  "Fx $FxSlot.", 5, 2, 12, 30, 15,   ifxpannell-5-30,5
	FLsetColor 0,0,0,iFx$FxSlot.Fxn
	FLsetTextColor 255, 255, 50,  iFx$FxSlot.Fxn

	FLcolor2  50, 255, 50
	FLcolor 0,0,0

gkFx$FxSlot.inCh1,giFx$FxSlot.inCh1h  FLslider  " ", 0,1,0,1,-1, 10, 10,   5,5
gkFx$FxSlot.inCh2,giFx$FxSlot.inCh2h  FLslider  " ", 0,1,0,1,-1, 10, 10,  15,5
gkFx$FxSlot.inCh3,giFx$FxSlot.inCh3h  FLslider  " ", 0,1,0,1,-1, 10, 10,  25,5
gkFx$FxSlot.inCh4,giFx$FxSlot.inCh4h  FLslider  " ", 0,1,0,1,-1, 10, 10,  35,5
gkFx$FxSlot.inCh5,giFx$FxSlot.inCh5h  FLslider  " ", 0,1,0,1,-1, 10, 10,  45,5
gkFx$FxSlot.inCh6,giFx$FxSlot.inCh6h  FLslider  " ", 0,1,0,1,-1, 10, 10,  55,5
gkFx$FxSlot.inCh7,giFx$FxSlot.inCh7h  FLslider  " ", 0,1,0,1,-1, 10, 10,  65,5
gkFx$FxSlot.inCh8,giFx$FxSlot.inCh8h  FLslider  " ", 0,1,0,1,-1, 10, 10,  75,5


gkFx$FxSlot.outCh1,giFx$FxSlot.outCh1h  FLslider  " ", 0,1,0,1,-1, 10, 10,  ifxpannell-85,ifxpannelh-15
gkFx$FxSlot.outCh2,giFx$FxSlot.outCh2h  FLslider  " ", 0,1,0,1,-1, 10, 10,  ifxpannell-75,ifxpannelh-15
gkFx$FxSlot.outCh3,giFx$FxSlot.outCh3h  FLslider  " ", 0,1,0,1,-1, 10, 10,  ifxpannell-65,ifxpannelh-15
gkFx$FxSlot.outCh4,giFx$FxSlot.outCh4h  FLslider  " ", 0,1,0,1,-1, 10, 10,  ifxpannell-55,ifxpannelh-15
gkFx$FxSlot.outCh5,giFx$FxSlot.outCh5h  FLslider  " ", 0,1,0,1,-1, 10, 10,  ifxpannell-45,ifxpannelh-15
gkFx$FxSlot.outCh6,giFx$FxSlot.outCh6h  FLslider  " ", 0,1,0,1,-1, 10, 10,  ifxpannell-35,ifxpannelh-15
gkFx$FxSlot.outCh7,giFx$FxSlot.outCh7h  FLslider  " ", 0,1,0,1,-1, 10, 10,  ifxpannell-25,ifxpannelh-15
gkFx$FxSlot.outCh8,giFx$FxSlot.outCh8h  FLslider  " ", 0,1,0,1,-1, 10, 10,  ifxpannell-15,ifxpannelh-15
	FLcolor2 -1
	FLcolor -1

;GUI per l'efecte 1 (Bit depth / sample rate reducer)
giFx1$FxSlot.name  FLbox  "Cruncher", 1, 4, 12, 160, 15,   ifxpannell/2-80,5
	FLhide giFx1$FxSlot.name

	FLcolor 20,50,90
	FLcolor2 250,0,0
	FLlabel  11,2,4,0,0,0 

gk1Fx1Slot$FxSlot., gih1Fx1Slot$FxSlot. FLknob  "bit depth", 4, 16, 0, 1, -1, 50, 85, 46
	FLsetVal_i   8, gih1Fx1Slot$FxSlot.
	FLhide gih1Fx1Slot$FxSlot.
gk2Fx1Slot$FxSlot., gih2Fx1Slot$FxSlot. FLknob  "foldover", 1, 16, 0, 1, -1, 50, ifxpannell-135, 46
	FLsetVal_i   4, gih2Fx1Slot$FxSlot.
	FLhide gih2Fx1Slot$FxSlot.
	FLcolor2 -1
	FLcolor -1
	FLlabel -1

;GUI per l'efecte 2 (Direct Convolver)
giFx2$FxSlot.name  FLbox  "Direct Convolver", 1, 4, 12, 160, 15,   ifxpannell/2-80,5
	FLhide giFx2$FxSlot.name

	FLcolor 0,0,0
	FLcolor2 250,255,50
	FLlabel  11,2,4,0,0,0 
 
gk1Fx2Slot$FxSlot., gih1Fx2Slot$FxSlot. FLknob  "IR mod 1", 1/16, 4, -1, 2, -1, 40, 100, 46
	FLsetVal_i   1, gih1Fx2Slot$FxSlot.
	FLsetBox 14, gih1Fx2Slot$FxSlot.
	FLhide gih1Fx2Slot$FxSlot.
gk2Fx2Slot$FxSlot., gih2Fx2Slot$FxSlot. FLknob  "IR mod 2", 1/16, 4, -1, 2, -1, 40, ifxpannell-140, 46
	FLsetVal_i   1/4, gih2Fx2Slot$FxSlot.
	FLsetBox 14, gih2Fx2Slot$FxSlot.
	FLhide gih2Fx2Slot$FxSlot.

	FLcolor2 -1
	FLcolor -1
	FLlabel -1

;GUI per l'efecte 3 (Feingenbaum Ringmod)
iwidth,iheight,ibpp bmopen "FeigRed.bmp", 1, 2 ;*** you can use another image

giFx3$FxSlot.name  FLbox  "Feigenbaum Ringmod", 1, 4, 12, 160, 15,   ifxpannell/2-80,5

	FLhide giFx3$FxSlot.name


gih1Fx3valSlot$FxSlot.	FLvalue	" ", 50, 18, 35, 112
	FLsetBox 1,gih1Fx3valSlot$FxSlot.
	FLhide gih1Fx3valSlot$FxSlot.

	FLcolor 120,120,240
	FLcolor2 20,50,90
	FLlabel  11,2,4,0,0,0 
gk1Fx3Slot$FxSlot., gih1Fx3Slot$FxSlot. FLknob  "Mod freq", .1, 1000, -1, 1, gih1Fx3valSlot$FxSlot., 60, 30, 35
	FLsetVal_i   0.7098, gih1Fx3Slot$FxSlot.
	FLhide gih1Fx3Slot$FxSlot.
;NO CANVIAR ELS VALORS (o canviar tambe a setOverlay, a FxControllers.h)
gk2Fx3Slot$FxSlot., gih2Fx3Slot$FxSlot. FLknob  "r0", .1, 3.9, 0, 1, -1, 40, 100, 24
	FLsetVal_i   1, gih2Fx3Slot$FxSlot.
	FLhide gih2Fx3Slot$FxSlot.
gk3Fx3Slot$FxSlot., gih3Fx3Slot$FxSlot. FLknob  "rw", .2, 4, 0, 1, -1, 40, 150, 24
	FLsetVal_i   1.2, gih3Fx3Slot$FxSlot.
	FLhide gih3Fx3Slot$FxSlot.
gk4Fx3Slot$FxSlot., gih4Fx3Slot$FxSlot. FLknob  "x0", .01, .2, 0, 1, -1, 40, 125, 78
	FLsetVal_i   .1, gih4Fx3Slot$FxSlot.
	FLhide gih4Fx3Slot$FxSlot.
	FLcolor2 -1
	FLcolor -1
	FLlabel -1
gih5Fx3Slot$FxSlot. FLbox " ",3,1,20,110,80,200,31;,1
	FLsetColor 0,0,0,gih5Fx3Slot$FxSlot.
	FLsetColor2 250,0,0,gih5Fx3Slot$FxSlot.
	FLsetImage  1,gih5Fx3Slot$FxSlot.,0 ;*** display image
	FLhide gih5Fx3Slot$FxSlot.

;GUI per l'efecte 4 (Morpheable filter)
giFx4$FxSlot.name  FLbox  "Morpheable Filter", 1, 4, 12, 160, 15,   ifxpannell/2-80,5
	FLhide giFx4$FxSlot.name

FLcolor  0,0,0,255, 150, 80
	FLlabel  11,2,4,0,0,0 

gk1Fx4Slot$FxSlot.,gk2Fx4Slot$FxSlot.,gih1Fx4Slot$FxSlot.,gih2Fx4Slot$FxSlot.\
 FLjoy "Cutoff/Morph",100, 8000, 0, 2,-1,0,-1,-1,140,80,70,30
	FLsetVal_i   1000, gih1Fx4Slot$FxSlot.
	FLhide gih1Fx4Slot$FxSlot.
	FLsetVal_i   1, gih2Fx4Slot$FxSlot.
	FLhide gih2Fx4Slot$FxSlot.
FLcolor -1

FLcolor  255, 150, 80,0,0,0
gk3Fx4Slot$FxSlot., gih3Fx4Slot$FxSlot. FLknob  "Res", 1, 50, -1, 1, -1, 40, 220, 50
	FLsetVal_i   10, gih3Fx4Slot$FxSlot.
	FLhide gih3Fx4Slot$FxSlot.

FLcolor -1
FLlabel -1

;GUI per l'efecte 5 (variable Comb/Allpass)
giFx5$FxSlot.name  FLbox  "variable Comb/Allpass", 1, 4, 12, 160, 15,   ifxpannell/2-80,5
	FLhide giFx5$FxSlot.name

	FLcolor2 180,150,100
	FLlabel  11,2,4,0,0,0 

gih1Fx5Slot$FxSlot.  FLvalue " ", 80,17, 40,58
	FLsetBox 1,gih1Fx5Slot$FxSlot.
	FLhide gih1Fx5Slot$FxSlot.
gk2Fx5Slot$FxSlot., gih2Fx5Slot$FxSlot. FLslider  "rev time", 0.01, 10, -1, 5, gih1Fx5Slot$FxSlot.,220, 15, 80, 40
	FLsetVal_i   2, gih2Fx5Slot$FxSlot.
	FLhide gih2Fx5Slot$FxSlot.

gih3Fx5Slot$FxSlot.  FLvalue " ", 80,17, 40,95
	FLsetBox 1,gih3Fx5Slot$FxSlot.
	FLhide gih3Fx5Slot$FxSlot.
gk4Fx5Slot$FxSlot., gih4Fx5Slot$FxSlot. FLslider  "loop time", 0.01, 10, -1, 5, gih3Fx5Slot$FxSlot.,220, 15, 80, 77
	FLsetVal_i   3.14, gih4Fx5Slot$FxSlot.
	FLhide gih4Fx5Slot$FxSlot.

gk5Fx5Slot$FxSlot., gih5Fx5Slot$FxSlot.   FLbutBank   3, 1,2, 30, 30, 210,100, -1, 0,0,0 
	FLsetVal_i   1, gih5Fx5Slot$FxSlot.
	FLhide gih5Fx5Slot$FxSlot.
gih6Fx5Slot$FxSlot.  FLbox  "comb filter", 1, 2, 11, 68, 12, 116, 102 
gih7Fx5Slot$FxSlot.  FLbox  "allpass filter", 1, 2, 11, 78, 12, 115, 117 
	FLhide gih6Fx5Slot$FxSlot.
	FLhide gih7Fx5Slot$FxSlot.

	FLcolor2 -1
	FLcolor -1
	FLlabel -1

;GUI per l'efecte 6 (Parametric Eq)
giFx6$FxSlot.name  FLbox  "Zoelter's Parametric Eq", 1, 4, 12, 160, 15,   ifxpannell/2-80,5
	FLhide giFx6$FxSlot.name

	FLcolor2 250,235,30

	FLlabel  11,2,4,0,0,0 
 
gk1Fx6Slot$FxSlot., gih1Fx6Slot$FxSlot.   FLbutBank   2, 1,3, 15, 45, 40,90, -1, 0,0,0 
	FLsetVal_i   0, gih1Fx6Slot$FxSlot.
	FLhide gih1Fx6Slot$FxSlot.

	FLcolor2 -1
	
gih2Fx6Slot$FxSlot.  FLbox  "Peaking Eq", 1, 2, 11, 68, 12, 56, 90 
gih3Fx6Slot$FxSlot.  FLbox  "Low Shelf", 1, 2, 11, 68, 12, 56, 15+90 
gih4Fx6Slot$FxSlot.  FLbox  "High Shelf", 1, 2, 11, 68, 12, 56, 30+90 

	FLhide gih2Fx6Slot$FxSlot.
	FLhide gih3Fx6Slot$FxSlot.
	FLhide gih4Fx6Slot$FxSlot.



gih5Fx6Slotval$FxSlot.  FLvalue "freq", 50,17, 55,30
	FLsetBox 1,gih5Fx6Slotval$FxSlot.
	FLhide gih5Fx6Slotval$FxSlot.

gih6Fx6Slotval$FxSlot.  FLvalue "gain", 50,17, 55,47
	FLsetBox 1,gih6Fx6Slotval$FxSlot.
	FLhide gih6Fx6Slotval$FxSlot.

gih7Fx6Slotval$FxSlot.  FLvalue "Q", 50,17, 55,64
	FLsetBox 1,gih7Fx6Slotval$FxSlot.
	FLhide gih7Fx6Slotval$FxSlot.


	FLcolor 130,0,20
	FLcolor2 250,235,30

gk5Fx6Slot$FxSlot., gih5Fx6Slot$FxSlot. FLknob  "Freq", 20, 10000, -1, 1, gih5Fx6Slotval$FxSlot., 50, 130, 30
	FLsetVal_i   1000, gih5Fx6Slot$FxSlot.
	FLhide gih5Fx6Slot$FxSlot.


gk6Fx6Slot$FxSlot., gih6Fx6Slot$FxSlot. FLknob  "Gain dB", -18, 6, 0, 1, gih6Fx6Slotval$FxSlot., 50, 195, 30
	FLsetVal_i   0, gih6Fx6Slot$FxSlot.
	FLhide gih6Fx6Slot$FxSlot.


gk7Fx6Slot$FxSlot., gih7Fx6Slot$FxSlot. FLknob  "Q", .1, 100, -1, 1, gih7Fx6Slotval$FxSlot., 50, 260, 30
	FLsetVal_i   sqrt(.5), gih7Fx6Slot$FxSlot.
	FLhide gih7Fx6Slot$FxSlot.


	FLcolor2 -1
	FLcolor2 130,0,20

gk8Fx6Slot$FxSlot., gih8Fx6Slot$FxSlot. FLbutton  "enable soft sat", 1,0, 3, 25,25, 230, 108,-1
	FLsetVal_i   0, gih8Fx6Slot$FxSlot.
	FLhide gih8Fx6Slot$FxSlot.

	FLcolor2 -1
	FLcolor -1
	FLlabel -1

;GUI per l'efecte 7 (R. Bristow Johnson's Eq)
giFx7$FxSlot.name  FLbox  "R. Bristow Johnson's Eq", 1, 4, 12, 160, 15,   ifxpannell/2-80,5
	FLhide giFx7$FxSlot.name

	FLlabel  11,2,4,0,0,0
	FLcolor2 240,50,130

gk1Fx7Slot$FxSlot., gih1Fx7Slot$FxSlot.   FLbutBank   2, 1,7, 15, 105, 40,30, -1, 0,0,0 
	FLsetVal_i   0, gih1Fx7Slot$FxSlot.
	FLhide gih1Fx7Slot$FxSlot.

	FLcolor2 -1
	
gih2Fx7Slot$FxSlot.  FLbox  "Lpf", 1, 2, 11, 18, 12, 56, 30 
gih3Fx7Slot$FxSlot.  FLbox  "Hpf", 1, 2, 11, 18, 12, 56, 30+15 
gih4Fx7Slot$FxSlot.  FLbox  "Bpf", 1, 2, 11, 18, 12, 56, 30+15+15 
gih5Fx7Slot$FxSlot.  FLbox  "Notch", 1, 2, 11, 30, 12, 56, 30+15+15+15 
gih6Fx7Slot$FxSlot.  FLbox  "Peak", 1, 2, 11, 27, 12, 56, 30+15+15+15+15 
gih7Fx7Slot$FxSlot.  FLbox  "Lo Sh", 1, 2, 11, 32, 12, 56, 30+15+15+15+15+15 
gih8Fx7Slot$FxSlot.  FLbox  "Hi Sh", 1, 2, 11, 28, 12, 56, 30+15+15+15+15+15+15 

	FLhide gih2Fx7Slot$FxSlot.
	FLhide gih3Fx7Slot$FxSlot.
	FLhide gih4Fx7Slot$FxSlot.
	FLhide gih5Fx7Slot$FxSlot.
	FLhide gih6Fx7Slot$FxSlot.
	FLhide gih7Fx7Slot$FxSlot.
	FLhide gih8Fx7Slot$FxSlot.

gih9Fx7Slotval$FxSlot.  FLvalue " ", 50,17, 100,110
	FLsetBox 1,gih9Fx7Slotval$FxSlot.
	FLhide gih9Fx7Slotval$FxSlot.

gih10Fx7Slotval$FxSlot.  FLvalue " ", 50,17, 165,110
	FLsetBox 1,gih10Fx7Slotval$FxSlot.
	FLhide gih10Fx7Slotval$FxSlot.

gih11Fx7Slotval$FxSlot.  FLvalue " ", 50,17, 270,30
	FLsetBox 1,gih11Fx7Slotval$FxSlot.
	FLhide gih11Fx7Slotval$FxSlot.

gih12Fx7Slotval$FxSlot.  FLvalue " ", 50,17, 270,85
	FLsetBox 1,gih12Fx7Slotval$FxSlot.
	FLhide gih12Fx7Slotval$FxSlot.

	FLcolor2 240,50,130
	FLcolor 35,0,140

gk9Fx7Slot$FxSlot., gih9Fx7Slot$FxSlot. FLknob  "Freq", 20, 10000, -1, 1, gih9Fx7Slotval$FxSlot., 50, 100, 40
	FLsetVal_i   1000, gih9Fx7Slot$FxSlot.
	FLhide gih9Fx7Slot$FxSlot.


gk10Fx7Slot$FxSlot., gih10Fx7Slot$FxSlot. FLknob  "Gain", -18, 6, 0, 1, gih10Fx7Slotval$FxSlot., 50, 165, 40
	FLsetVal_i   0, gih10Fx7Slot$FxSlot.
	FLhide gih10Fx7Slot$FxSlot.


gk11Fx7Slot$FxSlot., gih11Fx7Slot$FxSlot. FLknob  "Q", .1, 100, -1, 1, gih11Fx7Slotval$FxSlot., 40, 225, 20
	FLsetVal_i   sqrt(.5), gih11Fx7Slot$FxSlot.
	FLhide gih11Fx7Slot$FxSlot.

gk12Fx7Slot$FxSlot., gih12Fx7Slot$FxSlot. FLknob  "S", .1, 100, -1, 1, gih12Fx7Slotval$FxSlot., 40, 225, 75
	FLsetVal_i   1, gih12Fx7Slot$FxSlot.
	FLhide gih12Fx7Slot$FxSlot.


	FLcolor2 -1
	FLcolor -1
	FLlabel -1


;GUI per l'efecte 8 (BreakBeat Cutter)
giFx8$FxSlot.name  FLbox  "BreakBeat Cutter", 1, 4, 12, 160, 15,   ifxpannell/2-80,5
	FLhide giFx8$FxSlot.name
	FLlabel  11,2,3,0,0,0
	FLcolor2 150,30,0
	FLcolor 240,190,40
gk1Fx8Slot$FxSlot., gih1Fx8Slot$FxSlot. FLtext   "Bpm",          40,300,1,1, 40,20, 40, 35
gk2Fx8Slot$FxSlot., gih2Fx8Slot$FxSlot. FLcount  "SubDiv",       1,32,1,1,2, 60,20, 30, 75,-1,0,0 
gk3Fx8Slot$FxSlot., gih3Fx8Slot$FxSlot. FLcount  "BarLength",  .5,8,.5,.5,2, 60,20,100, 35,-1,0,0 
gk4Fx8Slot$FxSlot., gih4Fx8Slot$FxSlot. FLcount  "PhraseBars",    1,8,1,1,2, 60,20,100, 75,-1,0,0 
gk5Fx8Slot$FxSlot., gih5Fx8Slot$FxSlot. FLcount  "NumRepeats",    0,4,1,1,2, 60,20,170, 35,-1,0,0 
gk6Fx8Slot$FxSlot., gih6Fx8Slot$FxSlot. FLcount  "StutterSpeed",  1,4,1,1,2, 60,20,170, 75,-1,0,0 
gk7Fx8Slot$FxSlot., gih7Fx8Slot$FxSlot. FLknob   "StutterChance", 0,1,0,1, -1, 40, 260, 15
gk8Fx8Slot$FxSlot., gih8Fx8Slot$FxSlot. FLbutton "EnvChoice",     1, 0,2,    40,20,260, 75,-1,0,0 
gk9Fx8Slot$FxSlot., gih9Fx8Slot$FxSlot. FLbutton "Apply changes", 1, 0,1,    30,20,100,115,-1,0,0 
FLsetAlign 5,gih9Fx8Slot$FxSlot.

	FLsetVal_i   120, gih1Fx8Slot$FxSlot.
	FLsetVal_i     8, gih2Fx8Slot$FxSlot.
	FLsetVal_i     4, gih3Fx8Slot$FxSlot.
	FLsetVal_i     4, gih4Fx8Slot$FxSlot.
	FLsetVal_i     2, gih5Fx8Slot$FxSlot.
	FLsetVal_i     2, gih6Fx8Slot$FxSlot.
	FLsetVal_i    .1, gih7Fx8Slot$FxSlot.
	FLsetVal_i     1, gih8Fx8Slot$FxSlot.

	FLhide gih1Fx8Slot$FxSlot.
	FLhide gih2Fx8Slot$FxSlot.
	FLhide gih3Fx8Slot$FxSlot.
	FLhide gih4Fx8Slot$FxSlot.
	FLhide gih5Fx8Slot$FxSlot.
	FLhide gih6Fx8Slot$FxSlot.
	FLhide gih7Fx8Slot$FxSlot.
	FLhide gih8Fx8Slot$FxSlot.
	FLhide gih9Fx8Slot$FxSlot.

	FLlabel -1
	FLcolor2 -1
	FLcolor -1
#