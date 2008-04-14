  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;======================================================================;
;Example vpvoc instrument using tablexseg. This is based on the example
;provided in the Csound manual, with a few extra bells and whistles.
;Uses oscil1i to read the control function for the time pointer.
;Specify amount of pitch shift in p7 as a value in semitones.
;RP
;======================================================================;
instr   1
  idur      =  p3              
  ipvfn     =  p4                                 ;the pvanal output file pvoc.nnn
  ilength   =  p5                                 ;length of original sound file
  itpfn     =  p6                                 ;time pointer control function
  ipshft    =  p7                                 ;n semitones of pitch shift
; functions for tablexseg:
  ifn1      =  (p8 == 0 ? 3 : p8)
  idur1     =  p9
  ifn2      =  (p10 == 0 ? ifn1 : p10)
  idur2     =  p11
  ifn3      =  (p12 == 0 ? ifn2 : p12)
  idur3     =  p13
  ifn4      =  (p14 == 0 ? ifn3 : p14)
  ifmod     =  exp(ipshft/12*log(2))              ;convert to a freq multiplier
  igain     =  (p15 == 0 ? 1 : p15)
  ktimpnt   oscil1i   0,ilength,idur,itpfn
            tablexseg   ifn1, idur1, ifn2, idur2, ifn3, idur3, ifn4
  aout      vpvoc     ktimpnt,ifmod,ipvfn
            out       aout*igain
endin

instr   2       ;an instrument that synthesizes just one analysis bin
  idur      =  p3              
  ipvfn     =  p4                                 ;the pvanal output file pvoc.nnn
  ilength   =  p5                                 ;length of original sound file
  itpfn     =  p6                                 ;time pointer control function
  ibinno    =  p7
  igain     =  (p8 == 0 ? 1 : p8)
  isine     =  100
  ktimpnt   oscil1i   0,ilength,idur,itpfn
  kfreq,kamp   pvread   ktimpnt,ipvfn,ibinno
  aout      oscili    kamp,kfreq,isine
            out       aout*igain
endin