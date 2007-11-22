;grain envelope function
f1  0 8192  20    1  
;src function
f2  0 65536 1     "thewind.wav"     0     0     0   
;This generates 5 seconds of grains using the crude schedule instrument
i01 0  5
;The following lines are for manually testing instrument 2
;nn	st dur	amp	pshift iskipin	isrcfn ipan istart iend idirect iwrap ienvfn
;i02	0  1.47 20000   1      0        2      .5   0      1.47	1      1     1
;i.	2  .735	.	2
;i.	4  2.94	.	.5
;s
;nn	st dur	amp	pshift iskipin	isrcfn ipan istart iend idirect iwrap ienvfn
;i02	0  1.47 20000   1      0        2      .5   0      1.47	-1      1     1
;i.	2  .735	.	2
;i.	4  2.94	.	.5
e
