;--------------------------------------------------------
; Test score for rplpc instruments. 
; Note voiced/unvoiced transition begins at kerr=.001,
; as suggested by Eric Spjut. The best crossfade function
; seems to be the 1/4 cosine.
; RP
;--------------------------------------------------------
f1 0 8192 10 1
;cosine table for gbuzz
f2	0	8192	9	1	1	90
;linear xfade function
f3	0	129	7	1	129	0
;exponential xfade function
f4	0	129	5	1	129	.001
;1/4 cosine xfade function
f5	0	129	9	.25	1	90
;Use thewind.wav (44.1 KHz, 1.67 seconds long)
;Try various different settings in lpanal
;lp.100: 34 poles, hop 500, 100 Hz to 200 Hz
;nn	st	dur	cpsscl	iamp	lpstrt	lpend	lpc.nn	
i01	0	5	1	1	0	1.67	"wind1.lp"
;	xfadefn	ivoice	inoise
	5	.001	.025
;lp.101: 20 poles, hop 500, 100 Hz to 200 Hz
i01	+	.	.	.	.	.	"wind2.lp"
;lp.102: 32 poles, hop 300, 100 Hz to 200 Hz
i01	+	.	.	.	.	.	"wind3.lp"
;lp.103: 28 poles, hop 500, 150 Hz to 250 Hz
i01	+	.	.	.	.	.	"wind4.lp"
;lp.104: 24 poles, hop 500, 70 Hz to 200 Hz
i01	+	.	.	.9	.	.	"wind5.lp"
;lp.105: 26 poles, hop 500, 70 Hz to 200 Hz
i01	+	.	.	.	.	.	"wind6.lp"
;lp.106: 28 poles, hop 500, 70 Hz to 200 Hz
i01	+	.	.	.	.	.	"wind7.lp"
;lp.107: 26 poles, hop 500, 100 Hz to 200 Hz
i01	+	.	.	.	.	.	"wind8.lp"
;lp.111: 50 poles, hop 400, 100 Hz to 200 Hz
i01	+	.	.	.	.	.	"wind9.lp"
;lp.112: 50 poles, hop 500, 100 Hz to 200 Hz
i01	+	.	.	.	."wind10.lp"
s
;Try some cross synthesis
;soundin.123 = Small bit 'o Beethoven
;nn	st	dur	soundin	iamp	lpstrt	lpend	lpc.nn	
i02	0	3.645	123	1	0	1.67	"wind10.lp"	
;	xfadefn	ivoice	inoise
	5	1	1
s
;soundin.124 = Some glissing buzzes
;nn	st	dur	soundin	iamp	lpstrt	lpend	lpc.nn	
i02	0	2.685	124	.8	0	1.67	"wind10.lp"	
;	xfadefn	ivoice	inoise
	5	1	1
s
;soundin.125 = Buzz cluster swell chord
;nn	st	dur	soundin	iamp	lpstrt	lpend	lpc.nn	
i02	0	3.759	125	.8	0	1.67	"wind10.lp"	
;	xfadefn	ivoice	inoise
	5	1	1
e
