;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	44100	;CONTROL RATE
ksmps 		= 	1	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL                    | WIDTH | HEIGHT | X | Y
		FLpanel	"Flanger Implementation",   500,    350,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",     100,    20,     0,  80
idmix				FLvalue	" ",     100,    20,     0, 130
idfeedbackamt			FLvalue	" ",     100,    20,     0, 180
idamp				FLvalue	" ",     100,    20,     0, 230
idFlaDepth			FLvalue	" ",     100,    20,     0, 280
idFlaRate			FLvalue	" ",     100,    20,     0, 330

;SLIDERS					            				MIN |  MAX | EXP | TYPE |      DISP    | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",			.0001,   1,   -1,    5,           iddlt,   500,     30,    0,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",				0,      1,    0,    5,           idmix,   500,     30,    0, 100
gkfeedamt,ihfeedamt		FLslider 	"Feedback Amount",			-.99, .99,    0,    5,   idfeedbackamt,   500,     30,    0, 150
gkamp,ihamp			FLslider 	"Output Amplitude Rescaling",		0,      1,    0,    5,           idamp,   500,     30,    0, 200
gkFlaDepth,ihFlaDepth		FLslider 	"Flanger Modulation Depth (sec)",	0,     .2,    0,    5,      idFlaDepth,   500,     30,    0, 250
gkFlaRate,ihFlaRate		FLslider 	"Flanger Modulation Rate",		.001,   7,   -1,    5,       idFlaRate,   500,     30,    0, 300

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.0001, 	ihdlt
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	-1, 	ihOnOff
		FLsetVal_i	.9, 	ihfeedamt
		FLsetVal_i	.7, 	ihamp
		FLsetVal_i	.005, 	ihFlaDepth
		FLsetVal_i	.05, 	ihFlaRate

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 280, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               delayr delayw deltap3 - flanger               ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"A flanger is really just a delay effect where the delay tap  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"is slowly modulated using an LFO (Low Frequency Oscillator). ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Typically the delay times involved in this system are very   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"short so that rather than being able to hear distinct echoes,", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the comb filtering effect of very short delays is evident.   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"A feedback loop is essential to creating the sound of a      ", 	1,      5,     14,    490,    15,     5, 140          
ih		 	FLbox  	"flanger.                                                     ", 	1,      5,     14,    490,    15,     5, 160          
ih		 	FLbox  	"A flanger derives its name from that fact that when          ", 	1,      5,     14,    490,    15,     5, 180          
ih		 	FLbox  	"originally implemented using reel-to-reel tape recorders the ", 	1,      5,     14,    490,    15,     5, 200          
ih		 	FLbox  	"engineer was required to rub their finger against the flange ", 	1,      5,     14,    490,    15,     5, 220          
ih		 	FLbox  	"of the reel of tape with varying pressure in order to create ", 	1,      5,     14,    490,    15,     5, 240          
ih		 	FLbox  	"the short varying delay time modulations.                    ", 	1,      5,     14,    490,    15,     5, 260          
                                                                                              
				FLpanel_end                                                   
                                                                                              
				FLrun	;RUN THE FLTK WIDGET THREAD                           
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                                              
		instr	1	;PLAYS FILE
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH                             
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY                                 
CONTINUE:                                                                                     
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)                
gasigL, gasigR	diskin	"808loop.wav",     1,       0,        1                               
		endin                                                                         
                                                                                              
		instr 		2	;FLANGER-DELAY INSTRUMENT                             
afeedbacksigL	init		0	;LEFT AND RIGHT CHANNELS OF THE FEEDBACK SIGNAL ARE INITIALISED TO ZERO
afeedbacksigR	init		0       ;LEFT AND RIGHT CHANNELS OF THE FEEDBACK SIGNAL ARE INITIALISED TO ZERO                                                                                                    
iporttime	=		.1	;PORTAMENTO TIME                                      
kporttime	linseg		0, .001, iporttime, 1, iporttime ;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERON TO THE REQUIRED VALUE PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED
kdlt		portk		gkdlt, kporttime ;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
adlt		interp		kdlt	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
                                                                                              
amod		oscil		gkFlaDepth, gkFlaRate, 1	;OSCILLATOR THAT MAKES USE OF THE POSITIVE DOMAIN ONLY TRIANGLE WAVE IN FUNCTION TABLE 1
                                                                                              
adlt		sum		adlt, amod	;STATIC DELAY TIME AND MODULATING DELAY TIME ARE SUMMED
;REMEMBER THAT THE LENGTH OF THE DELAY BUFFER DEFINED WILL HAVE TO TAKE ACCOUNT OF THE SUMMED MAXIMUM OF THE STATIC DELAY TIME AND MODULATING DELAY TIME
                                                                                              
;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
abufferL	delayr	1.2	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigL 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS                          
		delayw	gasigL + afeedbacksigL	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
                                                                                              
abufferR	delayr	1.2	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigR 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS                          
		delayw	gasigR + afeedbacksigR	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
                                                                                              
afeedbacksigL	=	adelsigL * gkfeedamt	;CREATE FEEDBACK SIGNAL (AN ATTENUATED PROPORTION OF THE DELAY OUTPUT SIGNAL)
afeedbacksigR	=	adelsigR * gkfeedamt	;CREATE FEEDBACK SIGNAL (AN ATTENUATED PROPORTION OF THE DELAY OUTPUT SIGNAL)
                                                                                              
		outs		((adelsigL * gkmix) + (gasigL * (1-gkmix))) * gkamp, ((adelsigR * gkmix) + (gasigR * (1-gkmix))) * gkamp	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT
gasigL		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES                        
gasigR		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES                        
		endin                                                                         
                                                                                              
</CsInstruments>                                                                              
                                                                                              
<CsScore>                                                                                     
;INSTR | START | DURATION                                                                     
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE                                       
                                                                                              
f 1 0 131072 7 0 65536 1 65536 0	;POSITIVE DOMAIN TRIANGLE WAVE                        
                                                                                              
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR              
</CsScore>                                                                                    
                                                                                              
                                                                                              
</CsoundSynthesizer>                                                                          
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              















































































