sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Exponential (CR) ADSR envelope with k-rate times

ilevl    = p4*32767                 ; Output level
katk     = (p5 < .001 ? .001 : p5)  ; Attack time >1ms
kdec     = (p6 < .001 ? .001 : p6)  ; Decay time >1ms
ksusl    init p7                    ; Sustain level
krel     = (p8 < .001 ? .001 : p8)  ; Release time >1ms
ksus     = p3 - katk - kdec - krel  ; Calculate Sustain time
krate    = 1/(katk + kdec + ksus + krel)     ; Calculate total time 
k1       = katk
k2       = k1 + kdec
k3       = k2 + ksus
k4       = k3 + krel
aramp    oscili  k4, krate, 1       ; Generate index ramp
a1       limit  aramp, 0, k1        ; Isolate 1st quarter (Attack)
a2       limit  aramp, k1, k2       ; Isolate 2nd quarter (Decay)
a3       limit  aramp, k2, k3       ; Isolate 3rd quarter (Sustain)
a4       limit  aramp, k3, k4       ; Isolate 4th quarter (Release)
aramp    = .25*(a1*(1/katk) + (a2-k1)*(1/kdec) + (a3-k2)*(1/ksus) + (a4-k3)*(1/krel))
adsr1    tablei  aramp, 2, 1        ; Read ADSR with Sustain = 1
atk      tablei  aramp, 3, 1        ; Read Attack
adsr2    tablei  aramp, 4, 1        ; Read ADSR with Sustain = 0
adsr3    = adsr1*ksusl + adsr2*(1 - ksusl)   ; Scale and sum ADSRs
out      (adsr3 - atk)*ilevl        ; Shape Attack into inverted exp.

endin
