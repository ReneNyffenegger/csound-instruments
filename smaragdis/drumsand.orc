  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  ginsr     =  44100
  gisize65  =  ginsr/65536
  gisize32  =  ginsr/32768
  gisize16  =  ginsr/16384
  gisize8   =  ginsr/8192
  gisize4   =  ginsr/4096


instr 1                                                     ; El. piano
  inote     cpsmidi                               ; Get note
  ivel      veloc                                 ; Get velocity

  ipn       gauss     .5                          ; Gaussian panning!
  ipn       =  ipn + .5                           ; Center it!
     
  kgate     linenr    ivel/127, 0, .2, .01        ; gate
  a1        oscil     10000, (inote/440) * gisize65, 11

            outs      a1 * ipn * kgate, a1 * (1 - ipn) * kgate

  ga1l      =  a1 * ipn * kgate                   ; Aux out L
  ga1r      =  a1 * (1 - ipn) * kgate             ; Aux out R

endin

instr 2                                                     ; Synth bass
  inote     cpsmidi                               ; Get note
  ivel      veloc                                 ; Get velocity
  ipn       gauss     .5                          ; Gaussian panning!
  ipn       =  ipn + .5                           ; Center it!
     
  kgate     linenr    ivel/127, 0, .1, .01        ; gate
  a1        oscil     25000, (inote/220) * gisize32, 10

            outs      a1 * ipn * kgate, a1 * (1 - ipn) * kgate

  ga2l      =  a1 * ipn * kgate                   ; Aux out L
  ga2r      =  a1 * (1 - ipn) * kgate             ; Aux out R
     
endin

instr 4                                                     ; Muted guitar
  inote     cpsmidi                               ; Get note
  ivel      veloc                                 ; Get velocity

  ipn       gauss     .5                          ; Gaussian panning!
  ipn       =  ipn + .5                           ; Center it!
     
  kgate     linenr    ivel/127, 0, .4, .01        ; gate
  a1        oscil     30000, (inote/220) * gisize32, 12

            outs      a1 * ipn * kgate, a1 * (1 - ipn) * kgate

  ga1l      =  a1 * ipn * kgate                   ; Aux out L
  ga1r      =  a1 * (1 - ipn) * kgate             ; Aux out R

endin

instr 8                                                     ; Strings
  inote     cpsmidi                               ; Get note
  ivel      veloc                                 ; Get velocity
  ipn       gauss     .5                          ; Gaussian panning!
  ipn       =  ipn + .5                           ; Center it!
     
  kgate     linenr    ivel/127, 0, .1, .01        ; gate
  a1        loscil    30000, (inote/440) * gisize65, 14, 2/3, 1, 40002, 64641

            outs      a1 * ipn * kgate, a1 * (1 - ipn) * kgate

  ga2l      =  a1 * ipn * kgate                   ; Aux out L
  ga2r      =  a1 * (1 - ipn) * kgate             ; Aux out R
     
endin

instr 16
  ivl       veloc                                 ; Get velocity

  ipn       gauss     .5                          ; Gaussian panning!
  ipn       =  ipn + .5                           ; Center it!

  imod      =  0
  irel      =  .2
  inn       notnum                                ; Find which drum

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
            igoto     kstuff
sd:
  ift       =  2
            igoto     kstuff
hhc:
  ift       =  3
            igoto     kstuff
hho:
  ift       =  4
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
oops:
                                                       ; Dummy ftable for wrong note
  ift       =  2876

kstuff:

  kgt       linenr    200 * ivl, 0, irel, .01     ; gate

  a1        oscilx    10000, gisize32 + imod, ift, 1
     
            outs      a1 * ipn, a1 * (1 - ipn)

  ga16l     =  a1 * ipn                           ; Aux out L
  ga16r     =  a1 * (1 - ipn)                     ; Aux out R

endin

instr 99
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
