sr       =        44100
kr       =        4410
ksmps    =        10
nchnls   =        1

         instr    1 ; Roland TR808 Cymbal ?

p3       =        (p5 = 0 ? 1 : .15)         ; Select open or closed
ifreq    =        p4*540                     ; Tune

aenv     expsega  .1, .0005, 30000, p3 - .0005, .01   ; Percussive envelope
asqr1    oscil    1, ifreq, 1, -1            ; Oscillator 1
asqr2    oscil    1, ifreq*1.4471, 1, -1     ; Oscillator 2
asqr3    oscil    1, ifreq*1.6170, 1, -1     ; Oscillator 3
asqr4    oscil    1, ifreq*1.9265, 1, -1     ; Oscillator 4
asqr5    oscil    1, ifreq*2.5028, 1, -1     ; Oscillator 5
asqr6    oscil    1, ifreq*2.6637, 1, -1     ; Oscillator 6
a808     sum      asqr1, asqr2, asqr3, asqr4, asqr5, asqr6     ; Sum
a808     butterhp a808, 5270                 ; Highpass filter
a808     butterhp a808, 5270                 ; Highpass filter
         out      a808*aenv                  ; Output

         endin
