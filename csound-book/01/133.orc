        instr   133
idur    =       p3
iamp    =       ampdb(p4)
ifrq    =       p5
icut1   =       p6              
icut2   =       p7
iresgn  =       p8
kcut    expon   icut1, idur, icut2
aplk    pluck   iamp, ifrq, ifrq, 0, 1
abpf    butterbp    aplk, kcut, kcut*.2
alpf    butterlp    aplk, kcut              
amix    =     alpf+(abpf*iresgn)
        out     amix
        dispfft amix, idur, 1024
        endin
