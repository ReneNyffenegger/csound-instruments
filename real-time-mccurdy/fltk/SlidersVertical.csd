;Written by Iain McCurdy, 2006
				
<CsoundSynthesizer>

<CsOptions>
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	2

	;'FLPANEL' CREATES A PANEL INTO WHICH WIDGETS CAN BE PLACED (NOTE PANEL CLOSING LINE FURTHER DOWN) 
;       OPCODE |      "LABEL"      | WIDTH | HEIGHT | X | Y
	FLpanel	"Vertical Sliders",   720,    630,   50, 50

;SLIDERS
;OUTPUT | O.P.HANDLE	OPCODE		"LABEL"                               | MIN | MAX | EXP | TYPE | DISPLAY_HANDLE | WIDTH | HEIGHT | POS_X | POS_Y
gkoutput, ihandle	FLslider	"Type 2 - Vertical Fill Slider",         20, 20000,  0,     2,        -1,           30,    500,     100,    50
gkoutput, ihandle	FLslider	"Type 4 - Vertical Engraved Slider",     20, 20000,  0,     4,        -1,           30,    500,     330,    50
gkoutput, ihandle	FLslider	"Type 6 - Vertical Nice Slider",         20, 20000,  0,     6,        -1,           30,    500,     560,    50
;gkoutput, ihandle	FLslider	"Type 8 = Vertical Up-Box Nice Slider",  20, 20000,  0,     8,        -1,           30,    500,     790,    50;NOT USED - DOESN'T SEEM TO BE IMPLEMENTED IN CSOUND5 

	;'OUTPUT' MUST BE A GLOBAL VARIABLE (G PREFIX) AND K-RATE (K PREFIX)
	;'O.P.HANDLE' OUTPUT HANDLE (USED FOR INITIALISING THE SLIDER)
	;'LABEL' IS A TEXT STRING THAT WILL BE DISPLAYED IMMEDIATELY BENEATH THE SLIDER
	;'MIN' MINIMUM VALUE OF SLIDER
	;'MAX' MAXIMUM VALUE OF SLIDER
	;'EXP' DEFINES BEHAVIOUR OF THE SLIDER: 0 = LINEAR
	;					-1 = EXPONENTIAL
	;ANY OTHER POSITIVE VALUES INDICATES THE NUMBER OF A FUNCTION TABLE TO WHICH THE SLIDER WILL BE RESCALED
	;'TYPE' GRAPHICAL APPEARANCE OF SLIDER:
	;	2 - a vertical fill slider
	;	4 - a vertical engraved slider
	;	6 - a vertical nice slider
	;	8 - a vertical up-box nice slider	;NOT USED - DOESN'T SEEM TO BE IMPLEMENTED IN CSOUND5 
	;'DISP_HANDLE' HANDLE USED FOR ANY WIDGET THAT DISPLAYS SLIDER VALUE. -1=NOT_USED
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