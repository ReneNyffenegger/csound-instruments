; Orchestra file used to create this soundfile
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

   ;  score p-fields:
   ;  p4 =  soundin.# number {source soundfile} , p5 = skip time
   ;  amplitude modulation :
   ;     p9 =  opening % of audio signal to be modulated
   ;     p10 =  closing % of signal to be modulated
   ;     p11 =  modulating frequency (can be sub-audio or audio rate)

instr 1
  asig      soundin   p4, p5                      ; read in a soundfile
   ; add a fade-in/fade-out amplitude envelope & multiplier
  p7        =  (p7 = 0 ? .0001 : p7)              ; protect against illegal 0 values
  p8        =  (p8 = 0 ? .0001 : p8)              ; protect against illegal 0 values
  kamp      expseg    .01, p7 , p6 , p3 - (p7 + p8) , p6 , p8 , .01
  asig      =  asig * kamp

  ; apply amplitude modulation to these samples
  kmod      line      p9,  p3  , p10              ;  controls % of signal to be modulated
  knomod    =  (1. - kmod )                       ; non-modulated
  ampmod    oscili    kmod , p11 , 1              ; amplitude modulation oscillator
  asig      =  (knomod * asig)  +  (ampmod * asig)
            out       asig
endin

