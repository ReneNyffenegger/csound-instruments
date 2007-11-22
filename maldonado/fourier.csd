<CsoundSynthesizer>
<CsOptions>

</CsOptions>
<CsInstruments>
sr=44100
kr=441
ksmps=100
nchnls=1


	FLpanel	"Fourier synthesis",300,510
gkvol,gihvol	FLslider	"Volume", 0,10,0,5, -1, 200,20, 30,20
gkfreq,gihfreq	FLslider	"Frequency", 80,2000,-1,15, -1, 200, 20, 30,60
;          FLpack       280,300,10,120

gk1,gih1		FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,100
gk2,gih2		FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,115
gk3,gih3		FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,130
gk4,gih4		FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,145
gk5,gih5		FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,160
gk6,gih6		FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,175
gk7,gih7		FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,190
gk8,gih8		FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,205
gk9,gih9	 	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,220
gk10,gih10	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,235
gk11,gih11	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,250
gk12,gih12	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,265
gk13,gih13	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,280
gk14,gih14	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,295
gk15,gih15	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,310
gk16,gih16	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,325
gk17,gih17	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,340
gk18,gih18	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,355
gk19,gih19	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,370
gk20,gih20 	FLslider	" ", -1000,1000,0,15, -1, 200,10, 30,385
;	FLpack_end 

gkbut,gihb1	FLbutton		"Sine",1,1,1,40,25,30,400, 0,11,0,0
gkbut,gihb2	FLbutton		"Rect",2,2,1,40,25,80,400, 0,12,0,0
gkbut,gihb3	FLbutton		"Saw",3,3,1,40,25,130,400, 0,13,0,0
gkbut,gihb4	FLbutton		"Tri",4,4,1,40,25,180,400, 0,14,0,0

gklo,gihlo 	FLslider	"LoPass",0,21,0,5, -1, 200,10, 30,430
gkhi,gihhi	FLslider	"HiPass", 0,21,0,5, -1, 200,10, 30,455
gkov,gihov	FLslider	"Overtones", 0,1000,0,5, -1, 200,10, 30,480





	FLpanel_end
	FLsetVal_i	1000,gih1
	FLsetVal_i	0,gih2
	FLsetVal_i	333,gih3
	FLsetVal_i	0,gih4
	FLsetVal_i	200,gih5
	FLsetVal_i	0,gih6
	FLsetVal_i	143,gih7
	FLsetVal_i	0,gih8
	FLsetVal_i	111,gih9
	FLsetVal_i	0,gih10
	FLsetVal_i	91,gih11
	FLsetVal_i	0,gih12
	FLsetVal_i	77,gih13
	FLsetVal_i	0,gih14
	FLsetVal_i	66,gih15
	FLsetVal_i	0,gih16
	FLsetVal_i	59,gih17
	FLsetVal_i	0,gih18
	FLsetVal_i	52,gih19
	FLsetVal_i	0,gih20
	FLsetVal_i	5,gihvol
	FLsetVal_i	264,gihfreq
	FLsetVal_i	0,gihhi
	FLsetVal_i	21,gihlo
	FLsetVal_i	1000,gihov




	FLrun

	instr 1
