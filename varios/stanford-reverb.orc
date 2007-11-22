  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  ga1       init      0
  ga2       init      0

instr 9
  idur      =  p3
  iamp      =  p4
  ifileno   =  p5
  iskiptime =  p6
  iattack   =  p7
  irelease  =  p8
  ipan      =  p9                                 ; 1 = LEFT, .5 = CENTER, 0 = RIGHT
  irvbgain  =  p10

  kamp      linen     iamp, iattack, idur, irelease
  asig      soundin   ifileno, iskiptime, 4
  arampsig  =  kamp * asig

  aoutl     =  arampsig * ipan
  aoutr     =  arampsig * (1 - ipan)

  ga2       =  aoutl * p10
  ga1       =  aoutr * p11

            outs      aoutl, aoutr
  
endin

instr 99                           ; ACCEPTS GLOBAL OUTPUTS AND ADDS REVERB
                                   
  irevfactor   =      p4
  ilowpass  =  9000
  ioutputscale =      p5

  idel1     =  1237.000/sr
  idel2     =  1381.000/sr
  idel3     =  1607.000/sr
  idel4     =  1777.000/sr
  idel5     =  1949.000/sr
  idel6     =  2063.000/sr
  idel7     =  307.000/sr
  idel8     =  97.000/sr
  idel9     =  71.000/sr
  idel10    =  53.000/sr
  idel11    =  47.000/sr
  idel12    =  37.000/sr
  idel13    =  31.000/sr

  icsc1     =  .822 * irevfactor
  icsc2     =  .802 * irevfactor
  icsc3     =  .773 * irevfactor
  icsc4     =  .753 * irevfactor
  icsc5     =  .753 * irevfactor
  icsc6     =  .753 * irevfactor

  icsc7     =  .7 * irevfactor
                    
  acomb1    comb      ga1, icsc1, idel1
  acomb2    comb      ga1, icsc2, idel2
  acomb3    comb      ga1, icsc3, idel3
  acomb4    comb      ga1, icsc4, idel4
  acomb5    comb      ga1, icsc5, idel5
  acomb6    comb      ga1, icsc6, idel6

  acomball  =  acomb1 + acomb2 + acomb3 + acomb4 + acomb5 + acomb6

  allp1     alpass    acomball, icsc7, idel7
  allp2     alpass    allp1, icsc7, idel8
  allp3     alpass    allp2, icsc7, idel9
  alow      tone      allp3, ilowpass
  allp4     alpass    alow, icsc7, idel10
  allp5     alpass    allp4, icsc7, idel12
  arevout1  =  allp5 * ioutputscale

  acomb1    comb      ga2, icsc1, idel1
  acomb2    comb      ga2, icsc2, idel2
  acomb3    comb      ga2, icsc3, idel3
  acomb4    comb      ga2, icsc4, idel4
  acomb5    comb      ga2, icsc5, idel5
  acomb6    comb      ga2, icsc6, idel6

  acomball  =  acomb1 + acomb2 + acomb3 + acomb4 + acomb5 + acomb6

  allp1     alpass    acomball, icsc7, idel7
  allp2     alpass    allp1, icsc7, idel8
  allp3     alpass    allp2, icsc7, idel9
  alow      tone      allp3, ilowpass
  allp4     alpass    alow, icsc7, idel10
  allp6     alpass    allp4,icsc7, idel13
  arevout2  =  allp6 * ioutputscale

            outs      arevout1, arevout2

  ga1       =  0
  ga2       =  0

endin
