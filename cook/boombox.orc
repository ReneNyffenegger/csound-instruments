  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr    1 ; Bass enhancer inspired by the dBX120 "Boom Box"

  ilevl     =  p4                                 ; Output level
  imix      =  p5                                 ; Bass boost mix: 0=Input 1=Bass Boost
  kcount    init      0                           ; Initialize count to 0
  kloop     init      0                           ; Initialize loop to 0

  a1        soundin   "sample1.wav"
  ain       =  a1                                 ; Sum inputs to mono

  abass     butterlp  ain, 100                    ; Lowpass filter input
  aenv      follow    abass, .025                 ; Follow envelope
  aenv      butterlp  aenv, 25                    ; Smooth envelope
  kin       downsamp  abass                       ; Convert input to kr
  ktrig     trigger   kin, 0, 0                   ; Detect zero crossings
if       ktrig == 0 goto 1                        ; If no zero crossing goto 1...
  kcount    =  kcount + 1                         ; ... otherwise increment count
  kloop     wrap      kcount, 0, 4                ; Loop count at 4
1:
if kloop != 1 goto 2                              ; If count is not 1 goto 2
  adown1    =  1                                  ; Set subharmonic 1 to +1
  adown2    =  1                                  ; Set subharmonic 2 to +1...
            goto      output                      ; ... then goto output
2:
if kloop != 2 goto 3                              ; If count is not 2 goto 3
  adown1    =  -1                                 ; Set subharmonic 1 to -1
  adown2    =  1                                  ; Set subharmonic 2 to +1
            goto      output                      ; ... then goto output
3:
if kloop != 3 goto 4                              ; If count is not 3 goto 4
  adown1    =  1                                  ; Set subharmonic 1 to +1
  adown2    =  -1                                 ; Set subharmonic 2 to -1
            goto      output                      ; ... then goto output
4:
  adown1    =  -1                                 ; Set subharmonic 1 to -1
  adown2    =  -1                                 ; Set subharmonic 2 to -1
output:
  asub      butterlp  adown1 + adown2, 100        ; Lowpass filter subharmonics
            outs1     (a1*(1 - imix) + asub*imix*aenv)*ilevl ; L level, mix and output

endin
