<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    Silent
-odac           -idac     -d    ;;;realtime output</CsOptions>
<CsInstruments>

sr	=	48000
ksmps	=	100
nchnls	=	2

/*--- ---*/

		instr	1	; logcurve test

kmod	phasor	1/200

kout	logcurve kmod, 2

	printk2	kmod
	printk2	kout

		endin

/*--- ---*/
</CsInstruments>
<CsScore>

i1	0	8888

e
</CsScore>
</CsoundSynthesizer>
