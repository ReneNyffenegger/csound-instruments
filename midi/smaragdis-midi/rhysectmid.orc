  sr        =  44100
  kr        =  100
  ksmps     =  441
  nchnls    =  1

  ginsr     =  44100
  gisize65  =  ginsr/65536
  gisize32  =  ginsr/32768
  gisize16  =  ginsr/16384
  gisize8   =  ginsr/8192
  gisize4   =  ginsr/4096


instr 1                                                     ; EL. PIANO
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY

  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!
     
  kgate     linenr    ivel/127, 0, .2, .01        ; GATE
  a1        oscil     10000, (inote/440) * gisize65, 121

            out       a1 * ipn * kgate

  ga1l      =  a1 * ipn * kgate                   ; AUX OUT L
  ga1r      =  a1 * (1 - ipn) * kgate             ; AUX OUT R

endin

instr 2                                                     ; SYNTH BASS
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY
  isem      =  .059463094                         ; 1 SEMITONE = 2^(1/12)
  kpb       pchbend   2 * isem * inote            ; BEND OF 2 SEMITONES
  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!
     
  kgate     linenr    ivel/127, 0, .5, .01        ; GATE
  a1        oscil     25000, ((inote + kpb)/220) * gisize32, 110

            out       a1 * ipn * kgate

  ga2l      =  a1 * ipn * kgate                   ; AUX OUT L
  ga2r      =  a1 * (1 - ipn) * kgate             ; AUX OUT R
     
endin

instr 4                                                     ; MUTED GUITAR
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY

  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!
     
  kgate     linenr    ivel/127, 0, .4, .01        ; GATE
  a1        oscil     30000, (inote/220) * gisize32, 112

            out       a1 * ipn * kgate

  ga1l      =  a1 * ipn * kgate                   ; AUX OUT L
  ga1r      =  a1 * (1 - ipn) * kgate             ; AUX OUT R

endin

instr 5                                                     ; WOOD BASS
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY

  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!
     
  kgate     linenr    ivel/127, 0, .4, .01        ; GATE
  a1        oscil     30000, (inote/220) * gisize32, 120

            out       a1 * ipn * kgate

  ga1l      =  a1 * ipn * kgate                   ; AUX OUT L
  ga1r      =  a1 * (1 - ipn) * kgate             ; AUX OUT R

endin

instr 6                                                     ; JUMP BRASS
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY

  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!
     
  kgate     linenr    ivel/127, 0, .1, .01        ; GATE
  a1        oscil     8000, (inote/440) * gisize32, 115

            out       a1 * ipn * kgate

  ga1l      =  a1 * ipn * kgate                   ; AUX OUT L
  ga1r      =  a1 * (1 - ipn) * kgate             ; AUX OUT R

endin

instr          8                                            ; STRINGS
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY
  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!
     
  kgate     linenr    ivel/127, 0, .1, .01        ; GATE
  a1        loscil    30000, (inote/440) * gisize65, 114, 2/3, 1, 40002, 64641

            out       a1 * ipn * kgate

  ga2l      =  a1 * ipn * kgate                   ; AUX OUT L
  ga2r      =  a1 * (1 - ipn) * kgate             ; AUX OUT R
     
endin

instr 10                                                    ; SYNTH LEAD
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY
  isem      =  .059463094                         ; 1 SEMITONE = 2^(1/12)
  kpb       pchbend   2 * isem * inote            ; BEND OF 2 SEMITONES
  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!
     
  kgate     linenr    ivel/127, .02, .02, .01     ; gate
  kpeg      linseg    -isem*inote, .3, 0, 10, 0
  a1        oscil     25000, (inote + kpb + kpeg), 116

            out       a1 * ipn * kgate

  ga2l      =  a1 * ipn * kgate                   ; AUX OUT L
  ga2r      =  a1 * (1 - ipn) * kgate             ; AUX OUT R
     
endin

instr 15                                                    ; IVAN'S GUITAR
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY
  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!
     
  kgate     linenr    ivel/127, 0, .7, .1         ; gate
  a1        oscilx    25000, (inote/((4/3)*220)) * gisize32, 119, 1

            out       a1 * ipn * kgate

  ga2l      =  a1 * ipn * kgate                   ; AUX OUT L
  ga2r      =  a1 * (1 - ipn) * kgate             ; AUX OUT R
     
endin

instr          16
  ivl       veloc                                 ; GET VELOCITY

  ipn       gauss     .5                          ; GAUSSIAN PANNING!
  ipn       =  ipn + .5                           ; CENTER IT!

  imod      =  0
  ilvl      =  10000
  irel      =  .2
  inn       notnum                                ; Find which drum

if        inn == 44 igoto     pbd
if        inn == 45 igoto     tbd
if        inn == 46 igoto     psd  
if        inn == 52 igoto     lsd
if        inn == 57 igoto     hhc
if        inn == 59 igoto     hho
if        inn == 61 igoto     lcr
if        inn == 62 igoto     rdb
if        inn == 63 igoto     rde
if        inn == 66 igoto     hcr
if        inn == 76 igoto     hst
if        inn == 74 igoto     mst
if        inn == 72 igoto     lst
if        inn == 56 igoto     shk
if        inn == 86 igoto     lbk
if        inn == 88 igoto     hbk
if        inn == 43 igoto     htm
if        inn == 42 igoto     mtm
if        inn == 41 igoto     ltm
if        inn == 40 igoto     ftm
if        inn == 92 igoto     hmr
     
            igoto     oops

pbd:
  ift       =  10
  irel      =  .5
            igoto     kstuff
tbd:
  ift       =  1
            igoto     kstuff
psd:
  ift       =  11
  irel      =  .4
            igoto     kstuff
lsd:
  ift       =  2
            igoto     kstuff
hhc:
  ift       =  3
  ilvl      =  7000
            igoto     kstuff
hho:
  ift       =  4
  ilvl      =  7000
            igoto     kstuff
lcr:
  ift       =  5
  irel      =  .4
            igoto     kstuff
hcr:
  ift       =  5
  imod      =  .4
  irel      =  .5
            igoto     kstuff
hst:
  ift       =  6
  imod      =  0
            igoto     kstuff
mst:
  ift       =  6
  imod      =  -.2
            igoto     kstuff
lst:
  ift       =  6
  imod      =  -.4
            igoto     kstuff
shk:
  ift       =  7
            igoto     kstuff
hbk:
  ift       =  8
            igoto     kstuff
lbk:
  ift       =  8
  imod      =  -.4
            igoto     kstuff
htm:
  ift       =  9
  ilvl      =  7000
            igoto     kstuff
mtm:
  ift       =  9
  ilvl      =  7000
  imod      =  -.2
            igoto     kstuff
ltm:
  ift       =  9
  ilvl      =  7000
  imod      =  -.4
            igoto     kstuff
ftm:
  ift       =  9
  ilvl      =  7000
  imod      =  -.6
            igoto     kstuff
rdb:
  ift       =  13
  irel      =  .5
            igoto     kstuff
rde:
  ift       =  14
  irel      =  .5
  ilvl      =  7000
            igoto     kstuff
hmr:
  ift       =  12
            igoto     kstuff
oops:
                                                            ; DUMMY FTABLE FOR WRONG NOTE
  ift       =  2876

kstuff:

  kgt       linenr    200 * ivl, 0, irel, .01     ; gate

  a1        oscilx    ilvl, gisize32 + imod, ift, 1
     
            out       a1 * ipn

  ga16l     =  a1 * ipn                           ; AUX OUT L
  ga16r     =  a1 * (1 - ipn)                     ; AUX OUT R

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

            out       arevl
endin
