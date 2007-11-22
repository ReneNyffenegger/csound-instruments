; SL_ONE_A.ORC Same as SL_ONE except now we use the zak system.
;
; See SL_ONE.ORC/SCO for doco on principles of operation.
; Here we split the functions as follows:
;
; Sound source and flangers using zak with mixing options on output.
;
; Head driver driving zk, with the option for other instances of
; the head driver or other things to mix into the zk variables.
;
; Head converter - runs once to convert the zk head location into 
; exact x and y locations for the two ears and the two reference points.
;
; (The above two used to be in one instrument)
;
; The source drivers - create x, y and z positions for each of the sources
; in a zk set of variables - one for each source.
;
; The binaural mixers - using the zk x, y and z parameters above, a specified 
; za audio source (from the flangers) and the global head position data, 
; calculate the left and right ear signals and mix them to two global variables.
; 
; (The above two used to be in one instrument) 
;
;-----------------------------------------------------------------------------
                        ;
                        ; INITIALISATION OF ORCHESTRA
sr      =       44100   ;
kr      =       4410    ; MAKE K RATE FINER SO THE DOPPLER WORKS NICELY.
ksmps   =       10      ; 
                        ;
; sr    =       44100
; kr    =       4410
; ksmps =       10

nchnls  =       2
                        ; - - - - - - -
                        ;
                        ; INITALISE GLOBAL VARIABLES:

gidelmax init   0.3     ; MAXIMUM DELAY TIME FOR ALL DELAYS.


gal     init    0       ; Left and right head mix accumulators.
gar     init    0       ;

gkhxl   init    0       ; X position of left ear.
gkhyl   init    0       ; Y position of left ear.
gkhxr   init    0       ; X position of right ear.
gkhyr   init    0       ; Y position of right ear.
gkhxf   init    0       ; X position of front reference point.
gkhyf   init    0       ; Y position of front reference point.
gkhxb   init    0       ; X position of rear reference point.
gkhyb   init    0       ; Y position of rear reference point.
                        ;       
                        ;
                        ; USE za VARIABLES IN zak SYSTEM FOR 
                        ; PATCHING AUDIO SIGNALS AROUND.
                        ;   
        zakinit 1000,1000
                        ; za VARIABLES
                        ;
                        ; SUTPUTS OF MAJOR 7TH CHORDO
                        ; 
                        ; za0           
                        ; za1       
                        ; za2       
                        ; za3       
                        ;
                        ; OUTPUTS OF FLANGERS
                        ;               
                        ; za4       
                        ; za5       
                        ; za6       
                        ; za7       
                        ;
                        ;
                        ; zk VARIABLES
                        ;   
                        ; zk0   X LOCATION OF HEAD.
                        ; zk1   Y LOCATION OF HEAD.
                        ; zk2   ANGLE OF ROTATION OF HEAD 0 - 2pi ACW.
                        ;
                        ; zk100 X LOCATION OF SOUND SOURCE 0
                        ; zk101 Y
                        ; zk102 Z
                        ; zk103 VOLUME OF SOUND SOURCE 
                        ;
                        ; zk11x LIKEWISE FOR SOUND SOURCE 1
                        ; zk12x               2
                        ; zk13x               3
                        ;

;----------------------------------------------------------------------------
;
;                 Details of tables provided by score.
;                 All waveform tables are -1 to +1
;
; Table  1 = 2048 sine
; Table  2 = 16 step "Casio" waveform A Broad spectrum
; Table  3 = 16 step "Casio" waveform B Sine like
; Table  4 = 16 step "Casio" waveform C Narrow pulse
;
; Table 50 = 1024 step linear for rise of envlpx EG



;----------------------------------------------------------------------------
;
; Instrument 5 and 200 Direct write to zk destination, with linear ramping. 
;
; Parm   4  Output zk variable
;    5  Output mode 0 = write, !0 = mix  
;    6  Value to write at start
;    7  Value to write at end
;
;-----------------------------------------------------------------------------
;
;Inst   Start   Dur.    p4  p5  p6  p7  
;           Output__mix Start   End
;           zk      

        instr   5,200

                                    ; CREATE RAMP FOR DURATION OF INSTANCE.
kfade   phasor  1/p3
    
                                    ; CALCULATE VALUE AS IS RAMPS FROM START
                                    ; OF INSTANCE TO END.
kval    =       p6*(1-kfade)+p7*kfade

        zkwm    kval,p4,p5

        endin


