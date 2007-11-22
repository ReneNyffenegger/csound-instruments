  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1

instr 1
  kenv      linen     p5,  p6,  p3,  p7           ; amplitude envelope
  ipitch    =  cpspch(p4)
  amod      oscili    p9*ipitch,  p8,  100        ; modulating oscillator
  acar      oscili    kenv,  ipitch + amod,  100  ; carrier oscillator
            out       acar
endin

