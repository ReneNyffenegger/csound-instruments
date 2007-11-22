; stringphaser.orc
; by Sean Costello, August 23-26, 1999
; GUI and some additions by Josep M Comajuncosas, July 2001

sr = 44100
kr = 441
ksmps = 100
nchnls = 1

gasig2 init 0	; global variable to send pulse waves to ensemble section
ga2 init 0	; global variable to send output of ensemble to reverb

;GUI setup
FLcolor  32,0,64,0,0,0

	FLpanel	"JCM Strings v1",310,240,50,50

FLcolor -1
FLcolor  250,220,20,250,200,0
FLlabel  12, 4, 6, 250,220,20
FLgroup  "·Phaser·", 160, 120, 10, 110,2
FLlabel -1 
FLcolor -1
FLcolor  32,0,64,255, 50, 80

FLlabel  12, 9, 1, 64, 0, 32

knot, ih1 FLtext  " ", 0, 1, 1, 1, 0, 0, 0, 0

gkPhFreq,ih2	FLknob	"Freq", 200,8000,-1,2, -1, 40, 20,120
	FLsetVal_i   1000, ih2
gkPhFdbk,ih3	FLknob	"Fdbk", -.99,.95,0,2, -1, 40, 70,120
	FLsetVal_i   .2, ih3
gkPhQ,ih4	FLknob	"Q", .25,4,-1,2, -1, 40, 120,120
	FLsetVal_i   .5, ih4

gkPhStages, ih5 FLtext  "Ord", 1, 16, 1,1, 25,20, 50, 182
	FLsetVal_i   6, ih5
	FLsetColor   255, 50, 80,ih5
ih5t  FLbox  "Order", 1, 9,12, 25, 20, 50, 205
	FLsetColor   250,220,20,ih5t
 
gkPhSep,ih6	FLknob	"Sep", .25,4,-1,2, -1, 40, 95,172
	FLsetVal_i   1.01, ih6


FLsetBox  14, ih2
FLsetBox  14, ih3
FLsetBox  14, ih4
FLsetBox  3, ih5
FLsetBox  14, ih6

FLsetTextType 4,ih2
FLsetTextType 4,ih3
FLsetTextType 4,ih4
FLsetTextType 4,ih5
FLsetTextType 4,ih5t
FLsetTextType 4,ih6


FLcolor -1
FLlabel -1


	FLgroup_end

FLcolor  250,220,20,250,200,0
FLlabel  12, 4, 6, 250,220,20
FLgroup  "·Lfo·", 160, 65, 10, 20,2
FLlabel -1 
FLcolor -1
FLcolor  32,0,64,255, 50, 80

FLlabel  12, 9, 1, 64, 0, 32
gkLfoWave, ih10   FLbutBank   4, 1, 4, 20, 60, 15, 25, -1 ,0
ih10a  FLbox  "Sine", 1, 12,10, 25, 13, 35, 24
ih10b  FLbox  "Saw Down", 1, 12,10, 50, 13, 35, 39
ih10c  FLbox  "Saw Up", 1, 12,10, 40, 13, 35, 54
ih10d  FLbox  "Triangle", 1, 12,10, 40, 13, 35, 69

	FLsetColor   250,220,20,ih10a
	FLsetColor   250,220,20,ih10b
	FLsetColor   250,220,20,ih10c
	FLsetColor   250,220,20,ih10d

gkLfoFreq,ih11 	FLknob	"Freq", 0.001,20,-1,2, -1, 35, 90,30
	FLsetVal_i   .1, ih11
gkLfoDepth,ih12 	FLknob	"Depth", 0,1,0,2, -1, 35, 130,30
	FLsetVal_i   .7, ih12

FLsetBox  14, ih11
FLsetBox  14, ih12
FLsetTextType 4,ih11
FLsetTextType 4,ih12

FLcolor -1
FLlabel -1


	FLgroup_end

FLcolor  250,220,20,250,200,0
FLlabel  12, 4, 6, 250,220,20
FLgroup  "·12dB morph Vcf·", 120, 120, 180, 110,2
FLlabel -1 
FLcolor -1
FLcolor  32,0,64,255, 50, 80

FLlabel  12, 9, 1, 64, 0, 32

gkVcf1,gkVcf2,ihj1,ihj2 FLjoy " ",100, 10000, 0, 2,-1,0,-1,-1,110,110,185,115

FLcolor -1
FLlabel -1


	FLgroup_end

FLcolor  250,220,20,250,200,0
FLlabel  12, 4, 6, 250,220,20
FLgroup  "·hard Freeverb·", 120, 65, 180, 20,2
FLlabel -1 
FLcolor -1
FLcolor  32,0,64,255, 50, 80

