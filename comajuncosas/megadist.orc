sr = 44100
kr = 441
ksmps = 100

nchnls=2


FLcolor  64,0,32,0,0,0
	FLpanel	"distortion unit",180,150

FLcolor -1
FLcolor  250,220,20,250,200,0
FLlabel  12, 4, 6, 250,220,20
FLgroup  "·JCM distorter·", 160, 125, 10, 20,2
FLlabel -1 
FLcolor -1
FLcolor  64,0,32,80, 20, 255
FLlabel  12, 9, 1, 64, 0, 32

gkDrive,ih1	FLknob	"Drive", 0.125,8,-1,2, -1, 40, 20,30
	FLsetVal_i   1, ih1
gkOver,ih2	FLknob	"Over", 0,2,0,2, -1, 40, 70,30
	FLsetVal_i   .1, ih2
gkRound,ih3	FLknob	"Round", 0,2,0,2, -1, 40, 120,30
	FLsetVal_i   .1, ih3
gkasym1,ih4	FLknob	"Asym+", 0,2,0,2, -1, 40, 45,85
	FLsetVal_i   .1, ih4
gkasym2,ih5	FLknob	"Asym-", 0,2,0,2, -1, 40, 95,85
	FLsetVal_i   .1, ih5

FLsetBox  14, ih1
FLsetBox  14, ih2
FLsetBox  14, ih3
FLsetBox  14, ih4
FLsetBox  14, ih5

FLsetTextType 4,ih1
FLsetTextType 4,ih2
FLsetTextType 4,ih3
FLsetTextType 4,ih4
FLsetTextType 4,ih5

FLcolor -1
FLlabel -1
	FLgroup_end
	FLpanel_end


	FLrun

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 1; Assymetric distortion unit
;Josep M Comajuncosas / May'2001
;gelida@intercom.es
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


kenv linseg 0,.5,.9,2,1,p3-3,.8,.5,0
aDist_In oscil kenv,220,1

kDrive = gkDrive
kOver = gkOver
kRound = gkRound
kasym1 = gkasym1
kasym2 = gkasym2

;main distorter (modified assymetric tanh() function)
;adist
axtan=(exp(kasym1+aDist_In)-exp(-aDist_In+kasym2))/(exp(aDist_In)+exp(-aDist_In))
adist=(1+(kOver/(1+(kRound*axtan)^2)))*tanh(kDrive*axtan)

;compensate amplitude based on the asymptotic lymits of the previous function
;kmax
kt1=exp(2*kDrive*exp(kasym1))
kt2=exp(2*kasym1)
kst3=kRound^2
kt4=kt1*kst3
kt5=kt2*kst3
kt6=kt1*kt5

kmax=(kt1+kt6+kOver*kt1-1-kt5-kOver)/((1+kt5)*(1+kt1))


;kmin
ks1=exp(2*kDrive*exp(kasym2))
ks2=exp(2*kasym2)
ks4=ks1*kst3
ks5=ks2*kst3
ks6=ks1*ks5

kmin=(-ks1-ks6-kOver*ks1+1+ks5+kOver)/((1+ks5)*(1+ks1))

;normalize the signal (not guaranteed with extreme settings...)
adistn=2*((adist-kmin)/(kmax-kmin))-1

outs adistn*10000,adistn*10000

endin