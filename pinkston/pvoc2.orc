  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;==================================================================
;Simple cross synthesis instrument using pvbufread and pvcross. 
;Notes:
;       - pvcross requires a preceding pvbufread to work
;       - pvbufread reads the analysis data from one pvanal 
;         output file. The output is buffered for use by 
;         subsequent pvcross or pvinterp units in the same instr.
;       - pvcross reads the analysis data from a second pvanal
;         output file and then resynthesizes it using a combination
;         of the amplitude data in its own pvanal file and the one
;         being read by pvbufread, according to the two kamp args.
;       - To produce a amp data crossfade from file1 to file2,
;         make kamp1 and kamp2 be 1 and 0, respectively.
;       - To produce a pure "cross synthesis," make the values for
;         both kamp1 and kamp2 be 0. This will cause pvcross to use
;         the amp data from file1 only, and the freq data from file2.
; RP
;===================================================================

instr   2
  idur      =  p3
  ipvfn1    =  p4
  ilen1     =  p5
  ipvfn2    =  p6
  ilen2     =  p7
  iamp1     =  p8
  iamp2     =  p9
  ifmod     =  p10                                ;max pitch change in semitones
  ifmfn     =  (p11 == 0 ? 1 : p11)               ;default to a valid fn#

; Independent timptrs for pvbufread and pvcross
  ktime1    line      0, idur, ilen1
  ktime2    line      0, idur, ilen2
; Allows a crossfade between the two analysis files for amp control 
  kcross    line      iamp1, idur, iamp2    
; Frequency modification control function
  kfctrl    oscil1i   0,ifmod,p3,ifmfn
  kfmod     =  exp(kfctrl/12*log(2))
            pvbufread   ktime1, ipvfn1
  apv       pvcross   ktime2, kfmod, ipvfn2, 1-kcross, kcross
  apv       linen     apv,.1,p3,.2                ;overall envelope
            out       apv
endin
