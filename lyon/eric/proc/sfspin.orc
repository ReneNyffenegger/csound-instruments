  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;one file goes into a funk
;random reads of this sound
;either at variable speed or straight
;arrange for silence at beginning/end of excerpt
;sndin -d65536S |janus

;f1 0 length -1 1 0
;i1 0 dur incr speed offset(0) spacefieldgain(1)
  gilength  =  131072
instr 1
  iphs1     =  0
  iamp      =  .5

  iincr     =  p4*(sr/gilength)
  iphs      =  p5
  ispeed    =  p6
  ioffset   =  p7
  imult     =  p8

  iatk      =  .05
  idk       =  .05
  isust     =  p3 - (iatk+idk)
  ifile     =  2                                  ;p6
  ix        =  .125*imult
  ixx       =  (ioffset*.125)+ix

  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  aweird    oscili    kenv, iincr, ifile, iphs
  kndx      oscili    ix, ispeed, 1, iphs1
  kndx      =  kndx + ixx
  kleft     tablei    kndx,1,1
  kndx      =  kndx+.25
  kright    tablei    kndx,1,1
            outs      kleft*aweird,kright*aweird  ;
endin
