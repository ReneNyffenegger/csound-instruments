include ../setup.mk

dirs = accci barrass-stephen brandt byrne cascone clarke comajuncosas \
compositions cook costello csound-book dal-porto diffamator dobson \
dodge dx7 dx7-pinkston-varo eastman ffitch fischman fredrics gui hamel \
harris keller king lyon maldonado midi mikelson miller molyneux moss \
noorden oi pavan pinkston pocino real-time-mccurdy risset \
rossing smaragdis spjut themis udo varga varios vectro winkler \
xscanned

.PHONY: accci

all:
	for d in $(dirs) ;\
	do \
	cd $$d && $(MAKE) ; cd .. ;\
	done

clean:
	for d in $(dirs) ;\
	do \
	cd $$d && $(MAKE) cleanall; cd .. ;\
	done

dist:
	git archive --format=tar --prefix=instrumentos-csound/ HEAD | gzip > instrumentos-csound.tar.gz