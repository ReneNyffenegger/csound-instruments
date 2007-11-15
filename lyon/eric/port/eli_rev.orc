  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1
  idur      =  p3
  iamp      =  p4
  ipan      =  p5
  iwetmix   =  p6
  irvbtime  =  p7

  adry      soundin   1, 0
  adry      =  adry*iamp

  awet      =  adry

  acomb1    comb      awet, irvbtime, .050
  acomb2    comb      awet, irvbtime, .056
  acomb3    comb      awet, irvbtime, .061
  acomb4    comb      awet, irvbtime, .068
  acomb5    comb      awet, irvbtime, .072
  acomb6    comb      awet, irvbtime, .078
  awet      =  (acomb1+acomb2+acomb3+acomb4+acomb5+acomb6)

  awet      alpass    awet, .12, .006

  aout      =  adry + awet*iwetmix
;   aout = awet
   
  aoutl     =  aout*ipan
  aoutr     =  aout*(1-ipan)
            outs      aoutl, aoutr
endin

; csound reverb instrument for comparison
instr 2
  idur      =  p3
  iamp      =  p4
  ipan      =  p5
  iwetmix   =  p6
  irvbtime  =  p7

  adry      soundin   1, 0
  adry      =  adry*iamp

  awet      reverb    adry, irvbtime

  aout      =  adry + awet*iwetmix
;   aout = awet
   
  aoutl     =  aout*ipan
  aoutr     =  aout*(1-ipan)
            outs      aoutl, aoutr
endin

instr 3
  idur      =  p3
  iamp      =  p4
  ipan      =  p5
  iwetmix   =  p6
  irvbtime  =  p7

  adry      soundin   1, 0

  aout      =  adry
   
  aoutl     =  aout*ipan
  aoutr     =  aout*(1-ipan)
            outs      aoutl, aoutr
endin

instr 4
  idur      =  p3
  iamp      =  p4
  ipan      =  p5
  iwetmix   =  p6
  irvbtime  =  p7

  adry      soundin   1, 0
  adry      =  adry*iamp

  iloop1    =  .050                               ; comb lengths
  iloop2    =  .056
  iloop3    =  .061
  iloop4    =  .068
  iloop5    =  .072
  iloop6    =  .078

                                ; calc remix gains for correct -60dB time
  igain1    =  exp( log(.001)*(iloop1/irvbtime) )
  igain2    =  exp( log(.001)*(iloop2/irvbtime) )
  igain3    =  exp( log(.001)*(iloop3/irvbtime) )
  igain4    =  exp( log(.001)*(iloop4/irvbtime) )
  igain5    =  exp( log(.001)*(iloop5/irvbtime) )
  igain6    =  exp( log(.001)*(iloop6/irvbtime) )

  acomb1    delayr    iloop1
            delayw    adry + igain1*acomb1
  acomb2    delayr    iloop2
            delayw    adry + igain2*acomb2
  acomb3    delayr    iloop3
            delayw    adry + igain3*acomb3
  acomb4    delayr    iloop4
            delayw    adry + igain4*acomb4
  acomb5    delayr    iloop5
            delayw    adry + igain5*acomb5
  acomb6    delayr    iloop6
            delayw    adry + igain6*acomb6

  awet      =  (acomb1+acomb2+acomb3+acomb4+acomb5+acomb6)
  awet      alpass    awet, .12, .006

  aout      =  adry + awet*iwetmix
   
  aoutl     =  aout*ipan
  aoutr     =  aout*(1-ipan)
            outs      aoutl, aoutr
endin

