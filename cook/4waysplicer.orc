  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; 4-Way Splicer: Switches between inputs when at similar level

  ilevl     =  p4                                 ; Output level
  irange    =  (2^p5)/65536                       ; Similarity needed to splice: 1 to 16 bits
  kcount    init      0                           ; Initialize counter
  kgate1    init      1                           ; Initialize gate 1
  kgate2    init      0                           ; Initialize gate 1
  kgate3    init      0                           ; Initialize gate 1
  kgate4    init      0                           ; Initialize gate 1

  ain1      diskin    "sample1.wav", 1, 0, 1
  ain2      diskin    "sample2.wav", 1, 0, 1
  ain3      diskin    "speech1.wav", 1, 0, 1
  ain4      diskin    "sample4.wav", 1, 0, 1

  kin1      downsamp  ain1                        ; Convert to kr
  kin2      downsamp  ain2                        ; Convert to kr
  kin3      downsamp  ain3                        ; Convert to kr
  kin4      downsamp  ain4                        ; Convert to kr
  kin1      =  int(kin1*irange)                   ; Quantise
  kin2      =  int(kin2*irange)                   ; Quantise
  kin3      =  int(kin3*irange)                   ; Quantise
  kin4      =  int(kin4*irange)                   ; Quantise
if       kcount = 1 goto 2                        ; Select input pair to compare
if       kcount = 2 goto 3
if       kcount = 3 goto 4
if       kcount = 4 goto 1
1:
if       kin1 != kin2 goto out                    ; If unequal go to output
  kgate1    =  0                                  ; Set gates
  kgate2    =  1
  kgate3    =  0
  kgate4    =  0
  kcount    =  1                                  ; Set count
            goto      out
2:
if       kin2 != kin3 goto out                    ; If unequal go to output
  kgate1    =  0                                  ; Set gates
  kgate2    =  0
  kgate3    =  1
  kgate4    =  0
  kcount    =  2                                  ; Set count
            goto      out
3:
if       kin3 != kin4 goto out                    ; If unequal go to output
  kgate1    =  0                                  ; Set gates
  kgate2    =  0
  kgate3    =  0
  kgate4    =  1
  kcount    =  3                                  ; Set count
            goto      out
4:
if       kin4 != kin1 goto out                    ; If unequal go to output
  kgate1    =  1                                  ; Set gates
  kgate2    =  0
  kgate3    =  0
  kgate4    =  0
  kcount    =  4                                  ; Set count
out:
                                ; Output section
  aout1     =  ain1*kgate1 + ain2*kgate2          ; Gate input signals to splice
  aout2     =  ain3*kgate3 + ain4*kgate4          ; Gate input signals to splice
            out       (aout1 + aout2)*ilevl       ; Output and level

endin
