
# -----------------------------------------------------------------------------

CS = csound
RESAMPLE = snd_resample -v -q256
RM = rm -f

# -----------------------------------------------------------------------------

all: samples instrs

instrs: crash.wav hihat1.wav hihat2.wav ride1.wav ride2.wav drum_08.wav	     \
	clap1.wav rimshot.wav snare1.wav tom.wav crash2.wav hihat1a.wav

samples: cym_sample-crash.pcm cym_sample-hihat1.pcm cym_sample-hihat2.pcm    \
	 cym_sample-ride1.pcm cym_sample-ride2.pcm cym_sample-crash2.pcm     \
	 cym_sample-hihat1a.pcm

oggs: instrs
	j=1; for i in *.wav ; do					     \
		oggenc -s $$j -q 1 -o `basename $$i .wav`.ogg $$i ;	     \
		let "j=j+1" ;						     \
	done

clean:
	$(RM) *.sf *.wav *.pcm *.srt *.ogg

# -----------------------------------------------------------------------------

# create sample files for cymbal instruments

cym_sample-%.pcm: cym_sample.orc cym_sample-%.sco
	$(CS) -d -m7 -H1 -f -J -o tmp.sf cym_sample.orc cym_sample-$*.sco
	$(RESAMPLE) -F -R 192000 -o $@ -i tmp.sf
	$(RM) tmp.sf

%.wav: %.orc %.sco
	$(CS) -d -m7 -H1 -s -W -o $@ $*.orc $*.sco

# -----------------------------------------------------------------------------

