sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2



garvb   init    0

        instr   301 
kenv    expon  8000, p3, .01
asig    oscil   kenv, cpspch(p4), 1
        outs1   asig
garvb   =       garvb+(asig*.45)    
        endin


        instr 302   
ifrq    =       cpspch(p4)
k1      gauss   ifrq*2
kenv    linen   1, p3*.8, p3, p3*.1
a1      oscil   8000, ifrq, 2
a2      oscil   5000, ifrq+k1, 2
asig    =       (a1+a2)*kenv
        outs2   asig    
garvb   =       garvb+(asig*.2) 
        endin
    
    
        instr 399
irvbtime = 1    1.6*p4
asig    nreverb garvb, irvbtime, .4
        outs    asig, asig
garvb   =       0
        endin
