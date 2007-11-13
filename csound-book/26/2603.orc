            strset    1, "hello.con"
            strset    2, "fox.con"
            strset    3, "oneecho.aif"
            strset    4, "twoechos.aif"
            strset    5, "fiveechos.aif"
            strset    6, "gaussreverb.aif"
            strset    7, "uniformreverb.aif"
            strset    8, "whitenoise.aif"

instr   2603    ; ECHO & REVERB DEMOS
  iscale    =  p4
  iexcite   =  p5
  irespond  =  p6
  aa        soundin   iexcite
  ab        convolve  aa, irespond
            out       ab*iscale
endin
