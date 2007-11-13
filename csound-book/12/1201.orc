
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
                    
          
          instr     1201      ; SIMPLE FM INSTRUMENT
isine     =         1                             ; f1 HAS SINE TABLE
iamp      =         p4                            ; PEAK AMP OF CARRIER
icarhz    =         p5                            ; CARRIER FREQUENCY
imodhz    =         p6                            ; MODULATOR FREQUENCY
index     =         p7                            ; MAX INDEX OF MODULATION
index1    =         p8                            ; MINIMUM INDEX
irise     =         p9                            ; RISE TIME
idecay    =         p10                           ; DECAY TIME
isteady   =         p3-irise-idecay               ; STEADY STATE TIME
imaxdev   =         index*imodhz             ; D = I * M
imindev   =         index1*imodhz            ; MINIMUM DEVIATION
ivardev   =         imaxdev-imindev               ; VARIABLE DEVIATION
kenv      expseg    .001, irise, 1, isteady, 1, idecay, .001     
kmodamp   =         imindev+ivardev*kenv     ; AMPLITUDE OF MODULATOR
amodsig   oscili    kmodamp, imodhz, isine   ; GATED MODULATOR
acarsig   oscili    iamp*kenv, icarhz+amodsig, isine   
          out       acarsig   
          endin          
