  ginsr     =  44100
  gisize32  =  ginsr/32768
  gisize65  =  ginsr/65536

instr 1
  ivl       veloc                                 ; GET VELOCITY
  imod      =  0
  irel      =  .2
  inn       notnum                                ; FIND WHICH DRUM
if   inn == 45      igoto     tbd
if   inn == 52      igoto     lsd
if   inn == 57      igoto     hhc
if   inn == 59      igoto     hho
if   inn == 61      igoto     lcr
if   inn == 62      igoto     rdb
if   inn == 66      igoto     hcr
if   inn == 86      igoto     lbk
if   inn == 88      igoto     hbk
if   inn == 43      igoto     htm
if   inn == 42      igoto     mtm
if   inn == 41      igoto     ltm
if   inn == 40      igoto     ftm
          
            igoto     oops

tbd:
  ift       =  101
            igoto     kstuff
lsd:
  ift       =  102
            igoto     kstuff
hhc:
  ift       =  103
            igoto     kstuff
hho:
  ift       =  104
            igoto     kstuff
lcr:
  ift       =  105
  irel      =  .4
            igoto     kstuff
hcr:
  ift       =  105
  imod      =  .4
  irel      =  .5
            igoto     kstuff
hbk:
  ift       =  108
            igoto     kstuff
lbk:
  ift       =  108
  imod      =  -.4
            igoto     kstuff
htm:
  ift       =  109
            igoto     kstuff
mtm:
  ift       =  109
  imod      =  -.2
            igoto     kstuff
ltm:
  ift       =  109
  imod      =  -.4
            igoto     kstuff
ftm:
  ift       =  109
  imod      =  -.6
            igoto     kstuff
rdb:
  ift       =  110
  irel      =  .5
            igoto     kstuff
oops:
                                                       ; DUMMY FTABLE FOR WRONG NOTE
  ift       =  101
  irel      =  .1
            igoto     kstuff

kstuff:
  kgate     linenr    200 * ivl, 0, irel, .01     ; gate
  asig      oscil     30000, gisize32 + imod, ift
            out       asig * kgate
endin
