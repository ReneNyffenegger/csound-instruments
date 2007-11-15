  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;i1 0 dur atk dk gain hpfroll ifreq iseed
;f1 0 16384 13 1 1 h0 h1 h2 ...
;f2 9 8192 10 1 .1 .05 .01
instr 1 ; full sustain version
  iamp      =  10000
  itk       =  p4
  idk       =  p5
  igain     =  p6
  irollup   =  p7
  ifreq     =  p8
  iseed     =  p9
  ilp       =  1./p10
  isu       =  p3-(itk+idk)
  in        =  ftlen( 1 )
  in2       =  in/2
  imult     =  in2/32767
  aenv      linseg    0,itk,iamp,isu,iamp,idk,0
  apch      oscil     iamp, ifreq, 2
  asig      randi     apch, 100, .222
  andx      =  in2+(imult*asig)
  aws       tablei    andx,1
  acomb     comb      aws,.5,ilp
  andx      =  in2+(imult*acomb)
  aws       tablei    andx,1
  aout      atone     aws,irollup
            out       aout*aenv
endin

; i2 0 dur atk release gain rollup freq seed
instr 2 ; adsr version
  iamp      =  10000
  ia        =  p4
  id        =  .02
  ir        =  p5
  is        =  p3-(ia+id+ir)
  igain     =  p6 * iamp
  igain2    =  igain * .4
  irollup   =  p7
  ifreq     =  p8
  iseed     =  p9
  ilp       =  1./ifreq
  in        =  ftlen( 1 )
  in2       =  in/2
  imult     =  in2/32767
  irvt      =  1.0
  aenv      linseg    0,ia,igain,id,igain2,is,igain2,ir,0
  apch      oscil     iamp, ifreq, 2
  asig      randi     apch, 100, iseed
  andx      =  in2+(imult*asig)
  aws       tablei    andx,1
  acomb     comb      aws,irvt,ilp
  aout      atone     acomb,irollup
            out       aout*aenv
endin
