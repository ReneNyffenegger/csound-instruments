; realtime audio in granular control
; requires midi sliderbank from DAN (guitargr.lso)
; runs with directcsound v. 3.x
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<CsoundSynthesiser>
<CsOptions>
;enables sound in/out
 -b882 -odevaudio -idevaudio -m3 -t60 -+K

</CsOptions>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<CsInstruments>

	sr=44100
	kr=441
	ksmps = 100 
	nchnls = 2	


massign	1, 1

ginorm=0.0078125
giamp=1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr	1

ico=10; cutoff freq of filter for sliders

gktrans, gkbw, gkpoint1, gkpoint2, gkgdur, gkdens, gkenv, gkcps	slider8f	1, \
					1, 0.25, 4, 1, 0, ico,\
					2, 0, 16, 10, 0, ico,\
					3, 0, 1, 0, 0, ico,\
					4, 0, 1, 0, 0, ico,\
					5, .01, .1, .01, 0, ico,\
					6, 1, 254, 127, 0, ico,\
					7, 0, .5, .25, 0, ico,\
					8, .001, 1, 1, 0, ico
	
printk2	gkcps
endin


instr	2

ifn=5

kris=gkenv*gkgdur

kdec=(.5-gkenv)*gkgdur

ap	phasor	gkcps
apoint=(gkpoint1)+ap


asig	fog	giamp, gkdens, gktrans, apoint, 0, gkbw, kris, gkgdur, kdec, 200, ifn, 3, p3

outs     asig*gkpoint1, asig*gkpoint2
endin

instr	3

ifn=5

kris=gkenv*gkgdur

kdec=(.5-gkenv)*gkgdur

ap	phasor	gkcps
apoint=(gkpoint2)+ap


asig	fog	giamp, 254-gkdens, 4-gktrans, apoint, 0, 16-gkbw, kris, gkgdur, kdec, 200, ifn, 3, p3

outs     asig*gkpoint1, asig*gkpoint2
endin


instr	4
ifn=5

ilength	tableng	ifn
asig, asig1	ins

;WRITING AUDIO TO TABLE
and	phasor	1/(ilength/sr)
andex=and*ilength
tablew	asig, andex, ifn, 0, 0, 1

endin

</CsInstruments>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<CsScore>

f0 60000	; allows realtime midi playing for 60000 seconds


f2	0	2048	20	5; grain envelope
f3	0	2048	19	.5	1	270	1
; curve for testing slider conversion (???)
;f4	0	128	27	0	0	127	1
f5	0	1048576	-10	1


i1	0	60000
i2	0	6000
i3	0	6000
i4	0	6000
e





</CsScore>
</CsoundSynthesiser>