;-----------------------------------------------------------------------------
;
; Instrument 10 Sound with linear attack, exponential decay and tremelo
;
; An interpolated table waveform instrument.
; Ouput to a za variable.
;
; Parm   3  Duration
;    4  Output za number
;    5  Output mode 0 = write, !0 = mix
;    6  Frequency Hz
;    7  ^zk mod 
;    8  Volume
;    9  ^zk mod 
;   10  Table number
;   11  Rise time - linear
;   12  Decay time  
;   13  Tremelo period seconds = 1/frequency
;   14  Tremelo depth eg. 0.2 gives .8 to 1.2 volume
;
;   zk mod   0 means no change 
;       +N means add value from zk variable N
;       -N means multiply by value from zk variable N
;
;-----------------------------------------------------------------------------
;
;Inst   Start   Dur.    p4  p5  p6  p7  p8  p9  p10 p11 p12 p13 p14
;           Output__mix Freq____mod Volume__mod Table   trise   tdecay  trperiod trdepth
;           za      Hz  zk      p9

        instr   10  
                                    ; CALCULATE FREQUENCY AND VOLUME.
kfreq   zkmod   p6,p7
kvol    zkmod   p8,p9


a1      oscili  kvol,kfreq,p10  ; BASIC OSCILLATOR.
                                    ;
                                    ; EG WITH EXPONENTIAL DECAY.
                                    ;
                
kenv    envlpx  1,p11,p3,p12,50,1,0.006   
                
klfo    oscil   p14,1/p13,1     ; TREMOLO DEPTH AND FREQUENCY, SINE TABLE.
                                    ;
                                    ; MIX OR WRITE TO OUTPUT.

        zawm    (a1*(kenv*(1+klfo))),p4,p5

        endin


;-----------------------------------------------------------------------------
;
; Instrument 401 & 20 Self contained flanger with za input and output
;
; Parm   4  Output za variable
;    5  Output mode 0 = write, !0 = mix
;    6  Input za variable
;    7  ^ Gain
;    8  Delay time Max = 0.1 sec
;    9  Mix level 1 = purely delayed
;   10  Feedback ratio > 1 = feedback
;   11  Period of sine LFO 
;   12  Deviation from delay time eg. 0.2 => 0.8 to 1.2
;
;-----------------------------------------------------------------------------
;
;Inst   Start   Dur.    p4  p5  p6  p7  p8  p9  p10 p11 p12
;           Output__mix Input___gain    Delay   Del mix Feed-   LFO Range
;           za      za          level   back    Period

        instr   20, 401, 501, 601, 701

adum    delayr  0.1                 ; MAXIMUM DELAY = 0.1 SEC DON'T USE OUTPUT.

                                    ; MAKE AN LFO TABLE 1 = SINE
                                    ; WITH THE RANGE OF THE PARAMETER 8.
klfo    oscili  p12,1/p11,1

                                    ; GET INPUT SOUND.
a1      zarg    p6,p7 

                                    ; GET VARIABLE DELAY SOUND

a2      deltapi p8*(1+klfo)

                                    ; MIX OR WRITE TO OUTPUT.

        zawm    (a1*(1-p9))+(a2*p9),p4,p5

                                    ; WRITE THE INPUT SIGNAL PLUS FEEDBACK
                                    ; VALUE INTO THE DELAY LINE.
        delayw  a1+(a2*p10)
                                    ; END OF DELAY SECTION  
        endin


;-----------------------------------------------------------------------------
;
; Instrument 100 Provide X, Y and R for head.
;        Drive output to zk0 to zk2, with a mix option.
;
; parm  3   Duration
;   4   Initial X
;   5   Initial Y
;   6   Initial R 0 to 1 anticlockwise
;   7   Final   X
;   8   Final   Y
;   9   Final   R
;   10  Mix or write (0) to zk locations.
;
;-----------------------------------------------------------------------------

;Inst   Start   Dur.    p4  p5  p6  p7  p8  p9  p10 
;           Initial__________   Final____________   Mix/write
;           X   Y   R   X   Y   R   
;
                                    ;
                                    ; THIS CAN BE USED FOR ONE PERIOD OF TIME TO MOVE 
                                    ; THE HEAD TO A PARTICULAR LOCATION, AND THEN THE 
                                    ; VALUES WILL REMAIN UNTIL ANOTHER INSTANCE 
                                    ; CHANGES THEM.  
        instr   100
                                    ; CREATE A 0 TO 1 RAMP FOR THE DURATION OF THE
                                    ; INSTRUMENT'S TIME.
                                    ;
                                    ; USE THE STARTING TIME OF THIS INSTANCE AS
                                    ; A REFERENCE AND SUBTRACT IT FROM THE CURRENT 
                                    ; TIME.
        istart init 0  
        itimes init 0   
        ktimenow times

kpath   =       (ktimenow-istart)/p3
                                    ; USE THIS TO INTERPOLATE BETWEEN STARTING
                                    ; AND ENDING VALUES FOR X, Y AND R.
                                    ;
                                    ; kprem = REMAINDER OF WHAT IS LEFT OF PATH 
                                    ; TOWARDS 1.
kprem   =       1-kpath

