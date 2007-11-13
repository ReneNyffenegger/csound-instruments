; Orchestra file used to create example soundfiles "ex2-1" and "ex2-2" 
;Fixed wave form instrument, using envlpx to create an amplitude envelope
        
	sr=44100
        kr=2205
        ksmps=20
        nchnls=1
instr 1
ipitch = cpspch(p4)      ; convert p4 from pch  to  cps
kenv envlpx p5,  p6,  p3,  p7,  60,  p8,  .01,  p9  ; amplitude envelope
   display kenv , p3        ; show envelope shape on sterr
asignal  oscili   kenv,  ipitch,  p10
out asignal
endin
