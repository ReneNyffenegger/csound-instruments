; ************************************************************************
; ACCCI:      33-10-1.ORC
; synthesis:  Amplitude Modulation(33)
;             ring modulation, exterior soundfile (10)
;             speech1.wav(1)
; coded:      jpg 2/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqm      =  p5
  ifm       =  p6
  istsec    =  p7
   
  a1        soundin   "speech1.wav", istsec       ; carrier is speech file
  a2        line      .25, idur, .25              ; control signal
  a1        balance   a1, a2                      ; normalize a1
   
  amod      oscili    iamp, ifqm, ifm             ; modulator
  aenv      linen     1, .1, idur, 1              ; envelope
            out       a1*amod*aenv                ; ring modulation
endin

