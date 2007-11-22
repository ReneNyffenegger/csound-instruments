;Test score for Karplus Strong Demo Instrument
i01 0  2      30000  6.00
i01 +  .      .      7.00 
i01 +  .      .      8.00 
i01 +  .      .      9.00 
s
;try with alternate method of injecting the noise
i02 0  2      22000  6.00
i02 +  .      28000  7.00
i02 +  .      .      8.00 
i02 +  .      .      9.00 
s
;tests of instrument 3
;try with very short noise pulse
;nn	st	dur	amp	pch	plsrise plsdec	amp2	ifc	ifindec
i03 0  2      35000  6.00   .0001  .001   0      0      0    
i03 +  .      .      5.06 
i03 +  .      39000  5.00
i03 +  .      .      4.06 
s
;try with longer rise and decay on noise pulse (quasi-bowed attack)
i03 0  2      28000  6.00   .25    .1     0      0      .5   
i03 +  .      18000  7.00
i03 +  .      15000  8.00
i03 +  .      10000  9.00
s
;try with a sustained noise pulse
i03 0  4      30000  6.00   .25    .75    100    1000   .5
i03 +  .      20000  7.00   .      .      150    1500
i03 +  .      12000  8.00   .      .      .      2000 
i03 +  .      10000  9.00   .      .      .      2500 
s
;make a sustained chord
i03 0  26.5   4000   6.00   4      2      100    1000   2 
i03 .01       .      3000   7.00   .      .      120    1500
i03 .03       .      3000   7.07   .      .      .      2000 
i03 .02       .      3000   8.03   .      .      .      2500 
i03 .07       .      4000   5.00   .      .      100    1000
;add more notes
i03 5  21     2000   6.00   5      2      100    1000
i03 5.01      .      2000   8.00   .      .      120    1500
i03 5.03      .      3000   7.10   .      .      .      2000 
i03 5.02      .      3000   8.05   .      .      .      2500 
;still more notes
i03 9.5       17     3000   8.07   6      .      120    3000
i03 10.53     15.5   3000   7.07   5.5    .      .      2000 
i03 11 15     4000   8.03   6.25   .      .      2500 
i03 12 14.5   3000   5.00   .      .      100    800
i03 12.51     13.5   2600   8.05   7      .      110    2500
i03 12.52     .      2600   7.10   7.5    .      .      2000 
e