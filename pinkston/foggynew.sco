;sigmoid function for grain envelope rise/decay
f1  0 1024  19    .5    .5    270   .5
f2  0 1048576     1     "tamtam.aif"      0     0     0   
f3  0 262144      1     "smallgng.aif"    0     0     0   
f4  0 65536 1     "temple.aif"      0     0     0   
f5  0 262144      1     "belltree.aif"    0     0     0   
;Tamtam Tests
;     START 	DUR 	AMP	XPTCH   XSPD	GRDUR	IOLAPS	SNDFN	WNDFN
i1  0  10     15000  1      1      .02    2      2      1    
i1  +  30     .      1      .25    .      4    
i1  +  30     .      .5     .      .    
i1  +  30     .      2      .      .    
i1  +  30     .      1      .      .2   
i1  +  30     .      .5     .      .    
i1  +  30     .      2      .      .    
s
;Small Gong Tests
;     START 	DUR 	AMP	XPTCH   XSPD	GRDUR	IOLAPS	SNDFN	WNDFN
i1  0  5      10000  1      1      .02    2      3      1    
i1  +  20     .      .      .2     .      8    
i1  +  20     .      .      .      .2   
i1  +  20     .      .5     .      .02  
i1  +  20     .      .      .      .2   
i1  +  20     .      2      .      .02  
i1  +  20     .      .      .      .2   
s
;Temple Block Tests
;     START 	DUR 	AMP	XPTCH   XSPD	GRDUR	IOLAPS	SNDFN	WNDFN
i1  0  1      25000  1      1      .02    2      4      1    
i1  +  10     15000  .      .0125  .02    8  
i1  +  10     .      .      .      .05  
i1  +  10     .      .      .      .1   
i1  +  10     .      .      .      .2   
s
;BellTree Tests
;     START 	DUR 	AMP	XPTCH   XSPD	GRDUR	IOLAPS	SNDFN	WNDFN
i1  0  5      15000  1      1      .02    2      5      1    
i1  +  20     10000  .      .125   .      8    
i1  +  .      .      .      .      .05  
i1  +  .      .      .      .      .1   
i1  +  .      .      .      .      .2   
i1  +  .      .      .      .      .4   
i1  +  .      .      .5     .      .02  
i1  +  .      .      .      .      .05  
i1  +  .      .      .      .      .1   
i1  +  .      .      .      .      .2   
i1  +  .      .      .      .      .4   