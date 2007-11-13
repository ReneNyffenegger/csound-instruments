<CsoundSynthesizer>
<CsOptions>

-+S -+p12 -b1764 -t0 

</CsOptions>
<CsInstruments>

sr=44100
kr=44100
ksmps=1;00
nchnls=1
zakinit 1,1
maxalloc 1,1
maxalloc 100,1

iafn0	ftgen	40, 0, 4, -2, 0,0,0,0
iafn1	ftgen	41, 0, 4, -2, 0,0,0,0
iafn2   ftgen   42, 0, 8, -2, .01,5,.01,5,0.0001,1,.01,5

FLcolor  0,0,0
iPh=400
iPl=500
	FLpanel	"Jcn Salle2002 Synthesis Tutorial",iPl,iPh
FLcolor  -1

imargin=5
ilength=iPl-2*imargin
iheight=300
	FLtabs	ilength,iheight,imargin,imargin

iborder=7
itabsh=30
itabsl=10


	FLgroup	"Wavetable",ilength-itabsl,iheight-itabsh,itabsl,itabsh,iborder
gkWavetable, ihWavetable   FLbutton  " ", 1, 0, 2, 30, 20, 20, 40, -1,0,0 
FLsetColor2 0,250, 50,ihWavetable



gkButton1,ihb1 FLbutBank 2,1,4,  35,112, 100+200,80,  -1,0,0
FLsetVal_i 	1, ihb1

ihb11  FLbox  "   64 points", 1, 5, 12, 90, 20, 135+200, 80+2
ihb12  FLbox  "  256 points", 1, 5, 12, 90, 20, 135+200, 80+27+2
ihb13  FLbox  " 8192 points", 1, 5, 12, 90, 20, 135+200, 80+27+27+2
ihb14  FLbox  "32768 points", 1, 5, 12, 90, 20, 135+200, 80+27+27+27+2

gkButton2,ihb2 FLbutBank 2,1,4,  35,112, 100,80,  -1,0,0
FLsetVal_i 	1, ihb2

ihb21  FLbox  "wavetable 1:  sine", 1, 5, 12, 140, 20, 135, 80+2
ihb22  FLbox  "wavetable 2:   saw", 1, 5, 12, 140, 20, 135, 80+27+2
ihb23  FLbox  "wavetable 3:custom", 1, 5, 12, 140, 20, 135, 80+27+27+2
ihb24  FLbox  "wavetable 4: pulse", 1, 5, 12, 140, 20, 135, 80+27+27+27+2


gkButton3,ihb3 FLbutBank 2,4,1,  280,25, 100,230,  -1,0,0
FLsetVal_i 	1, ihb3

ihb31  FLbox  "no interp", 1, 5, 12, 70, 20, 100, 260
ihb32  FLbox  "linear", 1, 5, 12, 70, 20, 100+70, 260
ihb33  FLbox  "cubic", 1, 5, 12, 70, 20, 100+70+70, 260
ihb34  FLbox  "sync 8 points", 1, 5, 12, 70, 20, 100+70+70+70, 260



	FLgroup_end

	FLgroup	"FM",ilength-itabsl,iheight-itabsh, itabsl,itabsh,iborder
gkFM, ihFM   FLbutton  " ", 1, 0, 2, 30, 20, 20, 40, -1,0,0 
FLsetColor2 0,250, 50,ihFM
FLlabel  12, 5, 4, 0,0,0


gkButtonfm1,ihbfm1 FLbutBank 2,1,4,  35,112, 100,80,  -1,0,0
FLsetVal_i 	1, ihbfm1

ihbfm11  FLbox  "c:m = 1:1 ", 1, 5, 12, 140, 20, 135, 80+2
ihbfm12  FLbox  "c:m = 3:2 ", 1, 5, 12, 140, 20, 135, 80+27+2
ihbfm13  FLbox  "c:m = 5:7 ", 1, 5, 12, 140, 20, 135, 80+27+27+2
ihbfm14  FLbox  "c:m custom", 1, 5, 12, 140, 20, 135, 80+27+27+27+2

ihfmrval	FLvalue	"c:m ratio", 60, 20, 90,210
gkfmr,  ihfmr	FLslider	" ", 1/10, 10, 0, 5, ihfmrval, 280, 16, 100,240
FLsetVal_i 	2, ihfmr

ihfmIval	FLvalue	"mod Index", 60, 20, 350,160
gkfmI,  ihfmI	FLknob	" ", 0, 20, 0, 1, ihfmIval, 50, 350,100
FLsetVal_i 	1, ihfmr

FLlabel  -1

	FLgroup_end


	FLgroup	"Analog",ilength-itabsl,iheight-itabsh, itabsl,itabsh,iborder
FLlabel  12, 5, 4, 0,0,0

gkAnalog, ihAnalog   FLbutton  " ", 1, 0, 2, 30, 20, 20, 40, -1,0,0 
FLsetColor2 0,250, 50,ihAnalog

