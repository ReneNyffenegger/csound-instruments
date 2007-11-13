            strset    9, "fox.aif"

            strset    11, "hello.aif"

            strset    12, "lowpass3khz.con"

            strset    13, "lowpass1khz.con"

            strset    14, "lowpass300hz.con"

            strset    15, "rimshot.con"

            strset    16, "bassdrum.con"



instr  3005  ;LOWPASS DEMOS

  iscale    =  p4

  iexcite   =  p5

  irespond  =  p6

  aa        soundin   iexcite

  ab        convolve  aa, irespond                ;Use cvanal to make

            out       ab*iscale

endin

