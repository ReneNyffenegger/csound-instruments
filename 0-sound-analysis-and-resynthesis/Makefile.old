include ../../setup.mk

all: $(wavfiles)

klapper-2701.wav: a3_1.het
klapper-2702.wav: a3_2.het
klapper-2705.wav: glass_1.het
klapper-2706.wav: glass_2.het
klapper-2707.wav: gong1_1.het
klapper-2708.wav: gong1_2.het
klapper-2728.wav: a3_1.het
klapper-2729.wav: glass_1.het
klapper-2730.wav: glass_1.het
klapper-2731.wav: gong1_1.het

a3_1.het: a3.aif
	@hetro -f 100 -h 50 $^ $(SADIR)/$@ $(OUTPUT)

a3_2.het: a3.aif
	@hetro -f 200 -h 40 $^ $(SADIR)/$@ $(OUTPUT)

glass_1.het: glass.aif
	@hetro -f 100 -h 50 $^ $(SADIR)/$@ $(OUTPUT)

glass_2.het: glass.aif
	@hetro -f 200 -h 40 $^ $(SADIR)/$@ $(OUTPUT)

gong1_1.het: gong1.aif
	@hetro -f 100 -h 50 $^ $(SADIR)/$@ $(OUTPUT)

gong1_2.het: gong1.aif
	@hetro -f 200 -h 40 $^ $(SADIR)/$@ $(OUTPUT)

klapper-2709.orc: a3_1.lpc
klapper-2710.orc: a3_1.lpc
klapper-2711.orc: a3_1.lpc
klapper-2712.orc: a3_2.lpc
klapper-2713.orc: a3_1.lpc
klapper-2714.orc: a3_1.lpc
klapper-2715.orc: a3_1.lpc
klapper-2716.orc: glass_1.lpc
klapper-2717.orc: glass_1.lpc
klapper-2718.orc: glass_1.lpc
klapper-2719.orc: gong2_1.lpc
klapper-2720.orc: gong2_1.lpc
klapper-2721.orc: gong2_1.lpc
klapper-2722.orc: gong1_1.lpc
klapper-2723.orc: gong1_1.lpc
klapper-2724.orc: gong1_1.lpc
klapper-2725.orc: gong1_1.lpc
klapper-2726.orc: a3_1.lpc
klapper-2727.orc: glass_1.lpc
klapper-2728.orc: glass_1.lpc
klapper-2729.orc: a3_1.lpc
klapper-2730.orc: glass_1.lpc
klapper-2731.orc: gong1_1.lpc

a3_1.lpc: a3.aif
	@lpanal -p 50 -h 400 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

a3_2.lpc: a3.aif
	@lpanal -p 40 -h 200 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

glass_1.lpc: glass.aif
	@lpanal -p 50 -h 400 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

gong1_1.lpc: gong1.aif
	@lpanal -p 50 -h 400 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

gong2_1.lpc: gong1.aif # erro gauss
	@lpanal -p 40 -h 200 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

accci-60-22-1.wav:  accci-60-22-1.orc accci-60-22-1.sco santur1.pvx
accci-60-22-1b.wav: accci-60-22-1b.orc accci-60-22-1b.sco speech1.pvx
accci-60-22-1c.wav: accci-60-22-1c.orc accci-60-22-1c.sco snap1.pvx
accci-60-22-2.wav:  accci-60-22-2.orc accci-60-22-2.sco santur1.pvx
accci-60-22-3.wav:  accci-60-22-3.orc accci-60-22-3.sco santur1.pvx
accci-60-23-1.wav:  accci-60-23-1.orc accci-60-23-1.sco santur1.pvx
accci-60-23-2.wav:  accci-60-23-2.orc accci-60-23-2.sco speech1.pvx

karpen-2801.wav: violin.pvx
karpen-2802.wav: hellorcb.pvx
karpen-2803.wav: hellorcb.pvx
karpen-2804.wav: marimba.pvx
karpen-2805.wav: hellorcb.pvx
karpen-2806.wav: hellorcb.pvx
karpen-2807.wav: hellorcb.pvx
karpen-2808.wav: hellorcb.pvx
#export MALLOC_CHECK_=0
karpen-2809.wav: hellorcb.pvx #  *** glibc detected *** csound: double free or corruption (!prev): 0x08160bd0 
#export MALLOC_CHECK_=3
karpen-2810.wav: hellorcb.pvx
karpen-2810.wav: hellorcb.pvx
karpen-2811.wav: hellorcb.pvx
karpen-2813.wav: violin.pvx
karpen-2814.wav: violin.pvx
karpen-2815.wav: hellorcb.pvx
karpen-2816.wav: hellorcb.pvx
karpen-2816.wav: violin.pvx
karpen-2817.wav: hellorcb.pvx
karpen-2817.wav: hellorcb.pvx
karpen-2818.wav: violin.pvx
karpen-2818.wav: marimba.pvx
karpen-2821a.wav: violin.pvx
karpen-2821a.wav: altosax.pvx
karpen-2821.wav: violin.pvx
karpen-2821.wav: altosax.pvx
karpen-2822.wav: violin.pvx
karpen-2822.wav: marimba.pvx
karpen-2822.wav: speech1.lpc

