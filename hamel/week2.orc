; ORCHESTRA FILE
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0
  nchnls    =  2

instr 1
  kctrl     line      10000, p3, 0                ; ramp envelope
  asig      oscil     kctrl, cpspch(p5), 1        ; sine wave oscilator
            outs      asig * 1, asig * 0          ; output to left channel only

endin

instr 2
  kctrl     line      10000, p3, 0                ; ramp envelope
  asig      oscil     kctrl, cpspch(p5), 2        ; sine wave oscilator
            outs      asig * 0, asig * 1          ; output to right channel only
endin
