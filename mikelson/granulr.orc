  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  2

instr 1
  ifqc      =  p5
  kdnsenv   linseg    10, p3/2, 100, p3/2, 10
  kdurenv   linseg    .04, p3/2, .4,  p3/2, .04
  kampenv   linseg    0, .002, 1, p3-.004, 1, .002, 0

;  krand1 rand 30
  kdens     =  kdnsenv                            ;+ krand1/3

;            xamp  xpitch  xdens  kampoff  kpitchoff  kgdur    igfn  iwfn  imgdur
  aoutl     grain     p4,   ifqc,  kdens,  200,     210,    kdurenv,    p6,   2,     1
  aoutr     grain     p4,   ifqc,  kdens,  200,     190,    kdurenv,    p6,   2,     1
            outs      aoutl*kampenv, aoutr*kampenv
endin
