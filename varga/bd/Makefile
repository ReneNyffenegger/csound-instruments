
CS = csound
CSFLAGS = -d -m7 -H1 -s -W

TARGETS = bd01 bd02 bd03 bd10 bd10_01 bd11 bd14_01			\
	  bd4004m-01 bd4004m-02 bd4004m-03				\
	  bd4004m-04 bd4004m-05 bd4004m-06				\
	  bd4006 bd5000 bd_1600 bd_4014m				\
	  drum_05_04 drum_0600 drum_06_01 drum_08			\
	  hcbd_0001 hcbd_0002

# -----------------------------------------------------------------------------

WAVS = $(patsubst %,%.wav,$(TARGETS))

all: $(WAVS)

%.wav: %.orc %.sco
	$(CS) $(CSFLAGS) -o $@ $*.orc $*.sco

clean:
	rm -f *.wav *.sf *.pcm *.dat score.srt

