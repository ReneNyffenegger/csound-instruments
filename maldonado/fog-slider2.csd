; realtime audio in granular control
; version for GUI interface
; runs with directcsound v. 3.10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<CsoundSynthesiser>
<CsOptions>
;enables sound in/out
-odevaudio -idevaudio 

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
FLpanel	"fog control", 850, 550, 10, 10

gktrans, i1	FLslider	"trans", .25, 4, 0, 2, -1, 50, 500, 5, 5
gkbw, i2	FLslider	"bwidth", 0, 16, 0, 2, -1, 50, 500, 55, 5
gkpoint1, gkpoint2, i3, i4	FLjoy	"points", 0, 1, 0, 1, 0, 0, -1, -1, 400, 400, 405, 5
;gkpoint1, i3	FLslider	"point1", 0, 1, 0, 2, -1, 50, 500, 105, 5
;gkpoint2, i4	FLslider	"point2", 0, 1, 0, 2, -1, 50, 500, 155, 5
gkgdur, i5	FLslider	"dur", .01, .1, 0, 2, -1, 50, 500, 205, 5
gkdens, i6	FLslider	"dens", 1, 254, 0, 2, -1, 50, 500, 255, 5
gkenv, i7	FLslider	"env", 0, .5, 0, 2, -1, 50, 500, 305, 5
gkcps, i8 	FLslider	"cps", .001, 3, 0, 2, -1, 50, 500, 355, 5

FLpanel_end

FLrun
gktrans	init	.25
gkbw	init	0
gkpoint1	init	0
gkpoint2	init	0
gkgdur	init	.01
gkdens	init	1
gkenv	init	0
gkcps	init	.001
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr	1


;printk2	gkcps
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

f5	0	1048576	-10	1


;i1	0	60000
i2	0	6000
i3	0	6000
i4	0	6000
e





</CsScore>
</CsoundSynthesiser>
