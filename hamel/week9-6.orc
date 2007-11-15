; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  arand     rand      10000                       ; full band noise
  kwid      line      100, p3, 1                  ; line from 100 Hz to 1 Hz
  afilter   reson     arand, cpspch(p5), kwid     ; band-pass filter narrowing 
  afin      balance   afilter,arand  
            out       afin                        ; output
endin

