
CS = csound
CSFLAGS = -d -m7 -H1 -f -J
CSFLAG2 = -d -m7 -H1 -s -W

all: drums.wav

all_ogg: drums.ogg

cvgen.sf: cvgen.orc cvgen.sco room.sco
	$(CS) $(CSFLAGS) -o $@ cvgen.orc cvgen.sco

reverb.cv: cvgen.sf
	-$(CS) -U cvanal $< $@

drums.sf: drums.orc drums.sco room.sco fgen_h.sco score.sco
	$(CS) $(CSFLAGS) -o $@ drums.orc drums.sco

score.sco: score.in.sco score.scp
	scsort < score.in.sco | scoreproc -c score.scp > $@

reverb.sf: drums.sf reverb.cv reverb.orc reverb.sco
	$(CS) $(CSFLAGS) -o $@ reverb.orc reverb.sco

drums.wav: drums.orc drums.sco room.sco fgen_h.sco score.sco
	$(CS) $(CSFLAG2) -o $@ drums.orc drums.sco

clean:
	-rm *.wav *.pcm *.sf *.cv *.ogg score.srt

distclean: clean
	-rm score.sco

SRATE = 48000
LIMIT = 20000
CLPL1 = 20500
CLPL2 = 22000
SCALE = 1.43

MFLAGS = -verbose -srate $(SRATE) -smode 1 -lband 0 -nband 6 -ovrlp 4	\
	 -scale 1.0 -limit $(LIMIT) -clpl1 900000 -clpl2 999999		\
	 -freq1 1000.0 -flvl1 1.0 -flvh1 1.0				\
	 -freq2 4680.0 -flvl2 0.0 -flvh2 1.0				\
	 -freq3 4680.0 -flvl3 1.0 -flvh3 0.0				\
	 -freq4 4680.0 -flvl4 1.0 -flvh4 0.0				\
	 -r_lim a 1.0							\
	 -clpsn a 1.0

LFLAGS = -verbose -srate $(SRATE) -smode 1 -lband -2 -nband 11 -ovrlp 4	    \
	 -lmode 1							    \
	 -scale $(SCALE) -limit $(LIMIT) -clpl1 $(CLPL1) -clpl2 $(CLPL2)    \
	 -r_lim a 1.0							    \
	 -r_lim -2 0.5 -r_lim -1 0.6 -r_lim 0 0.7 -r_lim 1 0.75		    \
	 -r_lim 2 0.8 -r_lim 3 0.85 -r_lim 4 0.9 -r_lim 5 0.95

rvb_l.wav: reverb.sf Makefile
	snd_resample -F -q16 1.0 -i reverb.sf |				\
	dd bs=4096 skip=256 |						\
	maximizer - - $(MFLAGS) |					\
	maximizer - - $(LFLAGS) |					\
	float2wav16 $@ 2 $(SRATE)

drums.ogg: rvb_l.wav
	oggenc -s 1234 -q 6 -o $@ $<

