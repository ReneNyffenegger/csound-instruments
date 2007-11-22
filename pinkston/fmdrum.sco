;test score for fm drum instrument
;single sine cycle
f01 0 8192  10    1  
;half second of silence at start of tests
f0  .5
s
;Test a range of pitches, bend amounts, transient durations, and indexes.
;	st	dur	ipkdb	ipch	carfac	modfac	maxbnd	trdur	endbnd	indx1	indx2	isusdb
i01 0  .75    90     7.00   1      .31791 1      .2     0      7      .005   82
i01 +  .      .      6.08   .      .      <      <      .      <    
i01 +  .      .      6.04    
i01 +  .      .      6.00 
i01 +  .      .      5.08 
i01 +  .      .      5.04   .      .      1.5    .5     .      15   
e