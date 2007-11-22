;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
</CsOptions>

<CsInstruments>

;USING THE OPCODE FLsetColor TO CHANGE FROM THE DEFAULT COLOURS FOR WIDGETS

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2

		FLpanel	"Coloured Sliders", 900, 360, 50, 50

gkfrq1,ihandle1	FLslider	"A Red Slider", 200, 5000, -1, 3, -1, 750, 30, 85, 50
ired1		=	255
igreen1		=	0
iblue1		=	0
		FLsetColor   ired1, igreen1, iblue1, ihandle1

gkfrq2,ihandle2	FLslider	"A Green Slider", 200, 5000, -1, 3, -1, 750, 30, 85, 150
ired2		=	0
igreen2		=	255
iblue2		=	0
		FLsetColor   ired2, igreen2, iblue2, ihandle2

gkfrq3,ihandle3	FLslider	"A Blue Slider", 200, 5000, -1, 3, -1, 750, 30, 85, 250
ired3		=	0
igreen3		=	0
iblue3		=	255
		FLsetColor   ired3, igreen3, iblue3, ihandle3

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD!

		instr 1
		endin	
</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT
</CsScore>

</CsoundSynthesizer>