instr 5
  idur      =  p3
  iamp      =  p4
  ipan      =  p5
  iwetmix   =  p6
  irvbtime  =  p7

  adry      soundin   1, 0
  adry      =  adry*iamp

  iloop1    =  .050                               ; comb lengths
  iloop2    =  .056
  iloop3    =  .061
  iloop4    =  .068
  iloop5    =  .072
  iloop6    =  .078
   
                                ; gains forming the lowpasses in the combs
  ifiltscale   =      sr/25000                    ; (a cheap hack)
  ifiltgain1   =      .24*ifiltscale
  ifiltgain2   =      .26*ifiltscale
  ifiltgain3   =      .28*ifiltscale
  ifiltgain4   =      .29*ifiltscale
  ifiltgain5   =      .30*ifiltscale
  ifiltgain6   =      .32*ifiltscale

                                ; calc remix gains for correct -60dB time
  igain1    =  exp( log(.001)*(iloop1/irvbtime) ) * (1-ifiltgain1)
  igain2    =  exp( log(.001)*(iloop2/irvbtime) ) * (1-ifiltgain2)
  igain3    =  exp( log(.001)*(iloop3/irvbtime) ) * (1-ifiltgain3)
  igain4    =  exp( log(.001)*(iloop4/irvbtime) ) * (1-ifiltgain4)
  igain5    =  exp( log(.001)*(iloop5/irvbtime) ) * (1-ifiltgain5)
  igain6    =  exp( log(.001)*(iloop6/irvbtime) ) * (1-ifiltgain6)

  acomb1    delayr    iloop1
  afeedback1   =      adry + igain1*acomb1
  afilt1    delay1    afeedback1
            delayw    afeedback1 + afilt1*ifiltgain1
                
  acomb2    delayr    iloop2
  afeedback2   =      adry + igain2*acomb2
  afilt2    delay1    afeedback2
            delayw    afeedback2 + afilt2*ifiltgain2
                
  acomb3    delayr    iloop3
  afeedback3   =      adry + igain3*acomb3
  afilt3    delay1    afeedback3
            delayw    afeedback3 + afilt3*ifiltgain3
                
  acomb4    delayr    iloop4
  afeedback4   =      adry + igain4*acomb4
  afilt4    delay1    afeedback4
            delayw    afeedback4 + afilt4*ifiltgain4
                
  acomb5    delayr    iloop5
  afeedback5   =      adry + igain5*acomb5
  afilt5    delay1    afeedback5
            delayw    afeedback5 + afilt5*ifiltgain5
                
  acomb6    delayr    iloop6
  afeedback6   =      adry + igain6*acomb6
  afilt6    delay1    afeedback6
            delayw    afeedback6 + afilt6*ifiltgain6

  awet      =  (acomb1+acomb2+acomb3+acomb4+acomb5+acomb6)
  awet      alpass    awet, .12, .006

  aout      =  adry + awet*iwetmix
;  aout = acomb1
   
  aoutl     =  aout*ipan
  aoutr     =  aout*(1-ipan)
            outs      aoutl, aoutr
endin