khx     =       p4*kprem+p7*kpath
khy     =       p5*kprem+p8*kpath
khr     =       (p6*kprem+p9*kpath)*6.28318 

                                    ; WRITE OR MIX THESE TO FIXED zk LOCATIONS.
        zkwm    khx,0,p10
        zkwm    khy,1,p10
        zkwm    khr,2,p10

        endin


;-----------------------------------------------------------------------------
;
; Instrument 110 Convert the X, Y and R head location values in zk0 to zk2 into 
;        global variables for the ears and reference points.
;
; parm  3   Duration
;
;-----------------------------------------------------------------------------

;Inst   Start   Dur.    
;   

        instr 110
                                    ; 
                                    ; NOW CALCULATE THE X AND Y POSITIONS OF THE
                                    ; EARS AND THE FRONT AND BACK REFERENCE POINTS.
khx     zkr     0
khy     zkr     1
khr     zkr     2

        printks "*hx=%f hy=%f hr=%f \n",2,khx,khy,khr,0


                                    ; FIRST CALCULATE THE X DEVIATION OF THE RIGHT
                                    ; EAR FROM THE CENTRE OF THE HEAD. THE
                                    ; LEFT DEVIATION WILL BE MINUS THIS.
                                    ; WHEN THE HEAD IS POINTING STRAIGHT, THIS 
                                    ; WILL BE 0.25.
                                    ;
                                    ; WE NEED BOTH SIN AND COS OF THE HEAD ANGLE
                                    ; TWICE, BUT IT TAKES THE FPU A LONG TIME TO 
                                    ; CALCULATE IT, SO JUST DO THEM ONCE AND 
                                    ; ASSIGN THEM TO A VARIABLE.
kksin   =       sin(khr)
kkcos   =       cos(khr)

kdevxr  =       kkcos*0.25                  
                                    ; CALCULATE THE X LOCATION OF THE LEFT AND 
                                    ; RIGHT EARS.
gkhxl   =       khx-kdevxr      
gkhxr   =       khx+kdevxr      
                                    ; NOW DO LIKEWISE FOR Y.

                                    ; RIGHT EAR GOES PLUS AS ANGLE GOES ACW, THIS
                                    ; MEANS THAT THE Y DEVIATION INCREASES.
kdevyr  =       kksin*0.25                  

gkhyl   =       khy-kdevyr      
gkhyr   =       khy+kdevyr      
                                    ; NOW DO SIMILAR FOR THE F AND B REFERENCE
                                    ; POINTS WHICH ARE 0.209 FORWARD AND BACK OF 
                                    ; CENTRAL POINT BETWEEN THE EARS.
                                    ;
                                    ; 40 DEGREES FROM EARS. TAN 40 = 0.84
                                    ; 0.84 of 0.25 msec IS 0.209
                                    ;
                                    ; THIS WOULD RESULT IN A MAXIMUM DELAY DIFFERENCE
                                    ; BETWEEN THE EARS AND THE F OR B POINTS OF
                                    ; 0.325.

kdevxf  =       kksin*-0.209                    
                                    ; kdevxf GOES NEGATIVE (TO THE LEFT) AS THE
                                    ; HEAD IS ROTATED ACW.
gkhxf   =       khx+kdevxf      
gkhxb   =       khx-kdevxf      
                ;
kdevyf  =       kkcos*0.209 

gkhyf   =       khy+kdevyf      
gkhyb   =       khy-kdevyf      


        endin



;-----------------------------------------------------------------------------
;
; Instrument 120 Binaural mix system part 1 - locate the source
;
;       There could be many ways of moving the location.  This one
;       works with sine/cosine waves in x, y and z locations.
;
;       The output of this can write to the destination set of zk
;       variables, or it can mix to them.
;
; parm  3   Duration
;   4   Destination zk set
;   5   ^ mix or write (0) to zk lcoations.
;   6   zk source for modulation of cyclic range     } 0 = no change
;   7   zk source for modulation of cyclic frequency } !=0 = zk source
;                                } for multiplicative
;                                } moduluation                      
;   
;   8   Initial X
;   9   Final   X
;   10  Cyclic  X range
;   11  Cyclic  X time for cosine cycle ACW starting at East
;   12  Cyclic  X - where to start in cycle 0 - 1
;
;   13  Initial Y
;   14  Final   Y
;   15  Cyclic  Y range
;   16  Cyclic  Y time for sine cycle ACW starting at East
;   17  Cyclic  Y - where to start in cycle 0 - 1
;
;   18  Initial Z
;   19  Final   Z
;   20  Cyclic  Z range
;   21  Cyclic  Z time for sine cycle going up from centre point
;   22  Cyclic  Z - where to start in cycle 0 - 1
;
;-----------------------------------------------------------------------------

