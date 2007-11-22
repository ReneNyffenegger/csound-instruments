  sr        =  44100
  kr        =  100
  ksmps     =  441
  nchnls    =  2

  ginsr     =  44100
  gisize65  =  ginsr/65536
  gisize32  =  ginsr/32768
  gisize16  =  ginsr/16384
  gisize8   =  ginsr/8192
  gisize4   =  ginsr/4096


instr          1                                            ; EL. PIANO
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY

  kgate     linenr    ivel/127, 0, .2, .01        ; GATE
  a1        oscil     10000, (inote/440) * gisize65, 11

            outs      a1 * kgate, a1 * kgate

  ga1l      =  a1 * kgate                         ; AUX OUT L
  ga1r      =  a1 * kgate                         ; AUX OUT R

endin

instr 2                                                     ; SYNTH BASS
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY
     
  kgate     linenr    ivel/127, 0, .1, .01        ; GATE
  a1        oscil     25000, (inote/220) * gisize32, 10

            outs      a1 * kgate, a1 * kgate

  ga2l      =  a1 * kgate                         ; AUX OUT L
  ga2r      =  a1 * kgate                         ; AUX OUT R
     
endin

instr 4                                                     ; MUTED GUITAR
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY

  kgate     linenr    ivel/127, 0, .4, .01        ; gate
  a1        oscil     30000, (inote/220) * gisize16, 12

            outs      a1 * kgate, a1 * kgate

  ga1l      =  a1 * kgate                         ; AUX OUT L
  ga1r      =  a1 * kgate                         ; AUX OUT R

endin

instr 8                                                     ; STRINGS
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY
     
  kgate     linenr    ivel/127, 0, .1, .01        ; GATE
  a1        loscil    30000, (inote/440) * gisize65, 13, 2/3, 1, 40002, 64641

            outs      a1 * kgate, a1  * kgate

  ga2l      =  a1 * kgate                         ; AUX OUT L
  ga2r      =  a1 * kgate                         ; AUX OUT R
     
endin

instr 16
  ivl       veloc                                 ; GET VELOCITY

  imod      =  0
  irel      =  .2
  inn       notnum                                ; FIND WHICH DRUM

if        inn == 45 igoto     bd
if        inn == 52 igoto     sd
if        inn == 57 igoto     hhc
if        inn == 59 igoto     hho
if        inn == 61 igoto     lcr
if        inn == 66 igoto     hcr
if        inn == 76 igoto     hst
if        inn == 74 igoto     mst
if        inn == 72 igoto     lst
     
            igoto     oops

bd:
  ift       =  1
  ifr       =  gisize16
            igoto     kstuff
sd:
  ift       =  2
  ifr       =  gisize32
            igoto     kstuff
hhc:
  ift       =  3
  ifr       =  gisize16
            igoto     kstuff
hho:
  ift       =  4
  ifr       =  gisize16
            igoto     kstuff
lcr:
  ift       =  5
  irel      =  .4
  ifr       =  gisize32
            igoto     kstuff
hcr:
  ift       =  5
  imod      =  .4
  irel      =  .5
  ifr       =  gisize32
            igoto     kstuff
hst:
  ift       =  6
  imod      =  0
  ifr       =  gisize8
            igoto     kstuff
mst:
  ift       =  6
  imod      =  -.2
  ifr       =  gisize8
            igoto     kstuff
lst:
  ift       =  6
  imod      =  -.4
  ifr       =  gisize8
            igoto     kstuff
oops:
                                                            ; DUMMY FTABLE FOR WRONG NOTES
  ift       =  2876

kstuff:

  kgate     linenr    ivl/127, 0, irel, .01       ; GATE
  kgate     =  1

  a1        oscil     15000, ifr + imod, ift
     
            outs      a1 * kgate, a1 * kgate

  ga16l     =  a1 * kgate                         ; AUX OUT L
  ga16r     =  a1 * kgate                         ; AUX OUT R

endin

instr          99
  ga1l      init      0
  ga1r      init      0
  ga2l      init      0
  ga2r      init      0
  ga16l     init      0
  ga16r     init      0

  galll     =  ga1l + ga2l + ga16l
  gallr     =  ga1r + ga2r + ga16r

  arevl     reverb    galll/7, .7
  arevr     reverb    gallr/7, .8

            outs      arevl, arevr

endin
