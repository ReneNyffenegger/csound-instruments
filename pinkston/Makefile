include ../../setup.mk

all: $(wavfiles)

convunit.wav: convunit.orc convunit.sco 118.con

118.con: noise.wav

adsyn.wav: adsyn.orc adsyn.sco cello.het wind.het c2a.het c2b.het c2c.het c5.het

convolve.wav: domkyr44.con drottn44.con oster44.con thewind.con frigate.con noise.con noisewdg.con noischor.con laugh.con crash.con flush.con bigclunk.con popcorn.con cello44.con cellodec.con cellogls.con lognoise.con vowchord.con bees1.con

drumcomb.wav: drummer.wav

ourpvoc.wav: tamtam.pvx highbell.pvx

pvoc1.wav: wind1.pvx wind2.pvx wind3.pvx wind4.pvx fire1m44.pvx

pvoc2.wav: wind4.pvx wavest44.pvx eroi.pvx

pvoc3.wav: wind4.pvx wavest44.pvx eroi.pvx cello44.pvx plkpnolp.pvx

rplpc.wav: wind1.lpc wind2.lpc wind3.lpc wind4.lpc wind5.lpc wind6.lpc wind7.lpc wind8.lpc wind9.lpc wind10.lpc

vpvoc2.wav: crashcym.pvx

vpvoc.wav: crashcym.pvx

pvadd.wav: gong3.pvx kalimba-low.pvx

gong3.pvx: gong3.aif
kalimba-low.pvx: kalimba-low.aif
crashcym.pvx: crashcym.wav

wind1.lpc: thewind.wav
	lpanal -p 34 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind2.lpc: thewind.wav
	lpanal -p 20 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind3.lpc: thewind.wav
	lpanal -p 32 -h 300 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind4.lpc: thewind.wav
	lpanal -p 28 -h 500 -P 150 -Q 250 $< $(SADIR)/$@ $(OUTPUT)

wind5.lpc: thewind.wav
	lpanal -p 24 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind6.lpc: thewind.wav
	lpanal -p 26 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind7.lpc: thewind.wav
	lpanal -p 28 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind8.lpc: thewind.wav
	lpanal -p 26 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind9.lpc: thewind.wav
	lpanal -p 50 -h 400 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind10.lpc: thewind.wav
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

domkyr44.con: domkyr44.wav
drottn44.con: drottn44.wav
oster44.con: oster44.wav
thewind.con: thewind.wav
frigate.con: frigate.wav
noise.con: noise.wav
noisewdg.con: noisewdg.wav
noischor.con: noischor.wav
laugh.con: laugh.wav
crash.con: crash.wav
flush.con: flush.wav
bigclunk.con: bigclunk.wav
popcorn.con: popcorn.wav
cello44.con: cello44.wav
cellodec.con: cellodec.wav
cellogls.con: cellogls.wav
lognoise.con: lognoise.wav
vowchord.con: vowchord.wav
bees1.con: bees1.wav

cello.het: cello44.wav
	hetro -f175 -h30 $^ $(SADIR)/$@ $(OUTPUT)

wind.het: thewind.wav
	hetro -h50 $^ $(SADIR)/$@ $(OUTPUT)

c2a.het: c2.aiff
	hetro -f65 -h60 -M24000 $^ $(SADIR)/$@ $(OUTPUT)

c2b.het: c2.aiff
	hetro -f32.7032 -h100 -n512 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

c2c.het: c2.aiff
	hetro -f32.7032 -h100 -n1000 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

c5.het: c5.aiff
	hetro -f261 -h100 -n1000 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

include ../../rules.mk
