;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

;A SINE WITH OSCILLATOR WITH FL-SLIDER CONTROLLED FREQUENCY

sr		=		44100
kr		=		441
ksmps		=		100
nchnls		=		2

		OPCODE	LABEL              | WIDTH | HEIGHT | X | Y
		FLpanel	"Frequency Slider",   900,    400,   50,  50

imin		=		200	;MINIMUM VALUE OUTPUT BY THE SLIDER
imax		=		5000	;MAXIMUM VALUE OUTPUT BY THE SLIDER
iexp		=		-1	;LOGARITHMIC TYPE SLIDER SELECTED
itype		=		5	;SLIDER GRAPHIC TYPE (5='NICE' SLIDER)
idisp		=		-1	;DISPLAY HANDLE (-1=NOT USED)
iwidth		=		700	;WIDTH OF THE SLIDER IN PIXELS
iheight		=		30	;HEIGHT OF THE SLIDER IN PIXELS
ix		=		100	;DISTANCE OF THE LEFT EDGE OF THE SLIDER FROM THE LEFT EDGE OF THE PANEL
iy		=		50	;DISTANCE OF THE TOP EDGE OF THE SLIDER FROM THE TOP EDGE OF THE PANEL
gkfreq, ihandle	FLslider	"Frequency", imin, imax, iexp, itype, idisp, iwidth, iheight, ix, iy

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD

		instr 		1
iamp		=		15000
ifn		=		1
;OUTPUT		OPCODE		AMPLITUDE | FREQUENCY | FUNCTION_TABLE
asig		oscili		iamp,         gkfreq,       ifn
		outs		asig, asig
		endin

</CsInstruments>

<CsScore>
f 1 0 129 10 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>