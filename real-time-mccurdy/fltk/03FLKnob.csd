;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

;A SINE WITH OSCILLATOR WITH FL-KNOB CONTROLLED FREQUENCY

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2

;		OPCODE	LABEL              | WIDTH | HEIGHT | X | Y
		FLpanel	"Frequency Knob", 900, 400, 50, 50

imin		=	200	;MINIMUM VALUE OUTPUT BY THE KNOB
imax		=	5000	;MAXIMUM VALUE OUTPUT BY THE KNOB
iexp		=	-1	;LOGARITHMIC TYPE KNOB SELECTED
itype		=	1	;KNOB GRAPHIC TYPE (1=3D KNOB)
idisp		=	-1	;DISPLAY HANDLE (-1=NOT USED)
iwidth		=	70	;WIDTH OF THE KNOB IN PIXELS
iheight		=	70	;HEIGHT OF THE KNOB IN PIXELS
ix		=	125	;DISTANCE OF THE LEFT EDGE OF THE KNOB FROM THE LEFT EDGE OF THE PANEL
iy		=	50	;DISTANCE OF THE TOP EDGE OF THE KNOB FROM THE TOP EDGE OF THE PANEL
gkfreq, ihandle	FLknob	"Frequency", imin, imax, iexp, itype, idisp, iwidth, iheight, ix, iy

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD

		instr 	1
iamp		=	15000
ifn		=	1
;OUTPUT		OPCODE	AMPLITUDE | FREQUENCY | FUNCTION_TABLE
asig		oscili	iamp,        gkfreq,        ifn
		outs	asig, asig
		endin

</CsInstruments>

<CsScore>
f 1 0 129 10 1	;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>