;========================================
;Simple demonstration of the event opcode
;RP
;========================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr   1
  kamp      linseg    2000,p3,30000               ;gradually get louder
  kpit      linseg    11,p3,8                     ;gliss down 3 octaves
  klast     init      1                           ;initialize last phase val
  kphase    phasor    20
; The next line tests to see if the phasor has started a new
; cycle. If it has, then we'll make a new event. Otherwise,
; we'll skip over the event opcode and wait.
if      (kphase >= klast) kgoto skip
            event     "i",2,0,.025,kamp,kpit
skip:
  klast     =  kphase                             ;remember last phase val
endin

instr   2       ;simple blip
  agate     linen     p4,.001,p3,.01
  asig      oscili    agate,cpsoct(p5),1
            outs      asig,asig
endin
