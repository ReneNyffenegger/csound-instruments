include ../../../setup.mk

all: fita1.wav fita2.wav fita3.wav fita4.wav fita5.wav fita6.wav fita7.wav

fita1.wav: fitan.orc fita1.sco
ifeq ($(debug),0)
	@echo -ne "$@:\t"
	@csound -g -o $@ $(wordlist 1, 2, $^) 2>&1 | grep "errors in performance"
else	
	@csound -g -o $@ $(wordlist 1, 2, $^)
endif

fita2.wav: fitan.orc fita2.sco
ifeq ($(debug),0)
	@echo -ne "$@:\t"
	@csound -g -o $@ $(wordlist 1, 2, $^) 2>&1 | grep "errors in performance"
else	
	@csound -g -o $@ $(wordlist 1, 2, $^)
endif

fita3.wav: fitan.orc fita3.sco
ifeq ($(debug),0)
	@echo -ne "$@:\t"
	@csound -g -o $@ $(wordlist 1, 2, $^) 2>&1 | grep "errors in performance"
else	
	@csound -g -o $@ $(wordlist 1, 2, $^)
endif

fita4.wav: fitan.orc fita4.sco
ifeq ($(debug),0)
	@echo -ne "$@:\t"
	@csound -g -o $@ $(wordlist 1, 2, $^) 2>&1 | grep "errors in performance"
else	
	@csound -g -o $@ $(wordlist 1, 2, $^)
endif

fita5.wav: fitan.orc fita5.sco
ifeq ($(debug),0)
	@echo -ne "$@:\t"
	@csound -g -o $@ $(wordlist 1, 2, $^) 2>&1 | grep "errors in performance"
else	
	@csound -g -o $@ $(wordlist 1, 2, $^)
endif

fita6.wav: fitan.orc fita6.sco
ifeq ($(debug),0)
	@echo -ne "$@:\t"
	@csound -g -o $@ $(wordlist 1, 2, $^) 2>&1 | grep "errors in performance"
else	
	@csound -g -o $@ $(wordlist 1, 2, $^)
endif

fita7.wav: fitan.orc fita7.sco
ifeq ($(debug),0)
	@echo -ne "$@:\t"
	@csound -g -o $@ $(wordlist 1, 2, $^) 2>&1 | grep "errors in performance"
else	
	@csound -g -o $@ $(wordlist 1, 2, $^)
endif

include ../../../rules.mk
