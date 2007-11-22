;*** Warning! This example is not intended to be heard, but only to visualize the generated signals 
;*** with a wave editor. Don't attempt to hear it, because very low frequencies could damage the speakers

;*** lineto, tlineto and metro example
;*** opcode signal is placed in left channel, while original signal 
;*** is placed in right channel, in order to allow the user to compare them

  sr        =  40000
  kr        =  4000
  ksmps     =  10
  nchnls    =  2

;*** lineto with a stepped signal
instr   1
  kg        line      0,p3,.9

  k1        randh     20000, 1,.123
  aorig     upsamp    k1
  k1        lineto    k1,kg
  a1        upsamp    k1
            outs      a1,aorig
endin

;*** lineto with a oblique signal
instr   2
  kg        line      .1,p3,.4

  k1        rand      20000
  aorig     upsamp    k1
  k1        lineto    k1,kg
  a1        upsamp    k1
            outs      a1,aorig
endin

;*** tlineto with a random signal triggered by metro
instr   3
  kg        line      0,p3,.18
  ktrig     metro     5

  k1        rand      20000, 2,.123
  aorig     upsamp    k1
  k1        tlineto   k1,kg,ktrig
  a1        upsamp    k1
            outs      a1,aorig
endin