FLlabel  11, 9, 1, 64, 0, 32

gkRevWet,ihr1	FLknob	"d/w", 0,1,0,2, -1, 30, 190,35
	FLsetVal_i   .15, ihr1
	FLsetBox  14, ihr1
	FLsetTextType 4,ihr1

gkRevSize,ihr2 FLknob "Size",0.05,5,0,2,-1,30,225,35
	FLsetVal_i   .3, ihr2
	FLsetBox  14, ihr2
	FLsetTextType 4,ihr2

gkRevCutoff,ihr3 FLknob "Color",0,1,0,2,-1,30,260,35
	FLsetVal_i   7000, ihr3
	FLsetBox  14, ihr3
	FLsetTextType 4,ihr3

FLcolor -1
FLlabel -1

	FLgroup_end
	FLpanel_end

	FLrun


instr 19	; Used to generate simple sawtooth-like waveforms


ifreq  cpsmidi
iharms=(sr*.4) / ifreq	; Limits number of harmonics in bandlimited
			; pulse waveform

asig	gbuzz	1, ifreq, iharms, 1, .9, 2
kenv 	madsr	1, 0,1,1.5

aout = kenv * asig * .45

; The output of instr 19 is sent to the "ensemble" chorusing
; section. None of the dry signal will be heard in the output.
gasig2 = gasig2 + aout


endin



instr 22	; Ensemble section. Takes static sawtooth waves,
		; and produces an animated flanged/chorused/vibratoed
		; output. The phase shifter follows the output
		; of the ensemble.

ivib = p4 * .00025	; Determines amount of pitch change/vibrato/
			; chorusing. A value of 1 gives moderately thick 
			; chorusing, without excessive vibrato. Vary this 
			; according to taste.


;LFOs
ktimea	oscil	4, 0.33, 1
ktimeb	oscil	4, 0.33, 1, .333
ktimec	oscil	4, 0.33, 1, .667

ktimed	oscil	1, 5.5, 1
ktimee	oscil	1, 5.5, 1, .333
ktimef	oscil	1, 5.5, 1, .667


ktime1 = (ktimea + ktimed) * ivib
ktime2 = (ktimeb + ktimee) * ivib
ktime3 = (ktimec + ktimef) * ivib

;Chorus
adummy	delayr	.030
asig1	deltap3	ktime1 + .012
asig2	deltap3	ktime2 + .012
asig3 	deltap3	ktime3 + .012
	delayw	gasig2

aVcfIn = (asig1 + asig2 + asig3) * .33


;Vcf
klow limit 1-gkVcf2,0,1
kband mirror gkVcf2,0,1
khigh limit gkVcf2-1,0,1

alow, ahigh, aband	svfilter	aVcfIn, gkVcf1, 10
aPhaserIn mac klow,alow,kband,aband,khigh,ahigh


;Lfo
lfo:
ilfowave = 10+i(gkLfoWave)
klfofrq	oscil	gkLfoDepth, gkLfoFreq, ilfowave,-1
rigoto end
;rireturn
igoto skip0
if ilfowave == gkLfoWave kgoto skip0
reinit lfo

skip0:
kmod	= gkPhFreq*(1+klfofrq)
kmod limit kmod,20,sr/4

;Phaser
phaser:
istages = i(gkPhStages)

aphs	phaser2 aPhaserIn, kmod, gkPhQ, istages, 2, gkPhSep, gkPhFdbk
	aout2=(aPhaserIn + aphs) * .5

rireturn
igoto skip1
if istages == gkPhStages kgoto skip1
reinit phaser
skip1:
	
ga2 = ga2 + .37 * aout2

out	6000*aout2*(1-gkRevWet)

gasig2 = 0
end:
endin


instr 99	; Simple implementation of Feedback Delay Network (FDN)
		; reverb, as described by John Stautner and Miller 
		; Puckette, "Designing Multi-Channel Reverberators," 
	

atap	multitap ga2, 0.00043, 0.0215, 0.00268, 0.0298, 0.00485, 0.0572, 0.00595, 0.0708, 0.00741, 0.0797, 0.0142, 0.134, 0.0217, 0.181, 0.0272, 0.192, 0.0379, 0.346, 0.0841, 0.504



aRvb_Free nreverb	tanh(.5*ga2), gkRevSize, gkRevCutoff, 0, 8, 71, 4, 72

out 6000*((tanh(.5*aRvb_Free) + atap)*gkRevWet)

ga2 = 0

endin