  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr    1 ; Emulates a record or tape slowing to a stop (stereo)

  ilevl     =  p4*32767                           ; Output level
  idelay    =  p5                                 ; Delay before stopping in s
  itime     =  p6                                 ; Stopping time in s
  idecel    =  p7                                 ; Decceleration curve 
  ileng     =  ftlen(1)/ftsr(1)                   ; Sample length

  kdclick   linseg    0, .001, 1, p5 + p6 - .101, 1, .1, 0 ; Declick
  kstop     oscil1    idelay, 1, itime, idecel    ; Generate decceleration curve
  kline     phasor    (1/ileng)*kstop             ; Index
; a1,a2   table3  kline, 1, 1              ; Index sample table
  a1        table3    kline, 1, 1                 ; Index sample table
            outs1     a1*kdclick*ilevl            ; L level, declick and output
; outs2    a2*kdclick*ilevl                 ; R level, declick and output

endin
