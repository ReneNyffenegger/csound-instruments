  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;======================================================================;
;Instrument 1 demonstrates the use of vpvoc with tablexseg. It is based 
;on the example provided in the Csound manual, with a few extra bells 
;and whistles. It uses oscil1i to read the control function for the time 
;pointer. Specify amount of pitch shift in p7 as a value in semitones.
;
;Instrument 2 is a simple pvread instrument for individual bin resynthesis.
;
;Note that with all csound phase vocoder opcodes, you need to use the
;same version of csound to do the analysis that you will use to do the
;resynthesis, because the analysis file format has changed.
;
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
  igain1    =  p10
  ifn2      =  (p11 == 0 ? ifn1 : p11)            ;default to same function
  idur2     =  p12
  igain2    =  (p13 == 0 ? igain1 : p13)
  ifn3      =  (p14 == 0 ? ifn2 : p14)
  idur3     =  p15
  igain3    =  (p16 == 0 ? igain2 : p16)
  ifn4      =  (p17 == 0 ? ifn3 : p17)
  igain4    =  (p18 == 0 ? igain3 : p18)
  ifmod     =  exp(ipshft/12*log(2))              ;convert to a freq multiplier
  ktimpnt   oscil1i   0,ilength,idur,itpfn
            tablexseg   ifn1, idur1, ifn2, idur2, ifn3, idur3, ifn4
  aout      vpvoc     ktimpnt,ifmod,ipvfn
;apply dynamic gain control
  kgain     linseg    igain1,idur1,igain2,idur2,igain3,idur3,igain4
  kgain     =  ampdb(kgain)                       ;convert to amp factor
  agate     linen     kgain,.001,p3,.1            ;basic envelope
            out       aout*agate
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