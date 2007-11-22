; SIMPLE USE OF MIDIC7 CONTROLLING FREQUENCY

instr     1
  ifreq     cpsmidi   
  iamp      ampmidi   2000
  ikoct     =  4                                  ;2 OCTAVES TRANSPOSITION FACTOR

  kfratio   midic7    1,1,ikoct                   ;MOD.WHEEL CONTROLS TRANPOSITION
                                             ;RANGE: NO TRANSP. UP 2 OCTAVES

  a1        oscili    iamp,ifreq,1
  a2        oscili    iamp,ifreq*kfratio,1        ;2ND OSCIL IS TRANSPOSED BY
                                             ;KFRATIO AMOUNT
            out       a1+a2

endin









