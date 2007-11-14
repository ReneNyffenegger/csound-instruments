<CsoundSynthesizer>

<CsOptions>
-W -d -odevaudio
</CsOptions>

<CsInstruments>
sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

instr 1

anoise	rand		9000, .5, 1

kenv	linseg		0, .08, 1, p3-.16, 1, .08, 0		

kl		line		p4-400, p3, p5-400
ku		line		p6-400, p3, p7-400
kband = ku - kl
kfrq = (kband/2) + kl

a1		butterbp	anoise, kfrq, kband
ii = 0
loop:
ii = ii+1
a1		butterbp	a1, kfrq, kband
a1		balance		a1, anoise
if ii < 100 goto loop

		outs		a1*kenv, a1*kenv
endin
</CsInstruments>

<CsScore>
t 0 150
i1 0 15 1000 1000 1010 1010
i1 + 30 1000  500 1010 2000
i1 + 25 2000 2000 2010 2010
i1 +  5  500  500 2000 2000
i1 + 30  750  750  760  760
i1 + 30  750  500  760 1000
i1 + 30  500  500  510  510
i1 + 60  500  500  510 1500
i1 + 30 1500 1500 1510 1510
i1 + 25 1500 1500 1510 1750
i1 +  5 1500  500 1510  510
i1 + 30  500  500  510  750
i1 + 45  500 2000  510 2010
i1 + 15 2000 2000 2010 2010
i1 + 90  750 2000 3000 2010
i1 + 25 2000 2000 2010 2010
i1 + 10  500  500 4000 4000
i1 + 10 2500 2500 2510 2510
i1 + 10  500  500 4000 4000
i1 + 10 1000 1000 1010 1010
i1 + 10  500  500 4000 4000
i1 + 15 2000 2000 2010 2010
i1 + 90 1000 1500 3000 1510
i1 + 30 1500 1500 1510 1510
i1 + 60 1250 1250 2000 1260
i1 + 45 1250 1750 1260 1760
i1 + 60 1750  400 1760 5000
i1 75 60 1500 1500 1510 1510
i1 + 30 1500 1000 1510 1750
i1 225 60 500 500 510 510
i1 540 105 750 750 760 760
i1 + 30 750 500 760 1000
e
</CsScore>

</CsoundSynthesizer>
