;Use thewind.wav (soundin.500) as a test audio file
;Use Howard Fredric's impulse files from Sweden
;convolve.101 is Domkyrkan Cathedral (12+ sec reverberation)
;nn	st	dur	ampscl	soundin	impulse	idelay	idryfac
i01 0  8      .02    500    "domkyr44.con"      7.357  .75
s
;convolve.102 is Drottningholm Palace (round ballroom w/slapback)
;nn	st	dur	ampscl	soundin	impulse	idelay	idryfac
i01 0  4      .02    500    "drottn44.con"      1.496  .75
s
;convolve.103 is a Stockholm subway station (round, echoey)
;nn	st	dur	ampscl	soundin	impulse	idelay	idryfac
i01 0  5      .02    500    "oster44.con"       4.435  .75
s
;convolve.104 is "the wind is invisible"
;use eroica symphony (soundin.100) as a test audio file
i01 0  7      .004   100    "thewind.con"       1.6    0  
s
;convolve.105 is frigate.wav (birdcall of a frigate bird)
;use eroica symphony (soundin.100) as a test audio file
i01 0  7      .07    100    "frigate.con"       .4     0   
s
;convolve.106 is noise burst with exponential decay
;use eroica symphony (soundin.100) as a test audio file
i01 0  10     .05    100    "noise.con"  6      .75  
;use thewind (soundin.500) as a test audio file
i01 +  7      .04    500    "noise.con"  6      .75  
s
;convolve.107 is noise burst with logarithmic decay
;use eroica symphony (soundin.100) as a test audio file
i01 0  12     .035   100    "lognoise.con"      6      .75  
;use thewind (soundin.500) as a test audio file
i01 +  9      .03    500    "lognoise.con"      6      .75  
s
;convolve.108 is a noise "wedge" (noisewdg.wav)
;use eroica symphony (soundin.100) as a test audio file
i01 0  11     .05    100    "noisewdg.con"      6      .75  
;use thewind (soundin.500) as a test audio file
i01 +  8      .04    500    "noisewdg.con"      6      .75  
s
;convolve.118 is flanged noise (noischor.wav)
;use thewind (soundin.500) as a test audio file
i01 0  8      .02    500    "noischor.con"      6      .5   
;use bigclunk (soundin.502) as a test audio file
i01 +  8      .01    502    "noischor.con"      6      .25  
;use bees1.wav (soundin.505) as a test audio file
i01 +  10     .01    505    "noischor.con"      6      .25  
;use popcorn.wav (soundin.506) as a test audio file
i01 +  7      .045   506    "noischor.con"      6      .25  
;use laugh.wav (soundin.507) as a test audio file
i01 +  7      .018   507    "noischor.con"      6      .25  
s
;convolve.109 is a woman's laughter (laugh.wav)
;use eroica symphony (soundin.100) as a test audio file
i01 0  8      .05    100    "laugh.con"  2.459  .75
;use thewind (soundin.500) as a test audio file
i01 +  6      .04    500    "laugh.con"  2.459  .75
s
;convolve.110 is a glass breaking (crash.wav)
;use eroica symphony (soundin.100) as a test audio file
i01 0  7      .025   100    "crash.con"  1.736  .5
;use thewind (soundin.500) as a test audio file
i01 +  5      .06    500    "crash.con"  1.736  .75
s
;convolve.111 is bees buzzing (bees1.wav)
;use bigclunk (soundin.502) as a test audio file
i01 0  9      .015   502    "bees1.con"  6.555  .5
;use thewind (soundin.500) as a test audio file
i01 +  10     .003   500    "bees1.con"  6.555  .5
s
;convolve.112 is a toilet flush
;use eroica symphony (soundin.100) as a test audio file
i01 0  10     .008   100    "flush.con"  5.517  .25
;use thewind (soundin.500) as a test audio file
i01 +  8      .0035  500    "flush.con"  5.517  .25
s
;convolve.113 is an inside the piano clunk (bigclunk.wav)
;use eroica symphony (soundin.100) as a test audio file
i01 0  8      .01    100    "bigclunk.con"      4.272  .25
;use thewind (soundin.500) as a test audio file
i01 +  6      .01    500    "bigclunk.con"      4.272  .25
s
;convolve.114 is popcorn
;use eroica symphony (soundin.100) as a test audio file
i01 0  9      .03    100    "popcorn.con"       3.312  .25
;use thewind (soundin.500) as a test audio file
i01 +  7      .03    500    "popcorn.con"       3.312  .25
;use bigclunk (soundin.502) as a test audio file
i01 +  9      .03    502    "popcorn.con"       3.312  .25
s
;convolve.115 is a cello note
;use thewind (soundin.500) as a test audio file
i01 0  5      .01    500    "cello44.con"       1.567  .5
;use bigclunk (soundin.502) as a test audio file
i01 +  5      .01    502    "cello44.con"       1.567  .5
;use bees1.wav (soundin.505) as a test audio file
i01 +  8      .006   505    "cello44.con"       1.567  .5
;use popcorn.wav (soundin.506) as a test audio file
i01 +  6      .024   506    "cello44.con"       1.567  .5
;use laugh.wav (soundin.507) as a test audio file
i01 +  5      .012   507    "cello44.con"       1.567  .5
s
;convolve.116 is a cello note's decay (.474 sec)
;use thewind (soundin.500) as a test audio file
i01 0  4      .01    500    "cellodec.con"      .474   .5
;use bigclunk (soundin.502) as a test audio file
i01 +  4      .01    502    "cellodec.con"      .474   .5
;use bees1.wav (soundin.505) as a test audio file
i01 +  8      .006   505    "cellodec.con"      .474   .5
;use popcorn.wav (soundin.506) as a test audio file
i01 +  5      .024   506    "cellodec.con"      .474   .5
;use laugh.wav (soundin.507) as a test audio file
i01 +  4      .012   507    "cellodec.con"      .474   .5
s
;convolve.117 is cello decay with downward gliss (.575 sec)
;use thewind (soundin.500) as a test audio file
i01 0  4      .01    500    "cellogls.con"      .575   .25
;use bigclunk (soundin.502) as a test audio file
i01 +  4      .005   502    "cellogls.con"      .575   .25
;use bees1.wav (soundin.505) as a test audio file
i01 +  8      .006   505    "cellogls.con"      .575   .25
;use popcorn.wav (soundin.506) as a test audio file
i01 +  5      .06    506    "cellogls.con"      .575   .25
;use laugh.wav (soundin.507) as a test audio file
i01 +  4      .04    507    "cellogls.con"      .575   .25
s
;convolve.119 is a fof-generated chord
;use thewind (soundin.500) as a test audio file
i01 0  5      .01    500    "vowchord.con"      1.3    .25
;use bigclunk (soundin.502) as a test audio file
i01 +  5      .03    502    .      .      .25  
;use bees1.wav (soundin.505) as a test audio file
i01 +  9      .006   505    .      .      .25  
;use popcorn.wav (soundin.506) as a test audio file
i01 +  6      .05    506    .      .      .25  
;use laugh.wav (soundin.507) as a test audio file
i01 +  5      .03    507    .      .      .25  
e
