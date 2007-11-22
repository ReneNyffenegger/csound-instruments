;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
</CsOptions>

<CsInstruments>

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2

		FLpanel	"Text Box",700,400,50,50
itype		=	7	;BOX BORDER TYPE (7=EMBOSSED BOX)
ifont		=	10	;FONT TYPE (10='TIMES BOLD')
isize		=	20	;FONT SIZE
iwidth		=	400	;WIDTH OF THE FL BOX
iheight		=	30	;HEIGHT OF THE FL BOX
ix		=	150	;DISTANCE OF THE LEFT EDGE OF THE FL BOX FROM THE LEFT EDGE OF THE PANEL
iy		=	100	;DISTANCE OF THE UPPER EDGE OF THE FL BOX FROM THE UPPER EDGE OF THE PANEL
ih3	 FLbox  "Use Text Boxes For Labelling", itype, ifont, isize, iwidth, iheight, ix, iy
		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD!

		instr	1
		endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>