  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01
     
  kva       line      0, 3, .02
  kv        oscil     knote*kva, 4, 3

  kf        linseg    2200, 1.5, 1200, .5, 880, 5, 440
     
  k1        linseg    8000, .5, 8000, 5, 2000
  k2        line      700, .5, 700
     
  a5        oscil     k2, knote, 3
  a6        oscil     k2, knote*1.499, 3

  a1        oscil     k1, knote*2.001 + a5 + kv, 3
  a2        oscil     k1, knote*1.502 + a6 + kv, 3
  a2        butterlp  a2 + a1, kf

            out       a2 * kgate
endin

; SUBSTITUTE KNOTE FOR ALL AUDIO OSCILLATOR FREQUENCY ARGUMENTS
; MULTIPLY THE OUTPUT BY KGATE
; INSERT KNOTE ...  IVELOC... AND KGATE .... AT THE START OF EACH INSTRUMENT
;knote    cpsmidib
;iveloc   ampmidi   1
;kgate    linenr    iveloc, 0, .2, .01
