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
;			LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel		"hrtfer",    500,    350,    0,  0

;SWITCHES		                     	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,  -1,     2,    150,     30,    0,  0,    0,      1,      0,      3600

;NUMBER DISPLAY BOXES				WIDTH | HEIGHT | X | Y
idaz		FLvalue	"Azimuth (Degrees)",	70,       20,    0,  80
idelev		FLvalue	"Elevation (Degrees)",	70,       20,    0, 140


;XY PANELS								MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkaz, gkelev, ihaz, ihelev	FLjoy	"X=Azimuth  Y=Elevation",	-360,  360,   -360,  360,    0,     0,     idaz,  idelev,  360,    280,    70, 50

;SET INITIAL VALUES			VALUE | HANDLE
			FLsetVal_i   	0,	ihaz
			FLsetVal_i   	0,	ihelev

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 320, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                     hrtfer - 3D audio encoding              ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Hrtfer processes a mono audio signal such that it inhabits a ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"virtual 3D environment according to it two principle input   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"arguments, 'Azimuth' (left to right localisation) and        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"'Elevation' (vertical positioning). Both of these parameters ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"are expressed in degrees.                                    ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"This process is designed to be used binaurally so it will    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"work best when listened through headphones although some     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"spacial treatment is still observable through a conventional ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"stereo speaker setup.                                        ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Hrtfer requires a file of analysis data in order to function.", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"At present the only suitable file available is the file      ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'HRTFcompact' that is included with this download.           ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"For convenience hftfer's two principle k-rate parameters are ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"controlled using an X-Y panel in this example.               ", 	1,      5,     14,    490,    15,     5, 300                                                            
				
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

			instr	1	; SCANS FOR I-RATE CHANGES
; SENSE FLTK ON/OFF SWITCH
if		gkOnOff!=-1	kgoto	CONTINUE
		turnoff
CONTINUE:
asig, asigR	diskin	"bounce.wav", 1,0,1

aleft, aright 	hrtfer asig, gkaz, gkelev, "HRTFcompact"

		outs	aleft*100, aright*100
		endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>