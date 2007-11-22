; HEADSPINS.ORC
; S.BARRASS JULY 95
;
; 24 TRACKS OF 3D SOUND
; USES BINAURAL DELAY, LOW-PASS FILTER AND AMPLITUDE 
; TO PROVIDE ROUGH POSITION AND DISTANCE CUES
; USES THE ZAK GEN TO DO ARRAY ROUTING

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

; GLOBAL  ------------------------------------------------
  ginyq     =  sr*0.4
  gipi      =  3.14159265
  giattack  =  0.005
  girelease =  0.005

; CHANNELS
  gichannels   =      24
            zakinit   gichannels,gichannels

; PSEUDO HRTF
  gidelaymax   =      0.001
  gidelaymid   =      gidelaymax/2.0
  gidelaymin   =      0.0001
  gifmin    =  2.0/gidelaymax
  gifscale  =  ginyq/2.171

; PINNAE NOTCH CUE
  ginotchf  =  11000
  ginotchw  =  200

  giamplut  =  90                                 ; DISTANCE-TO-AMPLITUDE LOOKUP TABLE
                         
; ANGLE OF THE EAR RELATIVE TO THE SIDE OF THE HEAD (IN DEGREES) 
  giearangle   =      10
; ELLIPSE
  gie       =  0.6                                ; ECCENTRICITY
  gik       =  (1-gie)/gie                        ; NORMALISE

;
; CABLE
; PLUG A SOUND INTO A CHANNEL
; INSTR START DUR   CHANNEL PATCH PITCH
;
;======================================================= ; CHANNEL
instr 1

; INPUT PARAMETERS  ---------------------------------------------
  idur      =  p3
  ich       =  p4                                 ; CHANNEL
  ipatch    =  p5                                 ; PATCH
  ipitch    =  p6                                 ; PITCH OCTAVE.CLASS FORMAT 8.00 = MIDDLE C
; derived parameters     ---------------------------------------------
  ifroot    =  cpspch(ipitch)                     ; ROOT FREQUENCY IN HZ
            print     idur, ich, ipatch, ipitch, ifroot

  kamp      linen     1, giattack, idur, girelease ; DECLICKING ENVELOPE 
  ivib      unirand   20                          ; RANDOM VIBRATO FREQUENCY 
            print     ivib
  avib      oscil     4,ivib+20,91                ; VIBRATO
  ach       oscil     1, ifroot+avib, ipatch
            zaw       ach, ich                    ; ROUTE TO THE Z CHANNEL
endin

; THIS PLACER USES THE DECLICK ENVELOPE
; PLACER
; PLACE A CHANNEL IN THE SCENE
; AND WRITE TO STEREO OUTPUT
;
;
; INSTR START DUR   CHANNEL DISTANCE    ANGLE HEIGHT

instr 3

; INPUT PARAMETERS  ----------------------------------------
  idur      =  p3
  ach       zar       p4                          ; CHANNEL TO PLAY
  idistance =  p5                                 ; DISTANCE 0 TO 127 METRES
  iangle    =  p6                                 ; ANGLE 0_360 DEGREES WHERE 0 = RIGHT HAND
  iheight   =  p7                                 ; HEIGHT -10_10 BELOW_LEVEL_ABOVE
            print     idur,idistance,iangle,iheight
                                             
; derived parameters     ----------------------------------------
  idb       table     idistance, giamplut         ; convert distance-to-amplitude
  iamp      =  ampdb(idb)
  irevtime  =  idistance/5                        ; reverb in seconds
  iradians  =  iangle*2*gipi/360                  ; convert degreees-to-radians
            print     idb, iamp, iradians, irevtime

; delay

  ix        =  cos(iradians)
  idelay    =  abs(ix)*gidelaymax + gidelaymin 

  irdelay   =  (ix < 0 ? idelay : gidelaymin) 
  ildelay   =  (ix < 0 ? gidelaymin : idelay)                              
            print     ix, idelay, ildelay, irdelay

; APPROX HRTF USING ELLIPTICAL FUNCTIONS FOR EACH EAR
 
; RIGHT EAR
  irearangle   =      iangle-giearangle
  irhrtf    =  gik*gie/(1-gie*cos(irearangle*2*gipi/360)) 

; LEFT EAR
  ilearangle   =      iangle-180+giearangle
  ilhrtf    =  gik*gie/(1-gie*cos(ilearangle*2*gipi/360)) 

            print     ilhrtf,irhrtf

; K-RATE  ------------------------------------------------
; DE-CLICKING ENVELOPE

  kamp      linen     iamp, giattack, idur, girelease 

; A-RATE  ------------------------------------------------

; DISTANCE RELATED REVERB

  arev      reverb    ach, irevtime

; ANGLE POSITIONING BY BINAURAL DELAY
; NOTE : THERE REALLY SHOULD BE FREQUENCY DEPENDENCE HERE... 
; USED FIXED DELAY LINES BECAUSE DELTAP IS STUFFED ! 

  al0       =  ach*ilhrtf
  al1       delay     al0, ildelay
  ar0       =  ach*irhrtf
  ar1       delay     ar0, irdelay

; ATTENUATE UPPER FREQUENCIES FOR HEAD SHADOW 

  al2       tone      al1, exp(ilhrtf)*gifscale
  ar2       tone      ar1, exp(irhrtf)*gifscale

; PUT IN A FREQUENCY NOTCH AS A PINNAE CUE 
; al3 areson al0, ginotchf, ginotchw
; ar3 areson ar0, ginotchf, ginotchw

            dispfft   al2,      0.3, 1024
            dispfft   ar2,      0.3, 1024

            outs      al2*kamp, ar2*kamp

endin
