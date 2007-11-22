;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>


<CsInstruments>

sr 	= 	44100  
kr 	= 	4410
ksmps 	= 	10
nchnls 	= 	2	

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"vco",     500,    700,    0,  0

;SWITCHES                                               ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,    -1,    2,    150,     30,    0,  0,    0,      1,      0,      3600

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idcps			FLvalue	" ",      80,     20,   0, 127
idleak			FLvalue	" ",      80,     20,   0, 177
idnyx			FLvalue	" ",      80,     20,   0, 227
idpw			FLvalue	" ",      80,     20,   0, 277
idPWMamt		FLvalue	" ",      80,     20,   0, 327
idPWMspd		FLvalue	" ",      80,     20,   0, 377
idMVCFcf		FLvalue	" ",      80,     20,   0, 427
idMVCFres		FLvalue	" ",      80,     20,   0, 477

;SLIDERS				     				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkcps, ihcps		FLslider	"Frequency",  			2,   10000,  -1,   3,     idcps,    500,    27,     0, 100
gkleak, ihleak		FLslider	"Integrator Leak",		0,       1,   0,   3,    idleak,    500,    27,     0, 150
gknyx, ihnyx		FLslider	"Number of Harmonics",		0,       1,   0,   3,     idnyx,    500,    27,     0, 200
gkpw, ihpw		FLslider	"Pulse Width",    		0,       1,   0,   3,      idpw,    500,    27,     0, 250
gkPWMamt, ihPWMamt	FLslider	"PWM Amount",			0,       1,   0,   3,     idPWMamt, 500,    27,     0, 300
gkPWMspd, ihPWMspd	FLslider	"PWM Speed",			.001,   10,   0,   3,     idPWMspd, 500,    27,     0, 350
gkMVCFcf, ihMVCFcf	FLslider	"Moog VCF Cutoff Frequency",	4,      14,   0,   3,     idMVCFcf, 500,    27,     0, 400
gkMVCFres, ihMVCFres	FLslider	"Moog VCF Resonance",		0,      .9,   0,   3,     idMVCFres,500,    27,     0, 450

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkwave,ihwave 		FLcount  "Waveform", 		1,      3,   1,       1,      2,   150,     30,    175, 0,    -1
gkPWMwave,ihPWMwave	FLcount  "PWM LFO Waveform", 	0,      5,   1,       1,      2,   150,     30,    350, 0,    -1

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"1=Saw 2=Square/PWM 3=Triangle/Saw/Ramp", 	1,      5,     12,    150,    15,    175, 55

;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	100, 	ihcps
		FLsetVal_i	2, 	ihwave
		FLsetVal_i	0, 	ihleak
		FLsetVal_i	.5, 	ihnyx
		FLsetVal_i	.5, 	ihpw
		FLsetVal_i	0, 	ihPWMamt
		FLsetVal_i	1, 	ihPWMspd
		FLsetVal_i	20000, 	ihMVCFcf
		FLsetVal_i	0, 	ihMVCFres

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 340, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Miscellaneous Waveforms : vco                ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	" ", 	1,      5,     14,    490,    15,     5, 320
                                                           
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr	1	;(ALWAYS ON - SEE SCORE) SENSES FADER MOVEMENT
kSwitch		changed	gkleak, gknyx, gkwave, gkPWMwave
kSwitch		init	0
if		kSwitch==0	kgoto	CONTINUE
;***********RESTART INSTRUMENT 2 (WHEN I-RATE VARIABLE CHANGES)*************************************************************
;					ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
			schedkwhen	1,             0,       0,        2,        0,    -1
;***************************************************************************************************************************
CONTINUE:
	endin

	instr	2
iporttime	=	.1
kporttime	linseg	0,(.001),iporttime,(1),iporttime

kpw		portk	gkpw, kporttime
kcps		portk	gkcps, kporttime

iamp	=	10000
ifn	=	1
imaxd	=	1
kPWMmod	lfo	gkPWMamt, gkPWMspd, i(gkPWMwave)
kpw	mirror	kpw+((kPWMmod+gkPWMamt)*.5), 0, 1	;REFLECT OUT OF RANGE VALUES
asig	vco 	iamp, kcps, i(gkwave), kpw, ifn, imaxd, i(gkleak), i(gknyx);, 0, 0
iscale 		= 	32768
asig		moogvcf	asig, cpsoct(gkMVCFcf), gkMVCFres, iscale
	outs	asig, asig
; SENSE FLTK ON/OFF SWITCH
if	gkOnOff!=-1	kgoto	CONTINUE
turnoff
CONTINUE:     
	endin

</CsInstruments>


<CsScore>
f1 0 131072 10 1  ; audio function

f 0 3600
</CsScore>


</CsoundSynthesizer>



