instr 6
  idur      =  p3
  iamp      =  p4
  ipan      =  p5
  iwetmix   =  p6
  irvbtime  =  p7

  adry      soundin   1, 0
  adry      =  adry*iamp

  iloop1    =  .050                               ; comb lengths
  iloop2    =  .056
  iloop3    =  .061
  iloop4    =  .068
  iloop5    =  .072
  iloop6    =  .078
   
                                ; gains forming the lowpasses in the combs
  ifiltscale   =      sr/25000                    ; (a cheap hack)
  ifiltgain1   =      .24*ifiltscale
  ifiltgain2   =      .26*ifiltscale
  ifiltgain3   =      .28*ifiltscale
  ifiltgain4   =      .29*ifiltscale
  ifiltgain5   =      .30*ifiltscale
  ifiltgain6   =      .32*ifiltscale

                                ; calc remix gains for correct -60dB time
  igain1    =  exp( log(.001)*(iloop1/irvbtime) ) * (1-ifiltgain1)
  igain2    =  exp( log(.001)*(iloop2/irvbtime) ) * (1-ifiltgain2)
  igain3    =  exp( log(.001)*(iloop3/irvbtime) ) * (1-ifiltgain3)
  igain4    =  exp( log(.001)*(iloop4/irvbtime) ) * (1-ifiltgain4)
  igain5    =  exp( log(.001)*(iloop5/irvbtime) ) * (1-ifiltgain5)
  igain6    =  exp( log(.001)*(iloop6/irvbtime) ) * (1-ifiltgain6)

  acomb1    delayr    iloop1
  afeedback1   =      adry + igain1*acomb1
  afilt1    delay1    afeedback1
            delayw    afeedback1 + afilt1*ifiltgain1
                
  acomb2    delayr    iloop2
  afeedback2   =      adry + igain2*acomb2
  afilt2    delay1    afeedback2
            delayw    afeedback2 + afilt2*ifiltgain2
                
  acomb3    delayr    iloop3
  afeedback3   =      adry + igain3*acomb3
  afilt3    delay1    afeedback3
            delayw    afeedback3 + afilt3*ifiltgain3
                
  acomb4    delayr    iloop4
  afeedback4   =      adry + igain4*acomb4
  afilt4    delay1    afeedback4
            delayw    afeedback4 + afilt4*ifiltgain4
                
  acomb5    delayr    iloop5
  afeedback5   =      adry + igain5*acomb5
  afilt5    delay1    afeedback5
            delayw    afeedback5 + afilt5*ifiltgain5
                
  acomb6    delayr    iloop6
  afeedback6   =      adry + igain6*acomb6
  afilt6    delay1    afeedback6
            delayw    afeedback6 + afilt6*ifiltgain6

  alate     =  (acomb1+acomb2+acomb3+acomb4+acomb5+acomb6)
  alate     alpass    alate, .12, .006

  iecho1time   =      .0043                       ; early echo times
  iecho2time   =      .0215
  iecho3time   =      .0225
  iecho4time   =      .0268
  iecho5time   =      .0270
  iecho6time   =      .0298
  iecho7time   =      .0458
  iecho8time   =      .0485
  iecho9time   =      .0572
  iecho10time  =      .0587
  iecho11time  =      .0595
  iecho12time  =      .0612
  iecho13time  =      .0707
  iecho14time  =      .0708
  iecho15time  =      .0726
  iecho16time  =      .0741
  iecho17time  =      .0753
  iecho18time  =      .0797

  iecho1gain   =      .841                        ; early echo gains
  iecho2gain   =      .504
  iecho3gain   =      .491 
  iecho4gain   =      .379
  iecho5gain   =      .380
  iecho6gain   =      .346
  iecho7gain   =      .289
  iecho8gain   =      .272
  iecho9gain   =      .192
  iecho10gain  =      .193
  iecho11gain  =      .217
  iecho12gain  =      .181
  iecho13gain  =      .180
  iecho14gain  =      .181
  iecho15gain  =      .176
  iecho16gain  =      .142
  iecho17gain  =      .167
  iecho18gain  =      .134
    
  adump     delayr    .1
  aecho1    deltap    iecho1time
  aecho1    =  aecho1*iecho1gain
  aecho2    deltap    iecho2time
  aecho2    =  aecho2*iecho2gain
  aecho3    deltap    iecho3time
  aecho3    =  aecho3*iecho3gain
  aecho4    deltap    iecho4time
  aecho4    =  aecho4*iecho4gain
  aecho5    deltap    iecho5time
  aecho5    =  aecho5*iecho5gain
  aecho6    deltap    iecho6time
  aecho6    =  aecho6*iecho6gain
  aecho7    deltap    iecho7time
  aecho7    =  aecho7*iecho7gain
  aecho8    deltap    iecho8time
  aecho8    =  aecho8*iecho8gain
  aecho9    deltap    iecho9time
  aecho9    =  aecho9*iecho9gain
  aecho10   deltap    iecho10time
  aecho10   =  aecho10*iecho10gain
  aecho11   deltap    iecho10time
  aecho11   =  aecho11*iecho11gain
  aecho12   deltap    iecho11time
  aecho12   =  aecho12*iecho12gain
  aecho13   deltap    iecho12time
  aecho13   =  aecho13*iecho13gain
  aecho14   deltap    iecho13time
  aecho14   =  aecho14*iecho14gain
  aecho15   deltap    iecho14time
  aecho15   =  aecho15*iecho15gain
  aecho16   deltap    iecho15time
  aecho16   =  aecho16*iecho16gain
  aecho17   deltap    iecho16time
  aecho17   =  aecho17*iecho17gain
  aecho18   deltap    iecho17time
  aecho18   =  aecho18*iecho18gain

  aearly    =  aecho1+aecho2+aecho3+aecho4+aecho5+aecho6+aecho7+aecho8+aecho9
  aearly    =  aearly+aecho10+aecho11+aecho12+aecho13+aecho14+aecho15+aecho16+aecho17+aecho18

  alate2    delay     alate, .015
  awet      =  aearly + alate2

  aout      =  adry + awet*iwetmix
;  aout = acomb1
   
  aoutl     =  aout*ipan
  aoutr     =  aout*(1-ipan)
            outs      aoutl, aoutr
endin

