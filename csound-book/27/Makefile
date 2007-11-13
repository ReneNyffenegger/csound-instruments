include ../../../setup.mk

all: $(wavfiles)

2701.wav: a3_1.het
2702.wav: a3_2.het
2705.wav: glass_1.het
2706.wav: glass_2.het
2707.wav: gong1_1.het
2708.wav: gong1_2.het
2728.wav: a3_1.het
2729.wav: glass_1.het
2730.wav: glass_1.het
2731.wav: gong1_1.het

a3_1.het: a3.aif
	hetro -f 100 -h 50 $^ $(SADIR)/$@ $(OUTPUT)

a3_2.het: a3.aif
	hetro -f 200 -h 40 $^ $(SADIR)/$@ $(OUTPUT)

glass_1.het: glass.aif
	hetro -f 100 -h 50 $^ $(SADIR)/$@ $(OUTPUT)

glass_2.het: glass.aif
	hetro -f 200 -h 40 $^ $(SADIR)/$@ $(OUTPUT)

gong1_1.het: gong1.aif
	hetro -f 100 -h 50 $^ $(SADIR)/$@ $(OUTPUT)

gong1_2.het: gong1.aif
	hetro -f 200 -h 40 $^ $(SADIR)/$@ $(OUTPUT)

2709.orc: a3_1.lpc
2710.orc: a3_1.lpc
2711.orc: a3_1.lpc
2712.orc: a3_2.lpc
2713.orc: a3_1.lpc
2714.orc: a3_1.lpc
2715.orc: a3_1.lpc
2716.orc: glass_1.lpc
2717.orc: glass_1.lpc
2718.orc: glass_1.lpc
2719.orc: gong2_1.lpc
2720.orc: gong2_1.lpc
2721.orc: gong2_1.lpc
2722.orc: gong1_1.lpc
2723.orc: gong1_1.lpc
2724.orc: gong1_1.lpc
2725.orc: gong1_1.lpc
2726.orc: a3_1.lpc
2727.orc: glass_1.lpc
2728.orc: glass_1.lpc
2729.orc: a3_1.lpc
2730.orc: glass_1.lpc
2731.orc: gong1_1.lpc

a3_1.lpc: a3.aif
	lpanal -p 50 -h 400 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

a3_2.lpc: a3.aif
	lpanal -p 40 -h 200 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

glass_1.lpc: glass.aif
	lpanal -p 50 -h 400 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

gong1_1.lpc: gong1.aif
	lpanal -p 50 -h 400 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

gong2_1.lpc: gong1.aif
	lpanal -p 40 -h 200 -P 100 -Q 2000 $^ $(SADIR)/$@ $(OUTPUT)

include ../../../rules.mk
