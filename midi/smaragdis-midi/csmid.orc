  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  icps      cpsmidi   
  iamp      ampmidi   25000
; kbend        pchbend   100
  kval      midictrl  1
  kscale    =  kval * 5
  kamp      expon     iamp, 5, .001
  amp       linenr    kamp, .01, .333, .05
; a1           oscil     amp, icps+kbend, 1
  a1        oscil     amp, icps+kscale, 1
            out       a1
endin

