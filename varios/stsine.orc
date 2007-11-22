
; resibois
; STATIC SINE COMPRESSED/EXPANDED/LIMITED
;
;  THRESHOLD = 15000
;
;  P4 = OSCILLATOR AMPLITUDE
;  P5 = UPPER GAIN
;  P6 = LOWER GAIN

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  ig1       init      p5
  ig2       init      p6
  isp1      init      1
  isp2      init      1
  kthresh   init      15000

  aosc      oscil     p4,440,1
  aout      dam       aosc,kthresh,ig1,ig2,isp1,isp2
            out       aout

endin

