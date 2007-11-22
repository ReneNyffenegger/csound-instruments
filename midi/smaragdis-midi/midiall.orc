  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  ginsr     =  44100
  gisize32  =  ginsr/32768
  gisize65  =  ginsr/65536


instr 1                                           ; MIDI SINE INST
  icps      cpsmidi   
  iamp      ampmidi   10000, 100
  aeg       linenr    iamp, .2, 1, .01
  asig      oscil     aeg, icps, 1
            outs      asig, asig
endin

instr     2
  icps      cpsmidi   
  iamp      ampmidi   5000, 4
  kamp      expon     iamp, 5, iamp/icps          ;FREQ-DEPENDENT OVERALL DECAY
  amp       linenr    kamp, .01, .333, .05
  asig      oscil     amp, icps, 1
            outs      asig, asig
endin
     
instr 3                                      ; MIDI ORGAN WITH VIBRATO
  icps      cpsmidi   
  iamp      ampmidi   10000, 100
  aeg       linenr    iamp, .2, 2, .01
  kvib      oscil     icps * .017, 6, 1
  asig      oscil     aeg, icps + kvib, 2             
            outs      asig, asig
endin

instr 4                                           ; SLOW STRINGS (SUB)
  kfreq     cpsmidib  
  iveloc    veloc     
  kgate     linenr    iveloc/128, 0, .5, .1

  k1        linseg    0, .5, 32000, .5, 25000
  k2        oscil     kfreq*.005, 3, 1
  a1        oscil     k1, kfreq + k2, 3
  a2        oscil     k1, kfreq + k2 + 1, 3
  a3        oscil     k1, 2*(kfreq + k2), 3
  a1        butterlp  a1 + a2 + a3, 1200
            outs      a1/4 * kgate, a1/4 * kgate
endin

instr 5                                                     ; WAVETABLE EL. PIANO
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY
  kgate     linenr    ivel/127, 0, .2, .01        ; GATE
  a1        oscil     10000, (inote/440) * gisize65, 11
            outs      a1 * kgate, a1 * kgate
endin          

instr 6                                                     ; EL. PIANO
  inote     cpsmidi   
  ivel      veloc     0, 20000                   

  kvol      midictrl  7, 0, ivel
  kpan      midictrl  10, 0, 1

  kgate     linenr    kvol, 0, .2, .01
  a1        loscil    kgate, inote, 11, 110

            outs      a1 * kpan, a1 * (1 - kpan)
endin



instr          7                                            ;FM SQUARE SYNTH
  icps      cpsmidi   
  iamp      ampmidi   10000, 100
  iscale    =  iamp / 2000
  iattk     =  .1
  keg       expseg    .001, iattk, 1, .1, .6, .2, .9, .3, .6, 1, .001, 999, .001
  keg       linenr    iamp * keg, iattk, .5, .25
  kmeg      expseg    .001, iattk, iscale, .3, .9, .1, .6, 1, .001, 999, .001
  asig      foscil    keg, icps, 1, 2.002, kmeg, 1
            outs      asig, asig
endin

instr   8                                                   ; WAVESHAPING
  icps      cpsmidi   
  iamp      ampmidi   256, 100
  iscale    =  iamp*20
  kamp      linseg    0, .01, iamp, .35, iamp-30, 5, 0
  ktabmov   linseg    0, .01,  512, .35, 1024, 2, 1536, 5, 0
  awtosc    oscil     kamp, icps, 1
  asig      table     awtosc + 256 + ktabmov, 5, 0, 0, 1
  aeg       linenr    iscale, .01, .5, .01
            outs      asig * aeg, asig * aeg
endin


instr 10
  ivl       veloc                                 ; GET VELOCITY
  imod      =  0
  irel      =  .2
  inn       notnum                                ; FIND WHICH DRUM
if        inn == 45      igoto     tbd
if        inn == 52      igoto     lsd
if        inn == 57      igoto     hhc
if        inn == 59      igoto     hho
if        inn == 61      igoto     lcr
if        inn == 62      igoto     rdb
if        inn == 66      igoto     hcr
if        inn == 86      igoto     lbk
if        inn == 88      igoto     hbk
if        inn == 43      igoto     htm
if        inn == 42      igoto     mtm
if        inn == 41      igoto     ltm
if        inn == 40      igoto     ftm
          
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
            outs      asig * kgate, asig * kgate
endin

instr 9,11,12,13,14,15,16
endin
