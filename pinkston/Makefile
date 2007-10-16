include ../../setup.mk

all: $(wavfiles)

convunit.wav: convunit.orc convunit.sco 118.conv

118.conv: noise.wav

adsyn.wav: adsyn.orc adsyn.sco cello.hetro wind.hetro c2a.hetro c2b.hetro c2c.hetro c5.hetro

convolve.wav: domkyr44.conv drottn44.conv oster44.conv thewind.conv frigate.conv noise.conv noisewdg.conv noischor.conv laugh.conv crash.conv flush.conv bigclunk.conv popcorn.conv cello44.conv cellodec.conv cellogls.conv lognoise.conv vowchord.conv bees1.conv

drumcomb.wav: drummer.wav

ourpvoc.wav: tamtam.pvx highbell.pvx

pvoc1.wav: wind1.pvx wind2.pvx wind3.pvx wind4.pvx fire1m44.pvx

pvoc2.wav: wind4.pvx wavest44.pvx eroi.pvx

pvoc3.wav: wind4.pvx wavest44.pvx eroi.pvx cello44.pvx plkpnolp.pvx

rplpc.wav: wind1.lp wind2.lp wind3.lp wind4.lp wind5.lp wind6.lp wind7.lp wind8.lp wind9.lp wind10.lp

vpvoc2.wav: crashcym.pvx

vpvoc.wav: crashcym.pvx

pvadd.wav: gong3.pvx kalimba-low.pvx

gong3.pvx: gong3.aif
kalimba-low.pvx: kalimba-low.aif
crashcym.pvx: crashcym.wav

wind1.lp: thewind.wav
	lpanal -p 34 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind2.lp: thewind.wav
	lpanal -p 20 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind3.lp: thewind.wav
	lpanal -p 32 -h 300 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind4.lp: thewind.wav
	lpanal -p 28 -h 500 -P 150 -Q 250 $< $(SADIR)/$@ $(OUTPUT)

wind5.lp: thewind.wav
	lpanal -p 24 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind6.lp: thewind.wav
	lpanal -p 26 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind7.lp: thewind.wav
	lpanal -p 28 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind8.lp: thewind.wav
	lpanal -p 26 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind9.lp: thewind.wav
	lpanal -p 50 -h 400 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind10.lp: thewind.wav
	lpanal -p 50 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

cello44.pvx: cello44.wav
plkpnolp.pvx: plkpnolp.wav
wavest44.pvx: wavest44.wav
eroi.pvx: eroi.wav

wind1.pvx: thewind.wav
	pvanal -n 256 -w 4 $< $(SADIR)/$@ $(OUTPUT)

wind2.pvx: thewind.wav
	pvanal -n 128 -w 4 $< $(SADIR)/$@ $(OUTPUT) 

wind3.pvx: thewind.wav
	pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

wind4.pvx: thewind.wav

fire1m44.pvx: fire1m44.wav
	pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

tamtam.pvx: tamtam.aif
highbell.pvx: highbell.aif

domkyr44.conv: domkyr44.wav
drottn44.conv: drottn44.wav
oster44.conv: oster44.wav
thewind.conv: thewind.wav
frigate.conv: frigate.wav
noise.conv: noise.wav
noisewdg.conv: noisewdg.wav
noischor.conv: noischor.wav
laugh.conv: laugh.wav
crash.conv: crash.wav
flush.conv: flush.wav
bigclunk.conv: bigclunk.wav
popcorn.conv: popcorn.wav
cello44.conv: cello44.wav
cellodec.conv: cellodec.wav
cellogls.conv: cellogls.wav
lognoise.conv: lognoise.wav
vowchord.conv: vowchord.wav
bees1.conv: bees1.wav

cello.hetro: cello44.wav
	hetro -f175 -h30 $^ $(SADIR)/$@ $(OUTPUT)

wind.hetro: thewind.wav
	hetro -h50 $^ $(SADIR)/$@ $(OUTPUT)

c2a.hetro: c2.aiff
	hetro -f65 -h60 -M24000 $^ $(SADIR)/$@ $(OUTPUT)

c2b.hetro: c2.aiff
	hetro -f32.7032 -h100 -n512 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

c2c.hetro: c2.aiff
	hetro -f32.7032 -h100 -n1000 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

c5.hetro: c5.aiff
	hetro -f261 -h100 -n1000 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

include ../../rules.mk
