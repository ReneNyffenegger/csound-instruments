sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 1

instr    1 ; Divides sample into equal slices then replays in random order

ilevl    = p4*32767                  ; Output level
irate    = p5                        ; Rate
istep    = p6/2                      ; Number of slices
ileng    = ftsr(1)/ftlen(1)          ; Sample length
iseed    = rnd(1)                    ; Generate random seed value

krnd     randh  istep, irate, iseed  ; Generate random steps
krnd     = int(krnd + istep)/istep*2 ; Quantise steps
kramp    oscili  1/irate, irate, 2   ; Generate index ramp
kenv     oscili  1, irate, 3         ; Generate envelope
kind     = (krnd + kramp)*ileng      ; Calculate and scale index
asamp    table3  kind, 1, 1, 0, 1    ; Index sample
out      asamp*kenv*ilevl            ; Level, envelope and output

endin