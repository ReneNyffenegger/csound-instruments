  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  asig      soundin   p4, p6                      ; read in the soundfile
   ; now apply a new envelope to these samples
  kamp      expseg    .005 ,p7  , p5  , p3 - (p7 + p8) , p9 , p8 , .005

; < amp. envelopeasig = asig * kamp
; supply a moving stereo pan between left & right channels

  kpan      oscili    1. ,  p10/p3 , p11          ; panning control signal
            outs      kpan * asig , (1. - kpan) * asig
endin

   ;  score p-fields:
   ;  p4 =  soundin.number {source soundfile} , p6 = skip time
   ;  new amplitude envelope {p5, 7, 8 & 9}
   ;     p5 = "peak" level multiplier
   ;     p7 = rise {fade-in} time
   ;     p8 = decay {fade-out} time
   ;     p9 = "steady-state" level  multiplier
   ;  moving stereo pan {p10 & p11} :
   ;     p10 =  number of left-right pans per note
   ;     p11 = function number for moving pans
