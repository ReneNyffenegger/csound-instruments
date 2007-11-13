  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1704 
  kvary     expseg    p5, p3/2, p6, p3/2, p5      ; VARY GAP DURS BETWEEN p5 AND p6
  krnd      rand      .5, p7                      ; p7 IS RANDOM SEED
  kvary     init      p5                          ; BEGIN WITH MAXIMUM POSSIBLE GAP
start:
                                       ; START OF REINIT BLOCK 
  irnd      =  .5+i(krnd)                         ; OFFSET irnd TO BETWEEN 0 AND 1
  igap      =  .035+irnd*i(kvary)                 ; BETWEEN .035 AND .035+kvary SECS
  kbw       =  50+100*irnd                        ; SMALL RANDOM VAR IN FILTER BW
            timout    0, igap, continue           ; SKIP REINIT FOR igap SECONDS
            reinit    start     
continue:
                                    ; POPCORN ENVELOPE
  agate     expseg    .0001, .005, 1, .07, .0001
            rireturn                              ; END REINITIALIZING HERE
  anoise    rand      p4                          ; WHITE NOISE FOR POPS
  asig      reson     anoise, 400, kbw, 2         ; BANDPASS FILTERING
            out       asig*agate                  ; APPLY ENVELOPE
endin

