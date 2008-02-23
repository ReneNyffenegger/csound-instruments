<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc       -M0 ;;;RT audio I/O with MIDI in
</CsOptions>
<CsInstruments>
sr=44100
ksmps=100
nchnls=2

;Example by Gabriel Maldonado

massign	1, 10
gitabAscii	ftgen	30,0,512, -2, 0

giElem		init	30
gkvel		init 	1
giSine		ftgen	10,0,4096, 10, 1
giOutTab		ftgen	1,0,256, -2,   0
giOutTab2		ftgen	20,0,256, -2,   0
giMinMaxTab	ftgen	2,0,256, -2,   	0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, \
					0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, \
					0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, \
					0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1, 0,1

giExpTab		ftgen	3,0,128, -2,	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 \
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 \
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 \
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 \
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 

giFreqTab		ftgen	4,0,128, -7,   1,giElem,giElem+1
;................................................................
	FLpanel	"This Panel contains a Slider Bank",400,400, 0,100
FLsetSnapGroup 1
gkPitch,ih1 FLslider	"Base pitch", 1, 5000, -1, 1, -1,  300, 20, 50, 10  ; <--- saved on snap group 1

	FLscroll	400, 350, 0, 50
	FLcolor	-2
FLsetSnapGroup 0
	FLslidBnk	" ", giElem, giOutTab , 300 , giElem*20, 50, 10,  -12 , giExpTab, 0, giMinMaxTab  
	FLcolor	-1
	FLscroll_end
	FLpanel_end
;................................................................
	FLpanel	"Snapshots", 400, 500, 430, 100

ihx1	FLbox	"STORE AND RETREIVE SNAPSHOTS",1,1,14,360,20,20,55
	FLsetTextSize	35, ihx1
	FLsetTextColor 150,150,150,ihx1
	FLsetTextType 5,ihx1
	FLsetFont 2,ihx1
gk9,ih	FLbutton	"Store snapshot to current index",  3,0, 11,150,40,200,140,    0,7,0,0 
gk9,ih	FLbutton	"Save snapshot bank to disk",   1,0, 11,130,40,200,210,    0,5,0,0
gk9,ih	FLbutton	"Load snapshot bank from disk", 1,0, 11,  150,40, 20, 210,    0,6,0,0
gkSnapGroup,ih FLcount	"snapshot GROUP", 0,1, 1,  1,  2, 150,40, 20, 140, -1
gkGet,ih	FLbutBank	12, 8,8,       360,180, 20,260,    0,7,0,0
ihx2	FLbox	"This button bank allows to store/retrieve snapshots,according to the position of the <ctrl> key (key down = store, key up = retrieve)",1,1,14,360,20,20,180+270
	FLsetFont 4,ihx2
	FLsetTextType 5,ihx2

	FLpanel_end
;................................................................

	FLrun
FLsetVal_i	60, ih1	
	tb0_init	giOutTab

;///////////////////////////
	instr	1
;///////////////////////////
	vcopy	giOutTab2, giOutTab, giElem
	vport	giOutTab2, .1, giElem
kpitch	tonek	gkPitch, 20
kpitch2	oscili	1, 5, giSine
kpitch	=	kpitch * semitone(kpitch2 *.2)
kvel	tonek	gkvel, 20
a1	adsynt2	3000*kvel, kpitch, giSine, giFreqTab, giOutTab2, giElem
	outs	a1,a1

ad1	init	0
ad2	init	0

ad1 	delay	a1+ad2*.7, .2
ad2	delay	a1+ad1*.7, .41

	outs	ad1*.3, ad2*.3

gkascii	FLkeyIn	gitabAscii
gkasc2	tab	483,gitabAscii
printk2 gkascii
printk2 gkasc2,10 

	endin

	instr	5
	FLsavesnap	"SliderBankMIDI_snap.txt"

	endin

	instr	6
	FLloadsnap	"SliderBankMIDI_snap.txt"
	endin


	instr	7
;if i(gkCheck) == 0 goto then
if i(gkasc2) == 0 goto then
	inumsnap,	inumval FLsetsnap	i(gkGet),0,i(gkSnapGroup)
	goto endif
then:
	inumel	FLgetsnap	i(gkGet),i(gkSnapGroup)
endif:
	endin

	instr 10 
inum 	notnum
ivel 	ampmidi 	2
gkvel 	init 	ivel
isnap 	= 	inum - 48
isnap	limit	isnap,0, 25
inumel	FLgetsnap isnap,i(gkSnapGroup)
	endin

</CsInstruments>
<CsScore>

i1 0 3600
f0 3600

</CsScore>
</CsoundSynthesizer>