;Inst   Start   Dur.    p4  p5  p6  p7  p8  p9  p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22
;           Destination Range   Freq    X                   Y                   Z
;           three zks   mod mod X Init  Final       Cycle   Cycle   Y Init  Final       Cycle   Cycle   Z Init  Final       Cycle   Cycle
;           zk______Mix/wr  zk  zk  X pos   pos Range   time    phase   Y pos   pos Range   time    phase   Z pos   pos Range   time    phase


        instr   120     
                                    ; CREATE A 0 TO 1 RAMP FOR THE DURATION OF THE
                                    ; INSTRUMENT'S TIME.
                                    ;
                                    ; USE THE STARTING TIME OF THIS INSTANCE AS
                                    ; A REFERENCE AND SUBTRACT IT FROM THE CURRENT 
                                    ; TIME.
        istart init 0 
        itimes init  0   
        ktimenow times

kpath   =       (ktimenow-istart)/p3
                                    ; kprem = REMAINDER OF WHAT IS LEFT OF PATH 
                                    ; TOWARDS 1.
kprem   =       1-kpath
                                    ;
                                    ; USE THIS TO INTERPOLATE BETWEEN STARTING
                                    ; AND ENDING VALUES FOR X, Y AND Z.

kx      =       p8*kprem+p9*kpath
ky      =       p13*kprem+p14*kpath
kz      =       p18*kprem+p19*kpath

                                    ; MAKE AN LFO TABLE 1 = SINE
                                    ;
                                    ; CREATE FREQUENCY VALUES FOR X, Y AND Z, WITH
                                    ; THE INPUT PARAMETERS MULTIPLIED BY ANY 
                                    ; zk VALUE AS SPECIFIED.
                                    ;
                                    ; ALWAYS USE MULTIPLICATIVE MODULATION - SO
                                    ; ALWAYS USE A NEGATIVE ZK VALUE OR 0.

kxf     zkmod   1/p11,-abs(p7)
kyf     zkmod   1/p16,-abs(p7)
kzf     zkmod   1/p21,-abs(p7)

                                    ; DO LIKEWISE FOR THE RANGE - THE AMPLITUDE
                                    ; OF EACH AXIS.

