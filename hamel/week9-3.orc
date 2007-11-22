
; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  arand     rand      10000                       ; full band noise
  afilter   reson     arand, 300, 20              ; band-pass filter at 300 Hz (width 20 Hz)
  afin      balance   afilter, arand              ; balance the audio signals 
            out       afin                        ; output
endin

