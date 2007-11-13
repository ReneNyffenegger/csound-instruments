include ../../../setup.mk

all: $(wavfiles)

2801.wav: violin.pvx
2802.wav: hellorcb.pvx
2803.wav: hellorcb.pvx
2804.wav: marimba.pvx
2805.wav: hellorcb.pvx
2806.wav: hellorcb.pvx
2807.wav: hellorcb.pvx
2808.wav: hellorcb.pvx
# erro na glibc
2809.wav: hellorcb.pvx
2810.wav: hellorcb.pvx
2810.wav: hellorcb.pvx
2811.wav: hellorcb.pvx
2813.wav: violin.pvx
2814.wav: violin.pvx
2815.wav: hellorcb.pvx
2816.wav: hellorcb.pvx
2816.wav: violin.pvx
2817.wav: hellorcb.pvx
2817.wav: hellorcb.pvx
2818.wav: violin.pvx
2818.wav: marimba.pvx
2821a.wav: violin.pvx
2821a.wav: altosax.pvx
2821.wav: violin.pvx
2821.wav: altosax.pvx
2822.wav: violin.pvx
2822.wav: marimba.pvx
2822.wav: speech1.lpc

altosax.pvx: altosax.aif
	pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

hellorcb.pvx: hellorcb.aif
	pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

marimba.pvx: marimba.aif
	pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

violin.pvx: violin.aif
	pvanal -n 1024 -w 4 $< $(SADIR)/$@ $(OUTPUT)

speech1.lpc: speech1.aif
	lpanal -p 50 -h 400 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

include ../../../rules.mk
