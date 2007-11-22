  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gip2      =  1.570796
  giroll1   =  7000
  giroll2   =  3000
  giroll3   =  1000

  gigain    =  .25

instr 1
  ifile     =  p4
  iskip     =  p5
  it1a      =  p6
  it1b      =  p7
  it1c      =  p8
  it1d      =  p9
  it1e      =  p10
  ig1a      =  p11
  ig1b      =  p12
  ig1c      =  p13
  ig1d      =  p14
  ig1e      =  p15
  iloc1a    =  p16
  iloc1b    =  p17
  iloc1c    =  p18
  iloc1d    =  p19
  iloc1e    =  p20
  it2a      =  p21
  it2b      =  p22
  it2c      =  p23
  it2d      =  p24
  it2e      =  p25
  ig2a      =  p26
  ig2b      =  p27
  ig2c      =  p28
  ig2d      =  p29
  ig2e      =  p30
  iloc2a    =  p31
  iloc2b    =  p32
  iloc2c    =  p33
  iloc2d    =  p34
  iloc2e    =  p35
  it3a      =  p36
  it3b      =  p37
  it3c      =  p38
  it3d      =  p39
  it3e      =  p40
  ig3a      =  p41
  ig3b      =  p42
  ig3c      =  p43
  ig3d      =  p44
  ig3e      =  p45
  iloc3a    =  p46
  iloc3b    =  p47
  iloc3c    =  p48
  iloc3d    =  p49
  iloc3e    =  p50
  ilg1a     =  sin( iloc1a * gip2 )
  irg1a     =  cos( iloc1a * gip2 )
  ilg1b     =  sin( iloc1b * gip2 )
  irg1b     =  cos( iloc1b * gip2 )
  ilg1c     =  sin( iloc1c * gip2 )
  irg1c     =  cos( iloc1c * gip2 )
  ilg1d     =  sin( iloc1d * gip2 )
  irg1d     =  cos( iloc1d * gip2 )
  ilg1e     =  sin( iloc1e * gip2 )
  irg1e     =  cos( iloc1e * gip2 )
  ilg2a     =  sin( iloc2a * gip2 )
  irg2a     =  cos( iloc2a * gip2 )
  ilg2b     =  sin( iloc2b * gip2 )
  irg2b     =  cos( iloc2b * gip2 )
  ilg2c     =  sin( iloc2c * gip2 )
  irg2c     =  cos( iloc2c * gip2 )
  ilg2d     =  sin( iloc2d * gip2 )
  irg2d     =  cos( iloc2d * gip2 )
  ilg2e     =  sin( iloc2e * gip2 )
  irg2e     =  cos( iloc2e * gip2 )
  ilg3a     =  sin( iloc3a * gip2 )
  irg3a     =  cos( iloc3a * gip2 )
  ilg3b     =  sin( iloc3b * gip2 )
  irg3b     =  cos( iloc3b * gip2 )
  ilg3c     =  sin( iloc3c * gip2 )
  irg3c     =  cos( iloc3c * gip2 )
  ilg3d     =  sin( iloc3d * gip2 )
  irg3d     =  cos( iloc3d * gip2 )
  ilg3e     =  sin( iloc3e * gip2 )
  irg3e     =  cos( iloc3e * gip2 )
  ain       soundin   ifile, iskip
  ain       =  ain * gigain 
  atap1a    delay     ain, it1a
  atap1b    delay     ain, it1b
  atap1c    delay     ain, it1c
  atap1d    delay     ain, it1d
  atap1e    delay     ain, it1e
  at1a      =  atap1a * ig1a
  at1b      =  atap1b * ig1b
  at1c      =  atap1c * ig1c
  at1d      =  atap1d * ig1d
  at1e      =  atap1e * ig1e
  asum1     =  atap1a+atap1b+atap1c+atap1d+atap1e
  ain2      tone      asum1, giroll1
  atap2a    delay     ain2, it2a
  atap2b    delay     ain2, it2b
  atap2c    delay     ain2, it2c
  atap2d    delay     ain2, it2d
  atap2e    delay     ain2, it2e
  at2a      =  atap2a * ig2a
  at2b      =  atap2b * ig2b
  at2c      =  atap2c * ig2c
  at2d      =  atap2d * ig2d
  at2e      =  atap2e * ig2e
  asum2     =  atap2a+atap2b+atap2c+atap2d+atap2e
  ain3      tone      asum2, giroll2
  atap3a    delay     ain3, it3a
  atap3b    delay     ain3, it3b
  atap3c    delay     ain3, it3c
  atap3d    delay     ain3, it3d
  atap3e    delay     ain3, it3e
  at3a      =  atap3a * ig3a
  at3b      =  atap3b * ig3b
  at3c      =  atap3c * ig3c
  at3d      =  atap3d * ig3d
  at3e      =  atap3e * ig3e
  aleft1    =  (at1a*ilg1a)+(at1b*ilg1b)+(at1c*ilg1c)+(at1d*ilg1d)+(at1e*ilg1e)
  aleft2    =  (at2a*ilg2a)+(at2b*ilg2b)+(at2c*ilg2c)+(at2d*ilg2d)+(at2e*ilg2e)
  aleft3    =  (at3a*ilg3a)+(at3b*ilg3b)+(at3c*ilg3c)+(at3d*ilg3d)+(at3e*ilg3e)
  aleftout  =  aleft1+aleft2+aleft3
  aright1   =  (at1a*irg1a)+(at1b*irg1b)+(at1c*irg1c)+(at1d*irg1d)+(at1e*irg1e)
  aright2   =  (at2a*irg2a)+(at2b*irg2b)+(at2c*irg2c)+(at2d*irg2d)+(at2e*irg2e)
  aright3   =  (at3a*irg3a)+(at3b*irg3b)+(at3c*irg3c)+(at3d*irg3d)+(at3e*irg3e)
  arightout =  aright1+aright2+aright3
            outs      aleftout, arightout

