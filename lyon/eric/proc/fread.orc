;--- transp.orc ---
  sr        =  44100
  kr        =  4410
  ksmps     =  10

; here is the format for the function table
; which will hold your soundfile:
; f1 0 N -1 X 0
; N is a power of 2 large enough to accomodate 
; you soundfile
; X is the soundin number: 
; example: soundin.1 is of duration 1. second at 44100 SR
; f1 0 65536 -1 1 0
; I believe the newer version of Csound requires a
; final number to indicate if the file is in
; short format or long. I think the code for
; shorts is 4
; f1 0 65536 -1 1 0 4
; by setting 1 (means function 1) negative, you
; avoid rescaling of your soundfile
; you can only use mono sounds in the version
; of csound I use. You might be able to do stereo
; with the newer version, or just demultiplex your
; stereo soundfile and use 2 function tables.
; simple orch by Eric Lyon

; score line format:
; i1 0 dur increment
instr 1
  ifile     =  1
  ifunc     =  2
  itl       =  ftlen(ifile)
  iop       =  1/p3
  iincr     =  (sr/itl) * p4

  asig      oscili    1.0,iincr,ifile     
            out       asig
endin

;--- cut here ---
; transp.sco
; f1 0 65536 -1 1 0 4
; i1 0 2.0 .5 ; play at half speed
