sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Linear ADSR envelope with k-rate slopes

ilevl    = p4*32767                ; Output level
katk     = (p5 < .001 ? .001 : p5) ; Attack time >1ms
kdec     = (p6 < .001 ? .001 : p6) ; Decay time >1ms
ksusl    init p7                   ; Sustain level
krel     = (p8 < .001 ? .001 : p8) ; Release time >1ms
ksus     = p3 - katk - kdec - krel
krate    = 1/(katk + kdec + ksus + krel)
k1       = katk
k2       = k1 + kdec
k3       = k2 + ksus
k4       = k3 + krel
aramp    oscili  k4, krate, 1
a1       limit  aramp, 0, k1
a2       limit  aramp, k1, k2
a3       limit  aramp, k2, k3
a4       limit  aramp, k3, k4
aramp    = .25*(a1*(1/katk) + (a2-k1)*(1/kdec) + (a3-k2)*(1/ksus) + (a4-k3)*(1/krel))
adsr1    tablei  aramp, 2, 1
adsr2    tablei  aramp, 3, 1
adsr3    = adsr1*ksusl + adsr2*(1 - ksusl)
out      adsr3*ilevl

endin
