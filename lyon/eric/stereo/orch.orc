sr=44100
kr=4410
ksmps=10
nchnls = 2
gipiotwo = 1.570796
gipp = gipiotwo/2.0
gippp = gipp*.99
;i1 0 dur file skip amp seed speed
instr 1
ifile = p4
iskip = p5
iamp = p6
iseed = p7
ispeed = p8
iatk = .05
idk = .05
isust = p3-(idk+iatk)
	araw soundin ifile,iskip
	kpan randi gippp, ispeed, iseed
	kpan = kpan + gipp
	kleft = iamp * cos( kpan )
	kright = iamp * sin( kpan )
	outs (araw*kleft),(araw*kright)
endin
instr 2
ifile = p4
iskip = p5
iamp = p6
iseed = p7
ispeed = p8
iatk = .05
idk = .05
isust = p3-(idk+iatk)
        araw1,araw2 soundin ifile,iskip
        kpan randi gippp, ispeed, iseed
        kpan = kpan + gipp
        kleft = iamp * cos( kpan )
        kright = iamp * sin( kpan )
        outs (araw1*kleft),(araw2*kright)
endin

