  sr        =  44100
  kr        =  4410
  ksmps     =  10

;MONO -> MONO REVERB
; INDUSTRIAL SOUND
;i1 0 dur file skip srcdur gain revtime
instr          1
  ifile     =  p4
  iskip     =  p5
  indur     =  p6
  igain     =  p7
  irvt      =  p8
  itail     =  p3 - indur
  idel1     =  .07
  idel2     =  idel1 + .053
;irvt          =         1.33
  iclpt1    =  1/33
  iclpt2    =  1/47.12
  iclpt3    =  1/53.59
  iclpt4    =  1/67.13
  iclpt5    =  1/83.16
  iclpt6    =  1/106.0
  iallrvt   =  .15
  iall1     =  .02
  iall2     =  .031
  iorig     =  .7
  irev      =  (1.-iorig) 
            timout    indur, itail, contin
  araw      soundin   ifile,iskip
  araw      =  araw * igain
contin:
  adel1     delay     araw,idel1
  adel2     delay     araw,idel2
  acmb1     comb      araw, irvt, iclpt1
  acmb2     comb      araw, irvt, iclpt2
  acmb3     comb      adel1, irvt, iclpt3
  acmb4     comb      adel1, irvt, iclpt4
  acmb5     comb      adel2, irvt, iclpt5
  acmb6     comb      adel2, irvt, iclpt6
  acmbsum1  =  acmb1+acmb3+acmb5
  acmbsum2  =  acmb2+acmb4+acmb6
  allp1     alpass    acmbsum1,iallrvt,iall1
  allp2     alpass    acmbsum2,iallrvt,iall2
  arev      =  allp1+allp2
  arev      =  arev * irev
  alrev     atone     arev, 50
  araw      =  araw * iorig
            out       alrev+araw
endin
instr          100
endin