a1	oscili	gk1, gkfreq, 1
a2	oscili	gk2, 2*gkfreq, 1
a3	oscili	gk3, 3*gkfreq, 1
a4	oscili	gk4, 4*gkfreq, 1
a5	oscili	gk5, 5*gkfreq, 1
a6	oscili	gk6, 6*gkfreq, 1
a7	oscili	gk7, 7*gkfreq, 1
a8	oscili	gk8, 8*gkfreq, 1
a9	oscili	gk9, 9*gkfreq, 1
a10	oscili	gk10, 10*gkfreq, 1
a11	oscili	gk11, 11*gkfreq, 1
a12	oscili	gk12, 12*gkfreq, 1
a13	oscili	gk13, 13*gkfreq, 1
a14	oscili	gk14, 14*gkfreq, 1
a15	oscili	gk15, 15*gkfreq, 1
a16	oscili	gk16, 16*gkfreq, 1
a17	oscili	gk17, 17*gkfreq, 1
a18	oscili	gk18, 18*gkfreq, 1
a19	oscili	gk19, 19*gkfreq, 1
a20	oscili	gk12, 20*gkfreq, 1
af1	=	a1*(1<gkhi?0:1)*(gklo<1?0:1)
af2	=	a2*(2<gkhi?0:1)*(gklo<2?0:1)
af3	=	a3*(3<gkhi?0:1)*(gklo<3?0:1)
af4	=	a4*(4<gkhi?0:1)*(gklo<4?0:1)
af5	=	a5*(5<gkhi?0:1)*(gklo<5?0:1)
af6	=	a6*(6<gkhi?0:1)*(gklo<6?0:1)
af7	=	a7*(7<gkhi?0:1)*(gklo<7?0:1)
af8	=	a8*(8<gkhi?0:1)*(gklo<8?0:1)
af9	=	a9*(9<gkhi?0:1)*(gklo<9?0:1)
af10	=	a10*(10<gkhi?0:1)*(gklo<10?0:1)
af11	=	a11*(11<gkhi?0:1)*(gklo<11?0:1)
af12	=	a12*(12<gkhi?0:1)*(gklo<12?0:1)
af13	=	a13*(13<gkhi?0:1)*(gklo<13?0:1)
af14	=	a14*(14<gkhi?0:1)*(gklo<14?0:1)
af15	=	a15*(15<gkhi?0:1)*(gklo<15?0:1)
af16	=	a16*(16<gkhi?0:1)*(gklo<16?0:1)
af17	=	a17*(17<gkhi?0:1)*(gklo<17?0:1)
af18	=	a18*(18<gkhi?0:1)*(gklo<18?0:1)
af19	=	a19*(19<gkhi?0:1)*(gklo<19?0:1)
af20	=	a20*(20<gkhi?0:1)*(gklo<20?0:1)
aout2	= 	af2+af3+af4+af5+af6+af7+af8+af9+af10+af11+af12+af13+af14+af15+af16+af17+af18+af19+af20
aout	=	af1 + aout2*gkov/1000
	out	gkvol*aout
	endin	

              instr   11
	FLsetVal_i	1000,gih1
	FLsetVal_i	0,gih2
	FLsetVal_i	0,gih3
	FLsetVal_i	0,gih4
	FLsetVal_i	0,gih5
	FLsetVal_i	0,gih6
	FLsetVal_i	0,gih7
	FLsetVal_i	0,gih8
	FLsetVal_i	0,gih9
	FLsetVal_i	0,gih10
	FLsetVal_i	0,gih11
	FLsetVal_i	0,gih12
	FLsetVal_i	0,gih13
	FLsetVal_i	0,gih14
	FLsetVal_i	0,gih15
	FLsetVal_i	0,gih16
	FLsetVal_i	0,gih17
	FLsetVal_i	0,gih18
	FLsetVal_i	0,gih19
	FLsetVal_i	0,gih20
              endin


              instr   12
	FLsetVal_i	1000,gih1
	FLsetVal_i	0,gih2
	FLsetVal_i	333,gih3
	FLsetVal_i	0,gih4
	FLsetVal_i	200,gih5
	FLsetVal_i	0,gih6
	FLsetVal_i	143,gih7
	FLsetVal_i	0,gih8
	FLsetVal_i	111,gih9
	FLsetVal_i	0,gih10
	FLsetVal_i	91,gih11
	FLsetVal_i	0,gih12
	FLsetVal_i	77,gih13
	FLsetVal_i	0,gih14
	FLsetVal_i	66,gih15
	FLsetVal_i	0,gih16
	FLsetVal_i	59,gih17
	FLsetVal_i	0,gih18
	FLsetVal_i	52,gih19
	FLsetVal_i	0,gih20
              endin

              instr   13
	FLsetVal_i	1000,gih1
	FLsetVal_i	500,gih2
	FLsetVal_i	333,gih3
	FLsetVal_i	250,gih4
	FLsetVal_i	200,gih5
	FLsetVal_i	166,gih6
	FLsetVal_i	143,gih7
	FLsetVal_i	125,gih8
	FLsetVal_i	111,gih9
	FLsetVal_i	100,gih10
	FLsetVal_i	91,gih11
	FLsetVal_i	83,gih12
	FLsetVal_i	77,gih13
	FLsetVal_i	71,gih14
	FLsetVal_i	66,gih15
	FLsetVal_i	62,gih16
	FLsetVal_i	59,gih17
	FLsetVal_i	55,gih18
	FLsetVal_i	52,gih19
	FLsetVal_i	50,gih20
              endin

              instr   14
	FLsetVal_i	1000,gih1
	FLsetVal_i	0,gih2
	FLsetVal_i	-111,gih3
	FLsetVal_i	0,gih4
	FLsetVal_i	40,gih5
	FLsetVal_i	0,gih6
	FLsetVal_i	-20,gih7
	FLsetVal_i	0,gih8
	FLsetVal_i	12,gih9
	FLsetVal_i	0,gih10
	FLsetVal_i	-8,gih11
	FLsetVal_i	0,gih12
	FLsetVal_i	6,gih13
	FLsetVal_i	0,gih14
	FLsetVal_i 	-4,gih15
	FLsetVal_i	0,gih16
	FLsetVal_i	3,gih17
	FLsetVal_i	0,gih18
	FLsetVal_i	-3,gih19
	FLsetVal_i	0,gih20
              endin


</CsInstruments>
<CsScore>
f1 0 1024 10 1
i1 0 3600

</CsScore>
</CsoundSynthesizer>