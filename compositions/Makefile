dirs = alves amaro antosca bantha barrass-tim bergeman berry bianchini \
boulanger bush cascone cooper costello curtin ffitch flavio harrington \
huber hunkins jamary klapper kung Makefile mariano mikelson moss \
pagano pavan piche pierce schertzer sofia volkov whittle

all:
	for d in $(dirs) ;\
	do \
	cd $$d && $(MAKE) ; cd .. ;\
	done

cleanall:
	for d in $(dirs) ;\
	do \
	cd $$d && $(MAKE) cleanall; cd .. ;\
	done

