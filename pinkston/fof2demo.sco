;Test score for fofdemo orchestra. Test all the vowel formants from Dodge pp. 230-231. RP
f1  0 8192  10    1  
;generate a "sigmoid" for use in local envelope rise/decay
f2  0 8192  19    .5    .5    270   .5
;linear rise for phs control, vibrato onset, etc.
f3  0 513   7     0     513   1 
;function of zero
f4  0 2     2     0     0   
;Tests of instrument2 (fof2)
;	st	dur	amp	fund	glsmax	glsdel	glsdur	glsfn	octmax	octdel	octdur	octfn	phsfn	ifna
i02 0  10     20000  2.06   -1     0      10     3      0      0      0      0      3      1    
;	iphsdur	irise	idecay	iform	iband	ilrise	ildur	ildec	iolaps	itotdur
                        18.98   .1      .1      1000    0       .003    .02     .007    0       0     
i02 +  .      20000  .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1    
i02 +  .      10000  .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
s
i02 0  10     20000  3.06   -1     0      10     3      0      0      0      0      3      1    
;	iphsdur	irise	idecay	iform	iband	ilrise	ildur	ildec	iolaps	itotdur
                        18.98   .1      .1      1000    0       .003    .02     .007    0       0     
i02 +  .      10000  .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1    
i02 +  .      5000   .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
s
i02 0  10     10000  8.00   -1     0      10     3      0      0      0      0      3      1    
;	iphsdur	irise	idecay	iform	iband	ilrise	ildur	ildec	iolaps	iphsdur	itotdur
                        18.98   .1      .1      1000    0       .003    .02     .007    0       0     
i02 +  .      4000   .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1    
i02 +  .      2000   .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
;Tests of Instrument 3 - Try with sampled sounds
s

f11 0 131072      1     "cello44.wav"     0     0     0   

;grain freq=20Hz; glsmax=-1
;	st	dur	amp	hzmax	hzfn	glsmax	glsdel	glsdur	glsfn	octmax	octdel	octdur	octfn	phsfn	ifna
i03 0  10     20000  20     0      -1     0      10     3      0      0      0      0      3      11   
;	itimfac	irise	idecay	ipitfac	iband	ilrise	ildur	ildec	idurdel	idurdur	idurfn	iolaps	itotdur	irndhz	irndur	iseed
                        0       .1      .1      0       0       .003    .02     .007    0       0       0       0       0 0 0 0
i03 +  .      10000  .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1    
i03 +  .      5000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
s
;grain freq=50Hz; glsmax=0
;	st	dur	amp	hzmax	hzfn	glsmax	glsdel	glsdur	glsfn	octmax	octdel	octdur	octfn	phsfn	ifna
i03 0  10     20000  50     0      0      0      10     3      0      0      0      0      3      11   
;	itimfac	irise	idecay	ipitfac	iband	ilrise	ildur	ildec	idurdel	idurdur	idurfn	iolaps	itotdur	irndhz	irndur	iseed
                        0       .1      .1      0       0       .003    .02     .007    0       0       0       0       0 0 0 0
i03 +  .      10000  .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1    
i03 +  .      8000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
i03 +  .      7000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       1     
s
;grain freq=50Hz; glsmax=-1
;	st	dur	amp	hzmax	hzfn	glsmax	glsdel	glsdur	glsfn	octmax	octdel	octdur	octfn	phsfn	ifna
i03 0  10     20000  50     0      -1     0      10     3      0      0      0      0      3      11   
;	itimfac	irise	idecay	ipitfac	iband	ilrise	ildur	ildec	idurdel	idurdur	idurfn	iolaps	itotdur	irndhz	irndur	iseed
                        0       .1      .1      0       0       .003    .02     .007    0       0       0       0       0 0 0 0	
i03 +  .      10000  .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1    
i03 +  .      5000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
i03 +  .      4000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       1     
;add random freq and grain dur
s
;	st	dur	amp	hzmax	hzfn	glsmax	glsdel	glsdur	glsfn	octmax	octdel	octdur	octfn	phsfn	ifna
i03 0  10     20000  50     0      -1     0      10     3      0      0      0      0      3      11   
;	itimfac	irise	idecay	ipitfac	iband	ilrise	ildur	ildec	idurdel	idurdur	idurfn	iolaps	itotdur	irndhz	irndur	iseed
                        0       .1      .1      0       0       .003    .02     .007    0       0       0       0       0 40 40 0
i03 +  .      10000  .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1    
i03 +  .      5000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
i03 +  .      3000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       1     
s
;grain freq=15HZ
;	st	dur	amp	hzmax	hzfn	glsmax	glsdel	glsdur	glsfn	octmax	octdel	octdur	octfn	phsfn	ifna
i03 0  10     20000  15     0      -1     0      10     3      0      0      0      0      3      11   
;	itimfac	irise	idecay	ipitfac	iband	ilrise	ildur	ildec	idurdel	idurdur	idurfn	iolaps	itotdur	irndhz	irndur	iseed
                        0       .1      .1      0       0       .003    .02     .007    0       0       0       0       0 40 40 0
i03 +  .      10000  .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1    
i03 +  .      5000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
i03 +  .      5000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       1     
s
;grain freq=variable from 2 to 50 hz
;grain freq control function
f12 0 513   5     .04   256   1     257   .04
;grain length control function
f13 0 513   7     .25   256   1     257   .25
;phase control function (backwards, then forwards)
f14 0 513   7     1     256   .1    257   1 
;	st	dur	amp	hzmax	hzfn	glsmax	glsdel	glsdur	glsfn	octmax	octdel	octdur	octfn	phsfn	ifna
i03 0  10     25000  50     12     1      0      10     3      0      0      0      0      14     11  
;	itimfac	irise	idecay	ipitfac	iband	ilrise	ildur	ildec	idurdel	idurdur	idurfn	iolaps	itotdur	irndhz	irndur	iseed
                        0       .1      .1      0       0       .003    .02     .007    0       10      13      0       0 50 30 .1234
i03 +  .      10000  .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .1      .       .       .       .       .       . . . -1
i03 +  .      8000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .3    
i03 +  .      4000   .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       1     
s
;granular octaves
;	st	dur	amp	hzmax	hzfn	glsmax	glsdel	glsdur	glsfn	octmax	octdel	octdur	octfn	phsfn	ifna
i03 0  30     3000   400    12     -.3    0      10     3      0      0      0      0      14     11  
;	itimfac	irise	idecay	ipitfac	iband	ilrise	ildur	ildec	idurdel	idurdur	idurfn	iolaps	itotdur	irndhz	irndur	iseed
                        0       .1      .1      0       0       .003    .25     .007    0       10      13      0       0 50 50 .1234
i03 0  .      .      .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .5      .       .       .       .       .       .       .       .       . . . -1
i03 0  .      .      .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       2     
i03 0  .      .      .      .      .      .      .      .      .      .      .      .      .      .    
                        .       .       .       .25   
e