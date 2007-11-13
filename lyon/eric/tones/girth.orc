sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

instr 1
ifreq = cpspch( p4 )
ivsp = 1 * p8
igain = 5000 * p5
ivd1 = .04/2
ivd2 = .01/2
ivs1 = p6
ivs2 = p7
iatk1 = .05
iatk2 = .4
idk = 1.3
isust = p3 - (iatk1+iatk2+idk)
iddepth = .002
	kenv	linseg 0, iatk1, .1*igain, iatk2, igain, idk, igain*.2, isust, 0
	kringenv linseg 0, .02, igain*.5, 1.98, 0, p3-2, 0
	kvd		line ifreq*ivd1, p3, ifreq*ivd2
	kvibr	oscil kvd, ivsp,1	;sine
	kfreq = kvibr + ifreq
	kfadedown	line 1,p3,0
	kfadeup		line 0,p3,1
	
	kfstvib1 oscil ifreq*.02, ivs1, 1
	kfstvib2 oscil ifreq*.02, ivs2, 1
	kfreq1 = kfreq + kfstvib1
	kfreq2 = kfreq + kfstvib2
	
	asig1	oscil kfadedown, kfreq1, 2	; rich wave
	asig2	oscil kfadeup, kfreq1, 3 ;	few harmonix
	amix1	= asig1 + asig2
	amod1	oscil 1.0, kfreq1*2 + (kfreq1*kfadeup*amix1*3),1

	asig3	oscil kfadedown, kfreq2, 2	; rich wave
	asig4	oscil kfadeup, kfreq2, 3 ;	few harmonix
	amix2	= asig3 + asig4
	amod2	oscil 1.0, kfreq2*2 + (kfreq2*kfadeup*amix2*3),1
	
	aring = amod1*amod2*kringenv
	aleft =  (amix1 + amod1)*kenv + aring
	aright =  (amix2 + amod2)*kenv + aring
	
	outs aleft, aright
endin

;; FREQUENCY IN

instr 2
ifreq =  p4 
ivsp = 1 * p8
igain = 5000 * p5
ivd1 = .04/2
ivd2 = .01/2
ivs1 = p6
ivs2 = p7
iatk1 = .05
iatk2 = .4
idk = 1.3
isust = p3 - (iatk1+iatk2+idk)
iddepth = .002
	kenv	linseg 0, iatk1, .1*igain, iatk2, igain, idk, igain*.2, isust, 0
	kringenv linseg 0, .02, igain*.5, 1.98, 0, p3-2, 0
	kvd		line ifreq*ivd1, p3, ifreq*ivd2
	kvibr	oscil kvd, ivsp,1	;sine
	kfreq = kvibr + ifreq
	kfadedown	line 1,p3,0
	kfadeup		line 0,p3,1
	
	kfstvib1 oscil ifreq*.02, ivs1, 1
	kfstvib2 oscil ifreq*.02, ivs2, 1
	kfreq1 = kfreq + kfstvib1
	kfreq2 = kfreq + kfstvib2
	
	asig1	oscil kfadedown, kfreq1, 2	; rich wave
	asig2	oscil kfadeup, kfreq1, 3 ;	few harmonix
	amix1	= asig1 + asig2
	amod1	oscil 1.0, kfreq1*2 + (kfreq1*kfadeup*amix1*3),1

	asig3	oscil kfadedown, kfreq2, 2	; rich wave
	asig4	oscil kfadeup, kfreq2, 3 ;	few harmonix
	amix2	= asig3 + asig4
	amod2	oscil 1.0, kfreq2*2 + (kfreq2*kfadeup*amix2*3),1
	
	aring = amod1*amod2*kringenv
	aleft =  (amix1 + amod1)*kenv + aring
	aright =  (amix2 + amod2)*kenv + aring
	
	outs aleft, aright
endin