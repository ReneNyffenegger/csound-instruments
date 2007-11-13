  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   901
  inotedur  =  p3
  imaxamp   =  ampdb(p4)
  icarrfreq =  p5
  imodfreq  =  p6
  ilowndx   =  p7
  indxdiff  =  p8-p7

; PARAMETERS DEFINING THE ADSR AMPLITUDE ENVELOPE
; TIMES ARE A PERCENTAGE OF p3
;   attack amp  = p9     attack length  = p14
;   decay amp   = p10    decay length   = p15
;   sustain amp = p11    sustain length = p16
;   release amp = p12    release length = p17
;   end amp     = p13

; PARAMETERS DEFINING THE ADSR FREQ DEVIATION ENVELOPE
; TIMES ARE A PERCENTAGE OF p3
;   attack amp  = p18    attack length  = p23
;   decay amp   = p19    decay length   = p24
;   sustain amp = p20    sustain length = p25
;   release amp = p21    release length = p26
;   end amp     = p22

  aampenv   linseg    p9, p14*p3, p10, p15*p3, p11, p16*p3, p12, p17*p3, p13
  adevenv   linseg    p18, p23*p3, p19, p24*p3, p20, p25*p3, p21, p26*p3, p22
  amodosc   oscili    (ilowndx+indxdiff*adevenv)*imodfreq, imodfreq, 1
  acarosc   oscili    imaxamp*aampenv, icarrfreq+amodosc, 1
            out       acarosc
endin
