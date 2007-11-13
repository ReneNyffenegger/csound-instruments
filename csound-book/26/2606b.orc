            strset    1, "hello.con"

            strset    9, "fox.aif"

            strset    11, "hello.aif"

            strset    17, "highpass300hz.con"

            strset    18, "highpass1khz.con"

            strset    19, "highpass3khz.con"

            strset    20, "cymbal.aif"

            strset    21, "cymbal.con"



instr  3006  ; HIGHPASS DEMOS

  iscale    =  p4

  iexcite   =  p5

  irespond  =  p6

  aa        soundin   iexcite

  ab        convolve  aa, irespond 

            out       ab*iscale

endin