kxr     zkmod   p10,-abs(p6)
kyr     zkmod   p15,-abs(p6)
kzr     zkmod   p20,-abs(p6)
                
                                    ; DO THE CYCLIC CALCULATIONS:
                                    ;
                                    ; ADJUST STARTING PHASES SO THAT AN INPUT 
                                    ; PARAMETER OF 0 WILL START BOTH X AND Y 
                                    ; OSCILLATORS READY FOR AN ANTICLOCKWISE
                                    ; ROTATION STARTING AT EAST (3 O'CLOCK).
                
kxc     oscili  kxr,kxf,1,(p12+0.25)
kyc     oscili  kyr,kyf,1,p17
kzc     oscili  kzr,kzf,1,p22

                                    ; ADD THEM TO THE BASIC LOCATION VALUES
                                    ; AND WRITE OR MIX THEM TO THE THREE zk 
                                    ; LOCATIONS SPECIFIED BY p4.

        zkwm    kx+kxc,p4,p5
        zkwm    ky+kyc,p4+1,p5
        zkwm    kz+kzc,p4+2,p5

        endin


;-----------------------------------------------------------------------------
;
; Instrument 130 Binaural mix system  part 2
;
;       Based on SL_ONE.ORC, but here the input x, y and z positions are
;       from a zk set of variables.
;       
;       Signal from za variable, with volume control.
;
;
;       Super version with differing axes for extra time delay and
;       volume & high frequency gain.
;
;       In addition to the basic binaural time delays, there are 
;       three sets of directionality cues:
;
;       1/ The extra time sound takes to go around the head to the
;          far ear.
;
;       2/ Reduced volume when sound is more than 50 degrees of axis
;          from the forward pointing 40 degree from left/right axis
;          which the ear is assumed to be pointing along.
;          (This is not really required for binarual, or not to a 
;           great degree, it is mainly to enhance the placement when
;           listened to on speakers.)   
;
;       3/ Lowered high frequency response for far ear on the same 
;          axis.
;
;       In the original version of the binaural model, I did these
;       using the axis between the ears - there was no forward to 
;       backwards difference.  Now for each ear, the axis for volume 
;       and frequency response is 40 degrees forward, and the axis for 
;       extra time delay is 40 degrees backwards.
;
;       This is because the outer ear points forwards, but is rear of 
;       the centre of the head.
;
;       In each case the angle is more than would be true of a real
;       head, but I am trying to accentuate the naturally weak 
;       forward to backward cues. 
;
;       This involves calculating distances to two extra points, 
;       tan 40 = 0.84 of an ear distance in front of and 
;       behind the centre of the head (between the ears).
;       The ears are assumed to be 0.25 msec from the centre, so
;       we need points 0.209 in front of and behind the centre.
;       When the sound is on one of these axes, the maximum delay 
;       difference could be .3258 msec. 
;
;       The X,Y postitions of the two ears and the two reference 
;       points are already calculated and available as golbal 
;       variables.
;
;       I don't claim that this approach is unique or optimal, or
;       that it does not infringe any software patents.  If you
;       have fun with it I would really appreciate a copy of your
;       .SCO and .ORC files - to: firstpr@ozemail.com.au or to
;       rwhittle@ozonline.com.au.
;
; parm  3   Duration
;   4   za audio input source 
;   5   zk start of four zk variables for x, y, z and volume.
;
;-----------------------------------------------------------------------------

;Inst   Start   Dur.    p4  p5  
;           Source  Control
;           za  zk

        instr   130     
                                    ; GET SOUND SOURCE AND APPLY GAIN CONTROL.
as      zar     p4

kvol    zkr     p5+3

as      =       as*kvol

                                    ; GET THE X, Y AND Z LOCATIONS OF THE SOUND 
                                    ; SOURCE.
kx      zkr     p5
ky      zkr     p5+1
kz      zkr     p5+2

        printks "  Source %1.f x= %+5.2f  y=%+5.2f z=%+5.2f \n",2,p4,kx,ky,kz 

                                    ; THE HEAD IS AT ghx AND ghy, BUT WE USE THE
                                    ; X AND Y LOCATIONS OF THE EARS AND THE 
                                    ; REFERENCE POINTS WHICH ARE GLOBAL 
                                    ; VARIABLES.
                                    ;  
                                    ; THE HEAD'S Z LOCATION IS 0. 
                                    ;
                                    ; IT IS POINTING AT A DIRECTION gha, 0 TO 2pi,
                                    ; BUT WE DON'T NEED THAT HERE SINCE THE 
                                    ; INSTRUMENT WHICH PLACED THE HEAD ALSO 
                                    ; CALCULATED THE EAR AND REFERENCE POINT 
                                    ; LOCATIONS.
                                    ;
                                    ; X DIFFERENCE IN POSTIONS BETWEEN SOURCE AND
                                    ; LEFT EAR.  LIKEWISE FOR OTHER EAR AND 
                                    ; REFERENCE POINTS, AND FOR Y AS WELL.
kdifxl  =       kx-gkhxl
kdifxr  =       kx-gkhxr        

kdifxf  =       kx-gkhxf
kdifxb  =       kx-gkhxb

kdifyl  =       ky-gkhyl        
kdifyr  =       ky-gkhyr        

kdifyf  =       ky-gkhyf
kdifyb  =       ky-gkhyb
                                    ; - - - - - -
                                    ;
                                    ; NOW WE WANT TO DETERMINE THE DELAY TIMES 
                                    ; FROM THE SOURCE TO THE LEFT AND RIGHT EARS, 
                                    ; AND TO THE TWO REFERENCE POINTS F AND B.
                                    ;
                                    ; THESE ARE IN MILLISECONDS, WHICH IS THE UNIT 
                                    ; OF MEASUREMENT OF X, Y AND Z.
                                    ;
                                    ; THE HEAD IS AT Z = 0.
                                    ;
                                    ; CALCULATE DELAY TIMES TO LEFT AND RIGHT
                                    ; EARS. 
                                    ;
                                    ; WE NEED THE Z DIFFERENCE SQUARED FOR THE 
                                    ; FOLLOWING PYTHAGORAS STUFF
kzsq    =       kz*kz

kdell   =       sqrt(kdifxl*kdifxl+kdifyl*kdifyl+kzsq)  
kdelr   =       sqrt(kdifxr*kdifxr+kdifyr*kdifyr+kzsq)  

                                    ; NOW DO LIKEWISE FOR THE FRONT POINT AND THE
                                    ; BACK.

kdelf   =       sqrt(kdifxf*kdifxf+kdifyf*kdifyf+kzsq)  
kdelb   =       sqrt(kdifxb*kdifxb+kdifyb*kdifyb+kzsq)  
                                    ;
                                    ; ALL THESE DELAYS ARE POSITIVE VALUES.
                                    ;
                                    ; CALCULATE THE DELAY DIFFERENCE BETWEEN 
                                    ; THE LEFT EAR AND THE "F" POINT, FOR
                                    ; THE LEFT'S EXTRA DELAY.
                                    ; POSITIVE MEANS LEFT IS BEHIND THE "F" POINT
                                    ; AND THEREFORE THE SOUND IS COMING FROM 
                                    ; BEHIND THE HEAD = FROM THE RIGHT, AND MUST 
                                    ; HAVE AN EXTRA DELAY ADDED FOR THE LEFT EAR
                                    ; BECAUSE OF THE PATH AROUND THE HEAD.

kdeldiffl = kdell-kdelf
                                    ; LIKEWISE FOR RIGHT EAR.
kdeldiffr = kdelr-kdelf

                                    ; CALCULATE THE DELAY DIFFERENCE BETWEEN 
                                    ; THE LEFT EAR AND THE "B" POINT, FOR
                                    ; THE LEFT'S HIGH FREQUENCY GAIN LOBE.
                                    ; POSITIVE MEANS LEFT IS BEHIND THE "B" POINT
                                    ; AND THEREFORE THE SOUND IS COMING FROM 
                                    ; BEHIND THE HEAD, AND MUST HAVE ITS HIGH 
                                    ; FREQUENCIES ATTENUATED.
kdeldifbl = kdell-kdelb
                                    ; LIKEWISE FOR RIGHT EAR.
kdeldifbr = kdelr-kdelb

                                    ; - - - - - - 
                                    ;   
                                    ; ESTABLISH A DELAY LINE WITH THE MAXIMUM 
                                    ; LENGTH.  USE A DUMMY VARIABLE TO KEEP 
                                    ; COMPILER HAPPY.
adum    delayr  gidelmax    
                                    ; WE WRITE THE STUFF INTO IT LATER, AND
                                    ; GET STUFF OUT OF IT WITH DELTAPI.
                                    ; 
                                    ;
                                    ; GET THE DELAYED SOUNDS.
                                    ;
                                    ; DELAY TIME AND X, Y, Z COORDINATES ARE IN 
                                    ; MILLISECONDS = FEET. DELTAP IS IN SECONDS.
                                    ;
                                    ; SIMPLE VERSION:
                                    ; aleft  deltapi kdell/1000     
                                    ; aright deltapi kdelr/1000 
                                    ;
                                    ; HOWEVER WE WANT MORE SUBTLETY.
                                    ;
                                    ; ADD AN ADDITIONAL DELAY TO THE FURTHEST 
                                    ; EAR TO SIMULATE THE LONGER PATH AROUND THE 
                                    ; HEAD.  AT THE MOST, THIS IS THE EXTRA
                                    ; TRAVEL DISTANCE AROUND A QUARTER OF A CIRCLE
                                    ; COMPARED TO ITS RADIUS  = 1 - PI/2 = .57.
                                    ; SINCE THE RADIUS IS .25 msec, THIS IS .14
                                    ; msec.
                                    ;
                                    ; HOWEVER I WILL TRY FOR A .25 msec EXTRA
                                    ; DELAY TO GIVE A STRONGER EFFECT.
                                    ;
                                    ; THIS ONLY BECOMES AN ISSUE FOR HIGHER ANGLES
                                    ; WHERE THE KDELDIFFX IS ABOVE ABOUT HALF
                                    ; ITS MAXIMUM.  WE WANT TO INTRODUCE THE
                                    ; EXTRA DELAY SMOOTHLY BEYOND THIS.
                                    ;
                                    ; HOWEVER, WE DO NOT WANT A SUDDEN INCREASE AT
                                    ; THIS POINT - SQUARE THE DIFFERENCE BEYOND
                                    ; 0.15 AND SCALE TO A .25 MAX.
                                    ; THIS MEANS THAT THE EXTRA DELAY STARTS WHEN
                                    ; THE SOURCE IS ABOUT 63 DEGREES FROM THE 
                                    ; EAR -> F AXIS ON THE FAR SIDE OF THE HEAD,
                                    ; AND GROWS RAPIDLY AS THE ANGLE GETS SMALLER.
                                    ;
                                    ; MAKE THE CPU COSTLY CALCULATION OF 
                                    ; DELAY TIME HAPPEN AT THE CONTROL RATE - NOT 
                                    ; AUDIO RATE.
kdeldifftl =    kdeldiffl-0.15
kdeldifftr =    kdeldiffr-0.15
                                    ; WITH A 0.325 RANGE IN THE DIFFERENCE IN 
                                    ; DELAY TIMES BETWEEN EAR AND F REFERENCE 
                                    ; POINT, THESE VALUES COULD GO TO +0.14 WHEN 
                                    ; THE EAR IS BEHIND THE HEAD FROM THE SOUND 
                                    ; SOURCE.
                                    ;
                                    ; WITH .325 RANGE, TRY FOR A .25 msec
                                    ; EXTRA DELAY  
                                    ; .175 * .175 * 8 = .245 msec
            
                                    ; TRUE: FALSE

aleft   deltapi (kdell+(kdeldifftl < 0 ? 0: (kdeldifftl*kdeldifftl*8)))/1000
aright  deltapi (kdelr+(kdeldifftr < 0 ? 0: (kdeldifftr*kdeldifftr*8)))/1000

                                    ; NOTE - STARTING AT A DELAY DIFFERENCE OF
                                    ; 0.15 IMPLIES AN ANGLE OF 63.5 DEGREES FROM 
                                    ; THE AXIS, BUT WITH LITTLE EFFECT AT FIRST.
                                    ; 
                                    ;
                                    ; WRITE THE SOURCE INTO THE DELAY LINE.
                                    ; SEE THE CSOUND MANUAL ON HOW THE DELTAPI
                                    ; LINES MUST BE SANDWICHED BETWEEN THE 
                                    ; DELAYR AND DELAYW LINES.
        delayw  as          
                                    ;
                                    ; - - - - - - -
                                    ;
                                    ; ORIGINALLY I ASSUMED A 1/(DISTANCE SQUARED)
                                    ; VOLUME CURVE, WHERE A 10 FOOT (10 msec)
                                    ; DELAY GIVES AN EQUAL VOLUME IN THE EAR
                                    ; TO THE SOURCE.
                                    ;
                                    ; THE FOLLOWING CODE DOES THIS, AND ADDS A
                                    ; MINIMUM DISTANCE TO EACH EAR (FOR THE 
                                    ; PURPOSES OF CALCULATING LEVEL ONLY)
                                    ; OF 0.1 FEET.  THIS ALSO AVOIDS A DIVIDE BY 0
                                    ; WHEN THE SOUND SOURCE IS EXACTLY AT THE EAR.
                
; aleft  =      aleft*(100/(kdell*kdell)+0.01)
; aright =      aright*(100/(kdelr*kdelr)+0.01)
        
                                    ; HOWEVER, I FOUND THAT THE 1/ DISTANCE SQUARED
                                    ; IS SEVERE - LIKE A SOUND SOURCE IN 
                                    ; EMPTY SPACE WITH NO REVERB OR FLOOR 
                                    ; REFLECTION.
                                    ;
                                    ; TRY TO POWER OF 1.5 INSTEAD.
        
aleft   =       aleft*(100/(sqrt(kdell*kdell*kdell))+0.01)
aright  =       aright*(100/(sqrt(kdelr*kdelr*kdelr))+0.01)

                                    ; NOW TO PROCESS THESE DELAYED SOUNDS FOR 
                                    ; THE VOLUME AND FREQUENCY RESPONSES OF THE
                                    ; EARS.
                                    ;
                                    ; FIRST THE SOUND WILL BE SUBJECT TO A GAIN
                                    ; CONTROL BASED ON DIRECTION. THIS WILL BE
                                    ; STRONGER THAN A REAL BINAURAL MIC WOULD
                                    ; PICK UP, BUT HELPS CREATE SPACE WHEN LISTENED
                                    ; TO ON LOUDSPEAKERS.
                                    ;
                                    ; THEN A SEPARATE VOLUME FUNCTION WILL BE 
                                    ; PERFORMED ON THE HIGHER FREQUENCIES.
                                    ;
                                    ; WE ASSUME A 40 DEGREE FROM L-R AXIS FOR THESE
                                    ; EFFECTS, BASED ON A B REFERENCE POINT WHICH
                                    ; GIVES A MAXIMUM .325 msec DIFFERENCE IN
                                    ; DELAY TIMES FROM EACH EAR TO THE B POINT.
                                    ;
                                    ; THE IDEA FOR VOLUME IS THAT +/- 50 DEGREES
                                    ; FROM THIS AXIS, THE VOLUME WILL BE NORMAL.
                                    ; AFTER THAT IT DECREASES - DOWN TO 0.5 OF
                                    ; NORMAL WHEN THE EAR IS ON THE OPPOSITE SIDE
                                    ; OF THE HEAD FROM THE SOUND SOURCE.
                                    ;
                                    ; THE LATTER CASE WILL BE WITH kdeldifbx BEING
                                    ; + .325 msec.
                                    ;
                                    ; AT THE 50 DEGREE FROM AXIS POINT (ONE OF 
                                    ; WHICH CO-INCIDES WITH STRAIGHT AHEAD), THE
                                    ; DELAY DIFFERENCE WILL BE SIN 40 OF THIS.
                                    ; 0.643 OF -0.325 = -0.209.
                                    ; SO ONLY DELAYS ABOVE THIS WILL REDUCE THE
                                    ; VOLUME FROM 1.0 TO 0.5.
                                    ;
                                    ; SAVE A MULTIPLICATION AND MAKE THE RANGE
                                    ; BEYOND THIS (0.54) EQUAL TO CHANGE IN GAIN.
                                    ;
                                    ; TRUE :  FALSE 

aleft   =       aleft*(kdeldifbl < -0.209 ? 1 : 0.791-kdeldifbl)
aright  =       aright*(kdeldifbr < -0.209 ? 1 : 0.791-kdeldifbr)

                                    ; (FOR MAX SPEED, THIS COULD BE ADDED TO THE
                                    ; PAIR OF EQUATIONS ABOVE.)
                                    ;
                                    ; MAKE THE FILTERS GET LOWER WHEN THE 
                                    ; EAR IS ON THE OPPOSITE SIDE OF THE HEAD 
                                    ; TO THE SOUND.
                                    ;
                                    ; THIS LOWERS THE FREQUENCY TO 60% OF THE 
                                    ; USUAL.
                                    ; SCALED FOR 0.325 DIFFERENCE.

                                    ; True: False

kfiltl  =       1-(kdeldifbl < 0.1 ? 0: ((kdeldifbl-0.1)*1.78))
kfiltr  =       1-(kdeldifbr < 0.1 ? 0: ((kdeldifbr-0.1)*1.78))
        

aleftlow tone   aleft,3000*kfiltl
aleftlow tone   aleftlow,4500*kfiltl
    
arightlow tone  aright,3000*kfiltr
arightlow tone  arightlow,4500*kfiltr

                                    ; ADD LOW FREQUENCIES, PLUS GAIN ADJUSTED
                                    ; HIGH FREQENCIES, AND ACCUMULATE THE FINAL 
                                    ; SOUND TO THE GLOBAL BINAURAL MIX VARIABLES.
                                    ; 
                                    ; MAKE THE GAIN DROP OFF ONLY WHEN THE
                                    ; kdeldifx IS > 0 AND ALSO MAKE IT COME IN 
                                    ; RATHER SLOWLY BY SQUARING IT AND SCALING IT
                                    ; APPROPRIATELY.  GO FOR GAIN REDUCTION TO 
                                    ; 0.3, SO WE WANT A 0.7 LOSS WHEN THE 
                                    ; kdeldifbx IS 0.325
                                    ;
                                    ; TRUE : FALSE      
gal     =       gal+aleftlow+(aleft-aleftlow)*(kdeldifbl < 0 ? 1 : 1-kdeldifbl*kdeldifbl*6.6)   
gar     =       gar+arightlow+(aright-arightlow)*(kdeldifbr < 0 ? 1 :1-kdeldifbr*kdeldifbr*6.6)  


        endin



;-----------------------------------------------------------------------------
; Instrument 131  Debugging replacement for Binaural mix system, 
;        mixes directly to left and right ears - no binaural stuff - 
;        to speed up debugging of sound sources.
;
; parm  3   Duration
;   4   Source za
;-----------------------------------------------------------------------------
;Inst   Start   Dur.    p4  
;           Source  
;           za      

                                    ;---------------------------------------------
        instr   131 
                                    ;
                                    ; GET SOUND SOURCE.
as      zar     p4

                                    ; CODE ABOVE HERE GENERATES AN AUDIO SOURCE
                                    ; IN LOCAL VARIABLE AS.
                                    ;
                                    ;- - - - - - 
                                    ; ADD TO THE GLOBAL BINAURAL MIX VARIABLES.

gal     =       gal+as
gar     =       gar+as


        endin


;-----------------------------------------------------------------------------
;
; Instrument 810    Print a za value, preceded by a certain number of
;           spaces at a certain time interval
;
; Parm   4  za variable
;    5  Number of spaces before printing number
;    6  Time interval in seconds for each print
;
;-----------------------------------------------------------------------------
;
;Inst   Start   Dur.    p4  p5  p6  
;           Source  Spaces  Time
;           za      

        instr   810     
                                    ; READ THE SIGNAL.
a1      zar      p4

k1      downsamp a1

        printk   p6,k1,p5       

        endin


;-----------------------------------------------------------------------------
;
; Instrument 812    Print a zk value, preceded by a certain number of
;           spaces at a certain time interval
;
; Parm   4  zk variable
;    5  Number of spaces before printing number
;    6  Time interval in seconds for each print
;
;-----------------------------------------------------------------------------
;
;Inst   Start   Dur.    p4  p5  p6  
;           Source  Spaces  Time
;           zk      

        instr   812     
                                    ; READ THE SIGNAL.
k1      zkr     p4

        printk  p6,k1,p5        

        endin



;-----------------------------------------------------------------------------
;
; Instrument 900
;
; Output instrument to mix gal and gar into a stereo mix.
;
; Parm   4  Scale factor
;
;-----------------------------------------------------------------------------
;
;Inst   Start   Dur.    p4  
;           Scale

                                    ; MUST BE HIGH INSTRUMENT NUMBER SO IT IS 
                                    ; EXECUTED AFTER ALL SOUND CALCULATIONS HAVE
                                    ; BEEN ACCUMILATED TO gal AND gar.

        instr   900     
                                    ; DO THE OUTPUT MIXING WITH 1 LSB OF DITHER AND
                                    ; A SCALING FACTOR FOR EACH CHANNEL.

adith   rand    0.5

        outs    gal*p4+adith,gar*p4-adith

                                    ; CLEAR GLOBAL MIX VARIABLES FOR NEXT CYCLE.
gal     =       0   
gar     =       0   

                                    ; CLEAR ANY za OR zk VARIABLES WHICH ARE
                                    ; BEING USED AS ACCUMULATORS - READY FOR NEXT 
                                    ; CYCLE.
        zacl    0,7

        endin



;<<<<<<<<<<<<<<<<<<<<<<< END OF ORCHESTRA FILE


