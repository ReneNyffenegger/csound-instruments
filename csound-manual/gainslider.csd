<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    Silent
-odac           -idac     -d    ;;;realtime output
</CsOptions>
<CsInstruments>

sr	=	48000
ksmps	=	100
nchnls	=	2

/*--- ---*/

		instr	1	; gainslider test

; uncomment for realtime midi
;kmod	ctrl7	1, 1, 0, 127

; uncomment for non realtime
km0d phasor 1/10
kmod scale km0d, 127, 0

kout	gainslider	kmod

	printk2	kmod
	printk2	kout

aout	diskin	"soundfile.aiff", 1, 0, 1

aout	=	aout*kout

	outs	aout, aout

		endin

/*--- ---*/
</CsInstruments>
<CsScore>

i1	0	8888

e
</CsScore>
</CsoundSynthesizer>
