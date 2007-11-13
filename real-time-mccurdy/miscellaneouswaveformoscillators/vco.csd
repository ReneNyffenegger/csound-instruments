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
		FLpanel	"vco",     500,    400,    0,  0

;SWITCHES                                               ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,    -1,    2,    150,     30,    0,  0,    0,      1,      0,      3600

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",      80,     20,    0, 125
idcps			FLvalue	" ",      80,     20,    0, 175
idleak			FLvalue	" ",      80,     20,    0, 225
idnyx			FLvalue	" ",      80,     20,    0, 275
idpw			FLvalue	" ",      80,     20,    0, 325
idphs			FLvalue	" ",      80,     20,    0, 375

;SLIDERS				     				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp, ihamp		FLslider	"Amplitude",  			0,   32767,   0,   3,   idamp,   500,     25,    0, 100
gkcps, ihcps		FLslider	"Frequency (Hertz)",  		2,   10000,  -1,   3,   idcps,   500,     25,    0, 150
gkleak, ihleak		FLslider	"Integrator Leak",		0,       1,   0,   3,  idleak,   500,     25,    0, 200
gknyx, ihnyx		FLslider	"Number of Harmonics",		20,   sr/2,  -1,   3,   idnyx,   500,     25,    0, 250
gkpw, ihpw		FLslider	"Pulse Width",    		0,       1,   0,   3,    idpw,   500,     25,    0, 300
gkphs, ihphs		FLslider	"Initial Phase",    		0,       1,   0,   3,   idphs,   500,     25,    0, 350

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkwave,ihwave 		FLcount  "Waveform", 		1,      3,   1,       1,      2,   150,     30,    175, 0,    -1

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"1=Saw 2=Square/PWM 3=Saw/Triangle/Ramp", 	1,      5,     12,    150,    15,    175, 55

;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	10000, 	ihamp
		FLsetVal_i	100, 	ihcps
		FLsetVal_i	1, 	ihwave
		FLsetVal_i	0, 	ihleak
		FLsetVal_i	sr/2, 	ihnyx
		FLsetVal_i	.5, 	ihpw
		FLsetVal_i	0, 	ihphs

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Miscellaneous Waveforms : vco                ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Vco is a digital emulation of a voltage controlled oscillator", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"that one might find on an analogue synthesizer.              ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The precise method used is the integration of band limited   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"impulses. Vco implements a digital model of the analogue     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"electronics that were used to achieve this.                  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"It has three basic waveform settings: 'Saw', 'Square/PWM' and", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"'Saw/Triangle/Ramp'. As you can see, two of these settings   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"are capable of producing more than one wave type. This is    ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"achieved by warping the waveform using the 'Pulse Width' (PW)", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"control.                                                     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"For example when the 'Square/PWM' waveform is selected a     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"square wave is achieved by setting 'Pulse Width' to 0.5. When", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"'Saw/Triangle/Ramp' is selected a triangle wave is achieved  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"by setting 'Pulse Width' again to 0.5. Giving 'Pulse Width' a", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"value of zero or 1 achieves silence. PWM or 'Pulse Width     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Modulation' was a an effect popular on analogue synthesizers ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"whereby the pulse width of a waveform was modulated by an LFO", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"(Low Frequency Oscillator). In this example this can only be ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"achieved by manually moving the 'Pulse Width' slider back and", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"forth. In the next example featuring vco an LFO has been     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"implemented to drive the 'Pulse Width' parameter. Note that  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"'Pulse Width' has no effect when 'Saw' waveform is selected. ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"The 'Integrator Leak' control implements a quirk of the      ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"original analogue oscillator upon which this is based which  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"has an effect on the sound produced. For a more in depth     ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"discussion I point you in the direction of the the Csound    ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"Reference Manual in which the opcode's author, Hans Mikelson,", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"gives more technical information about the effect of         ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"integrator leakage.                                          ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"'Number of Harmonics' can be used to limit the number of     ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"harmonics that will be present in the waveform. Normally this", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"argument should be in the range close to zero up to 0.5. I   ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"have done some additional mathematics in the code so that the", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"values you see in the interface represent this harmonic limit", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"in hertz. the author suggests that a waveform can be         ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"'fattened up' by reducing this parameter.                    ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"Vco provides a useful source for subtractive synthesis and   ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"could be used as the starting point for a Csound model of an ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"analogue synthesizer.                                        ", 	1,      5,     14,    490,    15,     5, 740

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr		1	;(ALWAYS ON - SEE SCORE) SENSES FADER MOVEMENT
kSwitch		changed		gkleak, gknyx, gkwave, gkphs
;					 ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,       0,        2,        0,    -1
		endin

		instr		2
if	gkOnOff!=-1	kgoto	CONTINUE	;SENSE IF FLTK INSTRUMENT ON/OFF SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
turnoff						;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:					;A LABEL
iamp		=		10000
ifn		=		1
imaxd		=		1
asig		vco 		gkamp, gkcps, i(gkwave), gkpw, ifn, imaxd, i(gkleak), i(gknyx)/sr, i(gkphs)
		outs		asig, asig
		endin

</CsInstruments>


<CsScore>
f1 0 131072 10 1  ; audio function

f 0 3600
</CsScore>


</CsoundSynthesizer>



























