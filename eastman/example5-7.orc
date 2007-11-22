  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

 ; p4  = soundin.#   sflink  number
 ; p5 = amplitude multiplier      ; p6 = skip from front of soundfile
 ; p7 = exponential fade in time ; p8 = exponential fade out time
 ;  comb filter:  p9  =  comb reverb time , p10  =  comb loop time

instr 1

  inputdur  =  p3 - .3                            ; duration of audio input (.3 seconds shorter than output duration)
  audio     soundin   p4 , p6

 ;    output amplitude envelope: includes optional fade-in & fade-out  and
 ;    .3 seconds at tend to mute any input signal
  iamp      =  (p5 = 0 ? 1: p5 )
  ifadein   =  (p8 =0?.001:p8 )
  ifadeout  =  (p8 =0?.001:p8 )
  amp       expseg    .01,ifadein ,iamp,inputdur-(ifadein +ifadeout ),iamp,ifadeout ,.01 , .3 , .001
  audio     =  audio * amp

  aout      comb      audio ,p9, p10
            out       aout
endin