endin

instr 2
  ifile     =  p4
  iskip     =  p5
  it1a      =  p6
  it1b      =  p7
  it1c      =  p8
  it1d      =  p9
  it1e      =  p10
  ig1a      =  p11
  ig1b      =  p12
  ig1c      =  p13
  ig1d      =  p14
  ig1e      =  p15
  iloc1a    =  p16
  iloc1b    =  p17
  iloc1c    =  p18
  iloc1d    =  p19
  iloc1e    =  p20
  it2a      =  p21
  it2b      =  p22
  it2c      =  p23
  it2d      =  p24
  it2e      =  p25
  ig2a      =  p26
  ig2b      =  p27
  ig2c      =  p28
  ig2d      =  p29
  ig2e      =  p30
  iloc2a    =  p31
  iloc2b    =  p32
  iloc2c    =  p33
  iloc2d    =  p34
  iloc2e    =  p35
  it3a      =  p36
  it3b      =  p37
  it3c      =  p38
  it3d      =  p39
  it3e      =  p40
  ig3a      =  p41
  ig3b      =  p42
  ig3c      =  p43
  ig3d      =  p44
  ig3e      =  p45
  iloc3a    =  p46
  iloc3b    =  p47
  iloc3c    =  p48
  iloc3d    =  p49
  iloc3e    =  p50
  ilg1a     =  sin( iloc1a * gip2 )
  irg1a     =  cos( iloc1a * gip2 )
  ilg1b     =  sin( iloc1b * gip2 )
  irg1b     =  cos( iloc1b * gip2 )
  ilg1c     =  sin( iloc1c * gip2 )
  irg1c     =  cos( iloc1c * gip2 )
  ilg1d     =  sin( iloc1d * gip2 )
  irg1d     =  cos( iloc1d * gip2 )
  ilg1e     =  sin( iloc1e * gip2 )
  irg1e     =  cos( iloc1e * gip2 )
  ilg2a     =  sin( iloc2a * gip2 )
  irg2a     =  cos( iloc2a * gip2 )
  ilg2b     =  sin( iloc2b * gip2 )
  irg2b     =  cos( iloc2b * gip2 )
  ilg2c     =  sin( iloc2c * gip2 )
  irg2c     =  cos( iloc2c * gip2 )
  ilg2d     =  sin( iloc2d * gip2 )
  irg2d     =  cos( iloc2d * gip2 )
  ilg2e     =  sin( iloc2e * gip2 )
  irg2e     =  cos( iloc2e * gip2 )
  ilg3a     =  sin( iloc3a * gip2 )
  irg3a     =  cos( iloc3a * gip2 )
  ilg3b     =  sin( iloc3b * gip2 )
  irg3b     =  cos( iloc3b * gip2 )
  ilg3c     =  sin( iloc3c * gip2 )
  irg3c     =  cos( iloc3c * gip2 )
  ilg3d     =  sin( iloc3d * gip2 )
  irg3d     =  cos( iloc3d * gip2 )
  ilg3e     =  sin( iloc3e * gip2 )
  irg3e     =  cos( iloc3e * gip2 )
  ain1,ain2 soundin   ifile, iskip
