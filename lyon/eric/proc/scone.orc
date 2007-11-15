  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gigain    =  .5
instr 1 ; STEREO INPUT TO GLOBAL ARRAY
  ifile     =  p4
  iskip     =  p5
  igain     =  p6 * gigain
  ga1,ga2   soundin   ifile, iskip
  ga1       =  ga1 * igain
  ga2       =  ga2 * igain
endin

instr 2 ; COMB PROCESSING OF STEREO INPUT
  igain     =  1.0
  idel1     =  p4
  idepth1   =  p5
  imax1     =  idel1*2
  idel2     =  p6
  idepth2   =  p7
  imax2     =  idel2*2

  iatk      =  p8
  idk       =  p9
  isust     =  p3-(iatk+idk)

  aenv      linseg    0, iatk, igain, isust, igain, idk, 0.0
  asig1     =  ga1
  addl1     delayr    imax1
  atap1     deltap    idel1
  asig1     =  asig1 + (atap1*idepth1)
            delayw    asig1
  asig2     =  ga2
  addl2     delayr    imax2
  atap2     deltap    idel2
  asig2     =  asig2 + (atap2*idepth2)
            delayw    asig1

            outs      asig1*aenv, asig2*aenv
endin

instr 3 ; MONO INPUT TO GLOBAL ARRAY
  ifile     =  p4
  iskip     =  p5
  igain     =  p6 * gigain
  gamono    soundin   ifile, iskip
  gamono    =  gamono * igain
endin

instr 4 ; COMB PROCESSING OF MONO INPUT
  igain     =  1.0
  idel1     =  p4
  idepth1   =  p5
  imax1     =  idel1*2
  idel2     =  p6
  idepth2   =  p7
  imax2     =  idel2*2

  iatk      =  p8
  idk       =  p9
  isust     =  p3-(iatk+idk)

  aenv      linseg    0, iatk, igain, isust, igain, idk, 0.0
  asig1     =  gamono
  asig2     =  gamono
  addl1     delayr    imax1
  atap1     deltap    idel1
  asig1     =  asig1 + (atap1*idepth1)
            delayw    asig1
  addl2     delayr    imax2
  atap2     deltap    idel2
  asig2     =  asig2 + (atap2*idepth2)
            delayw    asig2

            outs      asig1*aenv, asig2*aenv
endin
