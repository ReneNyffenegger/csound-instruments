; SIMPLE USE OF MIDIC14 CONTROLLING OSCILI FREQUENCY (NO TABLE INDEXING)

instr          1
  ifreq     cpsmidi   
  iamp      ampmidi   1000
  ioct      =  16                                 ;4 OCTAVES TRANSPOSITION FACTOR
  ioneup3   =  1/3
  itwoup3   =  2/3
  kfratio   midic14   1,2,1/ioct-1,ioct-1         ;MOD.WHEEL   CONTROLS MSB AND 
                                        ;BREATH CON. CONTROLS LSB 
                                        ;TRANPOSITION RANGE: -4 UP TO +4 OCTAVES
  ifreq1    =  ifreq                              ;BASE FREQ
  kfreq2    =  ifreq*(1+kfratio*ioneup3)          ;FREQ TRANSPOSED 1/3 OF KFRATIO
  kfreq3    =  ifreq*(1+kfratio*itwoup3)          ;FREQ TRANSPOSED 2/3 OF KFRATIO
  kfreq4    =  ifreq*(1+kfratio)                  ;FREQ TRANSPOSED 3/3 OF KFRATIO
  a1        oscili    iamp,ifreq1,1               ;1ST OSCIL WITH BASE FREQ
  a2        oscili    iamp,kfreq2,1               ;2ND OSCIL IS TRANSPOSED 1/3 OF KRATIO
  a3        oscili    iamp,kfreq3,1               ;3RD OSCIL IS TRANSPOSED 2/3 OF KRATIO
  a4        oscili    iamp,kfreq4,1               ;4TH OSCIL IS TRANSPOSED BY KFRATIO AMOUNT
            out       a1+a2+a3+a4
endin





























