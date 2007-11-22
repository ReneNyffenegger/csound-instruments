;*******************************************************************************************************
;***** a simple FFT based realtime vocoder / Josep M Comajuncosas www.csounds.com/jmc /apr 14 -2003*****
;*******************************************************************************************************

<CsoundSynthesizer>
<CsOptions>
;********************
;please adjust these settings to your system!!!!!!!!	
-b1600
;********************

</CsOptions>
<CsInstruments>

sr      =       44100
kr      =       441
ksmps   =       100
nchnls  =       2

FLcolor   0,0,0
FLcolor2  0,0,0

        FLpanel         "jcn FFT vocoder",513,184
; some widgets should be contained here
ihbox	FLbox	" ", 1, 1,12, 511,182, 0,0
iwidth, iheight, ibpp	bmopen	"woodti.bmp", 1
FLsetImage	1, ihbox

FLcolor2  -1
FLcolor   -1

FLcolor2  226,229,0
FLcolor  213,153,105

gkFnMap,ihFnMap	FLbutBank 12, 1,6,  30, 120,10,40,-1,0,0

ihMap1	FLbox	"513 bin linear", 1,1,11, 0,20, 40,40
FLsetAlign	5, ihMap1
ihMap2	FLbox	"downwards shifted", 1,1,11, 0,20, 40,60
FLsetAlign	5, ihMap2
ihMap3	FLbox	"32 bin", 1,1,11, 0,20, 40,80
FLsetAlign	5, ihMap3
ihMap4	FLbox	"analog style", 1,1,11, 0,20, 40,100
FLsetAlign	5, ihMap4
ihMap5	FLbox	"a bit random", 1,1,11, 0,20, 40,120
FLsetAlign	5, ihMap5
ihMap6	FLbox	"random", 1,1,11, 0,20, 40,140
FLsetAlign	5, ihMap6
	
gkHold, ihHold	FLbutton	"Freeze", 1, 0, 2, 40, 30, 160,70, -1,0,0
FLsetAlign	3, ihHold
FLsetVal_i 	0, ihHold

gkSmear, ihSmear	FLknob	 "Smear", 0, .1, 0, 1, -1,50, 225,60
gkDepth, ihDepth	FLknob	 "Depth", 0, .1, 0, 1, -1,50, 310,60
gkDryWt, ihDryWt	FLknob	 "Mix",   0,  1, 0, 1, -1,50, 395,60
gkGain,  ihGain 	FLslider "Gain",.125, 8, -1, 3, -1,180,20, 115,140


FLsetVal_i 	0, ihSmear
FLsetVal_i 	0.1, ihDepth
FLsetVal_i 	1, ihDryWt
FLsetVal_i 	1, ihGain

        FLpanel_end     
        
        FLrun  

	instr 1
;********************
;audio interface
;load carrier
	aCarrier	rand 100;buzz 8000,110,190,1;in ; live source
;load modulator
	aModulator	soundin "djembe.wav";in ; live source
;********************

;********************
;control interface
reMap:
	ifnMap = 11+i(gkFnMap); mapping table from 11 to 16
	if ((11+i(gkFnMap))==ifnMap) kgoto okMap
reinit reMap
okMap:

ksmear = gkSmear                                ; portamento applied to amplitudes from 0 to about 0.1
kcross = gkDepth                                ; vocoder depth : 0 only carrier, 1 carrier fully modulated
kmix   = gkDryWt                                ; dry/wet mix: 0 only dry modulator, 1 only vocoded carrier
khold  = gkHold                                 ; when khold=1 the modulator is freezed (an on/off control)
kgain  = gkGain                                 ; output gain from 1/8 to 8
;********************

;********************
;instrument setup
;fft related
	ifftsize=1024
	ioverlap=ifftsize/4
	iwinsize=ifftsize*2
	iwintype=0
	ibins=1+ifftsize/2
	ifftdelay=iwinsize/sr

;for some reason the vectorial opcodes don't like to work with the whole table or a table of size power of two + 1
;so the last bins are ignored by now...
	ibinsToPort=ibins-2
	ibinsToCopy=ibins-1
	ibinsToMap=ibins-1

;make ftable to temporally store modulation amplitudes	
	ifnMod	ftgen	0, 0, 513, 10, 1
;point to a temporal table to store the mapping table
	ifnMapTemp=17
;********************

;the process itself, hardly 12 lines of code ;-)
;get FFT from carrier
	fCarrier pvsanal aCarrier,ifftsize,ioverlap,iwinsize,iwintype
;get FFT from modulator
	fModulator pvsanal aModulator,ifftsize,ioverlap,iwinsize,iwintype
;store amplitude bins
if (khold==1) kgoto noMod
	kflag	pvsftw 	fModulator, ifnMod 	; export  amps to table
noMod:
;apply smearing to modulator amplitudes
	vport	ifnMod, ksmear, ibinsToPort
;backup mapping function
	vcopy	ifnMapTemp, ifnMap, ibinsToCopy
;map channels
	vmap	ifnMap,ifnMod,ibinsToMap 
;read modified data back to fsrc
	pvsftr	fModulator, ifnMap
;restore mapping function
	vcopy	ifnMapTemp, ifnMap, ibinsToCopy
;vocodize carrier
	fVocodized pvsmaska fCarrier,ifnMod,kcross; apply vocoder
;resynthesize
	aSigOut pvsynth fVocodized ; and resynthesize
;prepare wet/dry mix
	aModulator delay aModulator,ifftdelay;compensate for the fft induced delay
	aout = kgain*(.5*(kmix*aSigOut+(1-kmix)*aModulator))
outs aout,aout

endin


</CsInstruments>
<CsScore>

f1 0 1024 10 1

;mapping tables are from 11 to 16 inc.:
;default mapping
;formant shift mapping (lowers a bit the lower bins up to 5kHz to have more "body")
;mapping to 32 bins
;mapping to 11 band in the vocal range (exponentially)
;random mapping but not too much...
;totally random mapping

f11 0 513   -23    "map1.txt"
f12 0 513   -23    "map2.txt"
f13 0 513   -23    "map3.txt"
f14 0 513   -23    "map4.txt"
f15 0 513   -23    "map5.txt"
f16 0 513   -23    "map6.txt"
f17 0 513 -10 1 ; temporal table

i1 0 100
f0 3600

e

</CsScore>
</CsoundSynthesizer>
