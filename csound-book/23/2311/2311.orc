sr	=	44100
kr	=	44100
ksmps	=	1	; NEEDED FOR SMOOTH DELAY TIME INTERPOLATION
nchnls	=	2

gifeed	=	.5
gilp1	=	1/10
gilp2	=	1/23
gilp3	=	1/41
giroll	=	3000
gadrysig	init	0

	instr	2307	; SCALABLE GLOBAL SEND LEVELS
idryamt	=	1-p4
iwetamt	=	p4
asndfile	soundin	"hellorcb.aif", 0
gadrysig	=	gadrysig+asndfile*iwetamt
	outs	asndfile*idryamt, asndfile*idryamt
	endin

	instr	2311	; 2 PARALLEL ALLPASS FILTERS W/ RANDOM DELAY TIMES
atmp	alpass	gadrysig, 1.7, .1
aleft	alpass	atmp, 1.01, .07
atmp	alpass	gadrysig, 1.5, .2
aright	alpass	atmp, 1.33, .05
kdel1	randi	.01, 1, .666
kdel1	=	kdel1+.1
addl1	delayr	.3
afeed1	deltapi	kdel1
afeed1	=	afeed1+gifeed*aleft
	delayw	aleft
kdel2	randi	.01,. 95, .777
kdel2	=	kdel2+.1
addl2	delayr	.3
afeed2	deltapi	kdel2
afeed2	=	afeed2+gifeed*aright
	delayw	aright
	outs	aleft, aright
gadrysig	=	0
	endin
