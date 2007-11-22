instr          1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01
  i1        =  6000*.3
  i2        =  500*.1
  i3        =  1
  i4        =  6000*.8
  i5        =  500

  a1        randi     6000,4000
  a1        oscil     a1,i3,2
  a1        oscil     a1,3000,1
     
  a2        oscil     i1,i3,2
  a2        oscil     a2,knote*.01,3

  a3        oscil     i4,i3,8
  a3        oscil     a3,knote,4

            out       (a1+a2+a3)*kgate

endin
