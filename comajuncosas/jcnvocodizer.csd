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
nchnls  =       1


	instr 1
;********************
;audio interface
;load carrier
	aCarrier	buzz 8000,110,190,1;rand 10000;in ; live source
;load modulator
	aModulator	soundin "djembe.wav";in ; live source
;********************

;********************
;control interface
ifnMap= 12; mapping table from 11 to 16
ksmear linseg 0,p3/2,0,p3/2,.1                  ; portamento applied to amplitudes from 0 to about 0.1
kcross	linseg	    0,p3/3,.1,p3/3,.05,p3/3,.05 ; vocoder depth : 0 only carrier, 1 carrier fully modulated
kmix linseg 0,p3,1                              ; dry/wet mix: 0 only dry modulator, 1 only vocoded carrier
khold linseg 0,p3/3,0,p3/3,1,p3/3,1             ; when khold=1 the modulator is freezed (an on/off control)
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

;the process itself, hardly a dozen lines of code ;-)
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
	aout = .5*(kmix*aSigOut+(1-kmix)*aModulator)
out aout

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

i1 0 10
f0 3600

e

</CsScore>
</CsoundSynthesizer>
