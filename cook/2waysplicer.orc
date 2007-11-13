sr       =        44100
kr       =        44100
ksmps    =        1
nchnls   =        1

instr    1 ; 2-Way Splicer: Switches between inputs when at similar level

ilevl    =        p4                         ; Output level
irange   =        (2^p5)/65536               ; Similarity needed to splice: 1 to 16 bits
kcount   init 0                              ; Initialize counter
kgate1   init 1                              ; Initialize gate 1
kgate2   init 0                              ; Initialize gate 2

ain1     soundin  "sample1.wav"                  ; Input 1
ain2     soundin  "sample2.wav"                  ; Input 2

kin1     downsamp ain1                       ; Convert to kr
kin2     downsamp ain2                       ; Convert to kr
kin1     =        int(kin1*irange)           ; Quantise
kin2     =        int(kin2*irange)           ; Quantise
         if       kcount = 1 goto 2          ; Flip count
         if       kcount = 2 goto 1          ; Flip count
1:
         if       kin1 !=  kin2 goto out     ; If unequal, skip to output
kgate1   =        0
kgate2   =        1
kcount   =        1
goto     out
2:
         if       kin2 !=  kin1 goto out     ; If unequal, skip to output
kgate1   =        1
kgate2   =        0
kcount   =        2
out:                                         ; Output section
aout1    =        ain1*kgate1 + ain2*kgate2  ; Gate input signals
         out      aout1*ilevl                 ; Output and level

endin
