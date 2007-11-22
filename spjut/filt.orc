  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  idb       =  ampdb(p4)
  kbw       oscil     p5,p6,1                     ; SET PEAK FREQ AND RATE OF FILTER OPEN/CLOSE, USE f1
  a1        rand      idb                         ; RANDOM SIGNAL
  afilt     reson     a1,0,kbw,1                  ; LOPASS FILTER RANDOM SIGNAL
            out       afilt

endin
