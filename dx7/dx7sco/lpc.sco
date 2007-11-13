;====================================================================;
;       Test score for DX7 alg 02 orc                                ;
;                                                                    ;
;       (imitates the CIANIA     voice...sorta)                      ;
;                                                                    ;
;       DX72Csound by Jeff Harrington  idealord@dorsai.org           ;
;       After Models by Russell Pinkston                             ;
;  Thanks to T. Suzuki of Yamaha Corp. for the DX7 frequency tables  ;
;====================================================================;
f01     0       512     10      1
; operator fpoutput level to amp scale function (data from Chowning/Bristow)

f99 0 8192 10 1 
t 0 20
i01 0 11.49 6.00 87 0 45 14 35 
 12 13 14 15 16 17 2 4000
 3 8 4 6 10 9 11 7
; Algorithm = 2
; Patch name is CIANIA    
f0         4                             ;allow for a 4-beat final decay.
e