altosax.pvx: altosax.aif
	@pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

hellorcb.pvx: hellorcb.aif
	@pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

marimba.pvx: marimba.aif
	@pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

violin.pvx: violin.aif
	@pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

speech1.lpc: speech1.aif #gauss: ill-conditioned
	@lpanal -p 50 -h 400 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)


######################################################################

pinkston-convunit.wav: pinkston-convunit.orc pinkston-convunit.sco noise.con

noise.con: noise.wav

pinkston-adsyn.wav: pinkston-adsyn.orc pinkston-adsyn.sco cello.het wind.het c2a.het c2b.het c2c.het c5.het

pinkston-convolve.wav: domkyr44.con drottn44.con oster44.con thewind.con frigate.con noise.con noisewdg.con noischor.con laugh.con crash.con flush.con bigclunk.con popcorn.con cello44.con cellodec.con cellogls.con lognoise.con vowchord.con bees1.con

# *** glibc detected *** csound: double free or corruption (!prev): 0x08161bb8 ***
# por isso separei a score em duas
pinkston-pvoc1a.wav: pinkston-pvoc1.orc pinkston-pvoc1a.sco thewind1.pvx thewind2.pvx
	@csound -g -o $@ $(wordlist 1, 2, $^) $(OUTPUT)

pinkston-pvoc1b.wav: pinkston-pvoc1.orc pinkston-pvoc1a.sco thewind3.pvx thewind4.pvx fire1m44.pvx
	@csound -g -o $@ $(wordlist 1, 2, $^) $(OUTPUT)

pinkston-pvoc2.wav: thewind4.pvx wavest44.pvx eroi.pvx

pinkston-pvoc3.wav: thewind4.pvx wavest44.pvx eroi.pvx cello44.pvx plkpnolp.pvx

pinkston-lpc.wav: wind1.lpc wind2.lpc wind3.lpc wind4.lpc wind5.lpc wind6.lpc wind7.lpc wind8.lpc wind9.lpc wind10.lpc

pinkston-vpvoc2.wav: crashcym.pvx

pinkston-vpvoc1.wav: crashcym.pvx

pinkston-pvadd.wav: gong3.pvx kalimba-low.pvx

gong3.pvx: gong3.aif

kalimba-low.pvx: kalimba-low.aif

crashcym.pvx: crashcym.wav

wind1.lpc: thewind.wav
	@lpanal -p 34 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind2.lpc: thewind.wav
	@lpanal -p 20 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind3.lpc: thewind.wav
	@lpanal -p 32 -h 300 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind4.lpc: thewind.wav
	@lpanal -p 28 -h 500 -P 150 -Q 250 $< $(SADIR)/$@ $(OUTPUT)

wind5.lpc: thewind.wav
	@lpanal -p 24 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind6.lpc: thewind.wav
	@lpanal -p 26 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind7.lpc: thewind.wav
	@lpanal -p 28 -h 500 -P 70 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind8.lpc: thewind.wav
	@lpanal -p 26 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind9.lpc: thewind.wav
	@lpanal -p 50 -h 400 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

wind10.lpc: thewind.wav
	@lpanal -p 50 -h 500 -P 100 -Q 200 $< $(SADIR)/$@ $(OUTPUT)

cello44.pvx: cello44.wav
plkpnolp.pvx: plkpnolp.wav
wavest44.pvx: wavest44.wav
eroi.pvx: eroi.wav

thewind1.pvx: thewind.wav
	@pvanal -n 256 -w 4 $< $(SADIR)/$@ $(OUTPUT)

thewind2.pvx: thewind.wav
	@pvanal -n 128 -w 4 $< $(SADIR)/$@ $(OUTPUT) 

thewind3.pvx: thewind.wav
	@pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

thewind4.pvx: thewind.wav
	@pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

fire1m44.pvx: fire1m44.wav
	@pvanal -n 1024 -w 8 $< $(SADIR)/$@ $(OUTPUT)

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
	@hetro -f175 -h30 $^ $(SADIR)/$@ $(OUTPUT)

wind.het: thewind.wav
	@hetro -h50 $^ $(SADIR)/$@ $(OUTPUT)

c2a.het: c2.aiff
	@hetro -f65 -h60 -M24000 $^ $(SADIR)/$@ $(OUTPUT)

c2b.het: c2.aiff
	@hetro -f32.7032 -h100 -n512 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

c2c.het: c2.aiff
	@hetro -f32.7032 -h100 -n1000 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

c5.het: c5.aiff
	@hetro -f261 -h100 -n1000 -M30000 $^ $(SADIR)/$@ $(OUTPUT)

include ../../rules.mk
