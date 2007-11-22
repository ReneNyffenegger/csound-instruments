; Audio-Rate Amplitude Modulation Instrument :
;  p3 = duration   p4 = pitch   p5 = amplitude  p6 = Attack time  p7 = decay time
;   p8 = ratio of modulating freq. to p4
;   p9 = 1st  amplitude modulation %
;   p10 = 2nd  amplitude modulation %
;   p11 = Function number controlling change in a. m. %
;   p12 = Function number for modulating oscillator

  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1

instr 1
  ipitch    =  cpspch(p4)
  kenv      linen     p5,  p6,  p3,  p7           ; amplitude envelope
; amplitude modulation :
  kmod      oscili    (p10 - p9),  1/p3,  p11     ; difference between 1st & 2nd a. m. %
  kmod      =  kenv * (kmod + p9)                 ; % of signal to be amp. modulated
  knomod    =  kenv - kmod                        ; % of signal NOT amp. modulated
  ampmod    oscili    kmod, ipitch * p8, p12      ; modulating oscillator

  audio     oscili    ampmod + knomod, ipitch , 1 ; carrier oscillator
            out       audio
endin
