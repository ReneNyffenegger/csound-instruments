;; gcc.orc
;; Grant Chu Covell
;; 24 May 98
;; azalea@world.std.com or gcovell@c-bridge.com


;; This orchestra and score represents a technique I've developed to 
;; generate complex textures from exceedingly short sound sources. Much 
;; of the implementation is somewhat arbitrary ( panning, envelope ), 
;; but should be enough to indicate this technique's potential. 
;; There can be clear similarities in the results with granular synthesis, 
;; but I have found more control and better surprises with this technique. 
;; I've used this technique extensively in _I.X. Talking about Counterpoint_.


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


  gipan     init      0
  gasigl    init      0
  gasigr    init      0
  girvb     init      0


instr 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39
;; PARAMETERS
  idurtotal =  p3                                 ;; DURATION OF THE RESULTING SOUND
  ilenmin   =  p4                                 ;; MIN AND
  ilenmax   =  p5                                 ;; MAX SAMPLE LENGTH ( IN SECONDS )
  idevstr   =  p6                                 ;; START AND
  idevend   =  p7                                 ;; END DEVIATION OF THE PLAYBACK RATE ( RELATIVE TO 1.0 )        
  ioffstr   =  p8                                 ;; START AND
  ioffend   =  p9                                 ;; END OFFSET ( IN SECONDS )
  ifnum     =  p10                                ;; FUNCTION TABLE WITH THE STORED SOUND
  iampl     =  p11                                ;; AMP ADJUSTMENT HERE
  irvb      =  p12                                ;; REVERB STRENGTH ( CAN BE ENHANCED )

;; "ENVELOPE" SHAPE

;; THIS CAN OBVIOUSLY BE "SCULPTED" IN ANY DESIRED WAY      
  kshape    linseg    0, 1, 0, 20, 1, idurtotal - 25, 1, 4, 0

;; INTERNAL SHAPES
  kdevline  line      idevstr, idurtotal, idevend
  koffline  line      ioffstr, idurtotal, ioffend

;; INITIALIZE PANNING START ( THE PANNING TECHNIQUE IS ARBITRARY )
  gipan     unirand   1.99
  gipan     =  int ( gipan )

;; INITIALIZE FOR LOOP
  irnddur   unirand   ( ilenmax - ilenmin )    
  irnddur   =  irnddur + ilenmin

;; THE LOOP
core:

;; "REINIT" LOOP PARAMETERS
  irnddur   unirand   ( ilenmax - ilenmin )
  irnddur   =  irnddur + ilenmin
            timout    0, irnddur, do

;; DEVIATION
  idevline  =  i ( kdevline )
  idevline  =  ( idevline = 0 ? idevstr: idevline )    

;; THE CHANGE IN SAMPLING RATE CAN EITHER FOLLOW A SET LINE...             
  ichange   =  idevline

;; ...OR THE CHANGE CAN DEVIATE RANDOMLY FROM WITHIN A RANGE               
;; ichange iunirand ( idevline - ( 1 / idevline ) )              
;; ichange =        ichange + ( 1 / idevline )
;; OFFSET
  ioffline  =  i ( koffline )
  ioffline  =  ( ioffline = 0 ? ioffstr : ioffline )                  
  ioffset   =  ioffline * sr

;; THIS PANNING TECHNIQUE IS SOMEWHAT ARBITRARY
  ipans     =  gipan
  ipane     =  abs ( ipans - 1 )
  gipan     =  ipane
          
            reinit    core

do:
  kpanenv   line      ipans, irnddur, ipane
  kintshape linen     1, irnddur * .1, irnddur, irnddur * .1
  asdex     init      0
  a1        tablei    asdex, ifnum, 0, ioffset, 0
            outs      a1 * kpanenv * kintshape * kshape * iampl, a1 * ( 1 - kpanenv ) * kintshape * kshape * iampl
  gasigl    =  gasigl + a1 * kpanenv * kintshape * kshape
  gasigr    =  gasigr + a1 * ( 1 - kpanenv ) * kintshape * kshape               
  girvb     =  irvb
  asdex     =  asdex + ( 1 * ichange )

            rireturn  
endin

instr 99

  al        reverb    gasigl, girvb
  ar        reverb    gasigr, girvb

            outs      al * .15, ar * .15
  gasigl    =  0
  gasigr    =  0

endin
