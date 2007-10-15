nchnls = 2

instr	2102	; pitch tracking harmonizer
a1, a0	ins	; get microphone input
a1	reson	a1, 0, 3000, 1	; and apply some EQ
w1	spectrum	a1, .02, 6, 24, 12, 1, 3	; form a spectral data type
Ê	; find the pitch
koct, kamp	specptrk	w1, 1, 6.5, 8.9, 7.5, 10, 7, .7, 0, 3, 1, .1
a2	delay	a1, .066	; time align pitch and audio
Ê	; add 4 new parts
a3	harmon	a2, koct, 1.25, .75, 1.5, 1.875, 0, 6.5
Ê	outs	a2, a3	; and send all 5 to output
Ê	endin
