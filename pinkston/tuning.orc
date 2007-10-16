	sr	=	44100
	kr	=	4410
	ksmps	=	10
	nchnls	=	1

;===========================================================================;
;			Tuning Table Instrument				    ;
;									    ;
; This instrument uses a tuning table which has ratios stored as pairs of   ;
; numerator, denomenator values in a function created by Gen02.  Only a     ;
; single octave's worth of tuning ratios are stored, beginning with octave  ;
; number 8, defined as middle C.  The desired note is entered in p5 as an   ;
; octave.pc value.  The octave and pc parts are separated, and the pc part  ;
; converted to an integer.  The pc * 2 is then used as an index into the    ;
; tuning table, which returns the corresponding numerator, denomenator set  ;
; for the desired pitch.  The correct frequency is computed from the basis  ;
; frequency (middle c = 261.6hz) and then transposed to the desired octave. ;
;								  	    ;
; Note that there is no reason to restrict the number of pitch classes per  ;
; octave to 12: to divide the octave into n parts, simply allocate a tuning ;
; table of at least 2n locations and enter the ratio for each pitch class.  ;
; You can still use oct.pc notation in p5.  E.g., if you have divided the   ;
; octave into 24 parts, then 8.01 would be a quarter-tone higher than 8.00, ;
; 8.02 would be the same as 8.01 in a 12-pitch class octave, and 8.24 would ;
; be the same as 9.00.  You just need to make sure that your table has the  ;
; correct size and that you have entered 24 pairs of values.  This code     ;
; would not need to be changed.  RP                                           ;
;===========================================================================;

	instr	1
ibasis	=	261.6			;middle c in hertz
ipitfn	=	p9			;the tuning table
ipch	=	p5			;the desired note in pch
ioct	=	int(ipch)		;get octave part only
ipc	=	int((ipch-ioct)*100+.5)	;get pitch class as integer
inum	table	ipc*2,ipitfn		;top value in ratio
iden	table	ipc*2+1,ipitfn		;bot value in ratio
ifreq	=	ibasis*inum/iden	;compute freq based on middle C
itrans	=	ioct-8			;n octs to transpose from basis oct
					
ipitch	=	ifreq*exp(itrans*log(2));transpose to correct octave

kgate	linen	p4,p6,p3,p7
asig	oscili	kgate,ipitch,p8
	out	asig
	endin