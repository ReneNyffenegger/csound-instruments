  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1408
  acar      line      400, p3, 800
  index     =  2.0
  imodfr    =  400
  idev      =  index*imodfr
  amodsig   oscil     idev, imodfr, 1
  a1        fof       1   5000, 5, acar+amodsig, 0, 1, .003, .5, .1, 3, 1, 2, p3, 0, 1
            out       a1
endin