;FLslidBnk	" Attack@  Decay@Sustain@Release", 4, 40, 150, 72, 70, 90, -5,-1, 1,42
;FLslidBnk	" Attack@  Decay@Sustain@Release", 4, 41, 150, 72, 70,180, -5,-1, 5,42
ihbA1  FLbox  "ADSR1 Amp Env   ", 1, 5, 11, 140, 20, 80, 45
ihbA2  FLbox  "ADSR2 Filter Env", 1, 5, 11, 140, 20, 80,155

gkAnAtt1, ihAnAtt1	FLslider	" Attack", .0001, 5,  0, 5, -1, 150, 18, 70,70
gkAnDec1, ihAnDec1	FLslider	"  Decay", .0001, 5,  0, 5, -1, 150, 18, 70,70+18
gkAnSus1, ihAnSus1	FLslider	"Sustain",     0, 1,  0, 5, -1, 150, 18, 70,70+18+18
gkAnRel1, ihAnRel1	FLslider	"Release", .0001, 5,  0, 5, -1, 150, 18, 70,70+18+18+18

gkAnAtt2, ihAnAtt2	FLslider	" Attack", .0001, 5,  0, 5, -1, 150, 18, 70,180
gkAnDec2, ihAnDec2	FLslider	"  Decay", .0001, 5,  0, 5, -1, 150, 18, 70,180+18
gkAnSus2, ihAnSus2	FLslider	"Sustain",     0, 1,  0, 5, -1, 150, 18, 70,180+18+18
gkAnRel2, ihAnRel2	FLslider	"Release", .0001, 5,  0, 5, -1, 150, 18, 70,180+18+18+18






gkButtonAn1,ihbAn1 FLbutBank 2,1,3,  30,75, 300,70,  -1,0,0
FLsetVal_i 	0, ihbAn1

ihbBA1  FLbox  "Sawtooth", 1, 5, 12, 70, 20, 330, 70
ihbBA2  FLbox  "Square  ", 1, 5, 12, 70, 20, 330, 70+25
ihbBA3  FLbox  "Triangle", 1, 5, 12, 70, 20, 330, 70+25+25
ihbA3  FLbox  "VCO", 1, 5, 11, 140, 20, 250, 45

gkAnCutoff, ihAnCut	FLknob	"Cutoff", 50, 12000, -1, 1, -1, 50, 260,175
gkAnReso, ihAnRs	FLknob	"Reson", 0, 1, 0, 1, -1, 50, 330,175
gkAnEnvMod, ihAnEm	FLknob	"EnvMod", 0, 1, 0, 1, -1, 50, 400,175

ihbA4  FLbox  "VCF", 1, 5, 11, 140, 20, 250, 155
FLsetVal_i 	1000, ihAnCut
FLsetVal_i 	0, ihAnRs

gkAnTrig, ihAnTrig   FLbutton  "Trigger", 1, 0, 1, 60, 30, 420,   260, 0, 4,0,-1 
FLsetAlign	1, ihAnTrig
FLsetTextColor	255,255,50,  ihAnTrig

gkAnnoEnv, ihAnnoEnv   FLbutton  "steady", 1, 0, 3, 60, 30, 350,   260, -1,0,0
FLsetAlign	1, ihAnnoEnv
FLsetTextColor	255,255,50,  ihAnnoEnv

FLlabel  -1
	FLgroup_end


FLgroup	"About",ilength-itabsl,iheight-itabsh, itabsl,itabsh,iborder
FLcolor2 255,255,50
FLlabel  11, 2, 1, 255, 255, 50
ihbbox1  FLbox  "Basic synthesis tutorial by Josep M Comajuncosas", 1, 5, 12, 350, 20, 60,130
ihbbox2  FLbox  "check www.csounds.com/jmc for updates", 1, 5, 12, 350, 20, 60,150
FLlabel  -1
FLcolor  -1

	FLgroup_end


	FLtabs_end

ifxpannelh=iPh-iheight-imargin-iborder
ifxpannell=ilength


	FLpanel	"Control",ifxpannell,ifxpannelh,imargin,iheight+iborder,iborder
 		

FLlabel  -1
FLcolor   0,0,0, 255,255,50
FLlabel  11, 2, 1, 255, 255, 50

kStart, ihStart   FLbutton  "@>", 1, 0, 1, 40, 30, 415,   10, 0, 100,0,-1 
kStop, ihStop   FLbutton  "@||",1, 0, 1, 40, 30, 415,   45, 0, 100,0,0

FLlabel  -1
FLcolor  -1
FLsetColor2 50, 255, 50,ihStart
FLsetColor2 50, 255, 50,ihStop

;FLcolor   0,0,0, 255,255,50
FLlabel  12, 2, 4, 255, 255, 50 

ihAmpVal	FLvalue	"Amp", 55, 20, 35,20
ihFreqVal	FLvalue	"Freq", 55, 20, 35,45
	
