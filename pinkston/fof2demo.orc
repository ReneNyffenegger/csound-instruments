sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	1

;========================================================
; 		Example FOF2 instrument 
;
;This uses fof2 with variable gliss, octaviation, and phs
;It's best with just a sine wave for the source sound.
;RP
;========================================================

	instr	2	
idur	=	p3
iamp	=	p4		
ifund	=	cpspch(p5)
iglsmax	=	p6		;max gliss amount
iglsdel	=	p7
iglsdur	=	p8
iglsfn	=	p9
ioctmax	=	p10
ioctdel	=	p11
ioctdur	=	p12
ioctfn	=	p13
iphsfn	=	p14		;function to control phase po
ifna	=	p15		;input sound file
ifnb	=	2		;hardwire to f2, a sigmoid
iphsdur	=	(p16 == 0 ? p3 : p16)
irise	=	p17		;main envelope settings
idecay	=	p18	
iform	=	p19
iband	=	p20
ilrise	=	p21		;local env settings
ildur	=	p22
ildec	=	p23
iolaps	=	(p24 == 0 ? ifund*ildur+1 : p24)	;compute overlaps
itotdur	=	(p25 == 0 ? idur : p25)
kgliss	init	0		;allow for gotos below
koct	init	0

kamp	linen	iamp,irise,idur,idecay
kphs	oscil1i	0,1,idur,iphsfn			;phase control function
	if	(iglsmax == 0) goto octaviation
kgliss	oscil1i	iglsdel,iglsmax,iglsdur,iglsfn	;gliss control function
octaviation:
	if	(ioctmax == 0) goto continue
koct	oscil1i	ioctdel,ioctmax,ioctdur,ioctfn	;octaviation control function
continue:
asig	fof2	kamp, ifund, iform, koct, iband, ilrise, ildur, ildec, iolaps, ifna, ifnb, itotdur, kphs, kgliss
	out	asig
	endin

;========================================================
; 		FOF2 instrument for granular synthesis
;
;Same as above, but with additional controls for varying
;and randomizing the grain frequency and grain duration.
;It's best with sampled sounds for the source sound.
;Note that the "formant frequency" must be set to 1 over
;the duration of the function table containing the sample
;in order to play back at the original pitch.
;RP
;========================================================

	instr	3	
idur	=	p3
iamp	=	p4		
ifreq	=	p5		;max grain frequency
ifrqfn	=	p6		;grain freq control func
iglsmax	=	p7		;max gliss amount
iglsdel	=	p8
iglsdur	=	p9
iglsfn	=	p10
ioctmax	=	p11
ioctdel	=	p12
ioctdur	=	p13
ioctfn	=	p14
iphsfn	=	p15		;function to control phase
ifna	=	p16		;input sound file
ifnb	=	2		;hardwire to f2, a sigmoid
ismpdur	=	nsamp(ifna)/sr	;original sample duration
				;time stretch factor defaults
itimfac	=	(p17 == 0 ? p3/ismpdur : p17)	;to fill p3
iphsdur	=	ismpdur*itimfac
				;set max phase position to 
iphsmax	=	nsamp(ifna)/ftlen(ifna)	;portion of table actually used
irise	=	p18		;main envelope settings
idecay	=	p19	
ipitfac	=	(p20 == 0 ? 1 : p20)	;pitch shift factor
iform	=	sr/ftlen(ifna) * ipitfac
iband	=	p21
ilrise	=	p22		;local env settings
ildur	=	p23
ildec	=	p24
idurdel	=	p25
idurdur	=	(p26 == 0 ? p3 : p26)
idurfn	=	p27
itotdur	=	(p29 == 0 ? idur : p29)
irndhz	=	p30/100		;pct random deviation in grain freq
irndur	=	p31/100		;pct random deviation in grain dur
iolaps	=	(p28 == 0 ? (ifreq+ifreq*irndhz)*(ildur+ildur*irndur)+1 : p28)	;compute overlaps
iseed	=	p32
kgliss	init	0		;allow for gotos below
koct	init	0
kfreq	=	ifreq		;these need resetting every k
kldur	=	ildur

kamp	linen	iamp,irise,idur,idecay
kphs	oscil1i	0,iphsmax,iphsdur,iphsfn	;phase control function
	if	(iglsmax == 0) goto octaviation
kgliss	oscil1i	iglsdel,iglsmax,iglsdur,iglsfn	;gliss control function
octaviation:
	if	(ioctmax == 0) goto varyhz
koct	oscil1i	ioctdel,ioctmax,ioctdur,ioctfn	;octaviation control function
varyhz:
	if	(ifrqfn == 0) goto randomhz
kfreq	oscil1i	0,ifreq,idur,ifrqfn
randomhz:
	if	(irndhz == 0) goto varydur
krndhz	randi	irndhz,100,iseed
kfreq	=	kfreq*(1+krndhz)
varydur:
	if	(idurfn == 0) goto randomdur
kldur	oscil1i	idurdel,ildur,idurdur,idurfn	;grain env duration control func
randomdur:
	if	(irndur == 0) goto continue
krndur	randi	irndur,100,iseed*.5
kldur	=	kldur*(1+krndur)
continue:
asig	fof2	kamp, kfreq, iform, koct, iband, ilrise, kldur, ildec, iolaps, ifna, ifnb, itotdur, kphs, kgliss
	out	asig
	endin