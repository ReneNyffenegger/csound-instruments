;Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	2

	;'FLPANEL' CREATES A PANEL INTO WHICH WIDGETS CAN BE PLACED (NOTE PANEL CLOSING LINE FURTHER DOWN) 
;       OPCODE |         "LABEL"          | WIDTH | HEIGHT | X | Y
	FLpanel	"HORIZONTAL SLIDER TYPES",   900,    450,   50, 50

;SLIDERS
;OUTPUT | O.P.HANDLE |    OPCODE       |    "LABEL"                                   | MIN | MAX | EXP | TYPE | DISPLAY_HANDLE | WIDTH | HEIGHT | POS_X | POS_Y
gkoutput,    ihandle      FLslider	     "Type 1 - Horizontal Fill Slider",         0,     1,    0,     1,        -1,        750,     30,     125,     50
gkoutput,    ihandle      FLslider	     "Type 3 - Horizontal Engraved Slider",     0,     1,    0,     3,        -1,        750,     30,     125,    150
gkoutput,    ihandle      FLslider	     "Type 5 - Horizontal 'Nice' Slider",       0,     1,    0,     5,        -1,        750,     30,     125,    250
;gkoutput,    ihhandle    FLslider	     "Type 7 - Horizontal Up-Box Nice Slider",  0,     1,    0,     7,        -1,        750,     30,     125,    350

	;'OUTPUT' MUST BE A GLOBAL VARIABLE (G PREFIX) AND K-RATE (K PREFIX)
	;'O.P.HANDLE' OUTPUT HANDLE (USED FOR INITIALISING THE SLIDER)
	;'LABEL' IS A TEXT STRING THAT WILL BE DISPLAYED IMMEDIATELY BENEATH THE SLIDER
	;'MIN' MINIMUM VALUE OF SLIDER
	;'MAX' MAXIMUM VALUE OF SLIDER
	;'EXP' DEFINES BEHAVIOUR OF THE SLIDER: 0 = LINEAR
	;					-1 = EXPONENTIAL
	;ANY OTHER POSITIVE VALUES INDICATES THE NUMBER OF A FUNCTION TABLE TO WHICH THE SLIDER WILL BE RESCALED
	;'TYPE' GRAPHICAL APPEARANCE OF SLIDER:
	;	1 - shows a horizontal fill slider 
	;	3 - a horizontal engraved slider 
	;	5 - a horizontal nice slider 
	;	7 - a horizontal up-box nice slider *NOT USED - DOESN'T SEEM TO BE IMPLEMENTED IN CSOUND 5*
	;'DISP_HANDLE' HANDLE USED FOR ANY WIDGET THAT DISPLAYS SLIDER VALUE -1=NOT USED
	;'WIDTH' WIDTH OF THE CREATED WIDGET IN PIXELS
	;'HEIGHT' HEIGHT OF THE CREATED WIDGET IN PIXELS
	;'POS_X' HORIZONTAL DISTANCE FROM THE LEFT EDGE OF THE PANEL IN PIXELS
	;'POS_Y' VERTICAL DISTANCE FROM THE TOP EDGE OF THE PANEL IN PIXELS

;	'FLpanel_end' CLOSES AN FLTK PANEL (see 'FLpanel' opcode above) 	
	FLpanel_end
	
;	'FLrun' opcode is needed in order to initiate the use of FLTK widgets
	FLrun

	instr 1		;A SIMPLE SINE WAVE INSTRUMENT
	endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>