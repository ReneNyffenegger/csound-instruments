f01 0 4097 7 0 512 1 1536 1 512 0 ; Trapezoid window

;Shift in +-1/100 semitones
;Delay and Base in ms
;Mix: 0=Dry 1=Harmomized

;                       -------L--------  -------R--------
;     Strt  Leng  Levl  Shift Delay Fdbk  Shift Delay Fdbk  Xfdbk Mix
i01   0.00  2.00  1.00  0013  0075  0.00 -0013  0080  0.00  0.50  0.50
i01   2.00  .     .     0200  .     0.50  0200  .     0.50  0.00  1.00
i01   4.00  .     .    -0200  0200  0.75 -0205  0250  0.75  .     .
e