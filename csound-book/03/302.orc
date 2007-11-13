sr          =           44100
kr          =           4410
ksmps       =           10
nchnls      =           1

            
            instr       303
iamp        =           p4
ifrq        =           cpspch(p5)
ivibfrq     =           p6
ivibamt     =           p7
istiff      =           p8
kv          linseg      0, 0.5, 0, 1, 1, p3-0.5, 1
a1          wgclar      iamp, ifrq, istiff, 0.1, 0.1, 0.2, ivibfrq, kv*ivibamt, 1, 50
            out         a1
            endin       
