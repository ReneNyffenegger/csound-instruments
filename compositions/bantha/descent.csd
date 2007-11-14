<CsoundSynthesizer>

<CsOptions>
-W -d -o c:\csound\waves\descent.wav
</CsOptions>

<CsInstruments>
sr = 44100
kr = 441
ksmps = 100
nchnls = 2
ga1 init 0
ga2 init 0

instr 1
ifq = (.0594*p4+1)*880	;a mistake in tuning that produced interesting results
iamp = p5
ipan = p6
anoise	rand		1000, .5, 1
a1		butterbp	anoise, ifq, .03*ifq
a2		butterbp	anoise, ifq*2, .03*ifq*2
a3		butterbp	anoise, ifq*3, .03*ifq*3
ii = 0
loop:
ii = ii+1
a1		butterbp	a1, ifq, .03*ifq
a1		balance		a1, anoise
a2		butterbp	a2, ifq*2, .03*ifq*2
a2		balance		a2, anoise
a3		butterbp	a3, ifq*3, .03*ifq*3
a3		balance		a3, anoise
if ii < 20 goto loop
kenv	oscil1i		0, 1, p3, 4
a4 = ((a1 + a2*.8 + a3*.65)/2675)*iamp*kenv
ilt		tablei		(1 - ipan), 100, 1
irt		tablei		ipan, 100, 1
		outs 		a4*ilt, a4*irt
ga1 = ga1 + a4*ilt
ga2 = ga2 + a4*irt
endin

instr 2
idur = p3
iamp   =  p4
ifq    =  p5
icycle =  p6

kphase  phasor  1/icycle     ; speed at which tables are scanned
kenvlp  linen   iamp, 15, idur, 15
kamp1   table   kphase,71,1,0,1
kcps1   tablei  kphase,51,1,0,1
asig1   oscili  kamp1,kcps1*ifq,10
kamp2   table   kphase+.1,71,1,0,1
kcps2   tablei  kphase+.1,51,1,0,1
asig2   oscili  kamp2,kcps2*ifq,10
kamp3   table   kphase+.2,71,1,0,1
kcps3   tablei  kphase+.2,51,1,0,1
asig3   oscili  kamp3,kcps3*ifq,10
kamp4   table   kphase+.3,71,1,0,1
kcps4   tablei  kphase+.3,51,1,0,1
asig4   oscili  kamp4,kcps4*ifq,10
kamp5   table   kphase+.4,71,1,0,1
kcps5   tablei  kphase+.4,51,1,0,1
asig5   oscili  kamp5,kcps5*ifq,10
kamp6   table   kphase+.5,71,1,0,1
kcps6   tablei  kphase+.5,51,1,0,1
asig6   oscili  kamp6,kcps6*ifq,10
kamp7   table   kphase+.6,71,1,0,1
kcps7   tablei  kphase+.6,51,1,0,1
asig7   oscili  kamp7,kcps7*ifq,10
kamp8   table   kphase+.7,71,1,0,1
kcps8   tablei  kphase+.7,51,1,0,1
asig8   oscili  kamp8,kcps8*ifq,10
kamp9   table   kphase+.8,71,1,0,1
kcps9   tablei  kphase+.8,51,1,0,1
asig9   oscili  kamp9,kcps9*ifq,10
kamp10  table   kphase+.9,71,1,0,1
kcps10  tablei  kphase+.9,51,1,0,1
asig10  oscili  kamp10,kcps10*ifq,10
asig11  oscili	kenvlp*3, 55, 10
asum =  asig1+asig2+asig3+asig4+asig5+asig6+asig7+asig8+asig9+asig10 
		outs	asum*kenvlp+asig11,asum*kenvlp+asig11
ga1 = ga1 + asum*kenvlp
ga2 = ga2 + asum*kenvlp
endin

instr 3
iamp = p4
ifq = cpspch(p5)
ipan = p6
kvib	oscil	15, 5, 10
a1		pluck	iamp, ifq+kvib, ifq, 10, 1
a2		reverb	a1, 2
ilt		tablei	(1 - ipan), 100, 1
irt		tablei	ipan, 100, 1
		outs	a2*ilt, a2*irt
endin

instr 99
alt		reverb2	ga1*.2+ga2*.08, p4, .3
art		reverb2	ga1*.08+ga2*.2, p4, .3
		outs	alt, art
ga1 = 0
ga2 = 0
endin
</CsInstruments>

<CsScore>
f4 0 8193 20 4
f10 0 8192 10 1
f51 0 8193 5 1 8192 .0001
f71 0 8193 20 6
f100  0.0  8193 9 .25 1.0  0.0

;      pchdev
i1 0 64  7 10000 .5
i1 + 40  5 . .
i1 + 24 -2 . .
i1 + 16 -2 . .
i1 +  8  4 . .
i1 + 40 -3 . .
i1 +  8 -3 . .
i1 + 16 -5 . .
i1 + 24 -8 . .
i1 +  8 -1 . .
i1 + 16 -8 . .
i1 +  8 -1 . .
i1 +  8 -9 . .
i1 +  8 -4 . .
i1 + 16 -1 . .
i1 + 24 -4 . .
i1 + 40 -5 . .
i1 + 24 -12 . .
i1 + 16 -12 . .
i1 + 16 -2 . .
i1 + 16 -5 . .

i1 24 40 0 10000 0
i1 + 16 0 . .
i1 + 24 0 . .
i1 + 40 -4 . .
i1 +  8 -5 . .
i1 +  8 -4 . .
i1 + 40  5 . .
i1 +  8 -7 . .
i1 + 16 -6 . .
i1 + 24 -7 . .
i1 + 16  2 . .
i1 +  8 -11 . .
i1 +  8 -2 . .
i1 + 40 -11 . .
i1 +  8 -12 . .
i1 + 16 -14 . .
i1 + 24 -12 . .
i1 + 24 -15 . .
i1 + 16 0 . .
i1 + 16 0 . .
i1 + 24 0 . .

i1 24 40 -2 10000 1
i1 + 16 -1 . .
i1 + 40 8 . .
i1 + 24 5 . .
i1 + 40 -3 . .
i1 + 24 2 . .
i1 + 8 -5 . .
i1 + 16 2 . .
i1 + 8 1 . .
i1 + 16 -6 . .
i1 + 8 -6 . .
i1 + 8 -8 . .
i1 + 8 -12 . .
i1 + 16 -9 . .
i1 + 40 -9 . .
i1 + 8 -11 . .
i1 + 8 -14 . .
i1 + 24 -7 . .
i1 + 24 -14 . .
i1 + 16 -16 . .
i1 + 32 -14 . .

;      idur   iamp  ifq  icycle time
i2  80  280    1700  12000  300

i3  88 4 4150 11.09 .45
i3 136 . 3250 11.08 .55
i3 160 . 3000 11.07 .02
i3 200 . 4250 11.06 .30
i3 232 .    . 11.05 .54
i3 248 . 3600 11.04 .63
i3 264 . 4000 11.03 .92
i3 272 .    . 11.02 .67
i3 288 . 3000 11.01 .79
i3 296 . 3250 11.00 .55
i3 312 .    . 10.11 .33
i3 336 . 2500 10.10 .21
i3 360 . 2800 10.09 .62
i3 392 . 1750  9.09 .12
i3 408 . 1500  9.09 .31
i3 424 . 1000  9.09 .50

i99 0 450 2
e
</CsScore>

</CsoundSynthesizer>
