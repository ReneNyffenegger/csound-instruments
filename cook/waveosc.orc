  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Wave Oscillator

  ilevl     =  p4*32767                           ; Level
  iptch     =  cpspch(p5)                         ; Pitch
  ipos1     =  p6                                 ; Start position
  ipos2     =  p7                                 ; End position
  iamp1     =  p8                                 ; Start width
  iamp2     =  p9                                 ; End width
  itabi     =  p10                                ; Index waveform
  itabr     =  p11                                ; Indexed waveform

  kpos      line      ipos1, p3, ipos1            ; Position
  kamp      line      iamp1, p3, iamp2            ; Width
  kosc      oscil     .5, iptch, itabi, -1        ; Indexing Osc
  awave     tablei    kosc*kamp + kpos, itabr, 1, 0, 1 ; Table Indexed
            out       awave*ilevl                 ; Level and output

endin