; ain     =         ain * gigain 
  atap1a    delay     ain1, it1a
  atap1b    delay     ain1, it1b
  atap1c    delay     ain1, it1c
  atap1d    delay     ain1, it1d
  atap1e    delay     ain1, it1e
  at1a      =  atap1a * ig1a
  at1b      =  atap1b * ig1b
  at1c      =  atap1c * ig1c
  at1d      =  atap1d * ig1d
  at1e      =  atap1e * ig1e
  asum1     =  atap1a+atap1b+atap1c+atap1d+atap1e
;ain2     tone      asum1, giroll1
  atap2a    delay     ain2, it2a
  atap2b    delay     ain2, it2b
  atap2c    delay     ain2, it2c
  atap2d    delay     ain2, it2d
  atap2e    delay     ain2, it2e
  at2a      =  atap2a * ig2a
  at2b      =  atap2b * ig2b
  at2c      =  atap2c * ig2c
  at2d      =  atap2d * ig2d
  at2e      =  atap2e * ig2e
  asum2     =  atap2a+atap2b+atap2c+atap2d+atap2e
  ain3      tone      asum2, giroll2
  atap3a    delay     ain3, it3a
  atap3b    delay     ain3, it3b
  atap3c    delay     ain3, it3c
  atap3d    delay     ain3, it3d
  atap3e    delay     ain3, it3e
  at3a      =  atap3a * ig3a
  at3b      =  atap3b * ig3b
  at3c      =  atap3c * ig3c
  at3d      =  atap3d * ig3d
  at3e      =  atap3e * ig3e
  aleft1    =  (at1a*ilg1a)+(at1b*ilg1b)+(at1c*ilg1c)+(at1d*ilg1d)+(at1e*ilg1e)
  aleft2    =  (at2a*ilg2a)+(at2b*ilg2b)+(at2c*ilg2c)+(at2d*ilg2d)+(at2e*ilg2e)
  aleft3    =  (at3a*ilg3a)+(at3b*ilg3b)+(at3c*ilg3c)+(at3d*ilg3d)+(at3e*ilg3e)
  aleftout  =  aleft1+aleft2+aleft3
  aright1   =  (at1a*irg1a)+(at1b*irg1b)+(at1c*irg1c)+(at1d*irg1d)+(at1e*irg1e)
  aright2   =  (at2a*irg2a)+(at2b*irg2b)+(at2c*irg2c)+(at2d*irg2d)+(at2e*irg2e)
  aright3   =  (at3a*irg3a)+(at3b*irg3b)+(at3c*irg3c)+(at3d*irg3d)+(at3e*irg3e)
  arightout =  aright1+aright2+aright3
            outs      aleftout, arightout

endin
