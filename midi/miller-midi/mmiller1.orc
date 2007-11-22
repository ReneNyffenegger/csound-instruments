  nchnls    =  2

instr          1                                  ; p4  = AMPLITUDE OF OUTPUT WAVE
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01

    ;i1        =         1/p3                     ; p5  = CARRIER FREQUENCY SPECIFIED IN HZ
  i1        =  1/.2
    ;idev1     =         p7 * p6                  ; p6  = MODULATING FREQUENCY IN HZ
  idev1     =  0 * 110
    ;idev2     =         (p8-p7) * p6             ; p7  = MODULATION INDEX 1
  idev2     =  (25-0) * 110
                                                  ; p8  = MODULATION INDEX 2
    ;ampcar    oscil     p4,i1,p9                 ; p9  = CARRIER ENVELOPE FUNCTION
  ampcar    oscil     10000, i1, 6
    ;ampmod    oscil     idev2,i1,p10             ; p10 = MODULATOR ENVELOPE FUNCTION
  ampmod    oscil     idev2, i1, 7

    ;amod      oscili    ampmod+idev1,p6,1
  amod      oscili    ampmod+idev1, knote*iveloc, 1
    ;gasig     oscili    ampcar,p5+amod,1
  asig      oscili    ampcar, knote+amod, 1
   ;outs1      gasig *.25
   ;outs2      gasig *.25

            outs      asig*kgate, asig*kgate   
endin

