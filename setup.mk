export SFDIR = /home/kroger/csound/sfdir/
export SSDIR = /home/kroger/csound/ssdir/
export SADIR = /home/kroger/csound/sadir/

debug = 0

vpath %.aif $(SSDIR)
vpath %.aiff $(SSDIR)
vpath %.wav $(SSDIR)
vpath %.wav $(SFDIR)
vpath %.pvx $(SADIR)
vpath %.con $(SADIR)
vpath %.het $(SADIR)
vpath %.lpc $(SADIR)

wavfiles = $(subst .sco,.wav,$(wildcard *.sco))
fullwavfiles = $(addprefix $(SFDIR),$(wavfiles))
