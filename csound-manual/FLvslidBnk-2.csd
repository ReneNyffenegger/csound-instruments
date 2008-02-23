<CsoundSynthesizer>
<CsOptions>



</CsOptions>
<CsInstruments>

sr	=	44100
ksmps	=	100
nchnls	=	1

giElem	init	20
giOutTab	ftgen	1,0,128, 2, 	0
giFreqTab	ftgen	2,0,128,-7, 	1,giElem, giElem+1
giSine	ftgen	3,0,256,10,	1

	FLpanel	"This Panel contains a Vertical Slider Bank",400,400
	FLvslidBnk  " ", giElem, giOutTab
        ; use a blank space " " for vertical slider label to obtain numbers
	FLpanel_end

	FLrun

	instr 1
a1	adsynt2	10000, 120, giSine, giFreqTab, giOutTab, giElem
	out	a1
	endin


</CsInstruments>
<CsScore>

i1 0 3600
f0 3600

</CsScore>
</CsoundSynthesizer>
