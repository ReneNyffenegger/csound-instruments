sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 1

instr    1 ; '2D' random sample indexer

ilevl    = p4*32767 ; Level
iratex   = p5       ; X rate
iratey   = p6       ; Y rate

iseed    = rnd(1)                       ; Generate random seed value
krndx    randi  .5, iratex              ; X random index
krndy    randi  .5, iratey              ; Y random index
ax       table3  .5 + krndx, 1, 1, 0, 1 ; X indexing
ay       table3  .5 + krndy, 2, 1, 0, 1 ; Y indexing
out      ax*ay*ilevl                    ; Output

endin