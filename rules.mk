OUTPUT = 2> /dev/null

%.wav: %.orc %.sco
ifeq ($(debug),0)
	@echo -ne "$@:\t"
	@csound -g -o $@ $(wordlist 1, 2, $^) 2>&1 | grep "errors in performance"
else	
	@csound -g -o $@ $(wordlist 1, 2, $^)
endif

%.pvx: %.aif
	@pvanal -n 1024 -w 8 $< $(SADIR)/$@ $(OUTPUT)

%.pvx: %.wav
	@pvanal -n 1024 -w 8 $< $(SADIR)/$@ $(OUTPUT)

%.con: %.wav
	@cvanal $< $(SADIR)/$@ $(OUTPUT)

play:
	play $(SFDIR)/$(file)

cleanall: clean cleananal

clean:
	@rm -f $(fullwavfiles)

cleananal:
	@rm -f $(SADIR)/*.*
