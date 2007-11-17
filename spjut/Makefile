include ../../setup.mk

all: $(wavfiles)

brightmusicdemos.wav: fox.con
brightmusicdemos.wav: hello.con
brightmusicdemos.wav: wmtell.con
directexample.wav: eightpoint.con
echodemos.wav: fox.con
echodemos.wav: hello.con
highpassdemos.wav: cymbal.con
highpassdemos.wav: hello.con
highpassdemos.wav: highpass1khz.con
highpassdemos.wav: highpass300hz.con
highpassdemos.wav: highpass3khz.con
instrumentdemos.wav: altosax.con
instrumentdemos.wav: brass.con
instrumentdemos.wav: hello.con
instrumentdemos.wav: marimba.con
instrumentdemos.wav: piano.con
instrumentdemos.wav: pluckbass.con
instrumentdemos.wav: violin.con
lowpassdemos.wav: bassdrum.con
lowpassdemos.wav: lowpass1khz.con
lowpassdemos.wav: lowpass300hz.con
lowpassdemos.wav: lowpass3khz.con
lowpassdemos.wav: rimshot.con
mixreverb.wav: gaussreverb.con
musicdemos.wav: fox.con
musicdemos.wav: hello.con
musicdemos.wav: wmtell.con
sinedemos.wav: 388cyclesmidc.con
sinedemos.wav: a440.con
sinedemos.wav: fivecyclesmidc.con
sinedemos.wav: hello.con
sinedemos.wav: middlec.con
sinedemos.wav: onecyclemidc.con
lpc2.wav: marimba.lpc

marimba.lpc: marimba.aif
	lpanal $< $(SADIR)/$@ $(OUTPUT)

eightpoint.con: eightpoint.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

hello.con: hello.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

fox.con: fox.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

oneecho.con: oneecho.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

twoechos.con: twoechos.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

fiveechos.con: fiveechos.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

gaussreverb.con: gaussreverb.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

uniformreverb.con: uniformreverb.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

whitenoise.con: whitenoise.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

lowpass3khz.con: lowpass3khz.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

lowpass1khz.con: lowpass1khz.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

lowpass300hz.con: lowpass300hz.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

rimshot.con: rimshot.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

bassdrum.con: bassdrum.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

highpass300hz.con: highpass300hz.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

highpass1khz.con: highpass1khz.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

highpass3khz.con: highpass3khz.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

cymbal.con: cymbal.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

onecyclemidc.con: onecyclemidc.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

fivecyclesmidc.con: fivecyclesmidc.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

388cyclesmidc.con: 388cyclesmidc.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

middlec.con: middlec.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

a440.con: a440.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

marimba.con: marimba.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

pluckbass.con: pluckbass.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

piano.con: piano.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

brass.con: brass.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

altosax.con: altosax.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

violin.con: violin.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

5th.con: 5th.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

tulip.con: tulip.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

time.con: time.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

boy.con: boy.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

wmtell.con: wmtell.aif
	cvanal -b0.000 -d0.000 $< $(SADIR)/$@ $(OUTPUT)

include ../../rules.mk
