include ../../setup-new.mk

export MALLOC_CHECK_=0

all: pvoc-01.wav pvoc-02.wav

pvoc-01.wav: pvoc-01.orc pvoc-01.sco dickens.pvx
pvoc-02.wav: pvoc-02.orc pvoc-02.sco dickens.pvx
pvoc-03.wav: pvoc-03.orc pvoc-03.sco traffic.pvx

include ../../rules.mk
