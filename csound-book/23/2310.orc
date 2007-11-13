sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


gadrysig  init      0    ; INITIALIZE GLOBAL VARIABLE

          instr     2307
idryamt   =         1-p4
iwetamt   =         p4
asndfile  soundin   "speech1.aif", 0
gadrysig  =         gadrysig+asndfile*iwetamt
          out       asndfile*idryamt
          endin

          instr     2310
istretch  =         p4/3
irvt1     =         .2*istretch
irvt2     =         .5*istretch
irvt3     =         2.1*istretch
irvt4     =         3.06*istretch
ar1       alpass    gadrysig, irvt1, .04
ar2       alpass    ar1, irvt2, .09653
ar3       alpass    ar2, irvt3, .065
ar4       alpass    ar3, irvt4, .043
arl1      tone      ar1, 5000
arl2      tone      ar2, 3000
arl3      tone      ar3, 1500
arl4      tone      ar4, 500
arev      =         arl1+arl2+arl3+arl4
          out       arev*3
gadrysig  =         0
          endin      
