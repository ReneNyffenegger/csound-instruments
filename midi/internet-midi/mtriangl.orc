;OSCIL WITH A TRIANGLE WAVE AS F1

  nchnls    =  2

            massign   1,1


instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01

;k1            linen     7000, .4, p3, .5
  k1        linen     7000, .4, 3, .5
;a1            oscil     k1, cpspch(p4), 1
  a1        oscil     k1, knote, 1
               ;outs     a1,a1
            outs      a1*kgate, a1*kgate
endin
