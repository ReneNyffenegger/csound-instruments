;test various comb, alpass, and reverb effects on input sounds
;soundin.300 = balloons.wav
;soundin.301 = blackorpheus.wav
;	st	dur	igain	ifile	iwet	idry	iskip
i01 0  5      1      300    0      1      0    
i01 6  .      .      .      .5     .5       	
i01 12
i01 18
i01 24
i01 30
i01 36
;comb instrument
;	st	dur	igain	irvt	ilpt
i90 6  6      .5     .01    .01
i90 +  .      .      .      .005 
i90 +  .      .4     .      .001 
i90 +  .      .      .4     .01 
i90 +  .      .      .      .005 
i90 +  .      .3     .      .001 
;zero the globals instrument
i100   0      42   
s
f0  1
s
;	st	dur	igain	ifile	iwet	idry	iskip
i01 0  5      1      300    0      1      0    
i01 6  .      .      .      .5     .5       	
i01 12
i01 18
i01 24 .      .      .      1      1    
i01 32
i01 40
;alpass instrument
;	st	dur	igain	irvt	ilpt
i91 6  6      .5     .01    .01
i91 12 .      .      .      .005 
i91 18 .      .4     .      .001 
i91 24 8      .5     3      .01  
i91 32 .      .      .      .005 
i91 40 .      .      .      .001 
;zero the globals instrument
i100   0      48   
s
f0  1
s
i01 0  5      1      300    0      1      0    
i01 6  .      .      .      .5     .5       	
i01 12
i01 18
i01 24
i01 30
i01 36
;delay/feedback instrument
;	st	dur	igain	ifeed	ilpt
i94 6  6      .5     .7     .01 
i94 +  .      .      .      .005 
i94 +  .      .4     .      .001 
i94 +  .      .      .9     .01 
i94 +  .      .      .      .005 
i94 +  .      .3     .      .001 
;zero the globals instrument
i100   0      42   
s
f0  1
s
;	st	dur	igain	ifile	iwet	idry	iskip
i01 0  5      1      300    .5     .5  
i01 6
;comb resonator instrument. same as i90, but specify desired pitch in p6
;	st	dur	igain	irvt	ipch
i99 0  6      .5     .01    7.00
i99 0  .      .      .      7.07 
i99 0  .      .      .      8.04 
i99 6  .      .      .4     7.00
i99 6  .      .      .      7.07 
i99 6  .      .      .      8.04 
i100   0      12   
s
f0  1
s
;	st	dur	igain	ifile	iwet	idry	iskip
i01 0  5      1      300    0      1      0    
i01 6  5      1      300    .5     1      0    
i01 14	
i01 24 10     1      301    0      1    
i01 35 10     1      301    .5     1   
i01 48
;reverb instrument
;	st	dur	igain	irvt	
i92 6  7      .4     2      
i92 14 9      .      4       
i92 35 12     .      2    
i92 48 14     .      4       
;zero the globals instrument
i100   0      62   
s
f0  1
s
;	st	dur	igain	ifile	iwet	idry	iskip
i01 0  5      1      300    .5     1      0    
i01 8	
i01 16
i01 24
i01 34
i01 44
;reverb2 instrument
;	st	dur	igain	irvt	ihdif	
i93 0  7      .4     2      0    
i93 8  .      .      .      .5   
i93 16 .      .      .      1    
i93 24 9      .      4      0    
i93 34 .      .      .      .5   
i93 44 .      .      .      1    
;zero the globals instrument
i100   0      53   
s
f0  1
s
;repeat reverb2 tests with soundin 301
i01 0  10     1      301    .5     1   
i01 13
i01 26
i01 38
i01 53
i01 68
;reverb2 instrument
;	st	dur	igain	irvt	ihdif	
i93 0  12     .4     2      0    
i93 13 .      .      .      .5   
i93 26 .      .      .      1    
i93 38 14     .      4      0    
i93 53 .      .      .      .5   
i93 68 .      .      .      1    
;zero the globals instrument
i100   0      82   
e
