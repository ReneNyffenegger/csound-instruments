; ROTATION OF SOUNDS IN CIRCLES WITH DOPPLER SHIFT
; WAV-FILES LOOPS USING LOSCIL
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
  isloop    =  p5                                 ; START LOOP (IN SAMPLES) OF WAVFILE
  ieloop    =  p6                                 ; END LOOP (IN SAMPLES) OF WAVFILE
  inrot     =  p7                                 ; NUMBER OF ROTATIONS DURING idur
  idrot     =  p8                                 ; DIRECTION OF ROTATION, ANTI-CLOCKWISE (idrot=1), CLOCKWISE (idrot=2)
  isrot     =  p9                                 ; STARTPOSITION OF THE ROTATION (0-1)
                                             ; CLOCKWISE      FRONT(0), LEFT(0.25), BACK(0.5), RIGHT(0.75) 
                                             ; ANTI-CLOCKWISE FRONT(0), LEFT(0.75), BACK(0.5), RIGHT(0.25)       
  iwavf     =  p10                                ; WAVFILE
  idiam     =  p11                                ; DIAMETER OF THE "CIRCLE" (5-15)

  icfreq    =  inrot/idur                         ; "CIRCLE" FREQUENCY

  k1        phasor    icfreq
  k2        tablei    k1,idrot,1,isrot,1  
  k3        tablei    k1,3,1,isrot,1      
  k4        tablei    k1,4,1,isrot,1      

  kdegree   =  k2*90                              ; PAN
  kdistance =  1+idiam*k3                         ; DISTANCE
  kfreq     =  (340/(340+3.14*idiam*k4*icfreq))*cpspch(inote) ; DOPPLER SHIFT

  kenv      linseg    0,.005*idur,1,.99*idur,1,.005*idur,0
  awav      loscil    kenv*30000,kfreq,iwavf,cpspch(8.09),1,isloop,ieloop

  al,ar     locsig    awav,kdegree,kdistance,.1
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
