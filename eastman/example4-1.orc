 ; Orchestra file used to create this soundfile example:
sr = 44100
kr = 2205
ksmps = 20
nchnls = 1

instr 1
kamp expseg 1, .2, 8000, p3-.4, 5000, .2, 1
ipitch = cpspch(p4)
a1 buzz kamp, ipitch , p5, 1
out a1
endin


