; DISTRIBUTION OF SOUNDS IN CIRCLES
; FM BELLS (FOSCIL)
; PETER ESCH (PESCH@PRATIQUE.FR), JULY 1998


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gal       init      0
  gar       init      0

instr 1
          
  idur      =  p3                                 ; DURATION
  inote     =  p4                                 ; NOTE IN PCH NOTATION
  ipan      =  p5                                 ; PAN POSITION
  idist     =  p6                                 ; DISTANCE
  idiam     =  p7                                 ; DIAMETER OF THE "CIRCLE"          
  iindx     =  p8                                 ; FM INDEX

  kenv      expon     1,idur,0.01
  a1        foscil    kenv*10000,cpspch(inote),1,1.143,iindx,1
       
  kdegree   =  ipan*90
  kdistance =  1+idiam*abs(idist)

  al,ar     locsig    a1,kdegree,kdistance,.1
  arl,arr   locsend   

  gal       =  gal+arl+.1*arr
  gar       =  gar+arr+.1*arl

            outs      al,ar
endin

instr 99

  krvbt     =  p4                                 ; REVERB TIME
  al        reverb2   gal,krvbt,.5
  ar        reverb2   gar,krvbt,.5

            outs      al,ar
  gal       =  0
  gar       =  0
endin
