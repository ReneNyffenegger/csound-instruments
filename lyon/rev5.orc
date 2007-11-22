  sr        =  44100
  kr        =  4410
  ksmps     =  10

;1 in 1 out

; FILE SKIP IORIG IGAIN REVTIMESTRETCH
instr          1
  ifile     =  p4
  iskip     =  p5
  iorig     =  p6
  igain     =  p7
  istretch  =  p8
  irvt1     =  .2*istretch
  irvt2     =  .5*istretch
  irvt3     =  2.1*istretch
  irvt4     =  3.06*istretch

  irev      =  1-iorig

  araw      soundin   ifile,iskip
  araw      =  araw*igain
  ar1       alpass    araw,irvt1,.04
  ar2       alpass    ar1,irvt2,.035
  ar3       alpass    ar2,irvt3,.065
  ar4       alpass    ar3,irvt4,.0491
  arl1      tone      ar1,10000
  arl2      tone      ar2,6000
  arl3      tone      ar3,3000
  arl4      tone      ar4,1000
  arev      =  arl1+arl2+arl3+arl4
            out       (irev*arev)+(iorig*araw)
endin