gkAmp,  ihAmp	FLslider	" ", 0.1, 1, -1, 5, ihAmpVal, 280, 16, 95,22
gkFreq, ihFreq	FLslider	" ", 50, 4000, -1, 5, ihFreqVal, 280, 16, 95,47
FLsetVal_i 	0.4, ihAmp
FLsetVal_i 	220, ihFreq
	
FLlabel  -1
FLcolor  -1



iPresets  FLbox  "Presets", 1, 4, 12, 40, 15,   20,450
	FLpanel_end

	FLpanel_end



	FLrun



instr 1
;Wavetable tutorial : change wave table, size, interpolation, aliasing

if (gkWavetable==0) kgoto Skip
kfn = 4*gkButton2+(1+gkButton1)

kInt = gkButton3
aPh phasor gkFreq

kPrevFn init 0
kNewFn trigger kfn, kPrevFn, 2

if (kNewFn==0) kgoto Next
reinit Next

Next:


if (kInt ==0) kgoto Interp0
if (kInt ==1) kgoto Interp1
if (kInt ==2) kgoto Interp3
if (kInt ==3) kgoto Interp8

Interp0:
ar	tablekt		aPh, kfn,1 
kgoto Made
Interp1:
ar	tablexkt	aPh, kfn, 0, 2,1,0,1
kgoto Made
Interp3:
ar	tablexkt	aPh, kfn, 0, 4,1,0,1
kgoto Made
Interp8:
ar	tablexkt	aPh, kfn, 0, 8,1,0,1
Made:
rireturn

zawm ar,0

Skip:
endin

instr 2
;FM basic tutorial : Modulator, Carrier, M/C ratio, Modulation index

if (gkFM==0) kgoto Skip

if (gkButtonfm1==0) kgoto ratio1
if (gkButtonfm1==1) kgoto ratio2
if (gkButtonfm1==2) kgoto ratio3
if (gkButtonfm1==3) kgoto ratio4

ratio1:
kratio=1
kgoto fm
ratio2:
kratio=2/3
kgoto fm
ratio3:
kratio=7/5
kgoto fm
ratio4:
kratio=gkfmr

fm:
kImod tonek gkfmI,10

acarr	foscili	1, gkFreq, 1, kratio, kImod,3
zawm acarr,0

Skip:
endin

instr 4
;Analog modelling tutorial: BL VCO, 24dB VCF, ADSR Env and modulation

iatt1 = i(gkAnAtt1)
idec1 = i(gkAnDec1)
isus1 = i(gkAnSus1)
irel1 = i(gkAnRel1)


iatt2 = i(gkAnAtt2)
idec2 = i(gkAnDec2)
isus2 = i(gkAnSus2)
irel2 = i(gkAnRel2)


if (gkAnalog==0) kgoto Skip

;aADSR1	mxadsr	iatt1, idec1, isus1, irel1
aADSR2	mxadsr	iatt2, idec2, isus2, irel2

aADSR1	expseg	0.00001,iatt1,1,idec1,isus1,irel1,0.00001

kwave=gkButtonAn1

if (kwave ==0) kgoto wave0
if (kwave ==1) kgoto wave1
if (kwave ==2) kgoto wave2

wave0:
ar0	vco	1, gkFreq,1,.5,4
kgoto wavedone
wave1:
ar0	vco	1, gkFreq,2,.5,4
kgoto wavedone
wave2:
ar0	vco	1, gkFreq,3,.5,4

wavedone:
kcutoff tonek gkAnCutoff,20 
ar moogvcf ar0,kcutoff*(1+(gkAnEnvMod*(aADSR2-1))),gkAnReso

zawm ar*(aADSR1*(1-gkAnnoEnv)+gkAnnoEnv),0

Skip:
endin

instr 100
;receiver
aMix zar 0
out aMix*gkAmp*20000
endin

instr 101
zacl 0
endin


</CsInstruments>
<CsScore>
;wave tables
f1  0    65 10 1
f2  0   257 10 1
f3  0  8193 10 1
f4  0 32769 10 1

f5  0    65 10 1 .5 .25 .125
f6  0   257 10 1 .5 .25 .125
f7  0  8193 10 1 .5 .25 .125
f8  0 32769 10 1 .5 .25 .125

f9  0    65 10 1 0 2 1 5 2 1
f10 0   257 10 1 0 2 1 5 2 1
f11 0  8193 10 1 0 2 1 5 2 1
f12 0 32769 10 1 0 2 1 5 2 1

f13 0    65 10 1 1 1 1 1 1 1 1 1 1 1 1 1 1
f14 0   257 10 1 1 1 1 1 1 1 1 1 1 1 1 1 1
f15 0  8193 10 1 1 1 1 1 1 1 1 1 1 1 1 1 1
f16 0 32769 10 1 1 1 1 1 1 1 1 1 1 1 1 1 1

;tables for the ADSR sliders
;f40

t 0 60

i1 0 -1
i2 0 -1
i4.1 0 -1
i100 0 -1
i101 0 -1
f0 3600
</CsScore>
</CsoundSynthesizer>
