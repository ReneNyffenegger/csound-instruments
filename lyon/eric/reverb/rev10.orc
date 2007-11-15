  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2
;2in 2out wet reverb
;i1 0 dur file skip gain
instr 1
  ifile     =  p4
  iskip     =  p5
  igain     =  p6 * 3
  it1d1     =  .023
  it1d2     =  .027
  it1d3     =  .031
  it2d1     =  .029
  it2d2     =  .039
  it2d3     =  .037
  itapgain  =  .2
  iallrvt   =  2.0
  ilpfraw   =  3000
  icombrvt  =  2.5
  ilpt1a    =  1/79.3
  ilpt1b    =  1/69.3
  ilpt1c    =  1/59.3
  ilpt2a    =  1/73.3
  ilpt2b    =  1/64.3
  ilpt2c    =  1/55.3
  icombgain =  .33
  icomblpf  =  600
  a1in, a2in   soundin  ifile, iskip
  a1in      =  a1in * igain
  a2in      =  a2in * igain
  atap1a    delay     a1in, it1d1
  atap1b    delay     a1in, it1d2
  atap1c    delay     a1in, it1d3
  atap2a    delay     a2in, it2d1
  atap2b    delay     a2in, it2d2
  atap2c    delay     a2in, it2d3
  atap1sum  =  (atap1a+atap1b+atap1c)*itapgain
  atap2sum  =  (atap2a+atap2b+atap2c)*itapgain
  aall1     alpass    atap1sum, iallrvt, .06
  aall2     alpass    atap2sum, iallrvt, .06
  ain1sum   =  a1in+aall1
  ain2sum   =  a2in+aall2
  araw1     atone     ain1sum, ilpfraw
  araw2     atone     ain2sum, ilpfraw
        ; midlevel reverb
  acomb1a   comb      araw1, icombrvt, ilpt1a
  acomb1b   comb      araw1, icombrvt, ilpt1b
  acomb1c   comb      araw1, icombrvt, ilpt1c
  acomb2a   comb      araw2, icombrvt, ilpt2a
  acomb2b   comb      araw2, icombrvt, ilpt2b
  acomb2c   comb      araw2, icombrvt, ilpt2c
  acombsum1 =  (acomb1a+acomb1b+acomb1c)
  acombsum2 =  (acomb2a+acomb2b+acomb2c)
  alpfc1    tone      acombsum1, icomblpf
  alpfc2    tone      acombsum2, icomblpf
  acdel1    delay     alpfc1, .03
  acdel1    =  acdel1 * .4
  acdel2    delay     alpfc2, .015
  acdel2    =  acdel2 * .4
  alpfc1    =  alpfc1 + acdel1
  alpfc2    =  alpfc2 + acdel2
        ; sum raw + comb
  arcsum1   =  alpfc1 + araw1
  arcsum2   =  alpfc2 + araw2
  iechorvt  =  4.5
  ielpt1a   =  .237
  ielpt1b   =  .391
  ielpt1c   =  .473
  ielpt2a   =  .221
  ielpt2b   =  .385
  ielpt2c   =  .507
  irawgain  =  .6
  ilpfcgain =  .1
  iechogain =  .1
  aecho1a   comb      arcsum1, iechorvt, ielpt1a
  aecho1b   comb      arcsum1, iechorvt, ielpt1b
  aecho1c   comb      arcsum1, iechorvt, ielpt1c
  aecho2a   comb      arcsum2, iechorvt, ielpt2a
  aecho2b   comb      arcsum2, iechorvt, ielpt2b
  aecho2c   comb      arcsum2, iechorvt, ielpt2c
  aecho1sum =  (aecho1a+aecho1b+aecho1c)
  aecho2sum =  (aecho2a+aecho2b+aecho2c)
  aout1     =  (araw1*irawgain)+(alpfc1*ilpfcgain)+(aecho1sum*iechogain)
  aout2     =  (araw2*irawgain)+(alpfc2*ilpfcgain)+(aecho2sum*iechogain)
            outs      aout1, aout2
endin
