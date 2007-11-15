; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  arand     rand      10000                       ; full band noise
  afilter   areson    arand, 1000, 800            ; band-reject filter at 1000 Hz (width 800 Hz)
  afin      balance   afilter, arand              ; balance the audio signals 
            out       afin                        ; output
endin


