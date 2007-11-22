  nchnls    =  2

            massign   1,1

;FINAL PROJECT

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01

  ibalance  =  .5
  inote     =  cpspch(8.00)
  arpch     randi     400, 1
  aprand    =  arpch + knote                      ;p4 amplitude
  k1        linseg    0, 5 * .20, 1 * 8000, 5 * .80, 0
  k2        linseg    0, 5 * .005, 1 * 8000, 5 * .80, .8 * 8000, 5 * .195, 0
  a1        oscil     k1, aprand, 9
  a2        oscil     k2, aprand * .5, 9
  a3        pluck     8000, knote, inote, 0, 1
  a1        =  a1+a2+a3 * .333
            outs      (a1 * ibalance)*kgate,( a1 * (1 - ibalance))*kgate
endin
