;Written by Iain McCurdy, 2006 - based on an example written by Gabriel Maldonado

;This example demonstrates how to implement snapshots including how to store a bank of presets 
;to the hard drive for later retrieval.

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>


<CsInstruments>

sr			=	44100
kr			=	4410
ksmps			=	10
nchnls			=	1


			FLpanel	"Snapshots Demonstration", 800, 400, 50, 50

;SLIDERS
;THESE THREE SLIDER WILL BE USED TO SET THE FREQUENCIES OF THREE OSCILLATORS
;					            		MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkcps1,ihcps1		FLslider 	"Frequency Slider 1",	100,  8000, -1,    5,     -1,    275,    30,     10, 10
gkcps2,ihcps2		FLslider 	"Frequency Slider 2",	100,  8000, -1,    5,     -1,    275,    30,     10, 60
gkcps3,ihcps3		FLslider 	"Frequency Slider 3",	100,  8000, -1,    5,     -1,    275,    30,     10, 110

;BUTTON BANK
;THIS BANK OF NUMBERED BUTTONS WILL BE USED TO RETRIEVE PREVIOUSLY STORED SNAPSHOTS.
;			OPCODE 		TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkget, ih		FLbutBank	12,     4,      4,    170,    150,   300,  0,    0,    100,   0,   0

;BUTTONS
;THESE BUTTONS ARE USED FOR LOADING A SNAPSHOT BANK, SAVING A SNAPSHOT BANK, AND STORING A SNAPSHOT
;EACH OF THE THREE BUTTONS TRIGGERS A SCORE EVENT IN A DIFFERENT INSTRUMENT (SEE THE p1 TO p3 VALUES AT THE END OF EACH LINE)
;                                                	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y  | OPCODE (O MEANS 'NOTE EVENT' | INS | STARTTIM | IDUR
gkloadbank,ih		FLbutton	"Load Bank", 	0,    0,    11,    150,     40,   480, 0,       0,                         101,     0,        0
gksavebank,ih		FLbutton	"Save Bank", 	0,    0,    11,    150,     40,   480, 40,      0,                         102,     0,        0
gksavesnap,ih		FLbutton	"Save Snapshot",0,    0,    11,    150,     40,   480, 80,      0,                         103,     0,        0

;COUNTERS
;THIS COUNTER WILL BE USED TO SELECT THE SNAPSHOT NUMBER TO WHICH SLIDER SETTINGS WILL BE STORED IF "Save Snapshot" is clicked.
;								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE (-1 MEANS 'NO SCORE EVENT')
gkstore,ih	 	FLcount		"Snapshot Number",	0,     15,    1,      5,     21,    150,     30,     480,    120,     -1

;                                         			                                | itype | ifont | isize | iwidth | iheight | ix | iy
ihCC	 FLbox  "First move the three frequency sliders.                                     ",     1,      6,      14,     650,      20,     0,  180
ihCC	 FLbox  "Next select an snapshot number using the counter.                           ",     1,      6,      14,     650,      20,     0,  200
ihCC	 FLbox  "Click on 'Save Snapshot' to store the current slider settings.              ",     1,      6,      14,     650,      20,     0,  220
ihCC	 FLbox  "Move the sliders again and store further snapshots in the same way.         ",     1,      6,      14,     650,      20,     0,  240
ihCC	 FLbox  "Snapshots can be retrieved by selecting snapshot numbers in the button bank.",     1,      6,      14,     650,      20,     0,  260
ihCC	 FLbox  "To store a bank of snapshots for later retrieval click on 'Save Bank'.      ",     1,      6,      14,     650,      20,     0,  280
ihCC	 FLbox  "To restore a previously stored bank of snapshots click on 'Load Bank'.      ",     1,      6,      14,     650,      20,     0,  300

			FLpanel_end

			FLrun

			instr		1	; SCANS FOR I-RATE CHANGES
asig1			oscil		10000, gkcps1, 1	;THREE OSCILLATORS
asig2			oscil		10000, gkcps2, 1        ;THREE OSCILLATORS
asig3			oscil		10000, gkcps3, 1        ;THREE OSCILLATORS
			out		asig1+asig2+asig3	;SUM THE THREE OSCILLATORS
			endin
	
			instr		100		;RETRIEVE SNAPSHOT
inumsnap		FLgetsnap	i(gkget)	;VARIABLE gkget IS DEFINED BY THE VALUE OUTPUT BY THE BUTTON BANK
			endin

			instr		101		;LOAD SNAPSHOT BANK
			FLloadsnap	"SnapshotsDemonstration.snap"	;THE SNAPSHOT FILE "SnapshotsDemonstration.snap" STORED
			endin                                           ;IN THE 'Snapshots' FOLDER IN THE 'CsoundAV' PROGRAM FOLDER WILL BE LOADED        

			instr		102		;SAVE SNAPSHOT BANK
			FLsavesnap	"SnapshotsDemonstration.snap"	;ALL SNAPSHOTS WILL BE STORED THE FILE "SnapshotsDemonstration.snap"
			endin						;IN THE 'Snapshots' FOLDER IN THE 'CsoundAV' PROGRAM FOLDER

			instr		103		;STORE SNAPSHOT
inumsnap, inumval 	FLsetsnap	i(gkstore)	;gkstore IS THE DETERMINED BY THE FLTK COUNTER
			endin				;OUTPUT VARIABLES inumsnap AND inumval ARE NOT USED BUT MUST STILL BE PRESENT

</CsInstruments>


<CsScore>
f 1 0 4096 10 1	;A SINE WAVE
i 1 0 3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























