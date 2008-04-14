  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;======================================================================;
;Simple pvoc playback instrument for time scaling with pitch shift.
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
  ispcwrp   =  p8
  ifmod     =  exp(ipshft/12*log(2))              ;convert to a freq multiplier
  ktimpnt   oscil1i   0,ilength,idur,itpfn
  aout      pvoc      ktimpnt, ifmod, ipvfn, ispcwrp
            out       aout
endin
